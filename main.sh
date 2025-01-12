#!/bin/bash

# Function to print headings with underlines
print_heading() {
    echo -e "\n\e[1;34m$1\e[0m"
    echo -e "\e[1;34m$(printf '%*s' ${#1} | tr ' ' '=')\e[0m"
}

# Function to print errors in red with guidance
print_error() {
    echo -e "\n\e[1;31mERROR: $1\e[0m"
    echo -e "\e[1;33mWhat to do: $2\e[0m"
}

# Function to print info with additional spacing for legibility
print_info() {
    echo -e "\n\e[1;32m$1\e[0m"
}

# Function to print Logo with Stylish Formatting
print_logo() {
    echo -e "\e[1;36m
     --[[ 
     __/\\\\\\\\\\\\_____/\\\________/\\\_____/\\\\\\\\\\\____/\\\\\\\\\\\\\\\__/\\\________/\\\_
      _\/\\\////////\\\__\/\\\_______\/\\\___/\\\/////////\\\_\///////\\\/////__\///\\\____/\\\/__       
       _\/\\\______\//\\\_\/\\\_______\/\\\__\//\\\______\///________\/\\\_________\///\\\/\\\/____      
        _\/\\\_______\/\\\_\/\\\_______\/\\\___\////\\\_______________\/\\\___________\///\\\/______     
         _\/\\\_______\/\\\_\/\\\_______\/\\\______\////\\\____________\/\\\_____________\/\\\_______    
          _\/\\\_______\/\\\_\/\\\_______\/\\\_________\////\\\_________\/\\\_____________\/\\\_______   
           _\/\\\_______/\\\__\//\\\______/\\\___/\\\______\//\\\________\/\\\_____________\/\\\_______  
            _\/\\\\\\\\\\\\/____\///\\\\\\\\\/___\///\\\\\\\\\\\/_________\/\\\_____________\/\\\_______ 
             _\////////////________\/////////_______\///////////___________\///______________\///________
     --]]\e[0m"
}


# Ensure the script is being run as root or with sudo privileges
if [[ $EUID -ne 0 ]]; then
    print_error "This script must be run as root or with sudo privileges" \
    "Please run the script with sudo. Example: sudo ./.sh"
    exit 1
fi

# Starting the setup
clear
print_logo
print_info "Starting setup for the PDF Summarizer dependencies..."



# Step 1: Update package lists
print_heading "Step 1: Update System Package List"
echo -e "Updating system package list...\n"
if ! apt-get update -y; then
    print_error "Failed to update package list" \
    "Please check your internet connection and try again."
    exit 1
else
    print_info "System package list updated successfully."
fi

# Step 2: Install system dependencies
print_heading "Step 2: Install System Dependencies"
echo -e "Installing essential packages...\n"
if ! apt install -y python3-pip python3-venv python3-dev build-essential poppler-utils libssl-dev libffi-dev libxml2-dev libxslt1-dev zlib1g-dev tk-dev; then
    print_error "Failed to install system dependencies" \
    "Please check your internet connection or package sources. Try running sudo apt-get update first."
    exit 1
else
    print_info "System dependencies installed successfully."
fi

# Step 3: Install Python dependencies using pip
print_heading "Step 3: Install Python Dependencies"
echo -e "Installing Python libraries...\n"

#Checking for PIP, the python package manager. 
print_info "Checking PIP (Python's package manager. It is essential)"

if ! pip3 --version && ! pip --version; then 
	echo "pip3 not found, attempting to install..."; 
	sudo apt-get install python3-pip -y 
	
	#Perform another check to see if PIP is installed
	if ! pip3 --version && ! pip --version; then
	print_error "Sorry, this seems to be a bug of some sort, please report it in the github repo"
	exit 1
	fi
fi

#If python3 and PIP are installed correctly, then we'll create a virtual environment. 
echo -e "Awesome, python and all its dependencies are in place. Now lets set up a virtual environment in python"

if ! python3 -m venv venv; then
    print_error "Failed to create virtual environment" \
    "Please report this as a bug."
    exit 1
fi

#If no errors, setting up venv, echo the same. 
print_info "Virtual environment set. Activating!"

source venv/bin/activate || {
	print_error "Failed to create virtual environment" \
    	"Well, this should have worked. the virtual environment never got activated. Exiting the program"
    	exit 1
}

print_info "Virtual envronment - Activated! Installing dependencies through PIP in the virtual environment"


echo "Installing Python dependencies..."

# Install tkinter (if necessary)
if ! dpkg -l | grep -q python3-tk; then
    echo "Installing tkinter..."
    sudo apt-get install python3-tk -y
fi

# Try to install the remaining dependencies
if ! pip3 install transformers torch pdfminer.six reportlab tokenizers tqdm colorama; then
    echo "Failed to install Python dependencies"
    echo "Please check your Python installation or try running 'sudo pip3 install <dependency>' for each package."
    exit 1
else
    echo "Python dependencies installed successfully."
fi



# Step 4: Verify installation of poppler-utils
print_heading "Step 4: Verify Poppler-utils Installation"
echo -e "Checking if poppler-utils is installed...\n"
if ! command -v pdftotext &> /dev/null; then
    print_error "Poppler-utils is not installed" \
    "Please install it manually by running: sudo apt-get install poppler-utils"
    exit 1
else
    print_info "Poppler-utils installed successfully."
fi

# Step 5: Check Python libraries installation
print_heading "Step 5: Verify Python Libraries Installation"
echo -e "Verifying installed Python libraries...\n"
if ! python3 -c "import transformers, torch, pdfminer, reportlab, tokenizers, tkinter; print('All Python dependencies verified!')"; then
    print_error "Some Python libraries are missing" \
    "Please run the pip installation again or troubleshoot specific libraries."
    exit 1
else
    print_info "All Python libraries verified successfully."
fi

# Step 6: Create project directory
print_heading "Step 6: Create Project Directory"
PROJECT_DIR="$HOME/pdf-summarizer"
echo -e "Creating project directory if it doesn't exist...\n"
if [ ! -d "$PROJECT_DIR" ]; then
    mkdir -p "$PROJECT_DIR"
    print_info "Project directory created at $PROJECT_DIR."
else
    print_info "Project directory already exists."
fi

# Step 7: Provide instructions for running the script
print_heading "Step 7: Instructions for Running the Script"
echo -e "You are ready to run your PDF Summarizer!\n"
echo -e "\e[1;32mTo run the PDF Summarizer, follow these steps:\e[0m"
echo -e "\e[1;34m1.\e[0m Navigate to the project directory: cd $PROJECT_DIR"
echo -e "\e[1;34m2.\e[0m Ensure your Python script (e.g., pdf_summarizer.py) is in the directory."
echo -e "\e[1;34m3.\e[0m Run the script using: python3 pdf_summarizer.py"
echo -e "\n\e[1;32mIf you encounter any issues, refer to the README.md or open an issue on GitHub.\e[0m"


# checking main.py and making it execution ready.
    # Check if the main.py file exists
    if ! [ -f main.py ]; then
        echo "Unable to load the main python file. The file name is main.py. Please check if file exists in the directory"
    else
        # If it exists, make it executable
        chmod +x main.py
        echo "checking main file : main.py found and made executable."
    fi  

    if ![ -f start.sh ];then
        print_error "the start file is missing. Please check the installation directory (/python-llm) to make sure you have start.sh"
    else
        #start.sh exists. making it executable.
        print_info "start file found. Made executable -- We are all good!"
    fi

# Final message
print_info "Setup complete! You are now ready to summarize PDFs with DistilBART. Exiting!"
