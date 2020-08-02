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
    lowp vec4 c = texture2D(inputImageTexture, textureCoordinate);
    lowp float close = max(0., (c.r - c.g));//有多靠近红色
    
    lowp float Y = 0.299*c.r + 0.587*c.g + 0.114*c.b;
    
    // 红色图通过alpha混合进黑白图上
    lowp vec4 result = vec4( mix(vec3(Y, Y, Y), vec3(close, 0, 0), close), c.w);

    gl_FragColor = vec4( mix(c.rgb, result.rgb, percent), result.w);
}