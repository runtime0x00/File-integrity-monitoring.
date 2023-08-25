# File Integrity Monitoring Script
![2023-08-25 16_52_54-FIM](https://github.com/runtime0x00/File-integrity-monitoring./assets/48301328/0a465b1a-f5d3-45c9-ac61-c53b20f6d2ed)
This PowerShell script allows you to collect a baseline of file hashes and monitor changes in a specified folder. It can be useful for detecting unauthorized changes to files or identifying new files in a folder.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Usage](#usage)
- [Script Explanation](#script-explanation)
- [Contributing](#contributing)
- [License](#license)

## Features

- Option A: Collect a new baseline of file hashes for a specified folder.
- Option B: Continuously monitor files in a folder and detect changes compared to the baseline.
- User-friendly menu and notifications.
- Utilizes built-in PowerShell cmdlets for file operations and hashing.

## Getting Started

### Prerequisites

- PowerShell 5.1 or later.

### Usage

1. Clone or download this repository to your local machine.

2. Open PowerShell and navigate to the script's directory.

3. Run the script:
   ```powershell
   .\fim.ps1
   ```

4. Choose an option from the menu:
   - Press `(A)` to collect a new baseline of file hashes.
   - Press `(B)` to begin monitoring files for changes.

5. Follow the on-screen instructions.

## Script Explanation

This script offers two main functionalities: collecting a baseline of file hashes and monitoring changes in files.

### Baseline Collection (Option A)

- If you select option `(A)` to collect a new baseline:
  - The script will delete an existing baseline file if it exists.
  - It will calculate the SHA-512 hash for each file in the specified folder.
  - Baseline hashes will be stored in `baseline.txt` for future comparison.

### File Monitoring (Option B)

- If you select option `(B)` to monitor files:
  - The script loads baseline hashes from `baseline.txt` into a dictionary.
  - It enters an infinite loop and continuously monitors the specified folder for changes.
  - If a new file is created, the script notifies you.
  - If a file's hash changes, indicating a modification, the script notifies you.
  - If a file is deleted, the script notifies you.

## Contributing

Contributions to enhance this script are welcome! If you find a bug or have a suggestion, please open an issue or submit a pull request.

## License

This script is free to use.

```

Please customize the content as needed for your specific use case and project structure.
