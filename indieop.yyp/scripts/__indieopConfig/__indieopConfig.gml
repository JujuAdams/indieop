// Whether to allow HTTP requests to the indieop service. Setting this to `false` will prevent any
// HTTP requests being made. Any calls to `.Submit()` will therefore fail.
#macro INDIEOP_ENABLE  true

// Set this to `true` to see more information about what events this library is sending. This is
// verbose output and likely not useful in production builds.
#macro INDIEOP_DEBUG  false

// The API key for your game. This can be found in the indieop backend.
#macro INDIEOP_API_KEY  ""

// Your game version, as a string.
#macro INDIEOP_GAME_VERSION  GM_version

// The latest repository version, used to track which specific branch and commit was used to build
// the current version of the game. This is optional.
#macro INDIEOP_REPO_VERSION  INDIEOP_GAME_VERSION

// The default player identifier to use. You should overwrite this default value using
// `indieopSetPlayerIdentifier()`.
// 
// N.B. You must be very careful not to use personal information for the player identifier (such
//      as their real name, Steam ID, etc.). You may want to consider hashing information to
//      ensure that nothing that violates your players' privacy is leaked.
// 
#macro INDIEOP_PLAYER_IDENTIFIER  "no player identifier set"