// Feather disable all

function __indieopEnsureInstance()
{
    if (INDIEOP_ENABLE && (not instance_exists(__objIndieop)))
    {
        instance_activate_object(__objIndieop);
        if (instance_exists(__objIndieop))
        {
            __indieopWarning("`__objIndieop` was deactivated. Please ensure that this object instance is never deactivated.");
        }
        else
        {
            instance_create_depth(0, 0, 0, __objIndieop);
        }
    }
}