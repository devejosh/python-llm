Here’s the updated README with the section you requested removed:

---

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

### 1. Set Up Debian (Required for Now)

If you haven’t already set up Debian, follow these steps to install Debian on WSL:

#### On Windows (using WSL):

1. **Enable WSL on Windows**:
   - Open PowerShell as Administrator and run the following command:
     ```powershell
     wsl --install
     ```
     This will install WSL and the default Linux distribution (Ubuntu).

2. **Install Debian using Command-Line**:
   - If you prefer to use Debian instead of Ubuntu, run the following command:
     ```powershell
     wsl --install -d Debian
     ```
     This command will directly install Debian through WSL, replacing the default Ubuntu distribution with Debian.

3. **Set up Debian**:
   - Once Debian is installed, launch it from the Start menu (search for "Debian").
   - The first time you open Debian, you will be asked to set up a username and password. Set the **username to `dusty`** and the **password to `123`** (or choose your own credentials).
   - After the setup, Debian will be ready to use.

#### On macOS/Linux (using a virtual machine):

- If you're using macOS or Linux, you can install Debian on a virtual machine using VirtualBox or VMware.
  - Download the Debian ISO from [Debian's official website](https://www.debian.org/distrib/).
  - Install the OS in a VM, following the Debian installation process.

> **Note**: Automated setup via PowerShell is planned for a future update.

### 2. Manual Setup of `main.sh` (Linux/WSL Users)

1. **Install Git and Clone the Repository**:
   - Open the Debian terminal and run:
     ```bash
     sudo apt update
     sudo apt install git
     git clone https://github.com/devejosh/python-llm.git
     cd python-llm
     ```

**Run the main file - main.sh --> This is the entry point to the setup, so please ensure to run it**:
   
    sudo su
    ./main.sh
     
     

---

## Automated Setup

After the steps above, everything will be automated. You don’t need to manually run the `main.sh` script or configure anything further. The setup and installation will be handled for you.

### 3. Import the PDF

Once everything is set up, run the following command to start the PDF summarizer:

```bash
python main.py
```

A window will pop up, allowing you to select the PDF file you want to summarize. If the window doesn’t appear, the program will ask you to type the file path in the terminal.

Once the PDF is selected, the program will process the file, summarize it, and save the summary in the same folder as the original file.

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

