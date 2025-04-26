shader_type spatial;

varying float pente;

void vertex() {
	pente = acos(NORMAL.y);
	// Called for every vertex the material is visible on.
}

uniform vec3 grass : source_color;
uniform vec3 dirt : source_color;

void fragment() {
	float pente_voulue = radians(13.0);
	if (pente > pente_voulue) {
		ALBEDO = dirt;
	}
	else{
		ALBEDO = grass;
	}
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
