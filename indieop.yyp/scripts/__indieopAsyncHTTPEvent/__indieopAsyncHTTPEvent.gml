function __indieopAsyncHTTPEvent()
{
    static _httpResponseMap = __indieopSystem().__httpResponseMap;
    
    var _id = async_load[? "id"];
    if (ds_map_exists(_httpResponseMap, _id))
    {
        if (async_load[? "status"] == 1)
        {
            return;
        }
        
        var _callbackBinding = _httpResponseMap[? _id];
        
        if ((async_load[? "http_status"] != undefined) && floor(real(async_load[? "http_status"])/100) == 2)
        {
            if (INDIEOP_DEBUG)
            {
                __indieopTrace($"HTTP request successful ({_callbackBinding.__string})");
            }
            
            if (is_callable(_callbackBinding.__callback))
            {
                _callbackBinding.__callback(true, _callbackBinding.__metadata);
            }
        }
        else
        {
            show_debug_message(json_encode(async_load, true));
            __indieopTrace($"Warning! HTTP request failed ({_callbackBinding.__string})");
            
            if (is_callable(_callbackBinding.__callback))
            {
                _callbackBinding.__callback(false, _callbackBinding.__metadata);
            }
        }
        
        ds_map_delete(_httpResponseMap, _id);
    }
}
