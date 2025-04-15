shader_type spatial;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

uniform float pixel_size = 0.02; // Taille des pixels
uniform float color_steps = 8.0; // Quantification des couleurs

void fragment() {
    // Taille de l'écran en pixels
    vec2 screen_res = vec2(textureSize(SCREEN_TEXTURE, 0));

    // Conversion des UV en pixels écran
    vec2 uv = SCREEN_UV * screen_res;

    // Pixelisation ultra précise : alignement exact de chaque pixel
    vec2 pixel_uv = round(uv / pixel_size) * pixel_size;

    // Remettre les UV en échelle 0-1
    pixel_uv /= screen_res;

    // Échantillonnage ultra net sans interpolation
    vec4 col = textureLod(SCREEN_TEXTURE, pixel_uv, 0.0);

    // Quantification des couleurs pour un effet encore plus net
    col.rgb = floor(col.rgb * color_steps) / color_steps;

    // Appliquer la couleur finale
    ALBEDO = col.rgb;
}