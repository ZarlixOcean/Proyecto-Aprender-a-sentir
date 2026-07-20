shader_type canvas_item;

uniform vec2 player_uv = vec2(0.5);
uniform float radio = 0.15;
uniform float oscuridad = 0.03;
uniform float suavizado = 0.04;

void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	float dist = distance(SCREEN_UV, player_uv);
	float t = (radio - dist) / suavizado;
	float alpha = clamp(t, 0.0, 1.0);
	vec3 dark = color.rgb * oscuridad;
	COLOR.rgb = mix(dark, color.rgb, alpha);
	COLOR.a = mix(1.0, 0.0, alpha);
}
