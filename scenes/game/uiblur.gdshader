shader_type canvas_item;

uniform sampler2D screen: hint_screen_texture, filter_linear_mipmap;
uniform float anim: hint_range(0.0, 1.0, 0.01) = 0;
uniform float darkening = 0.25;
uniform float bluring = 1;

void fragment() {
	COLOR = textureLod(screen, SCREEN_UV, bluring * anim);
	COLOR.rgb *= 1.0 - anim * darkening;
}
