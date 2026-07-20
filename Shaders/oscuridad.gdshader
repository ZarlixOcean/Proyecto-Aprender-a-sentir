shader_type canvas_item;

uniform vec2 player_uv = vec2(0.5);
uniform float radio = 0.15;
uniform float suavizado = 0.04;
uniform float progreso = 0.0;

void fragment() {
	float dist = distance(SCREEN_UV, player_uv);
	float circle_mask = 1.0 - smoothstep(radio - suavizado, radio + suavizado, dist);
	float alpha = (1.0 - circle_mask) * (1.0 - progreso);
	COLOR = vec4(0.0, 0.0, 0.0, alpha);
}
