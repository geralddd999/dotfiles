import re
import os
import json

def read_matugen_colors(file_path):
    """
    Reads a color file and returns a dictionary of colors.
    This function is smart and can handle three different formats:
    1. JSON (e.g., {"primary": "#d0bcff"})
    2. SCSS (e.g., $primary: #d0bcff;)
    3. .conf (e.g., primary = #d0bcff)
    """
    colors = {}
    with open(file_path, 'r') as f:
        content = f.read()

    # 1. First, try to read the file as JSON
    try:
        colors = json.loads(content)
        print("Successfully parsed as JSON.")
        return colors
    except json.JSONDecodeError:
        print("Could not parse as JSON. Trying other formats...")

    # 2. If JSON fails, try to read it as SCSS
    # This pattern looks for lines like "$primary: #d0bcff;"
    scss_pattern = re.compile(r'\$(\w+):\s*(#[0-9A-Fa-f]{6});')
    matches = scss_pattern.findall(content)
    if matches:
        colors = dict(matches)
        print("Successfully parsed as SCSS.")
        return colors

    # 3. If SCSS also fails, fall back to the .conf format
    # This pattern looks for lines like "primary = #d0bcff"
    conf_pattern = re.compile(r'(\w+)\s*[:=]\s*(#[0-9A-Fa-f]{6})')
    matches = conf_pattern.findall(content)
    if matches:
        colors = dict(matches)
        print("Successfully parsed as .conf format.")
        return colors
    
    # If no formats match, return an empty dictionary
    print("Warning: Could not recognize the color format.")
    return {}

def update_config_colors(config_file, colors, mappings):
    """
    Updates or adds color key-value pairs in a Kvantum .kvconfig file.

    :param config_file: Path to the .kvconfig file.
    :param colors: Dictionary of colors read from the matugen file.
    :param mappings: Dictionary mapping .kvconfig keys to matugen variable names.
    """
    if not os.path.exists(config_file):
        print(f"Warning: Config file not found at {config_file}. A new file will be created.")
        config_content = ""
    else:
        with open(config_file, 'r') as file:
            config_content = file.read()

    for key, variable in mappings.items():
        # Make the variable lookup case-insensitive for flexibility
        variable_lower = variable.lower()

        # Find the correct matugen variable, ignoring case
        found_color = None
        for matugen_key, matugen_color in colors.items():
            if matugen_key.lower() == variable_lower:
                found_color = matugen_color
                break

        if found_color:
            # Pattern to find 'key=somevalue'
            # This looks for the key at the beginning of a line (^) with optional whitespace
            pattern = re.compile(rf"^(?P<key>{re.escape(key)}=).*", re.MULTILINE)
            new_line = f"{key}={found_color}"

            # If the key is found, substitute the line; otherwise, append the new key-value pair.
            if pattern.search(config_content):
                config_content = pattern.sub(new_line, config_content)
            else:
                config_content += f"\n{new_line}"

    # Ensure the output directory exists
    output_dir = os.path.dirname(config_file)
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    with open(config_file, 'w') as file:
        file.write(config_content)

def main():
    xdg_config_home = os.environ.get("XDG_CONFIG_HOME", os.path.expanduser("~/Others/dotfiles"))

    # Point this to the output file from matugen
    #matugen_colors_file = os.path.expanduser("~/.local/share/color-schemes/DankMatugen.colors")
    matugen_colors_file = os.path.expanduser("~/Others/dotfiles/kde-qt/colors/diff-colors.json") #matugen generated color with colorscheme rainbow

    # Path to the Kvantum config file
    #config_file = os.path.join(xdg_config_home, "Kvantum", "MaterialAdw", "MaterialAdw.kvconfig")
    config_file = os.path.expanduser("~/Others/dotfiles/Kvantum/MaterialAdw/MaterialAdw.kvconfig")
    # --- END OF USER CONFIGURATION ---

    if not os.path.exists(matugen_colors_file):
        print(f"Error: Matugen color file not found at: {matugen_colors_file}")
        print("Please update the 'matugen_colors_file' variable in the script.")
        return

    # Mappings from Kvantum config keys to matugen color variable names
    mappings = {
        'window.color': 'background',
        'base.color': 'background',
        'alt.base.color': 'background',
        'button.color': 'surfaceContainer',
        'light.color': 'surfaceContainerLow',
        'mid.light.color': 'surfaceContainer',
        'dark.color': 'surfaceContainerHighest',
        'mid.color': 'surfaceContainerHigh',
        'highlight.color': 'primary',
        'inactive.highlight.color': 'primary',
        'text.color': 'onBackground',
        'window.text.color': 'onBackground',
        'button.text.color': 'onBackground',
        'disabled.text.color': 'onBackground',
        'tooltip.text.color': 'onBackground',
        'highlight.text.color': 'onSurface',
        'link.color': 'tertiary',
        'link.visited.color': 'tertiaryFixed',
        'progress.indicator.text.color': 'onBackground',
        'text.normal.color': 'onBackground',
        'text.focus.color': 'onBackground',
        'text.press.color': 'onsecondarycontainer',
        'text.toggle.color': 'onsecondarycontainer',
        'text.disabled.color': 'surfaceDim',
        # Add more mappings as needed
    }

    colors = read_matugen_colors(matugen_colors_file)
    if not colors:
        print(f"No colors were read from {matugen_colors_file}. Please check the file format.")
        return

    update_config_colors(config_file, colors, mappings)
    print(f"Kvantum config colors updated successfully in {config_file}!")


if __name__ == "__main__":
    main()
