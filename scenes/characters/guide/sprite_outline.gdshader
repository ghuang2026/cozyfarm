shader_type canvas_item;

uniform vec4 original_0: source_color;
uniform vec4 original_1: source_color;

uniform vec4 replace_0: source_color;
uniform vec4 replace_1: source_color;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	
	if(distance(color, original_0) <= .1){
		color = replace_0;
	}
	else if(distance(color, original_1) <= .1){
		color = replace_1;
	}
	COLOR = color;
}
