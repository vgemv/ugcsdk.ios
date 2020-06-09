varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
const highp vec2 iResolution= vec2(540.0,960.0);
const highp float radius = 12.0;

uniform highp float area_x;
uniform highp float area_y;
uniform highp float area_w;
uniform highp float area_h;
uniform highp float percent;
uniform highp float width;
uniform highp float height;

void main() {
    if(area_w > 0.0 && area_h > 0.0)
        if( textureCoordinate.x < area_x/width 
            || textureCoordinate.y < area_y/height 
            || textureCoordinate.x > (area_x+area_w)/width
            || textureCoordinate.y > (area_y+area_h)/height
        ){
            gl_FragColor = texture2D(inputImageTexture, textureCoordinate);
            return;
        }
    highp float x = textureCoordinate.x * iResolution.x;
    highp float y = textureCoordinate.y * iResolution.y;
    highp float radias_p = radius * percent;
    highp float realX = floor(x/radias_p + 0.5) * radias_p;
    highp float realY = floor(y/radias_p + 0.5) * radias_p;
    gl_FragColor = texture2D(inputImageTexture, vec2(realX/iResolution.x, realY/iResolution.y) );
}
