shader_type canvas_item;

uniform float time : hint_range(0.0, 1.0, 0.1);
uniform bool flip;

void fragment() {
	float spike = sin(UV.y * 31.4) / 10.0;
	float x = UV.x * .4 + .3;
	COLOR.a = ceil(x - time + spike);
	if(flip) {
		COLOR.a = 1.0 - COLOR.a;
	}
}