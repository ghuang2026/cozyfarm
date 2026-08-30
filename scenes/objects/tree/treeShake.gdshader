shader_type canvas_item;

uniform float shakeIntensity = 0.0;
uniform float shakeSpeed = 5;

void vertex() {
	vec2 shake = vec2(0.0);
	
	if(VERTEX.y < 0.0){
		shake.x = sin(.65 * TIME * shakeSpeed + VERTEX.y) * shakeIntensity;
	}
	VERTEX.xy += shake;
}
