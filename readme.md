# PDF Summarizer with DistilBART

This tool helps you summarize PDF documents quickly and efficiently using AI. It’s designed to be simple for anyone to use, even if you have limited computer experience. Follow this guide to get started!

---

## Features

- Summarizes PDF content into a concise format.
- Works on Windows, macOS, and Linux.
- Easy-to-use interface with a graphical option.
- Automatic installation of required components.
- Generates a polished, summarized PDF file.

---

## Prerequisites

Before using this tool, ensure:

1. You have **Python 3.8 or later** installed.
2. You’re connected to the internet (to download necessary components).
3. You have **Debian** set up on **WSL** (Windows Subsystem for Linux) or installed a Debian-based OS on a virtual machine (VM). This is a temporary requirement until functionality for automated setup via PowerShell is added.

---

## Step-by-Step Installation and Usage

### 1. Download the Project

1. Go to the project’s release page or repository.
2. Click the download button to get the project files.
3. Save the files in a folder on your computer.

### 2. Set Up Debian (Required for Now)

If you haven’t already set up Debian:

- On **Windows**:
  1. Install **WSL** by following [this guide](https://learn.microsoft.com/en-us/windows/wsl/install).
  2. Install Debian from the Microsoft Store.
- On **macOS/Linux**: Install Debian or use a Debian-based virtual machine (e.g., using VirtualBox).

> Note: Automated setup via PowerShell is planned for a future update.

### 3. Open a Terminal or Command Prompt

- **Windows**: Press `Win + R`, type `cmd`, and press Enter.
- **macOS/Linux**: Open your terminal application.

### 4. Navigate to the Project Folder

In the terminal, use the `cd` command to go to the folder where you saved the project.
For example:

```bash
cd path/to/your/project/folder
```

### 5. Run the Setup Command

Run this command to install everything the program needs:

```bash
python setup.py install
```

This may take a few minutes. Let it finish completely.

### 6. Start the PDF Summarizer

Run the following command to start the program:

```bash
python main.py
```

### 7. Choose a PDF File

- A window will pop up, allowing you to select a PDF file.
- If the window doesn’t appear, the program will ask you to type the file path in the terminal.

### 8. Wait for the Summary

- The program will process the PDF and show a progress bar.
- Once complete, it will save the summarized PDF in the same folder as the original file.

---

## Troubleshooting

### Problem: The Program Won’t Start

1. Make sure Python is installed correctly:
   - Open the terminal and type:
     ```bash
     python --version
     ```
   - If you see an error, install Python from [python.org](https://www.python.org/).
2. Ensure all files are in the same folder and haven’t been moved or renamed.

### Problem: Dependencies Not Found

- If the program shows an error about missing packages, run:
  ```bash
  pip install -r requirements.txt
  ```

### Problem: The Output PDF is Empty or Incorrect

- Make sure the input PDF has readable text (scanned PDFs with images won’t work well).

---

## Advanced Options (Optional)

### Run the Program in Command-Line Mode

You can skip the graphical window and directly provide a file path by running:

```bash
python main.py /path/to/your/file.pdf
```

### Custom Output Path

Specify where to save the summary:

```bash
python main.py /path/to/your/file.pdf --output /path/to/save/summary.pdf
```

---

## Need Help?

If you have any issues or questions, check the [project wiki](#) or contact support at support@example.com.

Happy summarizing!

