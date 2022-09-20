<#
Script: This script goes recursivly through any given folder and its sub-folders and deletes chosen type 
of file (just one file, can be a hidden file too). You'll be prompt before deleting anything and can even 
do a quick test (A "WhatIf") just to be sure before lanching deletion.

Developed by: cap0n3
#>

# Prompt User for folder path and file type
Write-Host "`n=== Welcome ! ===`n" -ForegroundColor Green
$folder_path = Read-Host -Prompt "Enter absolute path to folder"
$file_to_del =  Read-Host -Prompt "Enter type of file"

# Get all requested files
$all_files = Get-ChildItem -Path $folder_path -Force -Recurse -Filter $file_to_del

# Message for user
Write-Host "`n[INFO] $(($all_files).count) files to be deleted :`n" -ForegroundColor Magenta

Start-Sleep -Seconds 1

# Show files to be deleted
$all_files | 

ForEach-Object {
    Write-Host $($_.FullName) -ForegroundColor Cyan
}

# User confirmation set up
$title    = 'Confirm'
$question = 'Do you want to continue?'
$choices  = '&Yes', '&No', '&Test'

# Prompt user & Delete
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
    # Delete file (use -Force on Remove-Item)
    $all_files | 
    ForEach-Object {
        Write-Host "[*] ... Deleting $($_.FullName)" -ForegroundColor Magenta
        Remove-Item $_.FullName -Force
    }
    Write-Host "`nDONE !`n" -ForegroundColor Green
} 
elseif ($decision -eq 1) {
    Write-Host "`nLeaving script without deleting anything. Bye !`n" -ForegroundColor Green
}
elseif ($decision -eq 2) {
    # Simply test with WhatIf
    $all_files | 
    ForEach-Object {
        Write-Host "[TEST] ... Deleting $($_.FullName)" -ForegroundColor Green
        Remove-Item $_.FullName -WhatIf
    }
    Write-Host "`nTEST DONE !`n" -ForegroundColor Green
}
