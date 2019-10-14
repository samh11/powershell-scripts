param(
    [string]$Active = $false,
    [Int]$minKB = 1,
    [Int]$maxKB = 1024,
    [string]$folder =".\files"
)

# Usage:  delete_files.ps1 -> view files that would be removed
# Usage:  delete_files.ps1 -Active True -> delete files
# Usage:  delete_files.ps1 -minKB 1 -maxKB 100 -Active True -> specified min and max file size

Write-Output ("----------------------------------------------------------------------------")
Write-Output ("Folder: " + $folder + "  Use -folder folder where folder is the folder name")
Write-Output ("Deleting files less than or equal to " + $maxKB + " kb.  Use -maxKB N where N is maximum size in KB")
Write-Output ("Deleting files greater than or equal to " + $minKB + " kb.  Use -minKB N where N is minimum size in KB")
if ($Active -eq $False) {
    Write-Output ("Read only mode: use -Active $True to enable deletion")
}
Write-Output ("----------------------------------------------------------------------------")
  
$files = Get-ChildItem $folder
$kb = 1024
$minFileSize = $minKB * $kb;
$maxFileSize = $maxKB * $kb;
$count = 0;

foreach ($file in $files) {
    #$size = Measure-Object $file -property length -sum
    #Write-Output($file.Name + " " + $file.Length / 1024 + " KB")
    if ($file.Length -le $maxFileSize -and $file.Length -ge $minFileSize) {
        $count = $count + 1;
        if ($Active -ne $False) {
            Write-Output("Removing file: " + $file.Name + " " + $file.Length / 1024 + " KB")
            Remove-Item $($folder + "\" + $file) -Force
        } else {
            Write-Output("File would be removed: " + $file.Name + " " + $file.Length / 1024 + " KB")
        }
    } else {
        Write-Output("File not removed: " + $file.Name + " " + $file.Length / 1024 + " KB")
    }
}

Write-Output("Total files to be or removed: " + $count)

