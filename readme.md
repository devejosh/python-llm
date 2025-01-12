
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

1.  Your computer is compatible with **WSL** and **WSL** is installed.
2. You’re connected to the internet (to download necessary components).
3. You have **Debian** set up on **WSL** (Windows Subsystem for Linux) or installed a Debian-based OS on a virtual machine (VM). This is a temporary requirement until functionality for automated setup via PowerShell is added.

---

## Step-by-Step Installation and Usage

### Installing WSL ###
If Windows subsystem for linux (WSL) isn't set up  on your system, I suggest you check if your operating system and hardware supports WSL. If it does, proceed further.

- Open **Powershell** as **Administrator** and run the following command.

``` powershell
wsl --install
```
Running this command should install windows subsystem for linux on your system. The install will also  include the default Linux distribution (Ubuntu). 
After installing WSL, I recommend a system restart.

Once done, open powershell post restart and go through the following steps. 


2. **Start Ubuntu**:
   - use the following command to start ubuntu from command prompt or powershell.

   ```powershell
   wsl -d Ubuntu
   ```

   - After the system starts, you will see the terminal. Which looks something like 

  ```bash
  dusty@Asus-ROG-STRIX
  ```
  *** Note: *** your terminal will have the same prompt, but will have your ```username@<your machine name>``` listed. what I've listed above is an example.

  If you see your terminal, like you see in the snippet above, move foward. 

### 2. Manual Setup of `main.sh` (Linux/WSL Users)

1. **Install Git and Clone the Repository**:
   - Open the Debian terminal and run:
     ```bash
     sudo apt update -y
     sudo apt install git -y
     git clone https://github.com/devejosh/python-llm.git
     cd python-llm
     ```

**Run the main file - main.sh --> This is the entry point to the setup, so please ensure to run it**:
   
    sudo ./main.sh
     
     
### If you've set it up thus far, the shell script should take care of the rest. The shell program should install all the required dependencies and run the python file automatically.  ###
---


