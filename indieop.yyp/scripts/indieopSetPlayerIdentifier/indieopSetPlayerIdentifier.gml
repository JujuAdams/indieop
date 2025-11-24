// Feather disable all

/// Sets the current player identifier for future submissions to the indieop service. The player
/// identifier should be a string between 1 and 255 characters long.
/// 
/// N.B. You must be very careful not to use personal information for the player identifier (such
///      as their real name, Steam ID, etc.). You may want to consider hashing information to
///      ensure that nothing that violates your players' privacy is leaked.
/// 
/// For more information, please see `https://indieop.com/docs/api-reference/post-submit`.
/// 
/// @param playerIdentifier

function indieopSetPlayerIdentifier(_playerIdentifier)
{
    static _system = __indieopSystem();
    _system.__playerIdentifier = string_copy(string(_playerIdentifier), 1, 255);
    
    if (INDIEOP_DEBUG)
    {
        __indieopTrace($"Set player identifier to \"{_system.__playerIdentifier}\"");
    }
}