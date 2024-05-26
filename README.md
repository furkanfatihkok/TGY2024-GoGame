# GoGame

//TODO:
<p align="center">
  <img width="146" alt="GoGame" src="https://github.com/furkanfatihkok/TGY2024-GoGame/assets/113316242/d20f554c-29b9-49c9-8c5b-f09eedc99ec2">
</p>

<div align="center">
  <h1>GoGame Project by Furkan Fatih Kök</h1>
</div>

## Table of Contents
  - [Screenshots](#screenshots)
  - [Tech Stack](#tech-stack)
  - [Architecture](#architecture)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
  - [Home Screen](#home-screen)
  - [Detail Screen](#detail-screen)
  - [Favourite Screen](#favourite-screen)
  - [Search](#search)
- [Known Issues](#known-issues)

 ## Screenshots



| Image 1                | Image 2                | Image 3                | Image 4                  |
|------------------------|------------------------|------------------------| ------------------------ |
| ![home](https://github.com/furkanfatihkok/TGY2024-GoGame/assets/113316242/89065d70-bcbf-48d3-86fc-6c9301ec99ec)|![detail](https://github.com/furkanfatihkok/TGY2024-GoGame/assets/113316242/998cd381-eb96-4d32-8fd9-52b23056470c)| ![searching](https://github.com/furkanfatihkok/TGY2024-GoGame/assets/113316242/3688b3ff-989e-403d-8b6d-ca0139763bb8) | ![favourite](https://github.com/furkanfatihkok/TGY2024-GoGame/assets/113316242/581618ce-5758-42ac-b356-28ec1fc9bb34) |
| Home Screen    | Detail Screen    | Search   | Favourite Screen |

## Tech Stack

- **Xcode:** Version 15.3
- **Language:** Swift 5.10
- **Minimum iOS Version:** 15.0
- **Dependency Manager:** SPM

## Architecture

![Architecture](https://benoitpasquier.com/images/2018/01/mvvm-pattern.png)

## Getting Started

### Prerequisites

Before you begin, ensure you have the following:

- Xcode installed

Also, make sure that these dependencies are added in your project's target:

- [KingFisher](https://github.com/onevcat/Kingfisher): Kingfisher is a popular asynchronous image downloading and caching library for iOS and macOS apps. This library ensures smooth user experience by performing download and caching operations in the background, preventing thread congestion.


### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/furkanfatihkok/TGY2024-GoGame.git
    ```

2. Open the project in Xcode:

    ```bash
    cd GoGame
    open GoGame.xcodeproj
    ```
3. Add required dependencies using Swift Package Manager:

   ```bash
   - Kingfisher
    ```

6. Build and run the project.

## Usage

###  Home Screen //TODO:

1. Open the app on your simulator or device.
2. Browse the coins, click on the sections to see the values of the coins.
3. Go to Coin Detail by tapping on the relevant coin.

<p align="left">
  <img src="https://github.com/furkanfatihkok/TGY2024-GoGame/assets/113316242/72dee8b8-8aaa-47cd-8c00-e758e156a297" alt="Home Screen" width="200" height="400">
</p>

---

### Detail Screen //TODO:

1. Look at the chart for the coin.
2. Check the coin status with the search action to look for other coins.

<p align="left">
  <img src="https://github.com/furkanfatihkok/TGY2024-GoGame/assets/113316242/3ec36f66-608f-49bd-b02c-cd77acfb0e86" alt="Detail Screen" width="200" height="400">
</p>

---

### Favourite Screen //TODO:

1. Look at the chart for the coin.
2. Check the coin status with the search action to look for other coins. 

<p align="left">
  <img src="https://github.com/furkanfatihkok/TGY2024-GoGame/assets/113316242/ea06df89-5afb-4909-b61e-445d37155dd8" alt="Favourite Screen" width="200" height="400">
</p>

---

### Search //TODO:

1. Look at the chart for the coin.
2. Check the coin status with the search action to look for other coins.

<p align="left">
  <img src="https://github.com/furkanfatihkok/TGY2024-GoGame/assets/113316242/fc45e59a-4666-48bb-a12c-acb02b9bafe8" alt="Search" width="200" height="400">
</p>

---
### Known Issues
The filtering process does not work adequately for the coins I want to search.
