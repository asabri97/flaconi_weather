Weather App
-----------

This Flutter application displays weather information for a given city. The app fetches weather data from the OpenWeatherMap API and displays it in a user-friendly format.

### Features

-   Search for a city's weather
-   Display current weather details
-   Display a 5-day weather forecast
-   Toggle between Celsius and Fahrenheit for temperature display
-   Pull-to-refresh to update weather data
-   Error handling with appropriate user feedback

### Prerequisites

Before you begin, ensure you have met the following requirements:

-   You have installed the latest version of Flutter.
-   You have an API key from [OpenWeatherMap](https://openweathermap.org/api).

### Installing

1.  Clone the repository:

    bash

    Copy code

    `git clone https://github.com/your-repository/weather-app.git
    cd weather-app`

2.  Install dependencies:

    bash

    Copy code

    `flutter pub get`

3.  Create a `.env` file in the root directory and add your OpenWeatherMap API key:

    plaintext

    Copy code

    `BASE_URL=https://api.openweathermap.org
    API_KEY=your_api_key_here`

4.  Add `.env` file to your `pubspec.yaml` under `assets`:

    yaml

    Copy code

    `flutter:
      assets:
        - .env`

### Running the App

To run the app on your local machine, use the following command:

bash

Copy code

`flutter run`

### Project Structure

-   `lib/`
    -   `data/`
        -   `models/` - Data models
        -   `repositories/` - Data repository implementations
        -   `services/` - API service classes
    -   `domain/`
        -   `entities/` - Domain entities
        -   `repositories/` - Domain repository interfaces
        -   `usecases/` - Use case implementations
    -   `presentation/`
        -   `blocs/` - BLoC state management
        -   `screens/` - UI screens
        -   `widgets/` - Reusable widgets
    -   `core/`
        -   `errors/` - Error handling
        -   `network/` - Network information

### Error Handling

-   Displays an appropriate message when the device is offline or if the city name is incorrect.
-   Displays a retry button on the error screen to re-fetch data.

### Testing

Unit tests are written to ensure the correctness of the repository and service layers. To run tests, use:

bash

Copy code

`flutter test`

### Contribution

Contributions are welcome! Please create a pull request or raise an issue for any bug or feature request.

### License

This project is licensed under the MIT License.

### Acknowledgements

-   [Flutter](https://flutter.dev/)
-   [OpenWeatherMap](https://openweathermap.org/)