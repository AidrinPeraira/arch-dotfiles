#!/bin/bash

# Paths
COLORS_JSON="$HOME/.config/noctalia/colors.json"
KITTY_THEME="$HOME/.config/kitty/dank-theme.conf"
NIRI_COLORS="$HOME/.config/niri/noctalia-colors.kdl"

# Read colors from JSON
get_color() {
    jq -r ".$1" "$COLORS_JSON"
}

PRIMARY=$(get_color "mPrimary")
SECONDARY=$(get_color "mSecondary")
TERTIARY=$(get_color "mTertiary")
SURFACE=$(get_color "mSurface")
SURFACE_VARIANT=$(get_color "mSurfaceVariant")
ON_SURFACE=$(get_color "mOnSurface")
ERROR=$(get_color "mError")
SHADOW=$(get_color "mShadow")

# Update Niri theme file
cat <<EOF > "$NIRI_COLORS"
layout {
    focus-ring {
        active-color "${PRIMARY}CC"
        inactive-color "#00000000"
    }

    border {
        active-color "$PRIMARY"
        inactive-color "$SURFACE_VARIANT"
    }

    shadow {
        color "${SHADOW}70"
    }
}
EOF

# Update Kitty theme file
cat <<EOF > "$KITTY_THEME"
cursor $PRIMARY
cursor_text_color $SURFACE

foreground            $ON_SURFACE
background            $SURFACE
selection_foreground  $SURFACE
selection_background  $PRIMARY
url_color             $SECONDARY

# Black
color0   $SURFACE
color8   $SURFACE

# Red
color1   $ERROR
color9   $ERROR

# Green
color2   $SECONDARY
color10  $SECONDARY

# Yellow
color3   $TERTIARY
color11  $TERTIARY

# Blue
color4   $PRIMARY
color12  $PRIMARY

# Magenta
color5   $TERTIARY
color13  $TERTIARY

# Cyan
color6   $SECONDARY
color14  $SECONDARY

# White
color7   $ON_SURFACE
color15  $ON_SURFACE
EOF

# Tell running Kitty instances to reload
KITTY_SOCKETS=$(find /tmp /run/user/$(id -u) -name "kitty-*" -type s 2>/dev/null)
for socket in $KITTY_SOCKETS; do
    kitty @ --to "unix:$socket" set-colors -a -c "$KITTY_THEME"
done

# Reload Niri configuration
if command -v niri >/dev/null; then
    niri msg action load-config-file
fi

echo "Theme synced!"
