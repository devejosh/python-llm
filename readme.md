

```markdown
## PDF Summarizer with DistilBART

An AI-powered tool that quickly summarizes your PDF documents. Simple to use, with minimal setup.

---

## Features

- **AI-powered summaries** for PDF content.
- **Cross-platform support** (Windows, macOS, Linux).
- **Intuitive interface** for easy use.
- **Automatic installation** of dependencies.
- **Clean output** in a summarized PDF format.

---

## Prerequisites

1. WSL installed on Windows (optional for other OS).
2. A **stable internet connection**.
3. **Debian** setup on WSL or a Debian-based OS.

---

## Installation & Usage

### 1. Install WSL (Windows Only)

Run this command in **PowerShell** (as Administrator):

```powershell
wsl --install
```

> After installation, restart your system.

---

### 2. Set Up Ubuntu

Launch **Ubuntu** from **PowerShell** or **Command Prompt**:

```powershell
wsl -d Ubuntu
```

You should see a terminal prompt like:

```bash
username@machine-name:~$
```

---

### 3. Set Up the Application

1. **Clone the repository**:

   ```bash
   git clone https://github.com/devejosh/python-llm.git
   cd python-llm
   ```

2. **Install dependencies**:

   ```bash
   sudo apt update -y
   sudo apt install git -y
   sudo chmod +x ./main.sh
   sudo ./main.sh
   ```

3. **Start the app**:

   ```bash
   ./start.sh
   ```

---

## Support

- **Open an issue** on GitHub for any problems.
- Reach out to me on **X** (formerly Twitter).

---

*Project in early development. Feedback is welcome.*
