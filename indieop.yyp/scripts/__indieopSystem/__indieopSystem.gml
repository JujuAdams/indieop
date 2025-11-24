__indieopSystem();

function __indieopSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        __indieopTrace("Welcome to indieop, implemented by Juju Adams! This is version " + INDIEOP_VERSION + ", " + INDIEOP_DATE);
        
        if (INDIEOP_ENABLE)
        {
            if (INDIEOP_API_KEY == "")
            {
                __indieopError("`INDIEOP_API_KEY` has not been set.");
            }
        }
        
        __playerIdentifier = INDIEOP_PLAYER_IDENTIFIER;
        __httpResponseMap  = ds_map_create();
        
        __indieopEnsureInstance();
        
        if (INDIEOP_ENABLE)
        {
            time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
            {
                __indieopEnsureInstance();
            },
            [], -1));
        }
    }
    
    return _system;
}