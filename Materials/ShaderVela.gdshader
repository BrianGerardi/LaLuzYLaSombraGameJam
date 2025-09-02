shader_type canvas_item;
render_mode blend_mix;

uniform float speed : hint_range(0.1, 10.0) = 1.0;       // Velocidad del flameo
uniform float amplitude : hint_range(0.0, 10.0) = 1.0;   // Intensidad del movimiento en px
uniform float top_height : hint_range(0.0, 1.0) = 1.0;   // A partir de qué parte superior empieza a moverse (0 abajo, 1 arriba)
uniform float smoothness : hint_range(0.0, 1.0) = 0.2;   // Suavizado del blend

void vertex() {
    float t = TIME * speed;

    // En vez de usar UV.y (que es 0 abajo y 1 arriba) lo invertimos
    float mask = smoothstep(top_height, top_height - smoothness, UV.y);

    // Movimiento horizontal senoidal
    float offset = sin(t + VERTEX.y * 0.01) * amplitude * mask;

    VERTEX.x += offset;
}