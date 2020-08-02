#ifdef GL_ES
precision highp float;
#else
#define highp
#define lowp
#define mediump
#endif
varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform lowp float percent;

void main()
{
lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

gl_FragColor = mix(textureColor, vec4((1.0 - textureColor.rgb), textureColor.w), percent);
}
               