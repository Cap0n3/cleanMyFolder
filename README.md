# Clean My Folder

Small powershell script that goes recursivly through any given folder and its sub-folders and deletes any chosen type of file (just one type at the time, it can be a hidden file too).

All selected files will be listed and you'll be prompted files before deleting anything. If you're not sure you can even do a quick test (A "WhatIf") just to be sure before lanching actual deletion.

## Usage

Set execution policy :

```ps1
Set-ExecutionPolicy RemoteSigned
```

And launch script from folder :

```ps1
.\cleanMyFolder.ps1
```

Enter absolute path of target folder :

```txt
- Enter absolute path to folder:  C:\Users\Kim\Documents\myFolder
```

Enter type of file to delete :

```txt
- Enter type of file: .DS_Store
```

or to delete all `.log` files :

```txt
- Enter type of file: *.log
```

All `.DS_Store` files will be selected and you'll be prompt with 3 choices :

- `Y` - Lauch deletion
- `N` - Exit script without deleting anything
- `T` - Test deletion without deleting files
