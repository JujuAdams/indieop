// Feather disable all

/// Returns the current player identifier set for future indieop submissions.

function indieopGetPlayerIdentifier()
{
    static _system = __indieopSystem();
    return _system.__playerIdentifier;
}