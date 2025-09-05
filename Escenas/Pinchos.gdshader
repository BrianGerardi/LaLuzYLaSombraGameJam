shader_type canvas_item;

uniform float glow_strength = 0.8; // intensidad del brillo
uniform float glow_size = 3.5;     // tamaño del halo

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    
    if (tex.a < 0.1) {
        // si no hay sprite, dejamos transparente
        COLOR = vec4(0.0);
    }

    // color base del sprite
    vec3 base_color = tex.rgb;

    // calculamos brillo hacia afuera usando la distancia al borde
    float dist = length(UV - vec2(0.5)) * glow_size;
    float glow = exp(-dist * dist) * glow_strength; 

    // sumamos el halo al color original
    COLOR = vec4(base_color + base_color * glow, tex.a);
}