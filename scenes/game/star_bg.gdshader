shader_type canvas_item;

uniform sampler2D stars: repeat_enable, filter_nearest;

void fragment() {
    vec4 pixel;
    for (float i = 0.0; i < 3.0; i++) {
        vec2 offset = vec2(i * 0.25, TIME * i * 0.01);

        pixel = texture(stars, UV + offset);
        if (pixel.a > 0.1) {
            COLOR = pixel;
            COLOR.rgb /= 4.0 - i;
        }
    }
    COLOR.rgb *= 0.2;
	COLOR.a = 1.0;
}