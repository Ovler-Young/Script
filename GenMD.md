# Document to Markdown Converter (GenMD)

A [batch script](./GenMD.bat) that converts documents to Markdown format with enhanced features for handling images and formatting.

## Prerequisites

- [Pandoc](https://pandoc.org/installing.html) - Document converter
- [ImageMagick](https://imagemagick.org/script/download.php) - For image conversion
- PowerShell (comes pre-installed on Windows)

## Installation

1. Download `GenMD.bat` to your preferred location
2. Ensure Pandoc and ImageMagick are installed and accessible from the command line
3. (Optional) Create a shortcut to `GenMD.bat` for easier access

## Usage

There are three ways to use the converter:

### Method 1: Drag and Drop

1. Simply drag and drop any supported document onto the `GenMD.bat` file
2. The script will automatically convert it to Markdown format

### Method 2: Interactive Window

1. Double-click `GenMD.bat`
2. Drag and drop your file into the command window, or manually type/paste the file path
3. Press Enter to start the conversion

### Method 3: Manual Input

1. Double-click `GenMD.bat`
2. When prompted, type or paste the full path to your document
3. Press Enter to start the conversion

## Features

- Converts documents to Markdown while preserving:
  - Code blocks
  - Tables
  - Images
  - Footnotes
  - Superscript and subscript
- Automatically converts EMF images to PNG format
- Creates an `attachments` folder for media files
- Cleans up formatting issues like excessive dashes and equal signs

## Output

The script will create:

- A `.md` file with the same name as your input file
- An `attachments/[filename]` folder containing any extracted media

## Supported Input Formats

Supports all input formats that Pandoc can handle, including:

- Word Documents (.docx)
- HTML
- RTF
- And many more

## Troubleshooting

If you encounter any issues:

- Ensure all prerequisites are properly installed
- Check if the input file path contains special characters
- Verify you have write permissions in the output directory
- Open an issue here
