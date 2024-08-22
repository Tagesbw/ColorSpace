#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
// ColorSpace
out vec4 GetTagesColor;

void main() {

gl_Position = ProjMat * ModelViewMat * (vec4(Position, 1.0));

// --------------------------------------------------------------------------------------
// ColorSpace (For minecraft 1.20.5 +)
float posSpaceX = (0);
float posSpaceY = (0);
vec4 posSpace = vec4(0);
if((Color).r * 255 == 1 || (Color).r*255 == 2) {
    posSpaceX = (-round(Color.g * 255.0));
    posSpaceY = (-round(Color.b * 255.0));
        if((Color.g * 255.0 >= 128)) {
            posSpaceX = (-round(Color.g*-255.0 + 128));
        }
        if((Color.b * 255.0 >= 128)) {
            posSpaceY = (-round(Color.b*-255.0 + 128));
        }
    if((Color).r*255 == 2) {
    posSpaceX *= 2; posSpaceY *= 2;
    }
    GetTagesColor = Color;
    posSpace = vec4(posSpaceX, posSpaceY, 0, 0);
    gl_Position = ProjMat * ModelViewMat * (vec4(Position, 1.0) + posSpace);
}
// --------------------------------------------------------------------------------------

vertexDistance = fog_distance(Position, FogShape);
vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
texCoord0 = UV0;


}
