// OpenSCAD script to create a square traffic sign tilted like a "give way" sign
// Parameters to customize the sign
icon_text = "☢"; // The icon for the top third
main_text = ["EMBRACE", "LITERAL", "PLASTICITY"]; // The main raised text (one word per line)
sub_text = "Because Rocks Don't Live"; // The smaller raised text at the bottom

module traffic_sign(icon, main, sub) {
    sign_size = 120; // The side length of the square
    sign_thickness = 5;
    border_thickness = 3; // Thickness of the border

    // Draw the tilted square base
    color("red") {
        rotate([0, 0, 45]) {
            linear_extrude(height = sign_thickness) {
                square([sign_size, sign_size], center = true);
            }
        }
    }

    // Add a border around the sign
    color("white") {
        rotate([0, 0, 45]) {
            linear_extrude(height = sign_thickness + 0.1) {
                difference() {
                    square([sign_size + border_thickness * 2, sign_size + border_thickness * 2], center = true);
                    square([sign_size, sign_size], center = true);
                }
            }
        }
    }

    // Calculate text scaling to fit within the sign
    text_margin = 10;
    max_text_width = sign_size - 2 * text_margin;

    // Add the icon to the top third
    translate([0, sign_size / 4, sign_thickness + 1]) { // Ensure proper placement above base
        color("white") {
            linear_extrude(height = 2) {
                text(icon, valign="center", halign="center", size = max_text_width / 4, spacing = 1, font="DejaVu Sans"); // Use a font that supports ☢
            }
        }
    }

    // Add the main text to the middle (one word per line)
    for (i = [0 : len(main) - 1]) {
        translate([0, (sign_size / 12) - (i * 12), sign_thickness]) {
            color("white") {
                linear_extrude(height = 2) {
                    text(main[i], valign="center", halign="center", size = max_text_width / 10, spacing = 1);
                }
            }
        }
    }

    // Add the subtext to the bottom third
    translate([0, -sign_size / 4, sign_thickness]) {
        color("white") {
            linear_extrude(height = 2) {
                text(sub, valign="center", halign="center", size = max_text_width / (len(sub) + 10), spacing = 1);
            }
        }
    }
}

// Generate the sign with the specified texts
traffic_sign(icon_text, main_text, sub_text);
