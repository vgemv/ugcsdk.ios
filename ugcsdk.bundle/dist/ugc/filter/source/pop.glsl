precision lowp float;
varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;

const mediump vec3 luminanceWeighting = vec3(0.2125, 0.7154, 0.0721);

uniform lowp float percent;

void main()
{
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    float luminance = dot(textureColor.rgb, luminanceWeighting) ;
    vec3 firstColor = vec3(0.0,0.0,0.5);
    vec3 secondColor = vec3(1.0,0.0,0.0);
    vec3 resultColor = mix(firstColor, secondColor, luminance).rgb;
    gl_FragColor = vec4( mix(textureColor.rgb, resultColor, percent).rgb, textureColor.a);
}