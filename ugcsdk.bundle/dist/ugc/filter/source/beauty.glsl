precision highp float;
varying vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
uniform float percent;
uniform float width;
uniform float height;

const vec3 W=vec3(.299,.587,.114);
const mat3 saturateMatrix=mat3(
    1.1102,-.0598,-.061,
    -.0774,1.0826,-.1186,
-.0228,-.0228,1.1772);
vec2 blurCoordinates[24];

float hardLight(float color){
    if(color<=.5)
    color=color*color*2.;
    else
    color=1.-((1.-color)*(1.-color)*2.);
    return color;
}

void main(){

    float beauty = mix(0., 2., percent);//0~2.5
    float tone = mix(0., .5, percent);//-5~5
    vec4 params=vec4(
        1.0 - 0.6 * beauty,
        1.0 - 0.3 * beauty,
        0.1 + 0.3 * tone,
        0.1 + 0.3 * tone);
    float brightness = mix(0., 0.05, percent);//0~1
    float texelWidthOffset = mix(0., .5, percent)/width;//-10~10
    float texelHeightOffset = mix(0., .5, percent)/height;

    vec3 centralColor=texture2D(inputImageTexture,textureCoordinate).rgb;
    vec2 singleStepOffset=vec2(texelWidthOffset,texelHeightOffset);
    blurCoordinates[0]=textureCoordinate.xy+singleStepOffset*vec2(0.,-10.);
    blurCoordinates[1]=textureCoordinate.xy+singleStepOffset*vec2(0.,10.);
    blurCoordinates[2]=textureCoordinate.xy+singleStepOffset*vec2(-10.,0.);
    blurCoordinates[3]=textureCoordinate.xy+singleStepOffset*vec2(10.,0.);
    blurCoordinates[4]=textureCoordinate.xy+singleStepOffset*vec2(5.,-8.);
    blurCoordinates[5]=textureCoordinate.xy+singleStepOffset*vec2(5.,8.);
    blurCoordinates[6]=textureCoordinate.xy+singleStepOffset*vec2(-5.,8.);
    blurCoordinates[7]=textureCoordinate.xy+singleStepOffset*vec2(-5.,-8.);
    blurCoordinates[8]=textureCoordinate.xy+singleStepOffset*vec2(8.,-5.);
    blurCoordinates[9]=textureCoordinate.xy+singleStepOffset*vec2(8.,5.);
    blurCoordinates[10]=textureCoordinate.xy+singleStepOffset*vec2(-8.,5.);
    blurCoordinates[11]=textureCoordinate.xy+singleStepOffset*vec2(-8.,-5.);
    blurCoordinates[12]=textureCoordinate.xy+singleStepOffset*vec2(0.,-6.);
    blurCoordinates[13]=textureCoordinate.xy+singleStepOffset*vec2(0.,6.);
    blurCoordinates[14]=textureCoordinate.xy+singleStepOffset*vec2(6.,0.);
    blurCoordinates[15]=textureCoordinate.xy+singleStepOffset*vec2(-6.,0.);
    blurCoordinates[16]=textureCoordinate.xy+singleStepOffset*vec2(-4.,-4.);
    blurCoordinates[17]=textureCoordinate.xy+singleStepOffset*vec2(-4.,4.);
    blurCoordinates[18]=textureCoordinate.xy+singleStepOffset*vec2(4.,-4.);
    blurCoordinates[19]=textureCoordinate.xy+singleStepOffset*vec2(4.,4.);
    blurCoordinates[20]=textureCoordinate.xy+singleStepOffset*vec2(-2.,-2.);
    blurCoordinates[21]=textureCoordinate.xy+singleStepOffset*vec2(-2.,2.);
    blurCoordinates[22]=textureCoordinate.xy+singleStepOffset*vec2(2.,-2.);
    blurCoordinates[23]=textureCoordinate.xy+singleStepOffset*vec2(2.,2.);
    
    float sampleColor=centralColor.g*22.;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[0]).g;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[1]).g;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[2]).g;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[3]).g;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[4]).g;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[5]).g;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[6]).g;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[7]).g;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[8]).g;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[9]).g;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[10]).g;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[11]).g;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[12]).g*2.;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[13]).g*2.;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[14]).g*2.;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[15]).g*2.;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[16]).g*2.;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[17]).g*2.;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[18]).g*2.;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[19]).g*2.;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[20]).g*3.;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[21]).g*3.;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[22]).g*3.;
    sampleColor+=texture2D(inputImageTexture,blurCoordinates[23]).g*3.;
    
    sampleColor=sampleColor/62.;
    
    float highPass=centralColor.g-sampleColor+.5;
    
    for(int i=0;i<5;i++){
        highPass=hardLight(highPass);
    }
    float lumance=dot(centralColor,W);
    
    float alpha=pow(lumance,params.r);
    
    vec3 smoothColor=centralColor+(centralColor-vec3(highPass))*alpha*.1;
    
    smoothColor.r=clamp(pow(smoothColor.r,params.g),0.,1.);
    smoothColor.g=clamp(pow(smoothColor.g,params.g),0.,1.);
    smoothColor.b=clamp(pow(smoothColor.b,params.g),0.,1.);
    
    vec3 lvse=vec3(1.)-(vec3(1.)-smoothColor)*(vec3(1.)-centralColor);
    vec3 bianliang=max(smoothColor,centralColor);
    vec3 rouguang=2.*centralColor*smoothColor+centralColor*centralColor-2.*centralColor*centralColor*smoothColor;
    
    gl_FragColor=vec4(mix(centralColor,lvse,alpha),1.);
    gl_FragColor.rgb=mix(gl_FragColor.rgb,bianliang,alpha);
    gl_FragColor.rgb=mix(gl_FragColor.rgb,rouguang,params.b);
    
    vec3 satcolor=gl_FragColor.rgb*saturateMatrix;
    gl_FragColor.rgb=mix(gl_FragColor.rgb,satcolor,params.a);
    gl_FragColor.rgb=vec3(gl_FragColor.rgb+vec3(brightness));
}
