varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform sampler2D mask;

float rand(vec2 n)
{ 
	return fract( sin( dot( n, vec2(12.9898, 4.1414) ) ) * 43758.5453 );
}

float noise(vec2 n)
{
	const vec2 d = vec2( 0.0, 1.0 );
	vec2 b = floor( n ), f = smoothstep( vec2(0.0), vec2(1.0), fract(n) );
	return mix( mix( rand(b), rand(b + d.yx), f.x ), mix( rand(b + d.xy), rand(b + d.yy), f.x ), f.y );
}

// Rotate to reduce axial bias
const mat2 rot = mat2( 0.8, -0.6, 0.6, 0.8 );

float fbm( vec2 p )
{
    float f = 0.0;
    f += 0.5000 * noise( p ); p = rot * p * 2.02;
    f += 0.2500 * noise( p ); p = rot * p * 2.03;
    f += 0.1250 * noise( p ); p = rot * p * 2.01;
    f += 0.0625 * noise( p );

    return f / 0.9375;
}

void main() {
    vec2 time_offset = vec2(time, -time / 2.0) / 4.0;
	vec2 n=(v_vTexcoord + time_offset);
    float brightness = fbm(n) - 0.5;
    vec2 offset = vec2(brightness, 0.0) / 4.0;
	vec4 sample = texture2D(mask,v_vTexcoord);
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, mix( v_vTexcoord, v_vTexcoord + offset, sample.r ) );
}