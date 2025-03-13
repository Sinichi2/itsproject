# Financial Learning Assistant App

This Flutter application is a financial learning assistant that uses the Gemini AI model to provide users with personalized financial advice and education. The app allows users to input their financial information and ask questions, receiving tailored responses based on their specific situation.

## Features

- **AI-Powered Financial Advice:** Leverages the Gemini AI model to provide relevant financial guidance.
- **Personalized Responses:** Considers the user's financial information (income, savings, investments, debts, expenses, and goals) to tailor advice.
- **Interactive Chat Interface:** Offers a user-friendly chat interface for seamless interaction.
- **Safety Settings:** Implements safety settings to block harmful content (hate speech, sexually explicit material).
- **Clear Chat History:** Displays a clear history of the conversation between the user and the AI.
- **Loading Indicator:** Shows a loading indicator while the AI is processing a request.
- **Dark Mode UI:** The app has a dark mode UI with a gradient background.
- **Navigation:** The app has a back button to navigate to the homepage.

## Getting Started

### Prerequisites

- **Flutter SDK:** Ensure you have the Flutter SDK installed on your machine. You can find installation instructions on the official Flutter website: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
- **Dart SDK:** The Dart SDK is included with the Flutter SDK.
- **Google Generative AI API Key:** You'll need a Google Generative AI API key to use the Gemini model. You can obtain one from the Google AI Studio: [https://makersuite.google.com/app/apikey](https://makersuite.google.com/app/apikey)

### Installation

1.  **Clone the Repository:**

    ```bash
    git clone <repository_url>
    cd <project_directory>
    ```

    (Replace `<repository_url>` with the actual repository URL and `<project_directory>` with the project directory name)

2.  **Install Dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Create `.env` File:**

    - Create a `.env` file in the `lib/` directory of your project.
    - Add your Google Generative AI API key to the `.env` file:
      ```
      API_KEY=YOUR_API_KEY_HERE
      ```
      (Replace `YOUR_API_KEY_HERE` with your actual API key.)

4.  **Run the app**
    ```bash
    flutter run
    ```

### Usage

1.  **Launch the App:** Run the Flutter application on your emulator or physical device.
2.  **Navigate to the Learn Page:** Use the app's navigation to access the "Learn" page, where the chat interface is located.
3.  **Input Financial Information:** The app is pre-configured with some sample financial information. You can ask questions based on this information.
4.  **Ask Questions:** Type your financial questions or requests in the input field and press the send button.
5.  **Receive Advice:** The Gemini AI model will process your request and provide a response in the chat interface.
6.  **Navigate back to the homepage:** Press the back button to navigate back to the homepage.

## Project Structure

- `lib/`: Contains the Dart source code for the application.
  - `screens/`: Contains the screen widgets.
    - `learn.dart`: The main file for the financial learning chat interface.
    - `homepage.dart`: The main file for the homepage.
  - `.env`: Stores the API key.

## Dependencies

- `flutter`: The Flutter SDK.
- `google_generative_ai`: The package for interacting with the Google Generative AI API.
- `flutter_dotenv`: The package for reading the .env file.

## Contributing

Contributions to this project are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## Contact

Shiva Matthew Cruz- smvcruz@mymail.mapua.edu.ph
