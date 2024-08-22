#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

out vec4 fragColor;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
// ColorSpace
in vec4 GetTagesColor;

void main() {

vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;

// --------------------------------------------------------------------------------------
// ColorSpace (For minecraft 1.20.5 +)
    if(GetTagesColor.r*255 == 1 || GetTagesColor.r*255 == 2) {
        color = texture(Sampler0,texCoord0) * vec4(1) * ColorModulator;
        } else
        if ((color).r *255 <= 1 / 4) {
    color = vec4(0);
    }
// --------------------------------------------------------------------------------------


fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);

if (color.a < 0.1) {
    discard;
}
}
