shader_type canvas_item;

uniform float time_scale = 1.0;
uniform float noise_strength = 0.05;

void fragment() {
    vec2 uv = UV;
    uv.y += sin(TIME * time_scale + uv.x * 10.0) * noise_strength;
    COLOR = texture(TEXTURE, uv);
}