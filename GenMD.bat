@echo off
setlocal enabledelayedexpansion

:: Check if a file was dragged onto the script
if "%~1" neq "" (
    set "inputFile=%~1"
    call :ConvertFile
) else (
    :: If no file was dragged, ask for input
    set /p "inputPath=Enter the path of the file to convert: "
    :: Remove PowerShell formatting and quotes
    set "inputPath=!inputPath:& '=!"
    set "inputPath=!inputPath:'=!"
    set "inputPath=!inputPath:"=!"
    if exist "!inputPath!" (
        set "inputFile=!inputPath!"
        call :ConvertFile
    ) else (
        echo File not found: "!inputPath!"
    )
)

pause
exit /b

:ConvertFile
for %%I in ("%inputFile%") do (
    set "fileName=%%~nI"
    set "filePath=%%~dpI"
)

set "outputFile=!filePath!!fileName!.md"
set "attachmentDir=!filePath!attachments\!fileName!"

echo Converting "%inputFile%" to Markdown...
pandoc -t markdown+bracketed_spans+backtick_code_blocks+fenced_code_attributes+fenced_divs+footnotes-simple_tables-multiline_tables-grid_tables-table_captions+superscript+subscript --wrap=none --column=999 --extract-media="./attachments/!fileName!" "%inputFile%" -o "%outputFile%"

if %errorlevel% neq 0 (
    echo Conversion failed.
    exit /b
)

echo Conversion successful. Output file: "%outputFile%"

:: Convert EMF to PNG and update Markdown
echo Converting EMF files to PNG and updating Markdown...
for /r "%attachmentDir%" %%F in (*.emf) do (
    set "emfFile=%%~nxF"
    set "pngFile=%%~nF.png"
    magick "%%F" "%%~dpF!pngFile!"
    if !errorlevel! equ 0 (
        echo Converted: !emfFile! to !pngFile!
        powershell -Command "(Get-Content '%outputFile%') -replace [regex]::Escape('!emfFile!'), '!pngFile!' | Set-Content '%outputFile%'"
    ) else (
        echo Failed to convert: !emfFile!
    )
)

:: replace some characters in the markdown file
echo Updating Markdown file...
:: Replace repeated dashes and equal signs
powershell -NoProfile -Command "$content = Get-Content '%outputFile%'; $content | ForEach-Object { $_ -replace '-{4,}', '---' -replace '={4,}', '===' } | Set-Content '%outputFile%' -Encoding UTF8"

echo Process completed.
exit /b
