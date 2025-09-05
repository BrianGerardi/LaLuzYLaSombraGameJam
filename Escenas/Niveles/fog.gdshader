shader_type canvas_item;

uniform float speed = 0.05;
uniform float contraste = 5.0;
uniform float densidad = 0.3;
uniform sampler2D noise_tex;

void fragment() {
    vec2 uv1 = UV + vec2(TIME * speed, 0.0);
    vec2 uv2 = UV - vec2(TIME * speed * 0.5, 0.0);
	vec2 uv3 = UV - vec2(TIME * speed * 0.3, 0.0);
	vec2 uv4 = UV - vec2(TIME * speed * 0.4, 0.0);
	vec2 uv5 = UV - vec2(TIME * speed * 0.7, 0.0); // segunda capa más lenta

    float n1 = texture(noise_tex, fract(uv1)).r;
    float n2 = texture(noise_tex, fract(uv2)).r;
	float n3 = texture(noise_tex, fract(uv3)).r;
	float n4 = texture(noise_tex, fract(uv4)).r;
    float n5 = texture(noise_tex, fract(uv5)).r;

    float n = (n1 + n2) * 0.5; // mezcla

    n = pow(n, contraste);
    COLOR = vec4(0.8, 0.8, 0.8, n * densidad);
}