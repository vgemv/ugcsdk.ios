

// uniform  sampler2D inputImageTexture;
// uniform  sampler2D inputImageTexture2;
// varying  vec2 textureCoordinate;

// uniform float percent;

// vec4 lut3d(vec4 textureColor)
// {
//     float blueColor = textureColor.b * 15.0;
//     vec2 quad1;
//     quad1.y = max(min(4.0,floor(floor(blueColor) / 4.0)),0.0);
//     quad1.x = max(min(4.0,floor(blueColor) - (quad1.y * 4.0)),0.0);

//     vec2 quad2;
//     quad2.y = max(min(floor(ceil(blueColor) / 4.0),4.0),0.0);
//     quad2.x = max(min(ceil(blueColor) - (quad2.y * 4.0),4.0),0.0);

//     vec2 texPos1;
//     texPos1.x = (quad1.x * 0.25) + 0.5/64.0 + ((0.25 - 1.0/64.0) * textureColor.r);
//     texPos1.y = (quad1.y * 0.25) + 0.5/64.0 + ((0.25 - 1.0/64.0) * textureColor.g);

//     vec2 texPos2;
//     texPos2.x = (quad2.x * 0.25) + 0.5/64.0 + ((0.25 - 1.0/64.0) * textureColor.r);
//     texPos2.y = (quad2.y * 0.25) + 0.5/64.0 + ((0.25 - 1.0/64.0) * textureColor.g);

//     vec4 newColor1 = texture2D(inputImageTexture2, texPos1);
//     vec4 newColor2 = texture2D(inputImageTexture2, texPos2);

//     vec4 newColor = mix(newColor1, newColor2, fract(blueColor));
//     return newColor;
// }
// void main()
// {
//     vec4 orgColor = texture2D(inputImageTexture, textureCoordinate);
//     gl_FragColor = mix(orgColor,lut3d(orgColor), percent);
// }
      
varying vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;
uniform sampler2D inputImageTexture3;
uniform sampler2D inputImageTexture4;
uniform sampler2D inputImageTexture5;

void main(void)
{
    vec4 oralData = texture2D(inputImageTexture, textureCoordinate).rgba;
    vec3 temp1 = texture2D(inputImageTexture2, textureCoordinate).rgb;
    vec3 temp2 = texture2D(inputImageTexture3, textureCoordinate).rgb;

    oralData.r = oralData.r *0.7+0.3*texture2D(inputImageTexture5,vec2(temp2.r,oralData.r)).r;
    oralData.g = oralData.g *0.7+0.3*texture2D(inputImageTexture5,vec2(temp2.g,oralData.g)).r;
    oralData.b = oralData.b *0.7+0.3*texture2D(inputImageTexture5,vec2(temp2.b,oralData.b)).r;

    oralData.r = oralData.r *0.6+0.4*texture2D(inputImageTexture5,vec2(temp1.r,oralData.r)).r;
    oralData.g = oralData.g *0.6+0.4*texture2D(inputImageTexture5,vec2(temp1.g,oralData.g)).r;
    oralData.b = oralData.b *0.6+0.4*texture2D(inputImageTexture5,vec2(temp1.b,oralData.b)).r;

    oralData.r = texture2D( inputImageTexture4, vec2(oralData.r,0.5)).r;
    oralData.g = texture2D( inputImageTexture4, vec2(oralData.g,0.5)).g;
    oralData.b = texture2D( inputImageTexture4, vec2(oralData.b,0.5)).b;

    gl_FragColor = oralData;
}
      