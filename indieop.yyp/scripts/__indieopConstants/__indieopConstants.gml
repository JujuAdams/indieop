// Feather disable all

#macro INDIEOP_VERSION  "1.0.0"
#macro INDIEOP_DATE     "2025-11-24"

#macro INDIEOP_RUNNING_FROM_IDE  (GM_build_type == "run")

// Constants for the different form types. These map to form type strings as per
// `https://indieop.com/docs/api-reference/post-submit`:
// 
// `INDIEOP_FORM_TYPE_GENERAL`  = `"general"`
// `INDIEOP_FORM_TYPE_FEEDBACK` = `"feedback"`
// `INDIEOP_FORM_TYPE_BUG`      = `"bug_report"
// 
// These constants should be used with `indieopForm()`.
#macro INDIEOP_FORM_TYPE_GENERAL   0
#macro INDIEOP_FORM_TYPE_FEEDBACK  1
#macro INDIEOP_FORM_TYPE_BUG       2