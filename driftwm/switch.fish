#!/usr/bin/fish

set CONFIG_PATH "$HOME/.config/driftwm/config.toml"
set SHADER1 "/usr/share/driftwm/wallpapers/static/blue_drift.glsl"
set SHADER2 "/usr/share/driftwm/wallpapers/animated/dense_clouds.glsl"

if grep -q "$SHADER1" $CONFIG_PATH
    sed -i "s|$SHADER1|$SHADER2|" $CONFIG_PATH
else
    sed -i "s|$SHADER2|$SHADER1|" $CONFIG_PATH
end
