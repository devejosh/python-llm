# PDF Summarizer with DistilBART

A fast, AI-powered tool that generates concise summaries of your PDF documents. Designed to be intuitive and easy to use.

---

## 🚀 Features

- **AI-powered PDF Summaries**: Quickly generate concise summaries.
- **Cross-Platform**: Works on **Windows**, **macOS**, and **Linux**.
- **Intuitive UI**: Simple, user-friendly interface.
- **Automatic Dependency Installation**: No manual setup required.
- **Output**: Clean, summarized PDF ready to download.

---

## 📋 Prerequisites

1. **Windows**: Requires **WSL** (Windows Subsystem for Linux). 
2. A **stable internet connection** for dependencies.
3. **Debian-based OS** installed on WSL or VM (Linux/macOS users can skip).

---

## 🛠️ Installation & Setup

### 1. Install WSL (Windows)

Open **PowerShell** as Administrator and run:

```powershell
wsl --install
```

> Once installation completes, restart your computer.

---

### 2. Launch Ubuntu

After your system restarts, open **PowerShell** or **Command Prompt** and run:

```powershell
wsl -d Ubuntu
```

You should see a terminal prompt like:

```bash
username@machine-name:~$
```

---

### 3. Set Up the Project

1. **Clone the repository**:

   ```bash
   git clone https://github.com/devejosh/python-llm.git
   cd python-llm
   ```

2. **Install Dependencies**:

   ```bash
   sudo apt update -y
   sudo apt install git -y
   sudo chmod +x ./main.sh
   sudo ./main.sh
   ```

3. **Start the Summarizer**:

   ```bash
   ./start.sh
   ```

---

## 🧑‍💻 Support & Feedback

If you encounter any issues:

- **Open an issue** on [GitHub](https://github.com/devejosh/python-llm/issues).
- Contact me directly on **X** (formerly Twitter).

---

*This project is in its early stages. Contributions and feedback are welcome!*

**--Devendra**