
// final url =
//     Platform.isAndroid ? "http://10.0.2.2:3000/" : "http://10.11.20.195:3000/";
final registration = "${url}auth/register"; // Endpoint to register a new user.
final login = "${url}auth/login"; // Endpoint to authenticate and log in a user.
final game_achievements = "${url}achievement/games"; // Endpoint to retrieve game-related achievements.
final quiz_achievements = "${url}achievement/quizzes"; // Endpoint to retrieve quiz-related achievements.
final total_achievements = url + "achievement/total"; // Endpoint to retrieve the total number of achievements.
final feedback = url + "feedback/submit-feedback"; // Endpoint to submit user feedback.
final add_flashcard = url + "flashcards"; // Endpoint to add a new flashcard.
final delete_flashcard = url + "flashcards/"; // Endpoint to delete a flashcard by ID.
final new_achievement = url + "achievement/new_achievement"; // Endpoint to retrieve the user's newest achievement.
final reset_password = url + "auth/reset-password"; // Endpoint to reset the user's password.
final request_password_reset = url + "auth/request-password-reset"; // Endpoint to request a password reset code.
final code_validation = url + "auth/code-validation"; // Endpoint to validate the password reset code sent to the user.
final get_flashcard = url + "flashcards"; // Endpoint to retrieve all flashcards for the user.
final game_played = url + "user/recent_quiz_score"; // Endpoint to retrieve the user's most recent quiz score.
final twitter_login = "${url}auth/twitter-login"; // Endpoint to authenticate a user via Twitter.
final total_winning_games = "${url}user/winning-games"; // Endpoint to retrieve the total number of games won by the user.
final win_game = "${url}user/win-game"; // Endpoint to record a game win for the user.
final quizzes_allowed = "${url}user/total-quiz"; // Endpoint to check how many quizzes the user is allowed to play.
final submit_quiz = "${url}user/api/quiz/submit"; // Endpoint to submit quiz results.
final quiz_score = "${url}user/quiz/total-score"; // Endpoint to retrieve the user's total quiz score.
final quiz_score_by_id = "${url}user/quiz/score/"; // Endpoint to retrieve a user's quiz score by quiz ID.
final edit_username = "${url}user/edit-username"; // Endpoint to update the user's username.

// final url = "http://localhost:3000/"; // Local development server URL.
final url = "http://mad2025.northernhorizon.org:9094/"; // Production server URL.
// final registration = url + "auth/register";
// final login = url + "auth/login";
// final game_achievements = url + "achievement/games";
// final quiz_achievements = url + "achievement/quizzes";
// final total_achievements = url + "achievement/total";