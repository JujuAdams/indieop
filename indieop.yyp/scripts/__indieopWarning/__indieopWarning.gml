// Feather disable all

function __indieopWarning(_string)
{
    if (INDIEOP_RUNNING_FROM_IDE)
    {
        show_error($" \nindieop:\n{_string}\n ", true);
    }
    else
    {
        show_debug_message($"indieop: Warning! {_string}");
    }
}