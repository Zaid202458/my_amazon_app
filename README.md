# Amazon Clone App

A Flutter-based Amazon clone application that replicates core features of the Amazon shopping experience.

## Features

- Modern UI design matching Amazon's mobile app
- Home screen with carousel banners and deals
- Category-based product browsing
- Search functionality
- User authentication
- Shopping cart management

## Project Structure

```
lib/
  ├── constants/      # Global constants and theme configuration
  ├── home/          # Home screen related widgets and screens
  ├── models/        # Data models
  ├── services/      # API and backend services
  └── widgets/       # Reusable widgets

assets/
  └── images/        # App images and icons
```

## Setup Instructions

1. Make sure you have Flutter installed on your machine
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Add required images to `assets/images/` directory:
   - Banner images: banner1.jpg, banner2.jpg, banner3.jpg
   - Category images: mobiles.jpg, electronics.jpg, fashion.jpg, home.jpg
   - Deal images: deal_of_day.jpg, deal1.jpg, deal2.jpg, deal3.jpg, deal4.jpg
5. Run the app using `flutter run`

## Dependencies

- carousel_slider: ^4.2.1 (for image carousel)
- provider: ^6.1.2 (state management)
- http: ^1.1.0 (API calls)
- shared_preferences: ^2.2.2 (local storage)

## Contributing

Feel free to submit issues and enhancement requests.
