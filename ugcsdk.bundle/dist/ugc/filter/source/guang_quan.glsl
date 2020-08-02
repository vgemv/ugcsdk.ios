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
    lowp vec2 vignetteCenter = vec2(0.5,0.5);
    lowp vec3 vignetteColor = vec3(0.0,0.0,0.0);
    highp float vignetteStart = 0.3 / percent;
    highp float vignetteEnd = 0.75 / percent;
    lowp vec4 sourceImageColor = texture2D(inputImageTexture, textureCoordinate);
    lowp float d = distance(textureCoordinate, vec2(vignetteCenter.x, vignetteCenter.y));
    lowp float percent = smoothstep(vignetteStart, vignetteEnd, d);
    gl_FragColor = vec4(mix(sourceImageColor.rgb, vignetteColor, percent), sourceImageColor.a);
}
