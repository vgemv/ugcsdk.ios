
// uniform vec2 texture_size;

// uniform sampler2D inputImageTexture;
// uniform sampler2D inputImageTexture2;
uniform sampler2D texRGB; // Y
uniform sampler2D texY; // Y
uniform sampler2D texUV; // U
uniform sampler2D texU; // U
uniform sampler2D texV; // U

uniform int iformat;
uniform int oformat;

const int AV_PIX_FMT_NONE 		= -1;
const int AV_PIX_FMT_YUV420P 	= 0;
const int AV_PIX_FMT_NV12		= 23;
const int AV_PIX_FMT_NV21		= 24;
const int AV_PIX_FMT_RGBA		= 26;
const int AV_PIX_FMT_RGB24		= 2;
const int AV_PIX_FMT_AYUV64LE 	= 158;
const int AV_PIX_FMT_AYUV64BE 	= 159;

varying vec2 textureCoordinate;
uniform float width;
uniform float height;

uniform float area_x;
uniform float area_y;
uniform float area_w;
uniform float area_h;
uniform vec4 padding_color;

vec3 yuv2rgb(in vec3 yuv)
{
	// YUV offset
	// const vec3 offset = vec3(-0.0625, -0.5, -0.5);
	const vec3 offset = vec3(-0.0625, -0.5, -0.5);
	// RGB coefficients
	const vec3 Rcoeff = vec3( 1.164, 0.000,  1.596);
	const vec3 Gcoeff = vec3( 1.164, -0.391, -0.813);
	const vec3 Bcoeff = vec3( 1.164, 2.018,  0.000);

	vec3 rgb;

	yuv = clamp(yuv, 0.0, 1.0);

	yuv += offset;

	rgb.r = dot(yuv, Rcoeff);
	rgb.g = dot(yuv, Gcoeff);
	rgb.b = dot(yuv, Bcoeff);

	return rgb;
}

vec3 rgb2yuv(in vec3 rgb){
	vec3 yuv = vec3(0.0);

	// const vec3 Ycoeff = vec3( 0.299, 0.587, 0.114);
	// const vec3 Ucoeff = vec3( -0.14713, -0.28886, 0.436);
	// const vec3 Vcoeff = vec3( 0.615, -0.51499, -0.10001);

	// yuv.x = dot(rgb, Ycoeff);
	// yuv.y = dot(rgb, Ucoeff)+0.5;
	// yuv.z = dot(rgb, Vcoeff)+0.5;

	yuv.x = rgb.r * 0.299 + rgb.g * 0.587 + rgb.b * 0.114;
	yuv.y = rgb.r * -0.169 + rgb.g * -0.331 + rgb.b * 0.5 + 0.5;
	yuv.z = rgb.r * 0.5 + rgb.g * -0.419 + rgb.b * -0.081 + 0.5;


	return yuv;
}

vec2 remap_coord(in vec2 tcoord)
{
	bool oYUV = false;//oformat == AV_PIX_FMT_NV21 || oformat == AV_PIX_FMT_NV12 || oformat == AV_PIX_FMT_YUV420P ;

	//如果是 yuv，宽度会多出 0.5（用于放置 uv 通道），此时坐标需要修正
	/*
		nv12/nv21
		-------------------
		|          |  uv  |
		|     y    |-------
		|          |      |
		-------------------
		yuv420p
		-------------------
		|          |   u  |
		|     y    |-------
		|          |   v  |
		-------------------
	*/
	if(oYUV){
		if(tcoord.x > 2.0/3.0){ // 绘制坐标去到了 uv 区域，把坐标映射回 0～1 区域
			tcoord.x = (tcoord.x - 2.0/3.0) * 3.0;
			if(tcoord.y > 0.5){
				tcoord.y -= 0.5;
			}
			tcoord.y *= 2.0;
		} else { // y 区域，坐标放大，映射到 0~1 区域
			tcoord.x *= 1.5;
		}
	}

	return vec2(
		tcoord.x * ( area_x * 2.0 + area_w ) / area_w - ( area_x ) / area_w,
		tcoord.y * ( area_y * 2.0 + area_h ) / area_h - ( area_y ) / area_h
	);
}

vec4 get_color_from_texture(in vec2 tcoord)
{
	bool isYUV = false;
	vec3 yuv;
	vec4 rgba;
	yuv.x = texture2D(texY, tcoord).r;

	if ( iformat == AV_PIX_FMT_NV21 ) {
		yuv.y = texture2D(texUV, tcoord).a;
		yuv.z = texture2D(texUV, tcoord).x;
		isYUV = true;
	} else if ( iformat == AV_PIX_FMT_NV12 ) {
		yuv.y = texture2D(texUV, tcoord).x;
		yuv.z = texture2D(texUV, tcoord).a;
		isYUV = true;
	} else if ( iformat == AV_PIX_FMT_YUV420P ) {
		yuv.y = texture2D(texU, tcoord).x;
		yuv.z = texture2D(texV, tcoord).x;
		isYUV = true;
	} else if( iformat == AV_PIX_FMT_RGB24 ) {
		rgba = vec4(texture2D(texRGB, tcoord).rgb, 1.0);
	} else if( iformat == AV_PIX_FMT_RGBA ) {
		rgba = texture2D(texRGB, tcoord);
	}
	if(isYUV) {
		rgba = vec4(yuv2rgb(yuv) ,1.0);
	}

	return rgba;
}

vec4 mytexture2D(in vec2 tcoord)
{
	vec4 rgba;

	vec2 tcoord2 = remap_coord(tcoord);

	bool oYUV = oformat == AV_PIX_FMT_NV21 || oformat == AV_PIX_FMT_NV12 || oformat == AV_PIX_FMT_YUV420P ;

	if(tcoord2.x < 0.0 || tcoord2.x > 1.0 || tcoord2.y < 0.0 || tcoord2.y > 1.0){
		rgba = padding_color;//vec4(1.0,.0,.0,1.0);
	}
	else {
		rgba = get_color_from_texture(tcoord2);
	}
		// rgba = vec4(rgb2yuv( rgba.rgb ), 1.0);
		// rgba = vec4(yuv2rgb( rgba.rgb ), 1.0);
	
	if(oYUV){
		vec3 yuv = rgb2yuv( rgba.rgb );
		
		// if(tcoord.x > 2.0/3.0){
		// 	if( oformat == AV_PIX_FMT_NV12)
		// 		rgba = vec4(yuv.y,0,0,yuv.z);
		// 	else if( oformat == AV_PIX_FMT_NV21)
		// 		rgba = vec4(yuv.z,0,0,yuv.y);
		// 	else if( oformat == AV_PIX_FMT_YUV420P){
		// 		rgba = vec4(yuv.g,0,0,0);
		// 		if(tcoord.y > 0.5){
		// 			rgba = vec4(yuv.b,0,0,0);
		// 		}
		// 	}
		// } else {
			rgba = vec4(yuv, 1.0);
		// }
	}

	return rgba;
}

void main()
{
	// gl_FragColor = vec4(texture2D(texUV,textureCoordinate).x,0,0, 1.0);
	gl_FragColor = mytexture2D(textureCoordinate);
}

// NV12 end