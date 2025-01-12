import torch
from pdfminer.high_level import extract_text
from transformers import pipeline
import sys
import os
import subprocess
import logging
import tkinter as tk
from tkinter import filedialog
from time import sleep
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from tqdm import tqdm
from colorama import Fore

# Setup logging
logging.basicConfig(level=logging.INFO)

# Initialize summarizer pipeline
def initialize_summarizer():
    try:
        summarizer = pipeline("summarization", model="sshleifer/distilbart-cnn-12-6")
        logging.info("DistilBART Summarizer loaded successfully!")
        return summarizer
    except Exception as e:
        logging.error(f"Error initializing summarizer: {e}")
        sys.exit(1)

# Extract text from a PDF
def extract_pdf_text(pdf_path):
    try:
        text = extract_text(pdf_path)
        if not text.strip():
            raise ValueError("No text extracted, possibly a scanned PDF.")
        logging.info("Text extraction successful.")
        return text
    except Exception as e:
        logging.error(f"Error extracting text from PDF: {e}")

#    Summarize Text in Chunks with Progress Bar
# ==============================================
def summarize_text_in_chunks(text, summarizer, chunk_size=1024, max_length=130, min_length=30):
    chunks = [text[i:i+chunk_size] for i in range(0, len(text), chunk_size)]
    summaries = []

    print(f"{Fore.CYAN}[INFO] Summarizing text in chunks...\n")
    
    # Using tqdm to display a progress bar during chunk processing
    for i, chunk in tqdm(enumerate(chunks), total=len(chunks), desc="Summarizing", unit="chunk"):
        try:
            summary = summarizer(chunk, max_length=max_length, min_length=min_length, do_sample=False)
            summaries.append(summary[0]['summary_text'])
        except Exception as e:
            logging.error(f"{Fore.RED}[ERROR] Error summarizing chunk {i + 1}: {e}")
            summaries.append("Summary failed due to error.")
    
    return " ".join(summaries)

# Post-summarization enhancements (basic formatting for readability)
def post_summarization_enhancements(summary):
    # Split summary into paragraphs intelligently (basic example)
    paragraphs = summary.split('. ')
    formatted_summary = "\n\n".join(paragraphs)
    return formatted_summary

# Function to create a PDF of the summary
def create_summary_pdf(summary_text, output_pdf_path):
    try:
        c = canvas.Canvas(output_pdf_path, pagesize=letter)
        c.setFont("Helvetica", 12)
        
        paragraphs = summary_text.split('\n')
        text_object = c.beginText(40, 750)
        
        for paragraph in paragraphs:
            text_object.textLine(paragraph)
            if text_object.getY() < 100:
                c.showPage()
                text_object = c.beginText(40, 750)
        
        c.drawText(text_object)
        c.save()
        logging.info(f"Summary saved as {output_pdf_path}")
    except Exception as e:
        logging.error(f"PDF generation failed: {e}")

# Function to prompt user for PDF path with GUI fallback
def get_pdf_path():
    try:
        # Try to open a GUI file picker
        root = tk.Tk()
        root.withdraw()  # Hide the main window
        pdf_path = filedialog.askopenfilename(
            title="Select PDF File",
            filetypes=[("PDF files", "*.pdf")]
        )
        if pdf_path:
            return pdf_path
    except Exception as e:
        logging.warning(f"GUI file picker failed: {e}")

    # If GUI fails or isn't available, fall back to command line input
    os_type = sys.platform
    logging.info(f"GUI failed, falling back to command-line input. OS: {os_type}")

    # Provide instructions based on the OS
    if os_type == "win32":
        print("For Windows, please input the full absolute path (e.g., C:\\Users\\User\\Documents\\file.pdf). Use forward slashes (/) or escape backslashes (\\).")
    else:
        print("For Linux/macOS, please input the absolute path (e.g., /home/user/Documents/file.pdf).")

    pdf_path = input("Please enter the full path to your PDF file: ")

    # Normalize path
    return os.path.abspath(pdf_path)  # Converts to absolute path, ensuring compatibility

# Main function
def main():
    # Get PDF path from user
    pdf_path = get_pdf_path()

    if not pdf_path or not os.path.exists(pdf_path):
        logging.error(f"Invalid file path: {pdf_path}")
        return

    # Initialize the summarizer
    summarizer = initialize_summarizer()

    # Extract text from the PDF
    logging.info(f"Extracting text from PDF: {pdf_path}")
    pdf_text = extract_pdf_text(pdf_path)
    
    if pdf_text is None:
        logging.error("Failed to extract text. Exiting...")
        return

    # Summarize text in chunks
    logging.info("Summarizing text...")
    summary = summarize_text_in_chunks(pdf_text, summarizer)

    # Post-process the summary
    logging.info("Post-processing the summary...")
    formatted_summary = post_summarization_enhancements(summary)

    # Display and save the final summary
    print("\nSummary:")
    print(formatted_summary)
    
    output_pdf_path = pdf_path.replace(".pdf", "_summary.pdf")
    create_summary_pdf(formatted_summary, output_pdf_path)

if __name__ == "__main__":
    main()
