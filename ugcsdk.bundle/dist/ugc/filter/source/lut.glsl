#ifdef GL_ES
precision highp float;
#else
#define highp
#define lowp
#define mediump
#endif
varying vec2 textureCoordinate; 
uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;
uniform lowp float percent;
void main()
{
 vec4 value = texture2D(inputImageTexture, textureCoordinate);
 float r = texture2D(inputImageTexture2, vec2(value.r, 0.5)).r;
 float g = texture2D(inputImageTexture2, vec2(value.g, 0.5)).g;
 float b = texture2D(inputImageTexture2, vec2(value.b, 0.5)).b;
 gl_FragColor = mix(value, vec4(r,g,b,1.0), percent);
} 