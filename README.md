

# Flutter Base Template with MVVM and Repository Pattern

This is a Flutter base template that integrates several common architectural patterns and libraries to kickstart your Flutter project development. It incorporates MVVM (Model-View-ViewModel) architecture, Repository pattern, Provider for state management, environment flavors, localization, Go routes for navigation, and CI/CD setup using GitHub Actions.

## Features

- **MVVM Architecture**: Organize your codebase into Models, Views, and ViewModels for better separation of concerns.
- **Repository Pattern**: Decouple data sources from the rest of the application, making it easier to switch between different data providers.
- **Provider**: Utilize Provider package for state management, providing a simple way to manage and access application state.
- **Environment Flavors**: Define different environment configurations (e.g., development, staging, production) to handle various API endpoints, resources, and configurations.
- **Localization**: Easily add support for multiple languages and locales in your app, enabling internationalization.
- **Go Rout Navigation**: Implement navigation using Go routes for a structured and maintainable navigation flow.
- **CI/CD with GitHub Actions**: Automate your build, test, and deployment workflows using GitHub Actions, ensuring a smooth development pipeline.

## Getting Started

To use this template, follow these steps:

1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Customize the project configuration to fit your needs.
4. Start developing your Flutter application based on the provided template.

## Project Structure

The project structure is organized as follows:



## Directory Structure



## Environment Flavors

The template provides support for different environment flavors. You can define configurations for each flavor in the `main.dart` file using `flavor.dart` for easy access.

## Localization

Add localized strings for different languages and locales in the `lib/i18n` directory. The template is pre-configured to support multiple languages using the `flutter_localizations` package.

## CI/CD with GitHub Actions

The project includes CI/CD workflows defined in the `.github/workflows` directory. These workflows automate the build, test, and deployment processes using GitHub Actions.

## Contributions

Contributions to this template are welcome! If you have suggestions for improvements or new features, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


## Getting Started

1. Clone this repository.
2. Open the project in your favorite code editor.
3. Install dependencies by running `flutter pub get`.
4. Start building your application by creating screens, view models, and repositories in their respective directories.
5. Run your app using `flutter run`.

## Dependencies

This base template uses the following dependencies:

- `provider`: For state management and implementing the MVVM pattern.
- `http`: For making HTTP requests to a REST API (if needed).
- Other dependencies can be added as per your project requirements.


## Acknowledgements

Special thanks to the Flutter community for their contributions and inspiration.
