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

def update_svg_colors(svg_path, old_to_new_colors, output_path):
    """
    Updates the colors in an SVG file based on the provided color map.

    :param svg_path: Path to the SVG file.
    :param old_to_new_colors: Dictionary mapping old colors to new colors.
    :param output_path: Path to save the updated SVG file.
    """
    # Read the SVG content
    with open(svg_path, 'r') as file:
        svg_content = file.read()

    # Replace old colors with new colors
    for old_color, new_color in old_to_new_colors.items():
        # Using a function in re.sub for case-insensitive replacement of the hex value
        # This ensures that if the SVG has #FFFFFF and you want to replace #ffffff, it still works.
        def replacement(match):
            return new_color

        svg_content = re.sub(re.escape(old_color), replacement, svg_content, flags=re.IGNORECASE)

    # Ensure the output directory exists
    output_dir = os.path.dirname(output_path)
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    # Write the updated SVG content to the output file
    with open(output_path, 'w') as file:
        file.write(svg_content)

    print(f"SVG colors have been updated and saved to {output_path}!")

def main():
    xdg_config_home = os.environ.get("XDG_CONFIG_HOME", os.path.expanduser("~/Other/nixos-dotfiles"))

    # Point this thang to the output file from matugen
    matugen_colors_file = os.path.expanduser("~/Other/nixos-dotfiles/kde-qt/colors/colors.json")

    # Path to your source SVG file
    svg_path = os.path.join(xdg_config_home, "Kvantum", "Colloid", "ColloidDark.svg")

    # Path where the newly colored SVG will be saved
    output_path = os.path.join(xdg_config_home, "Kvantum", "MaterialAdw", "MaterialAdw.svg")
    # --- END OF USER CONFIGURATION ---

    if not os.path.exists(matugen_colors_file):
        print(f"Error: Matugen color file not found at: {matugen_colors_file}")
        print("Please update the 'matugen_colors_file' variable in the script.")
        return

    # Read colors from the matugen file
    color_data = read_matugen_colors(matugen_colors_file)

    if not color_data:
        print(f"No colors were read from {matugen_colors_file}. Please check the file format.")
        return

    # Specify the old colors and map them to new colors from the matugen file
    # You can now use the keys directly from your matugen colors file.
    old_to_new_colors = {
        '#31363b': color_data.get('background', '#31363b'),
        '#000000': color_data.get('shadow', '#000000'),
        '#5b9bf8': color_data.get('primary', '#5b9bf8'),
        '#93cee9': color_data.get('onSecondaryContainer', '#93cee9'),
        '#3daee9': color_data.get('secondary', '#3daee9'),
        '#ffffff': color_data.get('onPrimary', '#ffffff'),
        '#5a616e': color_data.get('surfaceVariant', '#5a616e'),
        '#f04a50': color_data.get('error', '#f04a50'),
        '#4285f4': color_data.get('secondary', '#4285f4'), # Duplicate key, will be overridden by the one above
        '#242424': color_data.get('background', '#242424'),
        '#2c2c2c': color_data.get('background', '#2c2c2c'),
        '#1e1e1e': color_data.get('background', '#1e1e1e'),
        '#3c3c3c': color_data.get('background', '#3c3c3c'),
        '#26272a': color_data.get('surfaceBright', '#26272a'),
        '#b74aff': color_data.get('tertiary', '#b74aff'),
        '#1a1a1a': color_data.get('background', '#1a1a1a'),
        '#333333': color_data.get('onSurface', '#333333'), # Used 333333 instead of 333
        '#212121': color_data.get('background', '#212121'),
    }

    # Update the SVG colors
    update_svg_colors(svg_path, old_to_new_colors, output_path)

if __name__ == "__main__":
    main()
