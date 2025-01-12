#!/bin/bash


# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo -e "\n\e[1;31mERROR: Virtual environment 'venv' not found. Please run the setup script first.\e[0m"
    exit 1
fi

# Activate the virtual environment
echo -e "\n\e[1;32mActivating virtual environment...\e[0m"
source venv/bin/activate

# Check if main.py exists in the directory
if [ ! -f "main.py" ]; then
    echo -e "\n\e[1;31mERROR: main.py not found. Please ensure it is present in the project directory.\e[0m"
    exit 1
fi

# Run the main.py script
echo -e "\n\e[1;32mRunning the PDF Summarizer...\e[0m"
python3 main.py

# Deactivate the virtual environment after the script ends
deactivate

