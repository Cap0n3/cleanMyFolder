<#
Script: Small powershell script that goes recursivly through any given folder and its sub-folders and deletes 
any chosen type of file (just one type at the time, it can be a hidden file too). All selected files will be 
listed and you'll be prompted files before deleting anything. If you're not sure you can even do a quick test 
(A "WhatIf") just to be sure before lanching actual deletion.

Developed by: cap0n3
#>

# Prompt User for folder path and file type
Write-Host "`n=== Welcome to Clean My Folder script ! ===`n" -ForegroundColor Green

# Check folder existence
while($check_path -eq $null) {
    $folder_path = Read-Host -Prompt "- Enter absolute path to folder"
    if (!(Test-Path -Path $folder_path)) {
        Write-Warning "'$($folder_path)' not found, check path please !"
    } else  {
        $check_path = $true 
    }
}

# Check files existence
while($check_file -eq $null) {
    # Ask file type to delete & don't allow empty entry
    while (!($file_to_del)) {
        $file_to_del =  Read-Host -Prompt "- Enter type of file"
        if (!($file_to_del)) {
            Write-Warning "Please enter file type"
        }
    }
    # Get all requested files
    $all_files = Get-ChildItem -Path $folder_path -Force -Recurse -Filter $file_to_del
    # Check if files are found
    if ($(($all_files).count) -eq 0) {
        Write-Warning "No files of type '$($file_to_del)' found at path '$($folder_path)'"
    } else {
        $check_file = $true
    }  
}

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
    Write-Host "`n[EXIT] Leaving script without deleting anything. Bye !`n" -ForegroundColor Green
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
