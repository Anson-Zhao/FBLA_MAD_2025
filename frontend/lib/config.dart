import 'dart:io';

// final url =
//     Platform.isAndroid ? "http://10.0.2.2:3000/" : "http://10.11.20.195:3000/";
final registration = url + "auth/register"; //endpoint register the user
final login = url + "auth/login";//endpoint login the user
final game_achievements = url + "achievement/games"; //endpoint that get game achievements 
final quiz_achievements = url + "achievement/quizzes"; //endpoint that get quiz achievemtns 
final total_achievements = url + "achievement/total"; //endpoint that get total achievements 
final feedback = url + "feedback/submit-feedback"; // endpoint that send feedback to us
final add_flashcard = url + "flashcards"; //endpoint that add flashcard 
final delete_flashcard = url + "flashcards/"; //endpoint that delete flashcard
final new_achievement = url + "achievement/new_achievement"; // endpoint that get user new achievement
final reset_password = url + "auth/reset-password"; //endpoint to reset password 
final request_password_reset = url + "auth/request-password-reset";//endpoint to reset password 
final code_validation = url + "auth/code-validation"; // endpoint that calidate the code that was sent to user
final get_flashcard = url + "flashcards"; // endpoint that get user flashcard
final game_played = url + "user/recent_quiz_score"; //endpoint that get recent quiz score
final twitter_login = "${url}auth/twitter-login"; //endpoint for twitter log in
final total_winning_games = "${url}user/winning-games"; // endpoint to get total won games
final win_game = "${url}user/win-game";
final quizzes_allowed = "${url}user/total-quiz";
final submit_quiz = "${url}user/api/quiz/submit";
final quiz_score = "${url}user/quiz/total-score";
final quiz_score_by_id = "${url}user/quiz/score/";
final edit_username = "${url}user/edit-username";

// final url = "http://localhost:3000/";
final url = "http://mad2025.northernhorizon:9094/";
// final registration = url + "auth/register";
// final login = url + "auth/login";
// final game_achievements = url + "achievement/games";
// final quiz_achievements = url + "achievement/quizzes";
// final total_achievements = url + "achievement/total";