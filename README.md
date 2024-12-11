
# SpaceX Missions App

A Swift-based iOS application that displays data fetched from the SpaceX API. The app lists SpaceX missions in a table view and provides detailed information about each mission when a row is selected. The app demonstrates the use of the MVVM (Model-View-ViewModel) architecture and efficient API integration.

## Features

- **Mission List**:
  - Displays a list of SpaceX missions fetched from the SpaceX API.
  - Each row contains the mission name.
  - Supports dynamic updates as data is fetched from the API.

- **Mission Details**:
  - When a mission is selected, a detailed view presents:
    - Mission name
    - Rocket used
    - Launch date
    - Associated mission patch image (if available)
  - Includes a placeholder image for missions without a patch image.

- **MVVM Architecture**:
  - Separates the View, Model, and ViewModel for clean and testable code.
  - ViewModel handles API calls and data preparation for the views.

- **Networking**:
  - Fetches mission data asynchronously using the SpaceX API.
  - Implements error handling for API failures.

## Screenshots

### Mission List

<img src="SpaceXApp/images/ss.png" alt="ImageTab" width="250">


### Mission Details
<img src="SpaceXApp/images/ss1.png" alt="ImageTab" width="250">

## Setup and Installation

1. Clone the repository:
   ```bash
   git clone <repository_url>
