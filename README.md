# CSTV

CSTV is an iOS app that showcases CS:GO matches taking place in various global tournaments. 

## Summary
- [Specs](#specs)
- [Installation and Usage](#installation-and-usage)
- [Contributing](#contributing)
- [Screenshots and Demonstration Video](#screenshots-and-demonstration-video)

## Specs
The project was developed using SwiftUI, with the Combine framework, and designed with the Model-View-ViewModel (MVVM) architecture. The app has an responsive layout to any supported device (iPhone/iPad and Mac with Apple silicon).

## Installation and Usage

The requirements are quite straightforward:

- iOS 16.0 or higher
- Xcode 14.0 or higher

After downloading or cloning the repository to your Mac, open CSTV.xcodeproj, and the app should run without any issues.

If you don't see any matches on the home screen, I suggest changing the current Bearer Token in CSTV/Network/MatchService.swift to your personal token. This will help you avoid access denial issues with API requests.

- Note: I've included my personal token in the project, but I'll revoke it later.

To create your personal token, sign up for an account at [PandaScore](https://app.pandascore.co/signup) and visit this [page](https://app.pandascore.co/dashboard/main). For more information, please refer to the [documentation](https://developers.pandascore.co/reference/get_additions).

## Contributing
I will be implementing more improvements in the future, but feel free to suggest or get in touch to discuss.

## Screenshots and [Demonstration Video](https://github.com/caioberkley/CSTV/blob/main/Screenshots/video_demo.mov)

<img src="https://github.com/caioberkley/CSTV/blob/main/Screenshots/home_screen_SE.png" width="30%" height="30%">  <img src="https://github.com/caioberkley/CSTV/blob/main/Screenshots/home_screen_iPad_landscape.png" width="60%" height="90%">
<img src="https://github.com/caioberkley/CSTV/blob/main/Screenshots/detail_screen_iPad_landscape.png" width="60%" height="90%"> <img src="https://github.com/caioberkley/CSTV/blob/main/Screenshots/detail_screen_13_mini.png" width="30%" height="30%">
