shader_type spatial;
uniform sampler2D noise;

void vertex() {
	
	
	float height = texture(noise, (VERTEX.xz / 10.0) - (0.01 * cos(VERTEX.xz + TIME*0.2))).x;
	
	VERTEX.y += height;
	// Called for every vertex the material is visible on.
}

uniform vec3 albedo : source_color;

void fragment() {
	NORMAL = normalize(cross(dFdx(VERTEX),dFdy(VERTEX)));
	ALBEDO = albedo;
	ROUGHNESS = 0.02;
	SPECULAR = 0.1;
	METALLIC = 0.2;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
