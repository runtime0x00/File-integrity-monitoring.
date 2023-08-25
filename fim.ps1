Write-Host ""
Write-Host "What would you like to do?"
Write-Host "Press (A) if you want to collect a new Baseline."
Write-Host "Press (B) to begin monitoring files with saved Baseline."
Write-Host ""

$your_response = Read-Host -Prompt "Please Enter 'A' or 'B'"
Write-Host "You Entered $($your_response)"

Function Calc-file-Hash($filepath) {
    $fileHash = Get-FileHash -Path $filepath -Algorithm SHA512
    return $fileHash
}

Function Erase-Baseline-If-Exists() {
    $baseline = Test-Path -Path .\baseline.txt
    if ($baseline) {
        Remove-Item -Path .\baseline.txt
    }
}

if ($your_response -eq "A".ToUpper()) {
    # Delete baseline.txt if it already exists
    Erase-Baseline-If-Exists

    # Begin calculating hash from files and store them in baseline.txt
    # Collect all files in one folder
    $files = Get-ChildItem -Path .\files
    
    # For each file, calculate the hash and write it to baseline.txt
    foreach ($file in $files) {
        $hash = Calc-file-Hash $file.FullName
        "$($hash.Path)|$($hash.Hash)" | Out-File -FilePath .\baseline.txt -Append
    }
}
elseif ($your_response -eq "B".ToUpper()) {
    # Load file and its hash from baseline.txt and store them in a dictionary
    $fileHashDict = @{}
    $filePathesandHashes = Get-Content -Path .\baseline.txt

    foreach ($f in $filePathesandHashes) {
        $fileHashDict.Add($f.split("|")[0], $f.split("|")[1])
    }

    $fileHashDict.values
}

# Begin continuously monitoring files with saved baseline
while ($true) {
    Start-Sleep -Seconds 1
    $files = Get-ChildItem -Path .\files
    
    # For each file, calculate the hash and compare it with the baseline
    foreach ($file in $files) {
        $hash = Calc-file-Hash $file.FullName
        
        # Notify user if a new file has been created
        if ($fileHashDict[$hash.Path] -eq $null) {
            Write-Host "$($hash.Path) has been created!!" -ForegroundColor Green
        }
        else {
            # Notify if a file has been changed
            if ($fileHashDict[$hash.Path] -eq $hash.Hash) {
                # The file has not changed
            }
            else {
                # File has been compromised, notify the user
                Write-Host "$($hash.Path) has changed" -ForegroundColor Red
            }
        }
    }

    # Check for deleted baseline files and notify the user
    foreach ($key in $fileHashDict.Keys) {
        $baselineFilesExistence = Test-Path -Path $key

        if (-Not $baselineFilesExistence) {
            Write-Host "$($key) has been deleted!!" -ForegroundColor DarkYellow
        }
    }
}
