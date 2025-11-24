new indieopForm("test form", "test tag", INDIEOP_FORM_TYPE_GENERAL)
.FieldRating("rating", "Overall Rating", 5)
.FieldCheckbox("enjoyed", "Did you enjoy the game?", true)
.FieldDropdown("difficulty", "Difficulty Level", "Medium", ["Easy", "Medium", "Hard"])
.FieldText("comments", "Additional Comments", "Great game! Really enjoyed the gameplay.")
.Submit(function(_success)
{
    show_debug_message(_success? "Submissions was successful" : "Submission failed");
});