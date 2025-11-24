// Feather disable all

function __indieopTrace()
{
    var _string = "indieop: ";
    
    var _i = 0;
    repeat(argument_count)
    {
        _string += argument[_i];
        ++_i;
    }
    
    show_debug_message(_string);
    
    return _string;
}