#!/usr/bin/fish

set CONFIG_PATH "$HOME/.config/driftwm/config.toml"

if grep -q 'window_placement = "auto"' $CONFIG_PATH
    sed -i 's/window_placement = "auto"/window_placement = "cursor"/' $CONFIG_PATH
else
    sed -i 's/window_placement = "cursor"/window_placement = "auto"/' $CONFIG_PATH
end
