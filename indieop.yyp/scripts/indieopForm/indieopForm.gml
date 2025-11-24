// Feather disable all

/// Constructor that creates a new form to submit to indieop. `indieopForm()` itself takes three
/// parameters. These are the form name and tag, both of which should be strings, and the third
/// parameter is the form type. The form type should be one of the `INDIEOP_FORM_TYPE_*` constants.
/// The player identifier should be set via `indieopSetPlayerIdentifier()`. The player identifier is
/// "baked" into the form when `indieopForm()` is called.
/// 
/// For further information, please visit `https://indieop.com/docs/api-reference/post-submit`.
///  
/// The form should be composed using the chained method interface (a "fluent interface") using the
/// following methods:
/// 
/// `.FieldText(key, label, value)`
/// `.FieldCheckbox(key, label, value)`
/// `.FieldDropdown(key, label, value, optionArray)`
/// `.FieldRating(key, label, value)`
/// 
/// When you are ready to submit the form, call this method:
/// 
/// `.Submit([callback], [metadata=undefined])`
/// 
/// If you've provided a valid callback then the callback will be executed with two parameters. The
/// first parameter is a boolean success/fail flag that represents whether the HTTP request was
/// successful. The second parameter is the `metadata` value that you passed in when calling
/// `.Submit()`.
/// 
/// Suggested usage:
/// 
///   new indieopForm("test form", "test tag", INDIEOP_FORM_TYPE_GENERAL)
///   .FieldRating("rating", "Overall Rating", 5)
///   .FieldCheckbox("enjoyed", "Did you enjoy the game?", true)
///   .FieldDropdown("difficulty", "Difficulty Level", "Medium", ["Easy", "Medium", "Hard"])
///   .FieldText("comments", "Additional Comments", "Great game! Really enjoyed the gameplay.")
///   .Submit(function(_success)
///   {
///       show_debug_message(_success? "Submissions was successful" : "Submission failed");
///   });
/// 
/// @param formName
/// @param tag
/// @param formType

function indieopForm(_formName, _tag, _formType) constructor
{
    static _system = __indieopSystem();
    static _httpResponseMap = _system.__httpResponseMap;
    
    __fieldArray = [];
    __keyDict = {};
    
    if (_formType == INDIEOP_FORM_TYPE_FEEDBACK)
    {
        var _formTypeString = "feedback";
    }
    else if (_formType == INDIEOP_FORM_TYPE_BUG)
    {
        var _formTypeString = "bug_report";
    }
    else
    {
        var _formTypeString = "general";
    }
    
    __payload = {
        form_name:         string_copy(string(_formName), 1, 255),
        tag:               string_copy(string(_tag), 1, 100),
        form_type:         _formTypeString,
        player_identifier: string_copy(_system.__playerIdentifier, 1, 255),
        game_version:      string_copy(string(INDIEOP_GAME_VERSION), 1,  50),
        repo_version:      string_copy(string(INDIEOP_REPO_VERSION), 1, 100),
        fields:            __fieldArray,
    };
    
    static __Field = function(_key, _label, _value, _type, _optionArray = undefined)
    {
        _key   = string_copy(string(_key),   1, 100);
        _label = string_copy(string(_label), 1, 255);
        
        if (struct_exists(__keyDict, _key))
        {
            __indieopWarning($"Key \"{_key}\" already exists");
            return;
        }
        
        __keyDict[$ _key] = true;
        
        array_push(__fieldArray, { "key": _key, "label": _label, "value": string(_value), "type": "text" });
    }
    
    static FieldText = function(_key, _label, _value)
    {
        __Field(_key, _label, string(_value), "text");
        return self;
    }
    
    static FieldCheckbox = function(_key, _label, _value)
    {
        try
        {
            _value = bool(_value);
        }
        catch(_error)
        {
            show_debug_message(json_stringify(_error));
            __indieopWarning($"Value \"{_value}\" invalid for `.FieldCheckbox()`");
            return self;
        }
        
        __Field(_key, _label, _value, "checkbox");
        return self;
    }
    
    static FieldDropdown = function(_key, _label, _value, _optionArray)
    {
        if (not is_array(_optionArray))
        {
            __indieopWarning($"Option array \"{_optionArray}\" invalid for `.FieldDropdown()`");
            return self;
        }
        
        var _i = 0;
        repeat(array_length(_optionArray))
        {
            _optionArray[@ _i] = string(_optionArray[_i]);
            ++_i;
        }
        
        _value = string(_value);
        
        if (array_get_index(_optionArray, _value) < 0)
        {
            __indieopWarning($"Value \"{_value}\" does not match any element of the option array ({json_stringify(_optionArray)})");
            return self;
        }
        
        __Field(_key, _label, _value, "dropdown", _optionArray);
        return self;
    }
    
    static FieldRating = function(_key, _label, _value)
    {
        try
        {
            _value = real(_value);
        }
        catch(_error)
        {
            show_debug_message(json_stringify(_error));
            __indieopWarning($"Value \"{_value}\" invalid for `.FieldRating()`");
            return self;
        }
        
        _value = clamp(round(_value), 1, 5);
        
        __Field(_key, _label, _value, "rating");
        return self;
    }
    
    static Submit = function(_callback = undefined, _metadata = undefined)
    {
        static _map = (function()
        {
            var _map = ds_map_create();
            _map[? "X-API-Key"   ] = INDIEOP_API_KEY;
            _map[? "Content-Type"] = "application/json";
            return _map;
        })();
        
        __indieopEnsureInstance();
        
        var _string = json_stringify(__payload);
        var _callbackBinding = { __string: _string, __callback: _callback, __metadata: _metadata };
        
        if (INDIEOP_ENABLE)
        {
            var _id = http_request("https://indieop.com/api/sdk/submit", "POST", _map, _string);
            
            if (INDIEOP_DEBUG)
            {
                __indieopTrace("Sent HTTP request for event \"", _string, "\"");
            }
            
            if (INDIEOP_DEBUG || is_callable(_callback))
            {
                _httpResponseMap[? _id] = _callbackBinding;
            }
        }
        else
        {
            if (INDIEOP_DEBUG) __indieopTrace("HTTP request blocked (`INDIEOP_ENABLE` = `fdlse`) \"", _string, "\"");
            
            if (is_callable(_callback))
            {
                call_later(1, time_source_units_frames, method(_callbackBinding, function() { __callback(false, __metadata); }));
            }
        }
    }
}