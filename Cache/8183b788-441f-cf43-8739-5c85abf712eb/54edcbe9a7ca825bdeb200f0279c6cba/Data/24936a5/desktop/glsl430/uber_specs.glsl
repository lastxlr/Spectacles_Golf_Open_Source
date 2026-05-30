#version 430
//#include <required.glsl> // [HACK 4/6/2023] See SCC shader_merger.cpp
// SCC_BACKEND_SHADER_FLAGS_BEGIN__
// SCC_BACKEND_SHADER_FLAGS_END__
//SG_REFLECTION_BEGIN(200)
//attribute vec4 boneData 5
//attribute vec3 blendShape0Pos 6
//attribute vec3 blendShape0Normal 12
//attribute vec3 blendShape1Pos 7
//attribute vec3 blendShape1Normal 13
//attribute vec3 blendShape2Pos 8
//attribute vec3 blendShape2Normal 14
//attribute vec3 blendShape3Pos 9
//attribute vec3 blendShape4Pos 10
//attribute vec3 blendShape5Pos 11
//attribute vec4 position 0
//attribute vec3 normal 1
//attribute vec4 tangent 2
//attribute vec2 texture0 3
//attribute vec2 texture1 4
//attribute vec4 color 18
//attribute vec3 positionNext 15
//attribute vec3 positionPrevious 16
//attribute vec4 strandProperties 17
//output vec4 sc_FragData0 0
//sampler sampler baseTexSmpSC 0:26
//sampler sampler emissiveTexSmpSC 0:27
//sampler sampler intensityTextureSmpSC 0:28
//sampler sampler matcapNormalSmpSC 0:29
//sampler sampler matcapTexSmpSC 0:30
//sampler sampler opacityTexSmpSC 0:31
//sampler sampler rimColorTexSmpSC 0:32
//sampler sampler sc_OITCommonSampler 0:35
//sampler sampler sc_RayTracingHitCasterIdAndBarycentricSmpSC 0:36
//sampler sampler sc_RayTracingRayDirectionSmpSC 0:37
//sampler sampler sc_ScreenTextureSmpSC 0:39
//texture texture2D baseTex 0:3:0:26
//texture texture2D emissiveTex 0:4:0:27
//texture texture2D intensityTexture 0:5:0:28
//texture texture2D matcapNormal 0:6:0:29
//texture texture2D matcapTex 0:7:0:30
//texture texture2D opacityTex 0:8:0:31
//texture texture2D rimColorTex 0:9:0:32
//texture texture2D sc_OITAlpha0 0:12:0:35
//texture texture2D sc_OITAlpha1 0:13:0:35
//texture texture2D sc_OITDepthHigh0 0:14:0:35
//texture texture2D sc_OITDepthHigh1 0:15:0:35
//texture texture2D sc_OITDepthLow0 0:16:0:35
//texture texture2D sc_OITDepthLow1 0:17:0:35
//texture texture2D sc_OITFilteredDepthBoundsTexture 0:18:0:35
//texture texture2D sc_OITFrontDepthTexture 0:19:0:35
//texture utexture2D sc_RayTracingHitCasterIdAndBarycentric 0:20:0:36
//texture texture2D sc_RayTracingRayDirection 0:21:0:37
//texture texture2D sc_ScreenTexture 0:23:0:39
//texture texture2DArray baseTexArrSC 0:42:0:26
//texture texture2DArray emissiveTexArrSC 0:43:0:27
//texture texture2DArray intensityTextureArrSC 0:44:0:28
//texture texture2DArray matcapNormalArrSC 0:45:0:29
//texture texture2DArray matcapTexArrSC 0:46:0:30
//texture texture2DArray opacityTexArrSC 0:47:0:31
//texture texture2DArray rimColorTexArrSC 0:48:0:32
//texture texture2DArray sc_ScreenTextureArrSC 0:52:0:39
//ssbo int sc_RayTracingCasterIndexBuffer 0:0:4 {
//uint sc_RayTracingCasterTriangles 0:[1]:4
//}
//ssbo float sc_RayTracingCasterNonAnimatedVertexBuffer 0:2:4 {
//float sc_RayTracingCasterNonAnimatedVertices 0:[1]:4
//}
//ssbo float sc_RayTracingCasterVertexBuffer 0:1:4 {
//float sc_RayTracingCasterVertices 0:[1]:4
//}
//spec_const bool BLEND_MODE_AVERAGE 0 0
//spec_const bool BLEND_MODE_BRIGHT 1 0
//spec_const bool BLEND_MODE_COLOR 2 0
//spec_const bool BLEND_MODE_COLOR_BURN 3 0
//spec_const bool BLEND_MODE_COLOR_DODGE 4 0
//spec_const bool BLEND_MODE_DARKEN 5 0
//spec_const bool BLEND_MODE_DIFFERENCE 6 0
//spec_const bool BLEND_MODE_DIVIDE 7 0
//spec_const bool BLEND_MODE_DIVISION 8 0
//spec_const bool BLEND_MODE_EXCLUSION 9 0
//spec_const bool BLEND_MODE_FORGRAY 10 0
//spec_const bool BLEND_MODE_HARD_GLOW 11 0
//spec_const bool BLEND_MODE_HARD_LIGHT 12 0
//spec_const bool BLEND_MODE_HARD_MIX 13 0
//spec_const bool BLEND_MODE_HARD_PHOENIX 14 0
//spec_const bool BLEND_MODE_HARD_REFLECT 15 0
//spec_const bool BLEND_MODE_HUE 16 0
//spec_const bool BLEND_MODE_INTENSE 17 0
//spec_const bool BLEND_MODE_LIGHTEN 18 0
//spec_const bool BLEND_MODE_LINEAR_LIGHT 19 0
//spec_const bool BLEND_MODE_LUMINOSITY 20 0
//spec_const bool BLEND_MODE_NEGATION 21 0
//spec_const bool BLEND_MODE_NOTBRIGHT 22 0
//spec_const bool BLEND_MODE_OVERLAY 23 0
//spec_const bool BLEND_MODE_PIN_LIGHT 24 0
//spec_const bool BLEND_MODE_REALISTIC 25 0
//spec_const bool BLEND_MODE_SATURATION 26 0
//spec_const bool BLEND_MODE_SOFT_LIGHT 27 0
//spec_const bool BLEND_MODE_SUBTRACT 28 0
//spec_const bool BLEND_MODE_VIVID_LIGHT 29 0
//spec_const bool ENABLE_BASE_TEX 30 0
//spec_const bool ENABLE_EMISSIVE 31 0
//spec_const bool ENABLE_MATCAP 32 0
//spec_const bool ENABLE_MATCAP_NORMAL 33 0
//spec_const bool ENABLE_OPACITY_TEX 34 0
//spec_const bool ENABLE_RECOLOR 35 0
//spec_const bool ENABLE_RIM_INVERT 36 0
//spec_const bool ENABLE_STIPPLE_PATTERN_TEST 37 0
//spec_const bool ENABLE_UV2 38 0
//spec_const bool ENABLE_UV3 39 0
//spec_const bool SC_USE_CLAMP_TO_BORDER_baseTex 40 0
//spec_const bool SC_USE_CLAMP_TO_BORDER_emissiveTex 41 0
//spec_const bool SC_USE_CLAMP_TO_BORDER_intensityTexture 42 0
//spec_const bool SC_USE_CLAMP_TO_BORDER_matcapNormal 43 0
//spec_const bool SC_USE_CLAMP_TO_BORDER_matcapTex 44 0
//spec_const bool SC_USE_CLAMP_TO_BORDER_opacityTex 45 0
//spec_const bool SC_USE_CLAMP_TO_BORDER_rimColorTex 46 0
//spec_const bool SC_USE_UV_MIN_MAX_baseTex 47 0
//spec_const bool SC_USE_UV_MIN_MAX_emissiveTex 48 0
//spec_const bool SC_USE_UV_MIN_MAX_intensityTexture 49 0
//spec_const bool SC_USE_UV_MIN_MAX_matcapNormal 50 0
//spec_const bool SC_USE_UV_MIN_MAX_matcapTex 51 0
//spec_const bool SC_USE_UV_MIN_MAX_opacityTex 52 0
//spec_const bool SC_USE_UV_MIN_MAX_rimColorTex 53 0
//spec_const bool SC_USE_UV_TRANSFORM_baseTex 54 0
//spec_const bool SC_USE_UV_TRANSFORM_emissiveTex 55 0
//spec_const bool SC_USE_UV_TRANSFORM_intensityTexture 56 0
//spec_const bool SC_USE_UV_TRANSFORM_matcapNormal 57 0
//spec_const bool SC_USE_UV_TRANSFORM_matcapTex 58 0
//spec_const bool SC_USE_UV_TRANSFORM_opacityTex 59 0
//spec_const bool SC_USE_UV_TRANSFORM_rimColorTex 60 0
//spec_const bool Tweak_N46 61 0
//spec_const bool UseViewSpaceDepthVariant 62 1
//spec_const bool baseTexHasSwappedViews 63 0
//spec_const bool emissiveTexHasSwappedViews 64 0
//spec_const bool intensityTextureHasSwappedViews 65 0
//spec_const bool matcapNormalHasSwappedViews 66 0
//spec_const bool matcapTexHasSwappedViews 67 0
//spec_const bool opacityTexHasSwappedViews 68 0
//spec_const bool rimColorTexHasSwappedViews 69 0
//spec_const bool rimTex 70 0
//spec_const bool sc_BlendMode_Add 71 0
//spec_const bool sc_BlendMode_AddWithAlphaFactor 72 0
//spec_const bool sc_BlendMode_AlphaTest 73 0
//spec_const bool sc_BlendMode_AlphaToCoverage 74 0
//spec_const bool sc_BlendMode_ColoredGlass 75 0
//spec_const bool sc_BlendMode_Custom 76 0
//spec_const bool sc_BlendMode_Max 77 0
//spec_const bool sc_BlendMode_Min 78 0
//spec_const bool sc_BlendMode_Multiply 79 0
//spec_const bool sc_BlendMode_MultiplyOriginal 80 0
//spec_const bool sc_BlendMode_Normal 81 0
//spec_const bool sc_BlendMode_PremultipliedAlpha 82 0
//spec_const bool sc_BlendMode_PremultipliedAlphaAuto 83 0
//spec_const bool sc_BlendMode_PremultipliedAlphaHardware 84 0
//spec_const bool sc_BlendMode_Screen 85 0
//spec_const bool sc_DepthOnly 86 0
//spec_const bool sc_FramebufferFetch 87 0
//spec_const bool sc_MotionVectorsPass 88 0
//spec_const bool sc_OITCompositingPass 89 0
//spec_const bool sc_OITDepthBoundsPass 90 0
//spec_const bool sc_OITDepthGatherPass 91 0
//spec_const bool sc_OITDepthPrepass 92 0
//spec_const bool sc_OITFrontLayerPass 93 0
//spec_const bool sc_OITMaxLayers4Plus1 94 0
//spec_const bool sc_OITMaxLayers8 95 0
//spec_const bool sc_OITMaxLayersVisualizeLayerCount 96 0
//spec_const bool sc_OutputBounds 97 0
//spec_const bool sc_ProjectiveShadowsCaster 98 0
//spec_const bool sc_ProjectiveShadowsReceiver 99 0
//spec_const bool sc_RayTracingCasterForceOpaque 100 0
//spec_const bool sc_RenderAlphaToColor 101 0
//spec_const bool sc_ScreenTextureHasSwappedViews 102 0
//spec_const bool sc_TAAEnabled 103 0
//spec_const bool sc_VertexBlending 104 0
//spec_const bool sc_VertexBlendingUseNormals 105 0
//spec_const bool sc_Voxelization 106 0
//spec_const bool uv2EnableAnimation 107 0
//spec_const bool uv3EnableAnimation 108 0
//spec_const int NODE_13_DROPLIST_ITEM 109 0
//spec_const int NODE_27_DROPLIST_ITEM 110 0
//spec_const int NODE_315_DROPLIST_ITEM 111 0
//spec_const int NODE_38_DROPLIST_ITEM 112 0
//spec_const int NODE_49_DROPLIST_ITEM 113 0
//spec_const int NODE_69_DROPLIST_ITEM 114 0
//spec_const int NODE_76_DROPLIST_ITEM 115 0
//spec_const int SC_DEVICE_CLASS 116 -1
//spec_const int SC_SOFTWARE_WRAP_MODE_U_baseTex 117 -1
//spec_const int SC_SOFTWARE_WRAP_MODE_U_emissiveTex 118 -1
//spec_const int SC_SOFTWARE_WRAP_MODE_U_intensityTexture 119 -1
//spec_const int SC_SOFTWARE_WRAP_MODE_U_matcapNormal 120 -1
//spec_const int SC_SOFTWARE_WRAP_MODE_U_matcapTex 121 -1
//spec_const int SC_SOFTWARE_WRAP_MODE_U_opacityTex 122 -1
//spec_const int SC_SOFTWARE_WRAP_MODE_U_rimColorTex 123 -1
//spec_const int SC_SOFTWARE_WRAP_MODE_V_baseTex 124 -1
//spec_const int SC_SOFTWARE_WRAP_MODE_V_emissiveTex 125 -1
//spec_const int SC_SOFTWARE_WRAP_MODE_V_intensityTexture 126 -1
//spec_const int SC_SOFTWARE_WRAP_MODE_V_matcapNormal 127 -1
//spec_const int SC_SOFTWARE_WRAP_MODE_V_matcapTex 128 -1
//spec_const int SC_SOFTWARE_WRAP_MODE_V_opacityTex 129 -1
//spec_const int SC_SOFTWARE_WRAP_MODE_V_rimColorTex 130 -1
//spec_const int Tweak_N56 131 0
//spec_const int baseTexLayout 132 0
//spec_const int emissiveTexLayout 133 0
//spec_const int intensityTextureLayout 134 0
//spec_const int matcapNormalLayout 135 0
//spec_const int matcapTexLayout 136 0
//spec_const int opacityTexLayout 137 0
//spec_const int rimColorTexLayout 138 0
//spec_const int sc_DepthBufferMode 139 0
//spec_const int sc_RenderingSpace 140 -1
//spec_const int sc_ScreenTextureLayout 141 0
//spec_const int sc_ShaderCacheConstant 142 0
//spec_const int sc_SkinBonesCount 143 0
//spec_const int sc_StereoRenderingMode 144 0
//spec_const int sc_StereoRendering_IsClipDistanceEnabled 145 0
//spec_const int sc_StereoViewID 146 0
//SG_REFLECTION_END
#define sc_StereoRendering_Disabled 0
#define sc_StereoRendering_InstancedClipped 1
#define sc_StereoRendering_Multiview 2
#ifdef VERTEX_SHADER
#define scOutPos(clipPosition) gl_Position=clipPosition
#define MAIN main
#endif
#ifdef SC_ENABLE_INSTANCED_RENDERING
#ifndef sc_EnableInstancing
#define sc_EnableInstancing 1
#endif
#endif
#define mod(x,y) (x-y*floor((x+1e-6)/y))
#if __VERSION__<300
#define isinf(x) (x!=0.0&&x*2.0==x ? true : false)
#define isnan(x) (x>0.0||x<0.0||x==0.0 ? false : true)
#define inverse(M) M
#endif
#ifdef sc_EnableStereoClipDistance
#if defined(GL_APPLE_clip_distance)
#extension GL_APPLE_clip_distance : require
#elif defined(GL_EXT_clip_cull_distance)
#extension GL_EXT_clip_cull_distance : require
#else
#error Clip distance is requested but not supported by this device.
#endif
#endif
#ifdef sc_EnableMultiviewStereoRendering
#define sc_StereoRenderingMode sc_StereoRendering_Multiview
#define sc_NumStereoViews 2
#extension GL_OVR_multiview2 : require
#ifdef VERTEX_SHADER
#ifdef sc_EnableInstancingFallback
#define sc_GlobalInstanceID (sc_FallbackInstanceID*2+gl_InstanceID)
#else
#define sc_GlobalInstanceID gl_InstanceID
#endif
#define sc_LocalInstanceID sc_GlobalInstanceID
#define sc_StereoViewID int(gl_ViewID_OVR)
#endif
#elif defined(sc_EnableInstancedClippedStereoRendering)
#ifndef sc_EnableInstancing
#error Instanced-clipped stereo rendering requires enabled instancing.
#endif
#ifndef sc_EnableStereoClipDistance
#define sc_StereoRendering_IsClipDistanceEnabled 0
#else
#define sc_StereoRendering_IsClipDistanceEnabled 1
#endif
#define sc_StereoRenderingMode sc_StereoRendering_InstancedClipped
#define sc_NumStereoClipPlanes 1
#define sc_NumStereoViews 2
#ifdef VERTEX_SHADER
#ifdef sc_EnableInstancingFallback
#define sc_GlobalInstanceID (sc_FallbackInstanceID*2+gl_InstanceID)
#else
#define sc_GlobalInstanceID gl_InstanceID
#endif
#define sc_LocalInstanceID (sc_GlobalInstanceID/2)
#define sc_StereoViewID (sc_GlobalInstanceID%2)
#endif
#else
#define sc_StereoRenderingMode sc_StereoRendering_Disabled
#endif
#if defined(sc_EnableInstancing)&&defined(VERTEX_SHADER)
#ifdef GL_ARB_draw_instanced
#extension GL_ARB_draw_instanced : require
#define gl_InstanceID gl_InstanceIDARB
#endif
#ifdef GL_EXT_draw_instanced
#extension GL_EXT_draw_instanced : require
#define gl_InstanceID gl_InstanceIDEXT
#endif
#ifndef sc_InstanceID
#define sc_InstanceID gl_InstanceID
#endif
#ifndef sc_GlobalInstanceID
#ifdef sc_EnableInstancingFallback
#define sc_GlobalInstanceID (sc_FallbackInstanceID)
#define sc_LocalInstanceID (sc_FallbackInstanceID)
#else
#define sc_GlobalInstanceID gl_InstanceID
#define sc_LocalInstanceID gl_InstanceID
#endif
#endif
#endif
#ifndef GL_ES
#extension GL_EXT_gpu_shader4 : enable
#extension GL_ARB_shader_texture_lod : enable
#define precision
#define lowp
#define mediump
#define highp
#define sc_FragmentPrecision
#endif
#ifdef GL_ES
#ifdef sc_FramebufferFetch
#if defined(GL_EXT_shader_framebuffer_fetch)
#extension GL_EXT_shader_framebuffer_fetch : require
#elif defined(GL_ARM_shader_framebuffer_fetch)
#extension GL_ARM_shader_framebuffer_fetch : require
#else
#error Framebuffer fetch is requested but not supported by this device.
#endif
#endif
#ifdef GL_FRAGMENT_PRECISION_HIGH
#define sc_FragmentPrecision highp
#else
#define sc_FragmentPrecision mediump
#endif
#ifdef FRAGMENT_SHADER
precision highp int;
precision highp float;
#endif
#endif
#ifdef VERTEX_SHADER
#ifdef sc_EnableMultiviewStereoRendering
layout(num_views=sc_NumStereoViews) in;
#endif
#endif
#define SC_INT_FALLBACK_FLOAT int
#define SC_INTERPOLATION_FLAT flat
#define SC_INTERPOLATION_CENTROID centroid
#ifndef sc_NumStereoViews
#define sc_NumStereoViews 1
#endif
#ifndef sc_TextureRenderingLayout_Regular
#define sc_TextureRenderingLayout_Regular 0
#define sc_TextureRenderingLayout_StereoInstancedClipped 1
#define sc_TextureRenderingLayout_StereoMultiview 2
#endif
#if defined VERTEX_SHADER
struct sc_Vertex_t
{
vec4 position;
vec3 normal;
vec3 tangent;
vec2 texture0;
vec2 texture1;
};
#ifndef sc_StereoRenderingMode
#define sc_StereoRenderingMode 0
#endif
#ifndef sc_StereoViewID
#define sc_StereoViewID 0
#endif
#ifndef sc_RenderingSpace
#define sc_RenderingSpace -1
#endif
#ifndef sc_TAAEnabled
#define sc_TAAEnabled 0
#elif sc_TAAEnabled==1
#undef sc_TAAEnabled
#define sc_TAAEnabled 1
#endif
#ifndef sc_MotionVectorsPass
#define sc_MotionVectorsPass 0
#elif sc_MotionVectorsPass==1
#undef sc_MotionVectorsPass
#define sc_MotionVectorsPass 1
#endif
#ifndef sc_NumStereoViews
#define sc_NumStereoViews 1
#endif
#ifndef sc_StereoRendering_IsClipDistanceEnabled
#define sc_StereoRendering_IsClipDistanceEnabled 0
#endif
#ifndef sc_ShaderCacheConstant
#define sc_ShaderCacheConstant 0
#endif
#ifndef sc_SkinBonesCount
#define sc_SkinBonesCount 0
#endif
#ifndef sc_VertexBlending
#define sc_VertexBlending 0
#elif sc_VertexBlending==1
#undef sc_VertexBlending
#define sc_VertexBlending 1
#endif
#ifndef sc_VertexBlendingUseNormals
#define sc_VertexBlendingUseNormals 0
#elif sc_VertexBlendingUseNormals==1
#undef sc_VertexBlendingUseNormals
#define sc_VertexBlendingUseNormals 1
#endif
#ifndef sc_DepthBufferMode
#define sc_DepthBufferMode 0
#endif
struct sc_Camera_t
{
vec3 position;
float aspect;
vec2 clipPlanes;
};
#ifndef sc_Voxelization
#define sc_Voxelization 0
#elif sc_Voxelization==1
#undef sc_Voxelization
#define sc_Voxelization 1
#endif
#ifndef UseViewSpaceDepthVariant
#define UseViewSpaceDepthVariant 1
#elif UseViewSpaceDepthVariant==1
#undef UseViewSpaceDepthVariant
#define UseViewSpaceDepthVariant 1
#endif
#ifndef sc_OITDepthGatherPass
#define sc_OITDepthGatherPass 0
#elif sc_OITDepthGatherPass==1
#undef sc_OITDepthGatherPass
#define sc_OITDepthGatherPass 1
#endif
#ifndef sc_OITCompositingPass
#define sc_OITCompositingPass 0
#elif sc_OITCompositingPass==1
#undef sc_OITCompositingPass
#define sc_OITCompositingPass 1
#endif
#ifndef sc_OITDepthBoundsPass
#define sc_OITDepthBoundsPass 0
#elif sc_OITDepthBoundsPass==1
#undef sc_OITDepthBoundsPass
#define sc_OITDepthBoundsPass 1
#endif
#ifndef sc_ProjectiveShadowsReceiver
#define sc_ProjectiveShadowsReceiver 0
#elif sc_ProjectiveShadowsReceiver==1
#undef sc_ProjectiveShadowsReceiver
#define sc_ProjectiveShadowsReceiver 1
#endif
#ifndef sc_OutputBounds
#define sc_OutputBounds 0
#elif sc_OutputBounds==1
#undef sc_OutputBounds
#define sc_OutputBounds 1
#endif
layout(binding=0,std430) readonly buffer sc_RayTracingCasterIndexBuffer
{
uint sc_RayTracingCasterTriangles[1];
} sc_RayTracingCasterIndexBuffer_obj;
layout(binding=1,std430) readonly buffer sc_RayTracingCasterVertexBuffer
{
float sc_RayTracingCasterVertices[1];
} sc_RayTracingCasterVertexBuffer_obj;
layout(binding=2,std430) readonly buffer sc_RayTracingCasterNonAnimatedVertexBuffer
{
float sc_RayTracingCasterNonAnimatedVertices[1];
} sc_RayTracingCasterNonAnimatedVertexBuffer_obj;
uniform mat4 sc_ModelMatrix;
uniform mat4 sc_ProjectorMatrix;
uniform vec2 sc_TAAJitterOffset;
uniform mat4 sc_ViewProjectionMatrixArray[sc_NumStereoViews];
uniform mat4 sc_PrevFrameViewProjectionMatrixArray[sc_NumStereoViews];
uniform mat4 sc_PrevFrameModelMatrix;
uniform mat4 sc_ModelMatrixInverse;
uniform int sc_FallbackInstanceID;
uniform vec4 sc_StereoClipPlanes[sc_NumStereoViews];
uniform vec4 sc_UniformConstants;
uniform vec4 sc_BoneMatrices[(sc_SkinBonesCount*3)+1];
uniform mat3 sc_SkinBonesNormalMatrices[sc_SkinBonesCount+1];
uniform vec4 weights0;
uniform vec4 weights1;
uniform mat4 sc_ProjectionMatrixInverseArray[sc_NumStereoViews];
uniform mat4 sc_ViewMatrixArray[sc_NumStereoViews];
uniform mat4 sc_ModelViewMatrixArray[sc_NumStereoViews];
uniform mat4 sc_ProjectionMatrixArray[sc_NumStereoViews];
uniform sc_Camera_t sc_Camera;
uniform vec4 voxelization_params_0;
uniform vec4 voxelization_params_frustum_lrbt;
uniform vec4 voxelization_params_frustum_nf;
uniform vec3 voxelization_params_camera_pos;
uniform mat4 sc_ModelMatrixVoxelization;
uniform mat3 sc_NormalMatrix;
uniform int PreviewEnabled;
uniform uvec4 sc_RayTracingCasterConfiguration;
uniform float depthRef;
out vec4 varPosAndMotion;
out vec4 varNormalAndMotion;
out float varClipDistance;
flat out int varStereoViewID;
in vec4 boneData;
in vec3 blendShape0Pos;
in vec3 blendShape0Normal;
in vec3 blendShape1Pos;
in vec3 blendShape1Normal;
in vec3 blendShape2Pos;
in vec3 blendShape2Normal;
in vec3 blendShape3Pos;
in vec3 blendShape4Pos;
in vec3 blendShape5Pos;
in vec4 position;
in vec3 normal;
in vec4 tangent;
in vec2 texture0;
in vec2 texture1;
out vec4 varScreenPos;
out vec4 varTex01;
out vec4 varTangent;
out vec4 varColor;
in vec4 color;
out float varViewSpaceDepth;
out vec2 varShadowTex;
out vec4 PreviewVertexColor;
out float PreviewVertexSaved;
out vec2 varScreenTexturePos;
in vec3 positionNext;
in vec3 positionPrevious;
in vec4 strandProperties;
void sc_SetClipDistancePlatform(float dstClipDistance)
{
#if sc_StereoRenderingMode==sc_StereoRendering_InstancedClipped&&sc_StereoRendering_IsClipDistanceEnabled
gl_ClipDistance[0]=dstClipDistance;
#endif
}
void sc_SetClipDistance(float dstClipDistance)
{
#if (sc_StereoRendering_IsClipDistanceEnabled==1)
{
sc_SetClipDistancePlatform(dstClipDistance);
}
#else
{
varClipDistance=dstClipDistance;
}
#endif
}
void sc_SetClipDistance(vec4 clipPosition)
{
#if (sc_StereoRenderingMode==1)
{
sc_SetClipDistance(dot(clipPosition,sc_StereoClipPlanes[sc_StereoViewID]));
}
#endif
}
void sc_SetClipPosition(vec4 clipPosition)
{
#if (sc_ShaderCacheConstant!=0)
{
clipPosition.x+=(sc_UniformConstants.x*float(sc_ShaderCacheConstant));
}
#endif
#if (sc_StereoRenderingMode>0)
{
varStereoViewID=sc_StereoViewID;
}
#endif
sc_SetClipDistance(clipPosition);
gl_Position=clipPosition;
}
int sc_GetLocalInstanceIDInternal(int id)
{
#ifdef sc_LocalInstanceID
return sc_LocalInstanceID;
#else
return 0;
#endif
}
void blendTargetShapeWithNormal(inout sc_Vertex_t v,vec3 position_1,vec3 normal_1,float weight)
{
vec3 l9_0=v.position.xyz+(position_1*weight);
v=sc_Vertex_t(vec4(l9_0.x,l9_0.y,l9_0.z,v.position.w),v.normal,v.tangent,v.texture0,v.texture1);
v.normal+=(normal_1*weight);
}
void sc_BlendVertex(inout sc_Vertex_t v)
{
#if (sc_VertexBlending)
{
#if (sc_VertexBlendingUseNormals)
{
blendTargetShapeWithNormal(v,blendShape0Pos,blendShape0Normal,weights0.x);
blendTargetShapeWithNormal(v,blendShape1Pos,blendShape1Normal,weights0.y);
blendTargetShapeWithNormal(v,blendShape2Pos,blendShape2Normal,weights0.z);
}
#else
{
vec3 l9_0=v.position.xyz+(blendShape0Pos*weights0.x);
v=sc_Vertex_t(vec4(l9_0.x,l9_0.y,l9_0.z,v.position.w),v.normal,v.tangent,v.texture0,v.texture1);
vec3 l9_1=v.position.xyz+(blendShape1Pos*weights0.y);
v=sc_Vertex_t(vec4(l9_1.x,l9_1.y,l9_1.z,v.position.w),v.normal,v.tangent,v.texture0,v.texture1);
vec3 l9_2=v.position.xyz+(blendShape2Pos*weights0.z);
v=sc_Vertex_t(vec4(l9_2.x,l9_2.y,l9_2.z,v.position.w),v.normal,v.tangent,v.texture0,v.texture1);
vec3 l9_3=v.position.xyz+(blendShape3Pos*weights0.w);
v=sc_Vertex_t(vec4(l9_3.x,l9_3.y,l9_3.z,v.position.w),v.normal,v.tangent,v.texture0,v.texture1);
vec3 l9_4=v.position.xyz+(blendShape4Pos*weights1.x);
v=sc_Vertex_t(vec4(l9_4.x,l9_4.y,l9_4.z,v.position.w),v.normal,v.tangent,v.texture0,v.texture1);
vec3 l9_5=v.position.xyz+(blendShape5Pos*weights1.y);
v=sc_Vertex_t(vec4(l9_5.x,l9_5.y,l9_5.z,v.position.w),v.normal,v.tangent,v.texture0,v.texture1);
}
#endif
}
#endif
}
vec4 sc_GetBoneWeights()
{
vec4 l9_0;
#if (sc_SkinBonesCount>0)
{
vec4 l9_1=vec4(1.0,fract(boneData.yzw));
vec4 l9_2=l9_1;
l9_2.x=1.0-dot(l9_1.yzw,vec3(1.0));
l9_0=l9_2;
}
#else
{
l9_0=vec4(0.0);
}
#endif
return l9_0;
}
void sc_GetBoneMatrix(int index,out vec4 m0,out vec4 m1,out vec4 m2)
{
int l9_0=3*index;
m0=sc_BoneMatrices[l9_0];
m1=sc_BoneMatrices[l9_0+1];
m2=sc_BoneMatrices[l9_0+2];
}
vec3 skinVertexPosition(int i,vec4 v)
{
vec3 l9_0;
#if (sc_SkinBonesCount>0)
{
vec4 param_1;
vec4 param_2;
vec4 param_3;
sc_GetBoneMatrix(i,param_1,param_2,param_3);
l9_0=vec3(dot(v,param_1),dot(v,param_2),dot(v,param_3));
}
#else
{
l9_0=v.xyz;
}
#endif
return l9_0;
}
void sc_SkinVertex(inout sc_Vertex_t v)
{
#if (sc_SkinBonesCount>0)
{
vec4 l9_0=sc_GetBoneWeights();
int l9_1=int(boneData.x);
int l9_2=int(boneData.y);
int l9_3=int(boneData.z);
int l9_4=int(boneData.w);
float l9_5=l9_0.x;
float l9_6=l9_0.y;
float l9_7=l9_0.z;
float l9_8=l9_0.w;
vec3 l9_9=(((skinVertexPosition(l9_1,v.position)*l9_5)+(skinVertexPosition(l9_2,v.position)*l9_6))+(skinVertexPosition(l9_3,v.position)*l9_7))+(skinVertexPosition(l9_4,v.position)*l9_8);
v.position=vec4(l9_9.x,l9_9.y,l9_9.z,v.position.w);
v.normal=((((sc_SkinBonesNormalMatrices[l9_1]*v.normal)*l9_5)+((sc_SkinBonesNormalMatrices[l9_2]*v.normal)*l9_6))+((sc_SkinBonesNormalMatrices[l9_3]*v.normal)*l9_7))+((sc_SkinBonesNormalMatrices[l9_4]*v.normal)*l9_8);
v.tangent=((((sc_SkinBonesNormalMatrices[l9_1]*v.tangent)*l9_5)+((sc_SkinBonesNormalMatrices[l9_2]*v.tangent)*l9_6))+((sc_SkinBonesNormalMatrices[l9_3]*v.tangent)*l9_7))+((sc_SkinBonesNormalMatrices[l9_4]*v.tangent)*l9_8);
}
#endif
}
int sc_GetStereoViewIndex()
{
int l9_0;
#if (sc_StereoRenderingMode==0)
{
l9_0=0;
}
#else
{
l9_0=sc_StereoViewID;
}
#endif
return l9_0;
}
mat4 createVoxelOrthoMatrix(float left,float right,float bottom,float top,float near,float far)
{
return mat4(vec4(2.0/(right-left),0.0,0.0,(-(right+left))/(right-left)),vec4(0.0,2.0/(top-bottom),0.0,(-(top+bottom))/(top-bottom)),vec4(0.0,0.0,(-2.0)/(far-near),(-(far+near))/(far-near)),vec4(0.0,0.0,0.0,1.0));
}
void main()
{
if (sc_RayTracingCasterConfiguration.x!=0u)
{
sc_SetClipPosition(vec4(position.xy,depthRef+(1e-10*position.z),1.0+(1e-10*position.w)));
return;
}
PreviewVertexColor=vec4(0.5);
PreviewVertexSaved=0.0;
sc_Vertex_t l9_0=sc_Vertex_t(position,normal,tangent.xyz,texture0,texture1);
sc_BlendVertex(l9_0);
sc_SkinVertex(l9_0);
#if (sc_RenderingSpace==3)
{
varPosAndMotion=vec4(vec3(0.0).x,vec3(0.0).y,vec3(0.0).z,varPosAndMotion.w);
varNormalAndMotion=vec4(l9_0.normal.x,l9_0.normal.y,l9_0.normal.z,varNormalAndMotion.w);
varTangent=vec4(l9_0.tangent.x,l9_0.tangent.y,l9_0.tangent.z,varTangent.w);
}
#else
{
#if (sc_RenderingSpace==4)
{
varPosAndMotion=vec4(vec3(0.0).x,vec3(0.0).y,vec3(0.0).z,varPosAndMotion.w);
varNormalAndMotion=vec4(l9_0.normal.x,l9_0.normal.y,l9_0.normal.z,varNormalAndMotion.w);
varTangent=vec4(l9_0.tangent.x,l9_0.tangent.y,l9_0.tangent.z,varTangent.w);
}
#else
{
#if (sc_RenderingSpace==2)
{
varPosAndMotion=vec4(l9_0.position.x,l9_0.position.y,l9_0.position.z,varPosAndMotion.w);
varNormalAndMotion=vec4(l9_0.normal.x,l9_0.normal.y,l9_0.normal.z,varNormalAndMotion.w);
varTangent=vec4(l9_0.tangent.x,l9_0.tangent.y,l9_0.tangent.z,varTangent.w);
}
#else
{
#if (sc_RenderingSpace==1)
{
vec4 l9_1=sc_ModelMatrix*l9_0.position;
varPosAndMotion=vec4(l9_1.x,l9_1.y,l9_1.z,varPosAndMotion.w);
vec3 l9_2=sc_NormalMatrix*l9_0.normal;
varNormalAndMotion=vec4(l9_2.x,l9_2.y,l9_2.z,varNormalAndMotion.w);
vec3 l9_3=sc_NormalMatrix*l9_0.tangent;
varTangent=vec4(l9_3.x,l9_3.y,l9_3.z,varTangent.w);
}
#endif
}
#endif
}
#endif
}
#endif
bool l9_4=PreviewEnabled==1;
vec2 l9_5;
if (l9_4)
{
vec2 l9_6=l9_0.texture0;
l9_6.x=1.0-l9_0.texture0.x;
l9_5=l9_6;
}
else
{
l9_5=l9_0.texture0;
}
varColor=color;
vec3 l9_7;
vec3 l9_8;
vec3 l9_9;
if (l9_4)
{
l9_9=varTangent.xyz;
l9_8=varNormalAndMotion.xyz;
l9_7=varPosAndMotion.xyz;
}
else
{
l9_9=varTangent.xyz;
l9_8=varNormalAndMotion.xyz;
l9_7=varPosAndMotion.xyz;
}
varPosAndMotion=vec4(l9_7.x,l9_7.y,l9_7.z,varPosAndMotion.w);
vec3 l9_10=normalize(l9_8);
varNormalAndMotion=vec4(l9_10.x,l9_10.y,l9_10.z,varNormalAndMotion.w);
vec3 l9_11=normalize(l9_9);
varTangent=vec4(l9_11.x,l9_11.y,l9_11.z,varTangent.w);
varTangent.w=tangent.w;
#if (UseViewSpaceDepthVariant&&((sc_OITDepthGatherPass||sc_OITCompositingPass)||sc_OITDepthBoundsPass))
{
vec4 l9_12;
#if (sc_RenderingSpace==3)
{
l9_12=sc_ProjectionMatrixInverseArray[sc_GetStereoViewIndex()]*l9_0.position;
}
#else
{
vec4 l9_13;
#if (sc_RenderingSpace==2)
{
l9_13=sc_ViewMatrixArray[sc_GetStereoViewIndex()]*l9_0.position;
}
#else
{
vec4 l9_14;
#if (sc_RenderingSpace==1)
{
l9_14=sc_ModelViewMatrixArray[sc_GetStereoViewIndex()]*l9_0.position;
}
#else
{
l9_14=l9_0.position;
}
#endif
l9_13=l9_14;
}
#endif
l9_12=l9_13;
}
#endif
varViewSpaceDepth=-l9_12.z;
}
#endif
vec4 l9_15;
#if (sc_RenderingSpace==3)
{
l9_15=l9_0.position;
}
#else
{
vec4 l9_16;
#if (sc_RenderingSpace==4)
{
l9_16=(sc_ModelViewMatrixArray[sc_GetStereoViewIndex()]*l9_0.position)*vec4(1.0/sc_Camera.aspect,1.0,1.0,1.0);
}
#else
{
vec4 l9_17;
#if (sc_RenderingSpace==2)
{
l9_17=sc_ViewProjectionMatrixArray[sc_GetStereoViewIndex()]*vec4(varPosAndMotion.xyz,1.0);
}
#else
{
vec4 l9_18;
#if (sc_RenderingSpace==1)
{
l9_18=sc_ViewProjectionMatrixArray[sc_GetStereoViewIndex()]*vec4(varPosAndMotion.xyz,1.0);
}
#else
{
l9_18=vec4(0.0);
}
#endif
l9_17=l9_18;
}
#endif
l9_16=l9_17;
}
#endif
l9_15=l9_16;
}
#endif
varTex01=vec4(l9_5,l9_0.texture1);
#if (sc_ProjectiveShadowsReceiver)
{
vec4 l9_19;
#if (sc_RenderingSpace==1)
{
l9_19=sc_ModelMatrix*l9_0.position;
}
#else
{
l9_19=l9_0.position;
}
#endif
vec4 l9_20=sc_ProjectorMatrix*l9_19;
varShadowTex=((l9_20.xy/vec2(l9_20.w))*0.5)+vec2(0.5);
}
#endif
vec4 l9_21;
#if (sc_DepthBufferMode==1)
{
vec4 l9_22;
if (sc_ProjectionMatrixArray[sc_GetStereoViewIndex()][2].w!=0.0)
{
vec4 l9_23=l9_15;
l9_23.z=((log2(max(sc_Camera.clipPlanes.x,1.0+l9_15.w))*(2.0/log2(sc_Camera.clipPlanes.y+1.0)))-1.0)*l9_15.w;
l9_22=l9_23;
}
else
{
l9_22=l9_15;
}
l9_21=l9_22;
}
#else
{
l9_21=l9_15;
}
#endif
vec4 l9_24;
#if (sc_TAAEnabled)
{
vec2 l9_25=l9_21.xy+(sc_TAAJitterOffset*l9_21.w);
l9_24=vec4(l9_25.x,l9_25.y,l9_21.z,l9_21.w);
}
#else
{
l9_24=l9_21;
}
#endif
sc_SetClipPosition(l9_24);
#if (sc_Voxelization)
{
sc_Vertex_t l9_26=sc_Vertex_t(l9_0.position,l9_0.normal,l9_0.tangent,l9_5,l9_0.texture1);
sc_BlendVertex(l9_26);
sc_SkinVertex(l9_26);
int l9_27=sc_GetLocalInstanceIDInternal(sc_FallbackInstanceID);
int l9_28=int(voxelization_params_0.w);
vec4 l9_29=createVoxelOrthoMatrix(voxelization_params_frustum_lrbt.x,voxelization_params_frustum_lrbt.y,voxelization_params_frustum_lrbt.z,voxelization_params_frustum_lrbt.w,voxelization_params_frustum_nf.x,voxelization_params_frustum_nf.y)*vec4(((sc_ModelMatrixVoxelization*l9_26.position).xyz+vec3(float(l9_27%l9_28)*voxelization_params_0.y,float(l9_27/l9_28)*voxelization_params_0.y,(float(l9_27)*(voxelization_params_0.y/voxelization_params_0.z))+voxelization_params_frustum_nf.x))-voxelization_params_camera_pos,1.0);
l9_29.w=1.0;
varScreenPos=l9_29;
sc_SetClipPosition(l9_29*1.0);
}
#else
{
#if (sc_OutputBounds)
{
sc_Vertex_t l9_30=sc_Vertex_t(l9_0.position,l9_0.normal,l9_0.tangent,l9_5,l9_0.texture1);
sc_BlendVertex(l9_30);
sc_SkinVertex(l9_30);
vec2 l9_31=((l9_30.position.xy/vec2(l9_30.position.w))*0.5)+vec2(0.5);
varTex01=vec4(l9_31.x,l9_31.y,varTex01.z,varTex01.w);
vec4 l9_32=sc_ModelMatrixVoxelization*l9_30.position;
vec3 l9_33=l9_32.xyz-voxelization_params_camera_pos;
varPosAndMotion=vec4(l9_33.x,l9_33.y,l9_33.z,varPosAndMotion.w);
vec3 l9_34=normalize(l9_30.normal);
varNormalAndMotion=vec4(l9_34.x,l9_34.y,l9_34.z,varNormalAndMotion.w);
vec4 l9_35=createVoxelOrthoMatrix(voxelization_params_frustum_lrbt.x,voxelization_params_frustum_lrbt.y,voxelization_params_frustum_lrbt.z,voxelization_params_frustum_lrbt.w,voxelization_params_frustum_nf.x,voxelization_params_frustum_nf.y)*vec4(l9_33.x,l9_33.y,l9_33.z,l9_32.w);
vec4 l9_36=vec4(l9_35.x,l9_35.y,l9_35.z,vec4(0.0).w);
l9_36.w=1.0;
varScreenPos=l9_36;
sc_SetClipPosition(l9_36*1.0);
}
#endif
}
#endif
vec4 l9_37=varPosAndMotion;
#if (sc_MotionVectorsPass)
{
vec4 l9_38=vec4(l9_37.xyz,1.0);
#if (sc_MotionVectorsPass)
{
vec4 l9_39=sc_ViewProjectionMatrixArray[sc_GetStereoViewIndex()]*l9_38;
vec4 l9_40=sc_PrevFrameViewProjectionMatrixArray[sc_GetStereoViewIndex()]*vec4(((sc_PrevFrameModelMatrix*sc_ModelMatrixInverse)*l9_38).xyz,1.0);
vec2 l9_41=((l9_39.xy/vec2(l9_39.w)).xy-(l9_40.xy/vec2(l9_40.w)).xy)*0.5;
varPosAndMotion.w=l9_41.x;
varNormalAndMotion.w=l9_41.y;
}
#endif
}
#endif
}
#elif defined FRAGMENT_SHADER // #if defined VERTEX_SHADER
#ifndef sc_FramebufferFetch
#define sc_FramebufferFetch 0
#elif sc_FramebufferFetch==1
#undef sc_FramebufferFetch
#define sc_FramebufferFetch 1
#endif
struct sc_RayTracingHitPayload
{
vec3 viewDirWS;
vec3 positionWS;
vec3 normalWS;
vec4 tangentWS;
vec4 color;
vec2 uv0;
vec2 uv1;
vec2 uv2;
vec2 uv3;
uvec2 id;
};
struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
vec2 N35_TransformedUV2;
vec2 N35_TransformedUV3;
vec3 VertexNormal_WorldSpace;
vec3 VertexTangent_WorldSpace;
vec3 VertexBinormal_WorldSpace;
vec2 Surface_UVCoord0;
vec2 Surface_UVCoord1;
vec4 VertexColor;
vec2 gScreenCoord;
vec3 ViewDirWS;
vec3 SurfacePosition_WorldSpace;
};
#ifndef sc_StereoRenderingMode
#define sc_StereoRenderingMode 0
#endif
#ifndef sc_ScreenTextureHasSwappedViews
#define sc_ScreenTextureHasSwappedViews 0
#elif sc_ScreenTextureHasSwappedViews==1
#undef sc_ScreenTextureHasSwappedViews
#define sc_ScreenTextureHasSwappedViews 1
#endif
#ifndef sc_ScreenTextureLayout
#define sc_ScreenTextureLayout 0
#endif
#ifndef sc_BlendMode_Normal
#define sc_BlendMode_Normal 0
#elif sc_BlendMode_Normal==1
#undef sc_BlendMode_Normal
#define sc_BlendMode_Normal 1
#endif
#ifndef sc_BlendMode_AlphaToCoverage
#define sc_BlendMode_AlphaToCoverage 0
#elif sc_BlendMode_AlphaToCoverage==1
#undef sc_BlendMode_AlphaToCoverage
#define sc_BlendMode_AlphaToCoverage 1
#endif
#ifndef sc_BlendMode_PremultipliedAlphaHardware
#define sc_BlendMode_PremultipliedAlphaHardware 0
#elif sc_BlendMode_PremultipliedAlphaHardware==1
#undef sc_BlendMode_PremultipliedAlphaHardware
#define sc_BlendMode_PremultipliedAlphaHardware 1
#endif
#ifndef sc_BlendMode_PremultipliedAlphaAuto
#define sc_BlendMode_PremultipliedAlphaAuto 0
#elif sc_BlendMode_PremultipliedAlphaAuto==1
#undef sc_BlendMode_PremultipliedAlphaAuto
#define sc_BlendMode_PremultipliedAlphaAuto 1
#endif
#ifndef sc_BlendMode_PremultipliedAlpha
#define sc_BlendMode_PremultipliedAlpha 0
#elif sc_BlendMode_PremultipliedAlpha==1
#undef sc_BlendMode_PremultipliedAlpha
#define sc_BlendMode_PremultipliedAlpha 1
#endif
#ifndef sc_BlendMode_AddWithAlphaFactor
#define sc_BlendMode_AddWithAlphaFactor 0
#elif sc_BlendMode_AddWithAlphaFactor==1
#undef sc_BlendMode_AddWithAlphaFactor
#define sc_BlendMode_AddWithAlphaFactor 1
#endif
#ifndef sc_BlendMode_AlphaTest
#define sc_BlendMode_AlphaTest 0
#elif sc_BlendMode_AlphaTest==1
#undef sc_BlendMode_AlphaTest
#define sc_BlendMode_AlphaTest 1
#endif
#ifndef sc_BlendMode_Multiply
#define sc_BlendMode_Multiply 0
#elif sc_BlendMode_Multiply==1
#undef sc_BlendMode_Multiply
#define sc_BlendMode_Multiply 1
#endif
#ifndef sc_BlendMode_MultiplyOriginal
#define sc_BlendMode_MultiplyOriginal 0
#elif sc_BlendMode_MultiplyOriginal==1
#undef sc_BlendMode_MultiplyOriginal
#define sc_BlendMode_MultiplyOriginal 1
#endif
#ifndef sc_BlendMode_ColoredGlass
#define sc_BlendMode_ColoredGlass 0
#elif sc_BlendMode_ColoredGlass==1
#undef sc_BlendMode_ColoredGlass
#define sc_BlendMode_ColoredGlass 1
#endif
#ifndef sc_BlendMode_Add
#define sc_BlendMode_Add 0
#elif sc_BlendMode_Add==1
#undef sc_BlendMode_Add
#define sc_BlendMode_Add 1
#endif
#ifndef sc_BlendMode_Screen
#define sc_BlendMode_Screen 0
#elif sc_BlendMode_Screen==1
#undef sc_BlendMode_Screen
#define sc_BlendMode_Screen 1
#endif
#ifndef sc_BlendMode_Min
#define sc_BlendMode_Min 0
#elif sc_BlendMode_Min==1
#undef sc_BlendMode_Min
#define sc_BlendMode_Min 1
#endif
#ifndef sc_BlendMode_Max
#define sc_BlendMode_Max 0
#elif sc_BlendMode_Max==1
#undef sc_BlendMode_Max
#define sc_BlendMode_Max 1
#endif
#ifndef sc_MotionVectorsPass
#define sc_MotionVectorsPass 0
#elif sc_MotionVectorsPass==1
#undef sc_MotionVectorsPass
#define sc_MotionVectorsPass 1
#endif
#ifndef sc_StereoRendering_IsClipDistanceEnabled
#define sc_StereoRendering_IsClipDistanceEnabled 0
#endif
#ifndef sc_ShaderCacheConstant
#define sc_ShaderCacheConstant 0
#endif
#ifndef sc_FramebufferFetch
#define sc_FramebufferFetch 0
#elif sc_FramebufferFetch==1
#undef sc_FramebufferFetch
#define sc_FramebufferFetch 1
#endif
#ifndef sc_RayTracingCasterForceOpaque
#define sc_RayTracingCasterForceOpaque 0
#elif sc_RayTracingCasterForceOpaque==1
#undef sc_RayTracingCasterForceOpaque
#define sc_RayTracingCasterForceOpaque 1
#endif
#ifndef intensityTextureHasSwappedViews
#define intensityTextureHasSwappedViews 0
#elif intensityTextureHasSwappedViews==1
#undef intensityTextureHasSwappedViews
#define intensityTextureHasSwappedViews 1
#endif
#ifndef BLEND_MODE_REALISTIC
#define BLEND_MODE_REALISTIC 0
#elif BLEND_MODE_REALISTIC==1
#undef BLEND_MODE_REALISTIC
#define BLEND_MODE_REALISTIC 1
#endif
#ifndef BLEND_MODE_FORGRAY
#define BLEND_MODE_FORGRAY 0
#elif BLEND_MODE_FORGRAY==1
#undef BLEND_MODE_FORGRAY
#define BLEND_MODE_FORGRAY 1
#endif
#ifndef BLEND_MODE_NOTBRIGHT
#define BLEND_MODE_NOTBRIGHT 0
#elif BLEND_MODE_NOTBRIGHT==1
#undef BLEND_MODE_NOTBRIGHT
#define BLEND_MODE_NOTBRIGHT 1
#endif
#ifndef BLEND_MODE_DIVISION
#define BLEND_MODE_DIVISION 0
#elif BLEND_MODE_DIVISION==1
#undef BLEND_MODE_DIVISION
#define BLEND_MODE_DIVISION 1
#endif
#ifndef BLEND_MODE_BRIGHT
#define BLEND_MODE_BRIGHT 0
#elif BLEND_MODE_BRIGHT==1
#undef BLEND_MODE_BRIGHT
#define BLEND_MODE_BRIGHT 1
#endif
#ifndef BLEND_MODE_INTENSE
#define BLEND_MODE_INTENSE 0
#elif BLEND_MODE_INTENSE==1
#undef BLEND_MODE_INTENSE
#define BLEND_MODE_INTENSE 1
#endif
#ifndef intensityTextureLayout
#define intensityTextureLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_intensityTexture
#define SC_USE_UV_TRANSFORM_intensityTexture 0
#elif SC_USE_UV_TRANSFORM_intensityTexture==1
#undef SC_USE_UV_TRANSFORM_intensityTexture
#define SC_USE_UV_TRANSFORM_intensityTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_intensityTexture
#define SC_SOFTWARE_WRAP_MODE_U_intensityTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_intensityTexture
#define SC_SOFTWARE_WRAP_MODE_V_intensityTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_intensityTexture
#define SC_USE_UV_MIN_MAX_intensityTexture 0
#elif SC_USE_UV_MIN_MAX_intensityTexture==1
#undef SC_USE_UV_MIN_MAX_intensityTexture
#define SC_USE_UV_MIN_MAX_intensityTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_intensityTexture
#define SC_USE_CLAMP_TO_BORDER_intensityTexture 0
#elif SC_USE_CLAMP_TO_BORDER_intensityTexture==1
#undef SC_USE_CLAMP_TO_BORDER_intensityTexture
#define SC_USE_CLAMP_TO_BORDER_intensityTexture 1
#endif
#ifndef BLEND_MODE_LIGHTEN
#define BLEND_MODE_LIGHTEN 0
#elif BLEND_MODE_LIGHTEN==1
#undef BLEND_MODE_LIGHTEN
#define BLEND_MODE_LIGHTEN 1
#endif
#ifndef BLEND_MODE_DARKEN
#define BLEND_MODE_DARKEN 0
#elif BLEND_MODE_DARKEN==1
#undef BLEND_MODE_DARKEN
#define BLEND_MODE_DARKEN 1
#endif
#ifndef BLEND_MODE_DIVIDE
#define BLEND_MODE_DIVIDE 0
#elif BLEND_MODE_DIVIDE==1
#undef BLEND_MODE_DIVIDE
#define BLEND_MODE_DIVIDE 1
#endif
#ifndef BLEND_MODE_AVERAGE
#define BLEND_MODE_AVERAGE 0
#elif BLEND_MODE_AVERAGE==1
#undef BLEND_MODE_AVERAGE
#define BLEND_MODE_AVERAGE 1
#endif
#ifndef BLEND_MODE_SUBTRACT
#define BLEND_MODE_SUBTRACT 0
#elif BLEND_MODE_SUBTRACT==1
#undef BLEND_MODE_SUBTRACT
#define BLEND_MODE_SUBTRACT 1
#endif
#ifndef BLEND_MODE_DIFFERENCE
#define BLEND_MODE_DIFFERENCE 0
#elif BLEND_MODE_DIFFERENCE==1
#undef BLEND_MODE_DIFFERENCE
#define BLEND_MODE_DIFFERENCE 1
#endif
#ifndef BLEND_MODE_NEGATION
#define BLEND_MODE_NEGATION 0
#elif BLEND_MODE_NEGATION==1
#undef BLEND_MODE_NEGATION
#define BLEND_MODE_NEGATION 1
#endif
#ifndef BLEND_MODE_EXCLUSION
#define BLEND_MODE_EXCLUSION 0
#elif BLEND_MODE_EXCLUSION==1
#undef BLEND_MODE_EXCLUSION
#define BLEND_MODE_EXCLUSION 1
#endif
#ifndef BLEND_MODE_OVERLAY
#define BLEND_MODE_OVERLAY 0
#elif BLEND_MODE_OVERLAY==1
#undef BLEND_MODE_OVERLAY
#define BLEND_MODE_OVERLAY 1
#endif
#ifndef BLEND_MODE_SOFT_LIGHT
#define BLEND_MODE_SOFT_LIGHT 0
#elif BLEND_MODE_SOFT_LIGHT==1
#undef BLEND_MODE_SOFT_LIGHT
#define BLEND_MODE_SOFT_LIGHT 1
#endif
#ifndef BLEND_MODE_HARD_LIGHT
#define BLEND_MODE_HARD_LIGHT 0
#elif BLEND_MODE_HARD_LIGHT==1
#undef BLEND_MODE_HARD_LIGHT
#define BLEND_MODE_HARD_LIGHT 1
#endif
#ifndef BLEND_MODE_COLOR_DODGE
#define BLEND_MODE_COLOR_DODGE 0
#elif BLEND_MODE_COLOR_DODGE==1
#undef BLEND_MODE_COLOR_DODGE
#define BLEND_MODE_COLOR_DODGE 1
#endif
#ifndef BLEND_MODE_COLOR_BURN
#define BLEND_MODE_COLOR_BURN 0
#elif BLEND_MODE_COLOR_BURN==1
#undef BLEND_MODE_COLOR_BURN
#define BLEND_MODE_COLOR_BURN 1
#endif
#ifndef BLEND_MODE_LINEAR_LIGHT
#define BLEND_MODE_LINEAR_LIGHT 0
#elif BLEND_MODE_LINEAR_LIGHT==1
#undef BLEND_MODE_LINEAR_LIGHT
#define BLEND_MODE_LINEAR_LIGHT 1
#endif
#ifndef BLEND_MODE_VIVID_LIGHT
#define BLEND_MODE_VIVID_LIGHT 0
#elif BLEND_MODE_VIVID_LIGHT==1
#undef BLEND_MODE_VIVID_LIGHT
#define BLEND_MODE_VIVID_LIGHT 1
#endif
#ifndef BLEND_MODE_PIN_LIGHT
#define BLEND_MODE_PIN_LIGHT 0
#elif BLEND_MODE_PIN_LIGHT==1
#undef BLEND_MODE_PIN_LIGHT
#define BLEND_MODE_PIN_LIGHT 1
#endif
#ifndef BLEND_MODE_HARD_MIX
#define BLEND_MODE_HARD_MIX 0
#elif BLEND_MODE_HARD_MIX==1
#undef BLEND_MODE_HARD_MIX
#define BLEND_MODE_HARD_MIX 1
#endif
#ifndef BLEND_MODE_HARD_REFLECT
#define BLEND_MODE_HARD_REFLECT 0
#elif BLEND_MODE_HARD_REFLECT==1
#undef BLEND_MODE_HARD_REFLECT
#define BLEND_MODE_HARD_REFLECT 1
#endif
#ifndef BLEND_MODE_HARD_GLOW
#define BLEND_MODE_HARD_GLOW 0
#elif BLEND_MODE_HARD_GLOW==1
#undef BLEND_MODE_HARD_GLOW
#define BLEND_MODE_HARD_GLOW 1
#endif
#ifndef BLEND_MODE_HARD_PHOENIX
#define BLEND_MODE_HARD_PHOENIX 0
#elif BLEND_MODE_HARD_PHOENIX==1
#undef BLEND_MODE_HARD_PHOENIX
#define BLEND_MODE_HARD_PHOENIX 1
#endif
#ifndef BLEND_MODE_HUE
#define BLEND_MODE_HUE 0
#elif BLEND_MODE_HUE==1
#undef BLEND_MODE_HUE
#define BLEND_MODE_HUE 1
#endif
#ifndef BLEND_MODE_SATURATION
#define BLEND_MODE_SATURATION 0
#elif BLEND_MODE_SATURATION==1
#undef BLEND_MODE_SATURATION
#define BLEND_MODE_SATURATION 1
#endif
#ifndef BLEND_MODE_COLOR
#define BLEND_MODE_COLOR 0
#elif BLEND_MODE_COLOR==1
#undef BLEND_MODE_COLOR
#define BLEND_MODE_COLOR 1
#endif
#ifndef BLEND_MODE_LUMINOSITY
#define BLEND_MODE_LUMINOSITY 0
#elif BLEND_MODE_LUMINOSITY==1
#undef BLEND_MODE_LUMINOSITY
#define BLEND_MODE_LUMINOSITY 1
#endif
#ifndef sc_SkinBonesCount
#define sc_SkinBonesCount 0
#endif
#ifndef UseViewSpaceDepthVariant
#define UseViewSpaceDepthVariant 1
#elif UseViewSpaceDepthVariant==1
#undef UseViewSpaceDepthVariant
#define UseViewSpaceDepthVariant 1
#endif
#ifndef sc_OITDepthGatherPass
#define sc_OITDepthGatherPass 0
#elif sc_OITDepthGatherPass==1
#undef sc_OITDepthGatherPass
#define sc_OITDepthGatherPass 1
#endif
#ifndef sc_OITCompositingPass
#define sc_OITCompositingPass 0
#elif sc_OITCompositingPass==1
#undef sc_OITCompositingPass
#define sc_OITCompositingPass 1
#endif
#ifndef sc_OITDepthBoundsPass
#define sc_OITDepthBoundsPass 0
#elif sc_OITDepthBoundsPass==1
#undef sc_OITDepthBoundsPass
#define sc_OITDepthBoundsPass 1
#endif
#ifndef sc_NumStereoViews
#define sc_NumStereoViews 1
#endif
#ifndef sc_OITMaxLayers4Plus1
#define sc_OITMaxLayers4Plus1 0
#elif sc_OITMaxLayers4Plus1==1
#undef sc_OITMaxLayers4Plus1
#define sc_OITMaxLayers4Plus1 1
#endif
#ifndef sc_OITMaxLayersVisualizeLayerCount
#define sc_OITMaxLayersVisualizeLayerCount 0
#elif sc_OITMaxLayersVisualizeLayerCount==1
#undef sc_OITMaxLayersVisualizeLayerCount
#define sc_OITMaxLayersVisualizeLayerCount 1
#endif
#ifndef sc_OITMaxLayers8
#define sc_OITMaxLayers8 0
#elif sc_OITMaxLayers8==1
#undef sc_OITMaxLayers8
#define sc_OITMaxLayers8 1
#endif
#ifndef sc_OITFrontLayerPass
#define sc_OITFrontLayerPass 0
#elif sc_OITFrontLayerPass==1
#undef sc_OITFrontLayerPass
#define sc_OITFrontLayerPass 1
#endif
#ifndef sc_OITDepthPrepass
#define sc_OITDepthPrepass 0
#elif sc_OITDepthPrepass==1
#undef sc_OITDepthPrepass
#define sc_OITDepthPrepass 1
#endif
#ifndef SC_DEVICE_CLASS
#define SC_DEVICE_CLASS -1
#endif
#ifndef ENABLE_STIPPLE_PATTERN_TEST
#define ENABLE_STIPPLE_PATTERN_TEST 0
#elif ENABLE_STIPPLE_PATTERN_TEST==1
#undef ENABLE_STIPPLE_PATTERN_TEST
#define ENABLE_STIPPLE_PATTERN_TEST 1
#endif
#ifndef sc_ProjectiveShadowsCaster
#define sc_ProjectiveShadowsCaster 0
#elif sc_ProjectiveShadowsCaster==1
#undef sc_ProjectiveShadowsCaster
#define sc_ProjectiveShadowsCaster 1
#endif
#ifndef sc_RenderAlphaToColor
#define sc_RenderAlphaToColor 0
#elif sc_RenderAlphaToColor==1
#undef sc_RenderAlphaToColor
#define sc_RenderAlphaToColor 1
#endif
#ifndef sc_BlendMode_Custom
#define sc_BlendMode_Custom 0
#elif sc_BlendMode_Custom==1
#undef sc_BlendMode_Custom
#define sc_BlendMode_Custom 1
#endif
#ifndef sc_Voxelization
#define sc_Voxelization 0
#elif sc_Voxelization==1
#undef sc_Voxelization
#define sc_Voxelization 1
#endif
#ifndef sc_OutputBounds
#define sc_OutputBounds 0
#elif sc_OutputBounds==1
#undef sc_OutputBounds
#define sc_OutputBounds 1
#endif
#ifndef baseTexHasSwappedViews
#define baseTexHasSwappedViews 0
#elif baseTexHasSwappedViews==1
#undef baseTexHasSwappedViews
#define baseTexHasSwappedViews 1
#endif
#ifndef matcapTexHasSwappedViews
#define matcapTexHasSwappedViews 0
#elif matcapTexHasSwappedViews==1
#undef matcapTexHasSwappedViews
#define matcapTexHasSwappedViews 1
#endif
#ifndef matcapNormalHasSwappedViews
#define matcapNormalHasSwappedViews 0
#elif matcapNormalHasSwappedViews==1
#undef matcapNormalHasSwappedViews
#define matcapNormalHasSwappedViews 1
#endif
#ifndef rimColorTexHasSwappedViews
#define rimColorTexHasSwappedViews 0
#elif rimColorTexHasSwappedViews==1
#undef rimColorTexHasSwappedViews
#define rimColorTexHasSwappedViews 1
#endif
#ifndef opacityTexHasSwappedViews
#define opacityTexHasSwappedViews 0
#elif opacityTexHasSwappedViews==1
#undef opacityTexHasSwappedViews
#define opacityTexHasSwappedViews 1
#endif
#ifndef emissiveTexHasSwappedViews
#define emissiveTexHasSwappedViews 0
#elif emissiveTexHasSwappedViews==1
#undef emissiveTexHasSwappedViews
#define emissiveTexHasSwappedViews 1
#endif
#ifndef baseTexLayout
#define baseTexLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 0
#elif SC_USE_UV_TRANSFORM_baseTex==1
#undef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_baseTex
#define SC_SOFTWARE_WRAP_MODE_U_baseTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_baseTex
#define SC_SOFTWARE_WRAP_MODE_V_baseTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 0
#elif SC_USE_UV_MIN_MAX_baseTex==1
#undef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 0
#elif SC_USE_CLAMP_TO_BORDER_baseTex==1
#undef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 1
#endif
#ifndef matcapTexLayout
#define matcapTexLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_matcapTex
#define SC_USE_UV_TRANSFORM_matcapTex 0
#elif SC_USE_UV_TRANSFORM_matcapTex==1
#undef SC_USE_UV_TRANSFORM_matcapTex
#define SC_USE_UV_TRANSFORM_matcapTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_matcapTex
#define SC_SOFTWARE_WRAP_MODE_U_matcapTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_matcapTex
#define SC_SOFTWARE_WRAP_MODE_V_matcapTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_matcapTex
#define SC_USE_UV_MIN_MAX_matcapTex 0
#elif SC_USE_UV_MIN_MAX_matcapTex==1
#undef SC_USE_UV_MIN_MAX_matcapTex
#define SC_USE_UV_MIN_MAX_matcapTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_matcapTex
#define SC_USE_CLAMP_TO_BORDER_matcapTex 0
#elif SC_USE_CLAMP_TO_BORDER_matcapTex==1
#undef SC_USE_CLAMP_TO_BORDER_matcapTex
#define SC_USE_CLAMP_TO_BORDER_matcapTex 1
#endif
#ifndef matcapNormalLayout
#define matcapNormalLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_matcapNormal
#define SC_USE_UV_TRANSFORM_matcapNormal 0
#elif SC_USE_UV_TRANSFORM_matcapNormal==1
#undef SC_USE_UV_TRANSFORM_matcapNormal
#define SC_USE_UV_TRANSFORM_matcapNormal 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_matcapNormal
#define SC_SOFTWARE_WRAP_MODE_U_matcapNormal -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_matcapNormal
#define SC_SOFTWARE_WRAP_MODE_V_matcapNormal -1
#endif
#ifndef SC_USE_UV_MIN_MAX_matcapNormal
#define SC_USE_UV_MIN_MAX_matcapNormal 0
#elif SC_USE_UV_MIN_MAX_matcapNormal==1
#undef SC_USE_UV_MIN_MAX_matcapNormal
#define SC_USE_UV_MIN_MAX_matcapNormal 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_matcapNormal
#define SC_USE_CLAMP_TO_BORDER_matcapNormal 0
#elif SC_USE_CLAMP_TO_BORDER_matcapNormal==1
#undef SC_USE_CLAMP_TO_BORDER_matcapNormal
#define SC_USE_CLAMP_TO_BORDER_matcapNormal 1
#endif
#ifndef rimColorTexLayout
#define rimColorTexLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_rimColorTex
#define SC_USE_UV_TRANSFORM_rimColorTex 0
#elif SC_USE_UV_TRANSFORM_rimColorTex==1
#undef SC_USE_UV_TRANSFORM_rimColorTex
#define SC_USE_UV_TRANSFORM_rimColorTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_rimColorTex
#define SC_SOFTWARE_WRAP_MODE_U_rimColorTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_rimColorTex
#define SC_SOFTWARE_WRAP_MODE_V_rimColorTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_rimColorTex
#define SC_USE_UV_MIN_MAX_rimColorTex 0
#elif SC_USE_UV_MIN_MAX_rimColorTex==1
#undef SC_USE_UV_MIN_MAX_rimColorTex
#define SC_USE_UV_MIN_MAX_rimColorTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_rimColorTex
#define SC_USE_CLAMP_TO_BORDER_rimColorTex 0
#elif SC_USE_CLAMP_TO_BORDER_rimColorTex==1
#undef SC_USE_CLAMP_TO_BORDER_rimColorTex
#define SC_USE_CLAMP_TO_BORDER_rimColorTex 1
#endif
#ifndef opacityTexLayout
#define opacityTexLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_opacityTex
#define SC_USE_UV_TRANSFORM_opacityTex 0
#elif SC_USE_UV_TRANSFORM_opacityTex==1
#undef SC_USE_UV_TRANSFORM_opacityTex
#define SC_USE_UV_TRANSFORM_opacityTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_opacityTex
#define SC_SOFTWARE_WRAP_MODE_U_opacityTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_opacityTex
#define SC_SOFTWARE_WRAP_MODE_V_opacityTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_opacityTex
#define SC_USE_UV_MIN_MAX_opacityTex 0
#elif SC_USE_UV_MIN_MAX_opacityTex==1
#undef SC_USE_UV_MIN_MAX_opacityTex
#define SC_USE_UV_MIN_MAX_opacityTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_opacityTex
#define SC_USE_CLAMP_TO_BORDER_opacityTex 0
#elif SC_USE_CLAMP_TO_BORDER_opacityTex==1
#undef SC_USE_CLAMP_TO_BORDER_opacityTex
#define SC_USE_CLAMP_TO_BORDER_opacityTex 1
#endif
#ifndef emissiveTexLayout
#define emissiveTexLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_emissiveTex
#define SC_USE_UV_TRANSFORM_emissiveTex 0
#elif SC_USE_UV_TRANSFORM_emissiveTex==1
#undef SC_USE_UV_TRANSFORM_emissiveTex
#define SC_USE_UV_TRANSFORM_emissiveTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_emissiveTex
#define SC_SOFTWARE_WRAP_MODE_U_emissiveTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_emissiveTex
#define SC_SOFTWARE_WRAP_MODE_V_emissiveTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_emissiveTex
#define SC_USE_UV_MIN_MAX_emissiveTex 0
#elif SC_USE_UV_MIN_MAX_emissiveTex==1
#undef SC_USE_UV_MIN_MAX_emissiveTex
#define SC_USE_UV_MIN_MAX_emissiveTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_emissiveTex
#define SC_USE_CLAMP_TO_BORDER_emissiveTex 0
#elif SC_USE_CLAMP_TO_BORDER_emissiveTex==1
#undef SC_USE_CLAMP_TO_BORDER_emissiveTex
#define SC_USE_CLAMP_TO_BORDER_emissiveTex 1
#endif
#ifndef ENABLE_BASE_TEX
#define ENABLE_BASE_TEX 0
#elif ENABLE_BASE_TEX==1
#undef ENABLE_BASE_TEX
#define ENABLE_BASE_TEX 1
#endif
#ifndef ENABLE_MATCAP
#define ENABLE_MATCAP 0
#elif ENABLE_MATCAP==1
#undef ENABLE_MATCAP
#define ENABLE_MATCAP 1
#endif
#ifndef ENABLE_MATCAP_NORMAL
#define ENABLE_MATCAP_NORMAL 0
#elif ENABLE_MATCAP_NORMAL==1
#undef ENABLE_MATCAP_NORMAL
#define ENABLE_MATCAP_NORMAL 1
#endif
#ifndef Tweak_N46
#define Tweak_N46 0
#elif Tweak_N46==1
#undef Tweak_N46
#define Tweak_N46 1
#endif
#ifndef rimTex
#define rimTex 0
#elif rimTex==1
#undef rimTex
#define rimTex 1
#endif
#ifndef ENABLE_RIM_INVERT
#define ENABLE_RIM_INVERT 0
#elif ENABLE_RIM_INVERT==1
#undef ENABLE_RIM_INVERT
#define ENABLE_RIM_INVERT 1
#endif
#ifndef ENABLE_RECOLOR
#define ENABLE_RECOLOR 0
#elif ENABLE_RECOLOR==1
#undef ENABLE_RECOLOR
#define ENABLE_RECOLOR 1
#endif
#ifndef ENABLE_OPACITY_TEX
#define ENABLE_OPACITY_TEX 0
#elif ENABLE_OPACITY_TEX==1
#undef ENABLE_OPACITY_TEX
#define ENABLE_OPACITY_TEX 1
#endif
#ifndef ENABLE_EMISSIVE
#define ENABLE_EMISSIVE 0
#elif ENABLE_EMISSIVE==1
#undef ENABLE_EMISSIVE
#define ENABLE_EMISSIVE 1
#endif
#ifndef ENABLE_UV2
#define ENABLE_UV2 0
#elif ENABLE_UV2==1
#undef ENABLE_UV2
#define ENABLE_UV2 1
#endif
#ifndef uv2EnableAnimation
#define uv2EnableAnimation 0
#elif uv2EnableAnimation==1
#undef uv2EnableAnimation
#define uv2EnableAnimation 1
#endif
#ifndef ENABLE_UV3
#define ENABLE_UV3 0
#elif ENABLE_UV3==1
#undef ENABLE_UV3
#define ENABLE_UV3 1
#endif
#ifndef uv3EnableAnimation
#define uv3EnableAnimation 0
#elif uv3EnableAnimation==1
#undef uv3EnableAnimation
#define uv3EnableAnimation 1
#endif
#ifndef NODE_38_DROPLIST_ITEM
#define NODE_38_DROPLIST_ITEM 0
#endif
#ifndef NODE_27_DROPLIST_ITEM
#define NODE_27_DROPLIST_ITEM 0
#endif
#ifndef Tweak_N56
#define Tweak_N56 0
#endif
#ifndef NODE_315_DROPLIST_ITEM
#define NODE_315_DROPLIST_ITEM 0
#endif
#ifndef NODE_69_DROPLIST_ITEM
#define NODE_69_DROPLIST_ITEM 0
#endif
#ifndef NODE_76_DROPLIST_ITEM
#define NODE_76_DROPLIST_ITEM 0
#endif
#ifndef NODE_13_DROPLIST_ITEM
#define NODE_13_DROPLIST_ITEM 0
#endif
#ifndef NODE_49_DROPLIST_ITEM
#define NODE_49_DROPLIST_ITEM 0
#endif
#ifndef sc_DepthOnly
#define sc_DepthOnly 0
#elif sc_DepthOnly==1
#undef sc_DepthOnly
#define sc_DepthOnly 1
#endif
struct sc_Camera_t
{
vec3 position;
float aspect;
vec2 clipPlanes;
};
layout(binding=1,std430) readonly buffer sc_RayTracingCasterVertexBuffer
{
float sc_RayTracingCasterVertices[1];
} sc_RayTracingCasterVertexBuffer_obj;
layout(binding=2,std430) readonly buffer sc_RayTracingCasterNonAnimatedVertexBuffer
{
float sc_RayTracingCasterNonAnimatedVertices[1];
} sc_RayTracingCasterNonAnimatedVertexBuffer_obj;
layout(binding=0,std430) readonly buffer sc_RayTracingCasterIndexBuffer
{
uint sc_RayTracingCasterTriangles[1];
} sc_RayTracingCasterIndexBuffer_obj;
uniform vec4 sc_CurrentRenderTargetDims;
uniform float sc_ShadowDensity;
uniform vec4 sc_ShadowColor;
uniform vec4 sc_UniformConstants;
uniform uvec4 sc_RayTracingCasterConfiguration;
uniform uvec4 sc_RayTracingCasterOffsetPNTC;
uniform uvec4 sc_RayTracingCasterFormatPNTC;
uniform uvec4 sc_RayTracingCasterOffsetTexture;
uniform uvec4 sc_RayTracingCasterFormatTexture;
uniform mat4 sc_ModelMatrix;
uniform mat3 sc_NormalMatrix;
uniform float correctedIntensity;
uniform mat3 intensityTextureTransform;
uniform vec4 intensityTextureUvMinMax;
uniform vec4 intensityTextureBorderColor;
uniform mat4 sc_ProjectionMatrixArray[sc_NumStereoViews];
uniform float alphaTestThreshold;
uniform mat3 baseTexTransform;
uniform vec4 baseTexUvMinMax;
uniform vec4 baseTexBorderColor;
uniform mat3 matcapTexTransform;
uniform vec4 matcapTexUvMinMax;
uniform vec4 matcapTexBorderColor;
uniform mat3 matcapNormalTransform;
uniform vec4 matcapNormalUvMinMax;
uniform vec4 matcapNormalBorderColor;
uniform mat3 rimColorTexTransform;
uniform vec4 rimColorTexUvMinMax;
uniform vec4 rimColorTexBorderColor;
uniform mat3 opacityTexTransform;
uniform vec4 opacityTexUvMinMax;
uniform vec4 opacityTexBorderColor;
uniform mat3 emissiveTexTransform;
uniform vec4 emissiveTexUvMinMax;
uniform vec4 emissiveTexBorderColor;
uniform mat4 sc_ViewMatrixArray[sc_NumStereoViews];
uniform mat4 sc_ViewMatrixInverseArray[sc_NumStereoViews];
uniform vec4 baseColor;
uniform float matcapIntensity;
uniform vec3 rimColor;
uniform float rimIntensity;
uniform float rimExponent;
uniform vec3 recolorRed;
uniform vec3 recolorGreen;
uniform vec3 recolorBlue;
uniform vec3 emissiveColor;
uniform float emissiveIntensity;
uniform vec2 uv2Scale;
uniform vec2 uv2Offset;
uniform vec2 uv3Scale;
uniform vec2 uv3Offset;
uniform vec4 sc_Time;
uniform mat4 sc_ViewProjectionMatrixArray[sc_NumStereoViews];
uniform sc_Camera_t sc_Camera;
uniform bool Port_Value_N079;
uniform int Port_Value_N064;
uniform vec3 Port_Value_N080;
uniform int PreviewEnabled;
uniform usampler2D sc_RayTracingHitCasterIdAndBarycentric;
uniform sampler2D sc_RayTracingRayDirection;
uniform sampler2D baseTex;
uniform sampler2DArray baseTexArrSC;
uniform sampler2D opacityTex;
uniform sampler2DArray opacityTexArrSC;
uniform sampler2D matcapNormal;
uniform sampler2DArray matcapNormalArrSC;
uniform sampler2D emissiveTex;
uniform sampler2DArray emissiveTexArrSC;
uniform sampler2D matcapTex;
uniform sampler2DArray matcapTexArrSC;
uniform sampler2D rimColorTex;
uniform sampler2DArray rimColorTexArrSC;
uniform sampler2D sc_ScreenTexture;
uniform sampler2DArray sc_ScreenTextureArrSC;
uniform sampler2D intensityTexture;
uniform sampler2DArray intensityTextureArrSC;
uniform sampler2D sc_OITFrontDepthTexture;
uniform sampler2D sc_OITDepthHigh0;
uniform sampler2D sc_OITDepthLow0;
uniform sampler2D sc_OITAlpha0;
uniform sampler2D sc_OITDepthHigh1;
uniform sampler2D sc_OITDepthLow1;
uniform sampler2D sc_OITAlpha1;
uniform sampler2D sc_OITFilteredDepthBoundsTexture;
flat in int varStereoViewID;
in vec4 varPosAndMotion;
in vec4 varNormalAndMotion;
in float varClipDistance;
#if sc_FramebufferFetch&&defined(GL_EXT_shader_framebuffer_fetch)
#define out inout
#endif
layout(location=0) out vec4 sc_FragData0;
#if sc_FramebufferFetch&&defined(GL_EXT_shader_framebuffer_fetch)
#undef out
#endif
in vec4 varScreenPos;
in float varViewSpaceDepth;
in vec4 PreviewVertexColor;
in float PreviewVertexSaved;
in vec4 varTangent;
in vec4 varTex01;
in vec4 varColor;
in vec2 varScreenTexturePos;
in vec2 varShadowTex;
bool N35_EnableUV2;
ssGlobals tempGlobals;
int sc_GetStereoViewIndex()
{
int l9_0;
#if (sc_StereoRenderingMode==0)
{
l9_0=0;
}
#else
{
l9_0=varStereoViewID;
}
#endif
return l9_0;
}
vec2 sc_SamplingCoordsGlobalToView(vec3 uvi,int renderingLayout,int viewIndex)
{
if (renderingLayout==1)
{
uvi.y=((2.0*uvi.y)+float(viewIndex))-1.0;
}
return uvi.xy;
}
vec2 sc_ScreenCoordsGlobalToView(vec2 uv)
{
vec2 l9_0;
#if (sc_StereoRenderingMode==1)
{
l9_0=sc_SamplingCoordsGlobalToView(vec3(uv,0.0),1,sc_GetStereoViewIndex());
}
#else
{
l9_0=uv;
}
#endif
return l9_0;
}
vec3 sc_RayTracingInterpolateAnimatedFloat3(vec3 brc,uvec3 indices,uint offset)
{
uvec3 l9_0=(indices*uvec3(6u))+uvec3(offset);
uint l9_1=l9_0.x;
uint l9_2=l9_0.y;
uint l9_3=l9_0.z;
return ((vec3(sc_RayTracingCasterNonAnimatedVertexBuffer_obj.sc_RayTracingCasterNonAnimatedVertices[l9_1],sc_RayTracingCasterNonAnimatedVertexBuffer_obj.sc_RayTracingCasterNonAnimatedVertices[l9_1+1u],sc_RayTracingCasterNonAnimatedVertexBuffer_obj.sc_RayTracingCasterNonAnimatedVertices[l9_1+2u])*brc.x)+(vec3(sc_RayTracingCasterNonAnimatedVertexBuffer_obj.sc_RayTracingCasterNonAnimatedVertices[l9_2],sc_RayTracingCasterNonAnimatedVertexBuffer_obj.sc_RayTracingCasterNonAnimatedVertices[l9_2+1u],sc_RayTracingCasterNonAnimatedVertexBuffer_obj.sc_RayTracingCasterNonAnimatedVertices[l9_2+2u])*brc.y))+(vec3(sc_RayTracingCasterNonAnimatedVertexBuffer_obj.sc_RayTracingCasterNonAnimatedVertices[l9_3],sc_RayTracingCasterNonAnimatedVertexBuffer_obj.sc_RayTracingCasterNonAnimatedVertices[l9_3+1u],sc_RayTracingCasterNonAnimatedVertexBuffer_obj.sc_RayTracingCasterNonAnimatedVertices[l9_3+2u])*brc.z);
}
vec4 sc_RayTracingFetchUnorm4(uint offset)
{
uint l9_0=floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[offset]);
return vec4(float(l9_0&255u),float((l9_0>>uint(8))&255u),float((l9_0>>uint(16))&255u),float((l9_0>>uint(24))&255u))/vec4(255.0);
}
sc_RayTracingHitPayload sc_RayTracingEvaluateHitPayload(ivec2 screenPos)
{
ivec2 l9_0=screenPos;
uvec4 l9_1=texelFetch(sc_RayTracingHitCasterIdAndBarycentric,l9_0,0);
uvec2 l9_2=l9_1.xy;
if (l9_1.x!=(sc_RayTracingCasterConfiguration.y&65535u))
{
return sc_RayTracingHitPayload(vec3(0.0),vec3(0.0),vec3(0.0),vec4(0.0),vec4(0.0),vec2(0.0),vec2(0.0),vec2(0.0),vec2(0.0),l9_2);
}
vec2 l9_3=unpackHalf2x16(l9_1.z|(l9_1.w<<uint(16)));
float l9_4=l9_3.x;
float l9_5=l9_3.y;
float l9_6=(1.0-l9_4)-l9_5;
vec3 l9_7=vec3(l9_6,l9_4,l9_5);
ivec2 l9_8=screenPos;
vec4 l9_9=texelFetch(sc_RayTracingRayDirection,l9_8,0);
float l9_10=l9_9.x;
float l9_11=l9_9.y;
float l9_12=(1.0-abs(l9_10))-abs(l9_11);
vec3 l9_13=vec3(l9_10,l9_11,l9_12);
float l9_14=clamp(-l9_12,0.0,1.0);
float l9_15;
if (l9_10>=0.0)
{
l9_15=-l9_14;
}
else
{
l9_15=l9_14;
}
float l9_16;
if (l9_11>=0.0)
{
l9_16=-l9_14;
}
else
{
l9_16=l9_14;
}
vec2 l9_17=vec2(l9_15,l9_16);
vec2 l9_18=l9_13.xy+l9_17;
uint l9_19=min(l9_1.y,sc_RayTracingCasterConfiguration.z)*6u;
uint l9_20=l9_19&4294967292u;
uint l9_21=l9_20/4u;
uint l9_22=sc_RayTracingCasterIndexBuffer_obj.sc_RayTracingCasterTriangles[l9_21];
uint l9_23=l9_21+1u;
uint l9_24=sc_RayTracingCasterIndexBuffer_obj.sc_RayTracingCasterTriangles[l9_23];
uvec4 l9_25=(uvec4(l9_22,l9_22,l9_24,l9_24)&uvec4(65535u,4294967295u,65535u,4294967295u))>>uvec4(0u,16u,0u,16u);
uvec3 l9_26;
if (l9_19==l9_20)
{
l9_26=l9_25.xyz;
}
else
{
l9_26=l9_25.yzw;
}
bool l9_27=sc_RayTracingCasterConfiguration.x==2u;
vec3 l9_28;
if (l9_27)
{
l9_28=sc_RayTracingInterpolateAnimatedFloat3(l9_7,l9_26,0u);
}
else
{
uint l9_29=sc_RayTracingCasterConfiguration.y>>16u;
uint l9_30=(l9_26.x*l9_29)+sc_RayTracingCasterOffsetPNTC.x;
uint l9_31=(l9_26.y*l9_29)+sc_RayTracingCasterOffsetPNTC.x;
uint l9_32=(l9_26.z*l9_29)+sc_RayTracingCasterOffsetPNTC.x;
vec3 l9_33;
if (sc_RayTracingCasterFormatPNTC.x==5u)
{
l9_33=((vec3(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_30],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_30+1u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_30+2u])*l9_6)+(vec3(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_31],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_31+1u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_31+2u])*l9_4))+(vec3(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_32],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_32+1u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_32+2u])*l9_5);
}
else
{
vec3 l9_34;
if (sc_RayTracingCasterFormatPNTC.x==6u)
{
l9_34=((vec3(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_30])),unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_30+1u])).x)*l9_6)+(vec3(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_31])),unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_31+1u])).x)*l9_4))+(vec3(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_32])),unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_32+1u])).x)*l9_5);
}
else
{
l9_34=vec3(1.0,0.0,0.0);
}
l9_33=l9_34;
}
l9_28=(sc_ModelMatrix*vec4(l9_33,1.0)).xyz;
}
vec3 l9_35;
if (sc_RayTracingCasterOffsetPNTC.y>0u)
{
vec3 l9_36;
if (l9_27)
{
l9_36=sc_RayTracingInterpolateAnimatedFloat3(l9_7,l9_26,3u);
}
else
{
uint l9_37=sc_RayTracingCasterConfiguration.y>>16u;
uint l9_38=(l9_26.x*l9_37)+sc_RayTracingCasterOffsetPNTC.y;
uint l9_39=(l9_26.y*l9_37)+sc_RayTracingCasterOffsetPNTC.y;
uint l9_40=(l9_26.z*l9_37)+sc_RayTracingCasterOffsetPNTC.y;
vec3 l9_41;
if (sc_RayTracingCasterFormatPNTC.y==5u)
{
l9_41=((vec3(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_38],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_38+1u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_38+2u])*l9_6)+(vec3(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_39],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_39+1u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_39+2u])*l9_4))+(vec3(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_40],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_40+1u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_40+2u])*l9_5);
}
else
{
vec3 l9_42;
if (sc_RayTracingCasterFormatPNTC.y==6u)
{
l9_42=((vec3(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_38])),unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_38+1u])).x)*l9_6)+(vec3(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_39])),unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_39+1u])).x)*l9_4))+(vec3(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_40])),unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_40+1u])).x)*l9_5);
}
else
{
l9_42=vec3(1.0,0.0,0.0);
}
l9_41=l9_42;
}
l9_36=normalize(sc_NormalMatrix*l9_41);
}
l9_35=l9_36;
}
else
{
l9_35=vec3(1.0,0.0,0.0);
}
bool l9_43=!l9_27;
bool l9_44;
if (l9_43)
{
l9_44=sc_RayTracingCasterOffsetPNTC.z>0u;
}
else
{
l9_44=l9_43;
}
vec4 l9_45;
if (l9_44)
{
uint l9_46=sc_RayTracingCasterConfiguration.y>>16u;
uint l9_47=(l9_26.x*l9_46)+sc_RayTracingCasterOffsetPNTC.z;
uint l9_48=(l9_26.y*l9_46)+sc_RayTracingCasterOffsetPNTC.z;
uint l9_49=(l9_26.z*l9_46)+sc_RayTracingCasterOffsetPNTC.z;
vec4 l9_50;
if (sc_RayTracingCasterFormatPNTC.z==5u)
{
l9_50=((vec4(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_47],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_47+1u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_47+2u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_47+3u])*l9_6)+(vec4(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_48],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_48+1u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_48+2u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_48+3u])*l9_4))+(vec4(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_49],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_49+1u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_49+2u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_49+3u])*l9_5);
}
else
{
vec4 l9_51;
if (sc_RayTracingCasterFormatPNTC.z==6u)
{
l9_51=((vec4(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_47])),unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_47+1u])))*l9_6)+(vec4(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_48])),unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_48+1u])))*l9_4))+(vec4(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_49])),unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_49+1u])))*l9_5);
}
else
{
vec4 l9_52;
if (sc_RayTracingCasterFormatPNTC.z==2u)
{
l9_52=((sc_RayTracingFetchUnorm4(l9_47)*l9_6)+(sc_RayTracingFetchUnorm4(l9_48)*l9_4))+(sc_RayTracingFetchUnorm4(l9_49)*l9_5);
}
else
{
l9_52=vec4(1.0,0.0,0.0,0.0);
}
l9_51=l9_52;
}
l9_50=l9_51;
}
l9_45=vec4(normalize(sc_NormalMatrix*l9_50.xyz),l9_50.w);
}
else
{
l9_45=vec4(1.0,0.0,0.0,1.0);
}
vec4 l9_53;
if (sc_RayTracingCasterFormatPNTC.w>0u)
{
uint l9_54=sc_RayTracingCasterConfiguration.y>>16u;
uint l9_55=(l9_26.x*l9_54)+sc_RayTracingCasterOffsetPNTC.w;
uint l9_56=(l9_26.y*l9_54)+sc_RayTracingCasterOffsetPNTC.w;
uint l9_57=(l9_26.z*l9_54)+sc_RayTracingCasterOffsetPNTC.w;
vec4 l9_58;
if (sc_RayTracingCasterFormatPNTC.w==5u)
{
l9_58=((vec4(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_55],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_55+1u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_55+2u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_55+3u])*l9_6)+(vec4(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_56],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_56+1u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_56+2u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_56+3u])*l9_4))+(vec4(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_57],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_57+1u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_57+2u],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_57+3u])*l9_5);
}
else
{
vec4 l9_59;
if (sc_RayTracingCasterFormatPNTC.w==6u)
{
l9_59=((vec4(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_55])),unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_55+1u])))*l9_6)+(vec4(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_56])),unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_56+1u])))*l9_4))+(vec4(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_57])),unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_57+1u])))*l9_5);
}
else
{
vec4 l9_60;
if (sc_RayTracingCasterFormatPNTC.w==2u)
{
l9_60=((sc_RayTracingFetchUnorm4(l9_55)*l9_6)+(sc_RayTracingFetchUnorm4(l9_56)*l9_4))+(sc_RayTracingFetchUnorm4(l9_57)*l9_5);
}
else
{
l9_60=vec4(1.0,0.0,0.0,0.0);
}
l9_59=l9_60;
}
l9_58=l9_59;
}
l9_53=l9_58;
}
else
{
l9_53=vec4(0.0);
}
uvec3 l9_61=l9_26%uvec3(2u);
vec2 l9_62=vec2(dot(l9_7,vec3(uvec3(1u)-l9_61)),0.0);
vec2 l9_63;
if (sc_RayTracingCasterFormatTexture.x>0u)
{
uint l9_64=sc_RayTracingCasterConfiguration.y>>16u;
uint l9_65=(l9_26.x*l9_64)+sc_RayTracingCasterOffsetTexture.x;
uint l9_66=(l9_26.y*l9_64)+sc_RayTracingCasterOffsetTexture.x;
uint l9_67=(l9_26.z*l9_64)+sc_RayTracingCasterOffsetTexture.x;
vec2 l9_68;
if (sc_RayTracingCasterFormatTexture.x==5u)
{
l9_68=((vec2(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_65],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_65+1u])*l9_6)+(vec2(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_66],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_66+1u])*l9_4))+(vec2(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_67],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_67+1u])*l9_5);
}
else
{
vec2 l9_69;
if (sc_RayTracingCasterFormatTexture.x==6u)
{
l9_69=((unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_65]))*l9_6)+(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_66]))*l9_4))+(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_67]))*l9_5);
}
else
{
l9_69=vec2(1.0,0.0);
}
l9_68=l9_69;
}
l9_63=l9_68;
}
else
{
l9_63=l9_62;
}
vec2 l9_70;
if (sc_RayTracingCasterFormatTexture.y>0u)
{
uint l9_71=sc_RayTracingCasterConfiguration.y>>16u;
uint l9_72=(l9_26.x*l9_71)+sc_RayTracingCasterOffsetTexture.y;
uint l9_73=(l9_26.y*l9_71)+sc_RayTracingCasterOffsetTexture.y;
uint l9_74=(l9_26.z*l9_71)+sc_RayTracingCasterOffsetTexture.y;
vec2 l9_75;
if (sc_RayTracingCasterFormatTexture.y==5u)
{
l9_75=((vec2(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_72],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_72+1u])*l9_6)+(vec2(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_73],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_73+1u])*l9_4))+(vec2(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_74],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_74+1u])*l9_5);
}
else
{
vec2 l9_76;
if (sc_RayTracingCasterFormatTexture.y==6u)
{
l9_76=((unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_72]))*l9_6)+(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_73]))*l9_4))+(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_74]))*l9_5);
}
else
{
l9_76=vec2(1.0,0.0);
}
l9_75=l9_76;
}
l9_70=l9_75;
}
else
{
l9_70=l9_62;
}
vec2 l9_77;
if (sc_RayTracingCasterFormatTexture.z>0u)
{
uint l9_78=sc_RayTracingCasterConfiguration.y>>16u;
uint l9_79=(l9_26.x*l9_78)+sc_RayTracingCasterOffsetTexture.z;
uint l9_80=(l9_26.y*l9_78)+sc_RayTracingCasterOffsetTexture.z;
uint l9_81=(l9_26.z*l9_78)+sc_RayTracingCasterOffsetTexture.z;
vec2 l9_82;
if (sc_RayTracingCasterFormatTexture.z==5u)
{
l9_82=((vec2(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_79],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_79+1u])*l9_6)+(vec2(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_80],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_80+1u])*l9_4))+(vec2(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_81],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_81+1u])*l9_5);
}
else
{
vec2 l9_83;
if (sc_RayTracingCasterFormatTexture.z==6u)
{
l9_83=((unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_79]))*l9_6)+(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_80]))*l9_4))+(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_81]))*l9_5);
}
else
{
l9_83=vec2(1.0,0.0);
}
l9_82=l9_83;
}
l9_77=l9_82;
}
else
{
l9_77=l9_62;
}
vec2 l9_84;
if (sc_RayTracingCasterFormatTexture.w>0u)
{
uint l9_85=sc_RayTracingCasterConfiguration.y>>16u;
uint l9_86=(l9_26.x*l9_85)+sc_RayTracingCasterOffsetTexture.w;
uint l9_87=(l9_26.y*l9_85)+sc_RayTracingCasterOffsetTexture.w;
uint l9_88=(l9_26.z*l9_85)+sc_RayTracingCasterOffsetTexture.w;
vec2 l9_89;
if (sc_RayTracingCasterFormatTexture.w==5u)
{
l9_89=((vec2(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_86],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_86+1u])*l9_6)+(vec2(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_87],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_87+1u])*l9_4))+(vec2(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_88],sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_88+1u])*l9_5);
}
else
{
vec2 l9_90;
if (sc_RayTracingCasterFormatTexture.w==6u)
{
l9_90=((unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_86]))*l9_6)+(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_87]))*l9_4))+(unpackHalf2x16(floatBitsToUint(sc_RayTracingCasterVertexBuffer_obj.sc_RayTracingCasterVertices[l9_88]))*l9_5);
}
else
{
l9_90=vec2(1.0,0.0);
}
l9_89=l9_90;
}
l9_84=l9_89;
}
else
{
l9_84=l9_62;
}
return sc_RayTracingHitPayload(-normalize(vec3(l9_18.x,l9_18.y,l9_13.z)),l9_28,l9_35,l9_45,l9_53,l9_63,l9_70,l9_77,l9_84,l9_2);
}
vec2 N35_gettransformUV(int pickUV,vec2 scale,vec2 offset,bool animated,bool enabled)
{
vec2 l9_0=tempGlobals.Surface_UVCoord0;
vec2 l9_1;
if (enabled==N35_EnableUV2)
{
vec2 l9_2;
if (pickUV==0)
{
l9_2=tempGlobals.Surface_UVCoord0;
}
else
{
l9_2=l9_0;
}
vec2 l9_3;
if (pickUV==1)
{
l9_3=tempGlobals.Surface_UVCoord1;
}
else
{
l9_3=l9_2;
}
vec2 l9_4;
if (pickUV==2)
{
l9_4=tempGlobals.gScreenCoord;
}
else
{
l9_4=l9_3;
}
l9_1=l9_4;
}
else
{
vec2 l9_5;
if (pickUV==0)
{
l9_5=tempGlobals.Surface_UVCoord0;
}
else
{
l9_5=l9_0;
}
vec2 l9_6;
if (pickUV==1)
{
l9_6=tempGlobals.Surface_UVCoord1;
}
else
{
l9_6=l9_5;
}
vec2 l9_7;
if (pickUV==2)
{
l9_7=tempGlobals.gScreenCoord;
}
else
{
l9_7=l9_6;
}
vec2 l9_8;
if (pickUV==3)
{
l9_8=tempGlobals.N35_TransformedUV2;
}
else
{
l9_8=l9_7;
}
l9_1=l9_8;
}
vec2 l9_9=scale;
vec2 l9_10=l9_1*l9_9;
vec2 l9_11=offset;
vec2 l9_12=l9_10+l9_11;
vec2 l9_13;
if (animated)
{
l9_13=l9_12+(offset*tempGlobals.gTimeElapsed);
}
else
{
l9_13=l9_12;
}
return l9_13;
}
vec2 N35_getUV(int pickUV)
{
vec2 l9_0=tempGlobals.Surface_UVCoord0;
vec2 l9_1;
if (pickUV==0)
{
l9_1=tempGlobals.Surface_UVCoord0;
}
else
{
l9_1=l9_0;
}
vec2 l9_2;
if (pickUV==1)
{
l9_2=tempGlobals.Surface_UVCoord1;
}
else
{
l9_2=l9_1;
}
vec2 l9_3;
if (pickUV==2)
{
l9_3=tempGlobals.N35_TransformedUV2;
}
else
{
l9_3=l9_2;
}
vec2 l9_4;
if (pickUV==3)
{
l9_4=tempGlobals.N35_TransformedUV3;
}
else
{
l9_4=l9_3;
}
return l9_4;
}
int baseTexGetStereoViewIndex()
{
int l9_0;
#if (baseTexHasSwappedViews)
{
l9_0=1-sc_GetStereoViewIndex();
}
#else
{
l9_0=sc_GetStereoViewIndex();
}
#endif
return l9_0;
}
void sc_SoftwareWrapEarly(inout float uv,int softwareWrapMode)
{
if (softwareWrapMode==1)
{
uv=fract(uv);
}
else
{
if (softwareWrapMode==2)
{
float l9_0=fract(uv);
uv=mix(l9_0,1.0-l9_0,clamp(step(0.25,fract((uv-l9_0)*0.5)),0.0,1.0));
}
}
}
void sc_ClampUV(inout float value,float minValue,float maxValue,bool useClampToBorder,inout float clampToBorderFactor)
{
float l9_0=clamp(value,minValue,maxValue);
float l9_1=step(abs(value-l9_0),9.9999997e-06);
clampToBorderFactor*=(l9_1+((1.0-float(useClampToBorder))*(1.0-l9_1)));
value=l9_0;
}
vec2 sc_TransformUV(vec2 uv,bool useUvTransform,mat3 uvTransform)
{
if (useUvTransform)
{
uv=vec2((uvTransform*vec3(uv,1.0)).xy);
}
return uv;
}
void sc_SoftwareWrapLate(inout float uv,int softwareWrapMode,bool useClampToBorder,inout float clampToBorderFactor)
{
if ((softwareWrapMode==0)||(softwareWrapMode==3))
{
sc_ClampUV(uv,0.0,1.0,useClampToBorder,clampToBorderFactor);
}
}
vec3 sc_SamplingCoordsViewToGlobal(vec2 uv,int renderingLayout,int viewIndex)
{
vec3 l9_0;
if (renderingLayout==0)
{
l9_0=vec3(uv,0.0);
}
else
{
vec3 l9_1;
if (renderingLayout==1)
{
l9_1=vec3(uv.x,(uv.y*0.5)+(0.5-(float(viewIndex)*0.5)),0.0);
}
else
{
l9_1=vec3(uv,float(viewIndex));
}
l9_0=l9_1;
}
return l9_0;
}
int opacityTexGetStereoViewIndex()
{
int l9_0;
#if (opacityTexHasSwappedViews)
{
l9_0=1-sc_GetStereoViewIndex();
}
#else
{
l9_0=sc_GetStereoViewIndex();
}
#endif
return l9_0;
}
int matcapNormalGetStereoViewIndex()
{
int l9_0;
#if (matcapNormalHasSwappedViews)
{
l9_0=1-sc_GetStereoViewIndex();
}
#else
{
l9_0=sc_GetStereoViewIndex();
}
#endif
return l9_0;
}
int emissiveTexGetStereoViewIndex()
{
int l9_0;
#if (emissiveTexHasSwappedViews)
{
l9_0=1-sc_GetStereoViewIndex();
}
#else
{
l9_0=sc_GetStereoViewIndex();
}
#endif
return l9_0;
}
vec3 ssPow(vec3 A,vec3 B)
{
float l9_0;
if (A.x<=0.0)
{
l9_0=0.0;
}
else
{
l9_0=pow(A.x,B.x);
}
float l9_1;
if (A.y<=0.0)
{
l9_1=0.0;
}
else
{
l9_1=pow(A.y,B.y);
}
float l9_2;
if (A.z<=0.0)
{
l9_2=0.0;
}
else
{
l9_2=pow(A.z,B.z);
}
return vec3(l9_0,l9_1,l9_2);
}
int matcapTexGetStereoViewIndex()
{
int l9_0;
#if (matcapTexHasSwappedViews)
{
l9_0=1-sc_GetStereoViewIndex();
}
#else
{
l9_0=sc_GetStereoViewIndex();
}
#endif
return l9_0;
}
int rimColorTexGetStereoViewIndex()
{
int l9_0;
#if (rimColorTexHasSwappedViews)
{
l9_0=1-sc_GetStereoViewIndex();
}
#else
{
l9_0=sc_GetStereoViewIndex();
}
#endif
return l9_0;
}
void sc_writeFragData0(vec4 col)
{
#if (sc_ShaderCacheConstant!=0)
{
col.x+=(sc_UniformConstants.x*float(sc_ShaderCacheConstant));
}
#endif
sc_FragData0=col;
}
int sc_ScreenTextureGetStereoViewIndex()
{
int l9_0;
#if (sc_ScreenTextureHasSwappedViews)
{
l9_0=1-sc_GetStereoViewIndex();
}
#else
{
l9_0=sc_GetStereoViewIndex();
}
#endif
return l9_0;
}
vec4 sc_readFragData0()
{
#if sc_FramebufferFetch
#ifdef GL_EXT_shader_framebuffer_fetch
return sc_FragData0;
#elif defined(GL_ARM_shader_framebuffer_fetch)
return gl_LastFragColorARM;
#endif
#else
return vec4(0.0);
#endif
}
int intensityTextureGetStereoViewIndex()
{
int l9_0;
#if (intensityTextureHasSwappedViews)
{
l9_0=1-sc_GetStereoViewIndex();
}
#else
{
l9_0=sc_GetStereoViewIndex();
}
#endif
return l9_0;
}
float transformSingleColor(float original,float intMap,float target)
{
#if ((BLEND_MODE_REALISTIC||BLEND_MODE_FORGRAY)||BLEND_MODE_NOTBRIGHT)
{
return original/pow(1.0-target,intMap);
}
#else
{
#if (BLEND_MODE_DIVISION)
{
return original/(1.0-target);
}
#else
{
#if (BLEND_MODE_BRIGHT)
{
return original/pow(1.0-target,2.0-(2.0*original));
}
#endif
}
#endif
}
#endif
return 0.0;
}
vec3 RGBtoHCV(vec3 rgb)
{
vec4 l9_0;
if (rgb.y<rgb.z)
{
l9_0=vec4(rgb.zy,-1.0,0.66666669);
}
else
{
l9_0=vec4(rgb.yz,0.0,-0.33333334);
}
vec4 l9_1;
if (rgb.x<l9_0.x)
{
l9_1=vec4(l9_0.xyw,rgb.x);
}
else
{
l9_1=vec4(rgb.x,l9_0.yzx);
}
float l9_2=l9_1.x-min(l9_1.w,l9_1.y);
return vec3(abs(((l9_1.w-l9_1.y)/((6.0*l9_2)+1e-07))+l9_1.z),l9_2,l9_1.x);
}
vec3 RGBToHSL(vec3 rgb)
{
vec3 l9_0=RGBtoHCV(rgb);
float l9_1=l9_0.y;
float l9_2=l9_0.z-(l9_1*0.5);
return vec3(l9_0.x,l9_1/((1.0-abs((2.0*l9_2)-1.0))+1e-07),l9_2);
}
vec3 HUEtoRGB(float hue)
{
return clamp(vec3(abs((6.0*hue)-3.0)-1.0,2.0-abs((6.0*hue)-2.0),2.0-abs((6.0*hue)-4.0)),vec3(0.0),vec3(1.0));
}
vec3 HSLToRGB(vec3 hsl)
{
return ((HUEtoRGB(hsl.x)-vec3(0.5))*((1.0-abs((2.0*hsl.z)-1.0))*hsl.y))+vec3(hsl.z);
}
vec3 transformColor(float yValue,vec3 original,vec3 target,float weight,float intMap)
{
#if (BLEND_MODE_INTENSE)
{
return mix(original,HSLToRGB(vec3(target.x,target.y,RGBToHSL(original).z)),vec3(weight));
}
#else
{
return mix(original,clamp(vec3(transformSingleColor(yValue,intMap,target.x),transformSingleColor(yValue,intMap,target.y),transformSingleColor(yValue,intMap,target.z)),vec3(0.0),vec3(1.0)),vec3(weight));
}
#endif
}
vec3 definedBlend(vec3 a,vec3 b)
{
#if (BLEND_MODE_LIGHTEN)
{
return max(a,b);
}
#else
{
#if (BLEND_MODE_DARKEN)
{
return min(a,b);
}
#else
{
#if (BLEND_MODE_DIVIDE)
{
return b/a;
}
#else
{
#if (BLEND_MODE_AVERAGE)
{
return (a+b)*0.5;
}
#else
{
#if (BLEND_MODE_SUBTRACT)
{
return max((a+b)-vec3(1.0),vec3(0.0));
}
#else
{
#if (BLEND_MODE_DIFFERENCE)
{
return abs(a-b);
}
#else
{
#if (BLEND_MODE_NEGATION)
{
return vec3(1.0)-abs((vec3(1.0)-a)-b);
}
#else
{
#if (BLEND_MODE_EXCLUSION)
{
return (a+b)-((a*2.0)*b);
}
#else
{
#if (BLEND_MODE_OVERLAY)
{
float l9_0;
if (a.x<0.5)
{
l9_0=(2.0*a.x)*b.x;
}
else
{
l9_0=1.0-((2.0*(1.0-a.x))*(1.0-b.x));
}
float l9_1;
if (a.y<0.5)
{
l9_1=(2.0*a.y)*b.y;
}
else
{
l9_1=1.0-((2.0*(1.0-a.y))*(1.0-b.y));
}
float l9_2;
if (a.z<0.5)
{
l9_2=(2.0*a.z)*b.z;
}
else
{
l9_2=1.0-((2.0*(1.0-a.z))*(1.0-b.z));
}
return vec3(l9_0,l9_1,l9_2);
}
#else
{
#if (BLEND_MODE_SOFT_LIGHT)
{
return (((vec3(1.0)-(b*2.0))*a)*a)+((a*2.0)*b);
}
#else
{
#if (BLEND_MODE_HARD_LIGHT)
{
float l9_3;
if (b.x<0.5)
{
l9_3=(2.0*b.x)*a.x;
}
else
{
l9_3=1.0-((2.0*(1.0-b.x))*(1.0-a.x));
}
float l9_4;
if (b.y<0.5)
{
l9_4=(2.0*b.y)*a.y;
}
else
{
l9_4=1.0-((2.0*(1.0-b.y))*(1.0-a.y));
}
float l9_5;
if (b.z<0.5)
{
l9_5=(2.0*b.z)*a.z;
}
else
{
l9_5=1.0-((2.0*(1.0-b.z))*(1.0-a.z));
}
return vec3(l9_3,l9_4,l9_5);
}
#else
{
#if (BLEND_MODE_COLOR_DODGE)
{
float l9_6;
if (b.x==1.0)
{
l9_6=b.x;
}
else
{
l9_6=min(a.x/(1.0-b.x),1.0);
}
float l9_7;
if (b.y==1.0)
{
l9_7=b.y;
}
else
{
l9_7=min(a.y/(1.0-b.y),1.0);
}
float l9_8;
if (b.z==1.0)
{
l9_8=b.z;
}
else
{
l9_8=min(a.z/(1.0-b.z),1.0);
}
return vec3(l9_6,l9_7,l9_8);
}
#else
{
#if (BLEND_MODE_COLOR_BURN)
{
float l9_9;
if (b.x==0.0)
{
l9_9=b.x;
}
else
{
l9_9=max(1.0-((1.0-a.x)/b.x),0.0);
}
float l9_10;
if (b.y==0.0)
{
l9_10=b.y;
}
else
{
l9_10=max(1.0-((1.0-a.y)/b.y),0.0);
}
float l9_11;
if (b.z==0.0)
{
l9_11=b.z;
}
else
{
l9_11=max(1.0-((1.0-a.z)/b.z),0.0);
}
return vec3(l9_9,l9_10,l9_11);
}
#else
{
#if (BLEND_MODE_LINEAR_LIGHT)
{
float l9_12;
if (b.x<0.5)
{
l9_12=max((a.x+(2.0*b.x))-1.0,0.0);
}
else
{
l9_12=min(a.x+(2.0*(b.x-0.5)),1.0);
}
float l9_13;
if (b.y<0.5)
{
l9_13=max((a.y+(2.0*b.y))-1.0,0.0);
}
else
{
l9_13=min(a.y+(2.0*(b.y-0.5)),1.0);
}
float l9_14;
if (b.z<0.5)
{
l9_14=max((a.z+(2.0*b.z))-1.0,0.0);
}
else
{
l9_14=min(a.z+(2.0*(b.z-0.5)),1.0);
}
return vec3(l9_12,l9_13,l9_14);
}
#else
{
#if (BLEND_MODE_VIVID_LIGHT)
{
float l9_15;
if (b.x<0.5)
{
float l9_16;
if ((2.0*b.x)==0.0)
{
l9_16=2.0*b.x;
}
else
{
l9_16=max(1.0-((1.0-a.x)/(2.0*b.x)),0.0);
}
l9_15=l9_16;
}
else
{
float l9_17;
if ((2.0*(b.x-0.5))==1.0)
{
l9_17=2.0*(b.x-0.5);
}
else
{
l9_17=min(a.x/(1.0-(2.0*(b.x-0.5))),1.0);
}
l9_15=l9_17;
}
float l9_18;
if (b.y<0.5)
{
float l9_19;
if ((2.0*b.y)==0.0)
{
l9_19=2.0*b.y;
}
else
{
l9_19=max(1.0-((1.0-a.y)/(2.0*b.y)),0.0);
}
l9_18=l9_19;
}
else
{
float l9_20;
if ((2.0*(b.y-0.5))==1.0)
{
l9_20=2.0*(b.y-0.5);
}
else
{
l9_20=min(a.y/(1.0-(2.0*(b.y-0.5))),1.0);
}
l9_18=l9_20;
}
float l9_21;
if (b.z<0.5)
{
float l9_22;
if ((2.0*b.z)==0.0)
{
l9_22=2.0*b.z;
}
else
{
l9_22=max(1.0-((1.0-a.z)/(2.0*b.z)),0.0);
}
l9_21=l9_22;
}
else
{
float l9_23;
if ((2.0*(b.z-0.5))==1.0)
{
l9_23=2.0*(b.z-0.5);
}
else
{
l9_23=min(a.z/(1.0-(2.0*(b.z-0.5))),1.0);
}
l9_21=l9_23;
}
return vec3(l9_15,l9_18,l9_21);
}
#else
{
#if (BLEND_MODE_PIN_LIGHT)
{
float l9_24;
if (b.x<0.5)
{
l9_24=min(a.x,2.0*b.x);
}
else
{
l9_24=max(a.x,2.0*(b.x-0.5));
}
float l9_25;
if (b.y<0.5)
{
l9_25=min(a.y,2.0*b.y);
}
else
{
l9_25=max(a.y,2.0*(b.y-0.5));
}
float l9_26;
if (b.z<0.5)
{
l9_26=min(a.z,2.0*b.z);
}
else
{
l9_26=max(a.z,2.0*(b.z-0.5));
}
return vec3(l9_24,l9_25,l9_26);
}
#else
{
#if (BLEND_MODE_HARD_MIX)
{
float l9_27;
if (b.x<0.5)
{
float l9_28;
if ((2.0*b.x)==0.0)
{
l9_28=2.0*b.x;
}
else
{
l9_28=max(1.0-((1.0-a.x)/(2.0*b.x)),0.0);
}
l9_27=l9_28;
}
else
{
float l9_29;
if ((2.0*(b.x-0.5))==1.0)
{
l9_29=2.0*(b.x-0.5);
}
else
{
l9_29=min(a.x/(1.0-(2.0*(b.x-0.5))),1.0);
}
l9_27=l9_29;
}
bool l9_30=l9_27<0.5;
float l9_31;
if (b.y<0.5)
{
float l9_32;
if ((2.0*b.y)==0.0)
{
l9_32=2.0*b.y;
}
else
{
l9_32=max(1.0-((1.0-a.y)/(2.0*b.y)),0.0);
}
l9_31=l9_32;
}
else
{
float l9_33;
if ((2.0*(b.y-0.5))==1.0)
{
l9_33=2.0*(b.y-0.5);
}
else
{
l9_33=min(a.y/(1.0-(2.0*(b.y-0.5))),1.0);
}
l9_31=l9_33;
}
bool l9_34=l9_31<0.5;
float l9_35;
if (b.z<0.5)
{
float l9_36;
if ((2.0*b.z)==0.0)
{
l9_36=2.0*b.z;
}
else
{
l9_36=max(1.0-((1.0-a.z)/(2.0*b.z)),0.0);
}
l9_35=l9_36;
}
else
{
float l9_37;
if ((2.0*(b.z-0.5))==1.0)
{
l9_37=2.0*(b.z-0.5);
}
else
{
l9_37=min(a.z/(1.0-(2.0*(b.z-0.5))),1.0);
}
l9_35=l9_37;
}
return vec3(l9_30 ? 0.0 : 1.0,l9_34 ? 0.0 : 1.0,(l9_35<0.5) ? 0.0 : 1.0);
}
#else
{
#if (BLEND_MODE_HARD_REFLECT)
{
float l9_38;
if (b.x==1.0)
{
l9_38=b.x;
}
else
{
l9_38=min((a.x*a.x)/(1.0-b.x),1.0);
}
float l9_39;
if (b.y==1.0)
{
l9_39=b.y;
}
else
{
l9_39=min((a.y*a.y)/(1.0-b.y),1.0);
}
float l9_40;
if (b.z==1.0)
{
l9_40=b.z;
}
else
{
l9_40=min((a.z*a.z)/(1.0-b.z),1.0);
}
return vec3(l9_38,l9_39,l9_40);
}
#else
{
#if (BLEND_MODE_HARD_GLOW)
{
float l9_41;
if (a.x==1.0)
{
l9_41=a.x;
}
else
{
l9_41=min((b.x*b.x)/(1.0-a.x),1.0);
}
float l9_42;
if (a.y==1.0)
{
l9_42=a.y;
}
else
{
l9_42=min((b.y*b.y)/(1.0-a.y),1.0);
}
float l9_43;
if (a.z==1.0)
{
l9_43=a.z;
}
else
{
l9_43=min((b.z*b.z)/(1.0-a.z),1.0);
}
return vec3(l9_41,l9_42,l9_43);
}
#else
{
#if (BLEND_MODE_HARD_PHOENIX)
{
return (min(a,b)-max(a,b))+vec3(1.0);
}
#else
{
#if (BLEND_MODE_HUE)
{
return HSLToRGB(vec3(RGBToHSL(b).x,RGBToHSL(a).yz));
}
#else
{
#if (BLEND_MODE_SATURATION)
{
vec3 l9_44=RGBToHSL(a);
return HSLToRGB(vec3(l9_44.x,RGBToHSL(b).y,l9_44.z));
}
#else
{
#if (BLEND_MODE_COLOR)
{
return HSLToRGB(vec3(RGBToHSL(b).xy,RGBToHSL(a).z));
}
#else
{
#if (BLEND_MODE_LUMINOSITY)
{
return HSLToRGB(vec3(RGBToHSL(a).xy,RGBToHSL(b).z));
}
#else
{
vec3 l9_45=a;
vec3 l9_46=b;
float l9_47=((0.29899999*l9_45.x)+(0.58700001*l9_45.y))+(0.114*l9_45.z);
float l9_48=pow(l9_47,1.0/correctedIntensity);
vec4 l9_49;
#if (intensityTextureLayout==2)
{
bool l9_50=(int(SC_USE_CLAMP_TO_BORDER_intensityTexture)!=0)&&(!(int(SC_USE_UV_MIN_MAX_intensityTexture)!=0));
float l9_51=l9_48;
sc_SoftwareWrapEarly(l9_51,ivec2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture,SC_SOFTWARE_WRAP_MODE_V_intensityTexture).x);
float l9_52=l9_51;
float l9_53=0.5;
sc_SoftwareWrapEarly(l9_53,ivec2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture,SC_SOFTWARE_WRAP_MODE_V_intensityTexture).y);
float l9_54=l9_53;
vec2 l9_55;
float l9_56;
#if (SC_USE_UV_MIN_MAX_intensityTexture)
{
bool l9_57;
#if (SC_USE_CLAMP_TO_BORDER_intensityTexture)
{
l9_57=ivec2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture,SC_SOFTWARE_WRAP_MODE_V_intensityTexture).x==3;
}
#else
{
l9_57=(int(SC_USE_CLAMP_TO_BORDER_intensityTexture)!=0);
}
#endif
float l9_58=l9_52;
float l9_59=1.0;
sc_ClampUV(l9_58,intensityTextureUvMinMax.x,intensityTextureUvMinMax.z,l9_57,l9_59);
float l9_60=l9_58;
float l9_61=l9_59;
bool l9_62;
#if (SC_USE_CLAMP_TO_BORDER_intensityTexture)
{
l9_62=ivec2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture,SC_SOFTWARE_WRAP_MODE_V_intensityTexture).y==3;
}
#else
{
l9_62=(int(SC_USE_CLAMP_TO_BORDER_intensityTexture)!=0);
}
#endif
float l9_63=l9_54;
float l9_64=l9_61;
sc_ClampUV(l9_63,intensityTextureUvMinMax.y,intensityTextureUvMinMax.w,l9_62,l9_64);
l9_56=l9_64;
l9_55=vec2(l9_60,l9_63);
}
#else
{
l9_56=1.0;
l9_55=vec2(l9_52,l9_54);
}
#endif
vec2 l9_65=sc_TransformUV(l9_55,(int(SC_USE_UV_TRANSFORM_intensityTexture)!=0),intensityTextureTransform);
float l9_66=l9_65.x;
float l9_67=l9_56;
sc_SoftwareWrapLate(l9_66,ivec2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture,SC_SOFTWARE_WRAP_MODE_V_intensityTexture).x,l9_50,l9_67);
float l9_68=l9_65.y;
float l9_69=l9_67;
sc_SoftwareWrapLate(l9_68,ivec2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture,SC_SOFTWARE_WRAP_MODE_V_intensityTexture).y,l9_50,l9_69);
float l9_70=l9_69;
vec3 l9_71=sc_SamplingCoordsViewToGlobal(vec2(l9_66,l9_68),intensityTextureLayout,intensityTextureGetStereoViewIndex());
vec4 l9_72=texture(intensityTextureArrSC,l9_71,0.0);
vec4 l9_73;
#if (SC_USE_CLAMP_TO_BORDER_intensityTexture)
{
l9_73=mix(intensityTextureBorderColor,l9_72,vec4(l9_70));
}
#else
{
l9_73=l9_72;
}
#endif
l9_49=l9_73;
}
#else
{
bool l9_74=(int(SC_USE_CLAMP_TO_BORDER_intensityTexture)!=0)&&(!(int(SC_USE_UV_MIN_MAX_intensityTexture)!=0));
float l9_75=l9_48;
sc_SoftwareWrapEarly(l9_75,ivec2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture,SC_SOFTWARE_WRAP_MODE_V_intensityTexture).x);
float l9_76=l9_75;
float l9_77=0.5;
sc_SoftwareWrapEarly(l9_77,ivec2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture,SC_SOFTWARE_WRAP_MODE_V_intensityTexture).y);
float l9_78=l9_77;
vec2 l9_79;
float l9_80;
#if (SC_USE_UV_MIN_MAX_intensityTexture)
{
bool l9_81;
#if (SC_USE_CLAMP_TO_BORDER_intensityTexture)
{
l9_81=ivec2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture,SC_SOFTWARE_WRAP_MODE_V_intensityTexture).x==3;
}
#else
{
l9_81=(int(SC_USE_CLAMP_TO_BORDER_intensityTexture)!=0);
}
#endif
float l9_82=l9_76;
float l9_83=1.0;
sc_ClampUV(l9_82,intensityTextureUvMinMax.x,intensityTextureUvMinMax.z,l9_81,l9_83);
float l9_84=l9_82;
float l9_85=l9_83;
bool l9_86;
#if (SC_USE_CLAMP_TO_BORDER_intensityTexture)
{
l9_86=ivec2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture,SC_SOFTWARE_WRAP_MODE_V_intensityTexture).y==3;
}
#else
{
l9_86=(int(SC_USE_CLAMP_TO_BORDER_intensityTexture)!=0);
}
#endif
float l9_87=l9_78;
float l9_88=l9_85;
sc_ClampUV(l9_87,intensityTextureUvMinMax.y,intensityTextureUvMinMax.w,l9_86,l9_88);
l9_80=l9_88;
l9_79=vec2(l9_84,l9_87);
}
#else
{
l9_80=1.0;
l9_79=vec2(l9_76,l9_78);
}
#endif
vec2 l9_89=sc_TransformUV(l9_79,(int(SC_USE_UV_TRANSFORM_intensityTexture)!=0),intensityTextureTransform);
float l9_90=l9_89.x;
float l9_91=l9_80;
sc_SoftwareWrapLate(l9_90,ivec2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture,SC_SOFTWARE_WRAP_MODE_V_intensityTexture).x,l9_74,l9_91);
float l9_92=l9_89.y;
float l9_93=l9_91;
sc_SoftwareWrapLate(l9_92,ivec2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture,SC_SOFTWARE_WRAP_MODE_V_intensityTexture).y,l9_74,l9_93);
float l9_94=l9_93;
vec3 l9_95=sc_SamplingCoordsViewToGlobal(vec2(l9_90,l9_92),intensityTextureLayout,intensityTextureGetStereoViewIndex());
vec4 l9_96=texture(intensityTexture,l9_95.xy,0.0);
vec4 l9_97;
#if (SC_USE_CLAMP_TO_BORDER_intensityTexture)
{
l9_97=mix(intensityTextureBorderColor,l9_96,vec4(l9_94));
}
#else
{
l9_97=l9_96;
}
#endif
l9_49=l9_97;
}
#endif
float l9_98=((((l9_49.x*256.0)+l9_49.y)+(l9_49.z/256.0))/257.00391)*16.0;
float l9_99;
#if (BLEND_MODE_FORGRAY)
{
l9_99=max(l9_98,1.0);
}
#else
{
l9_99=l9_98;
}
#endif
float l9_100;
#if (BLEND_MODE_NOTBRIGHT)
{
l9_100=min(l9_99,1.0);
}
#else
{
l9_100=l9_99;
}
#endif
return transformColor(l9_47,l9_45,l9_46,1.0,l9_100);
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
vec4 sc_OutputMotionVectorIfNeeded(vec4 finalColor)
{
#if (sc_MotionVectorsPass)
{
float l9_0=floor(((varPosAndMotion.w*5.0)+0.5)*65535.0);
float l9_1=floor(l9_0*0.00390625);
float l9_2=floor(((varNormalAndMotion.w*5.0)+0.5)*65535.0);
float l9_3=floor(l9_2*0.00390625);
return vec4(l9_1/255.0,(l9_0-(l9_1*256.0))/255.0,l9_3/255.0,(l9_2-(l9_3*256.0))/255.0);
}
#else
{
return finalColor;
}
#endif
}
float getFrontLayerZTestEpsilon()
{
#if (sc_SkinBonesCount>0)
{
return 5e-07;
}
#else
{
return 5.0000001e-08;
}
#endif
}
void unpackValues(float channel,int passIndex,inout int values[8])
{
#if (sc_OITCompositingPass)
{
channel=floor((channel*255.0)+0.5);
int l9_0=((passIndex+1)*4)-1;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_0>=(passIndex*4))
{
values[l9_0]=(values[l9_0]*4)+int(floor(mod(channel,4.0)));
channel=floor(channel/4.0);
l9_0--;
continue;
}
else
{
break;
}
}
}
#endif
}
float getDepthOrderingEpsilon()
{
#if (sc_SkinBonesCount>0)
{
return 0.001;
}
#else
{
return 0.0;
}
#endif
}
int encodeDepth(float depth,vec2 depthBounds)
{
float l9_0=(1.0-depthBounds.x)*1000.0;
return int(clamp((depth-l9_0)/((depthBounds.y*1000.0)-l9_0),0.0,1.0)*65535.0);
}
float viewSpaceDepth()
{
#if (UseViewSpaceDepthVariant&&((sc_OITDepthGatherPass||sc_OITCompositingPass)||sc_OITDepthBoundsPass))
{
return varViewSpaceDepth;
}
#else
{
return sc_ProjectionMatrixArray[sc_GetStereoViewIndex()][3].z/(sc_ProjectionMatrixArray[sc_GetStereoViewIndex()][2].z+((gl_FragCoord.z*2.0)-1.0));
}
#endif
}
float packValue(inout int value)
{
#if (sc_OITDepthGatherPass)
{
int l9_0=value;
value/=4;
return floor(floor(mod(float(l9_0),4.0))*64.0)/255.0;
}
#else
{
return 0.0;
}
#endif
}
void main()
{
N35_EnableUV2=false;
#if (sc_DepthOnly)
{
return;
}
#endif
#if ((sc_StereoRenderingMode==1)&&(sc_StereoRendering_IsClipDistanceEnabled==0))
{
if (varClipDistance<0.0)
{
discard;
}
}
#endif
bool l9_0=sc_RayTracingCasterConfiguration.x!=0u;
vec3 l9_1;
vec3 l9_2;
vec2 l9_3;
vec4 l9_4;
vec2 l9_5;
vec2 l9_6;
vec3 l9_7;
vec3 l9_8;
vec3 l9_9;
if (l9_0)
{
sc_RayTracingHitPayload l9_10=sc_RayTracingEvaluateHitPayload(ivec2(gl_FragCoord.xy));
vec3 l9_11=l9_10.positionWS;
vec3 l9_12=l9_10.normalWS;
vec4 l9_13=l9_10.tangentWS;
if (l9_10.id.x!=(sc_RayTracingCasterConfiguration.y&65535u))
{
return;
}
vec3 l9_14=l9_13.xyz;
vec4 l9_15=sc_ViewProjectionMatrixArray[sc_GetStereoViewIndex()]*vec4(l9_11,1.0);
l9_9=l9_12;
l9_8=l9_14;
l9_7=cross(l9_12,l9_14)*l9_13.w;
l9_6=l9_10.uv0;
l9_5=l9_10.uv1;
l9_4=l9_10.color;
l9_3=((l9_15.xy/vec2(l9_15.w))*0.5)+vec2(0.5);
l9_2=l9_10.viewDirWS;
l9_1=l9_11;
}
else
{
vec3 l9_16=normalize(varNormalAndMotion.xyz);
vec3 l9_17=normalize(varTangent.xyz);
l9_9=l9_16;
l9_8=l9_17;
l9_7=cross(l9_16,l9_17)*varTangent.w;
l9_6=varTex01.xy;
l9_5=varTex01.zw;
l9_4=varColor;
l9_3=sc_ScreenCoordsGlobalToView(gl_FragCoord.xy*sc_CurrentRenderTargetDims.zw);
l9_2=normalize(sc_Camera.position-varPosAndMotion.xyz);
l9_1=varPosAndMotion.xyz;
}
vec3 l9_18=(Port_Value_N080+vec3(0.001))-vec3(0.001);
tempGlobals=ssGlobals(sc_Time.x,sc_Time.y,0.0,vec2(0.0),vec2(0.0),l9_9,l9_8,l9_7,l9_6,l9_5,l9_4,l9_3,l9_2,l9_1);
N35_EnableUV2=(int(ENABLE_UV2)!=0);
tempGlobals.N35_TransformedUV2=N35_gettransformUV(NODE_13_DROPLIST_ITEM,uv2Scale,uv2Offset,(int(uv2EnableAnimation)!=0),N35_EnableUV2);
tempGlobals.N35_TransformedUV3=N35_gettransformUV(NODE_49_DROPLIST_ITEM,uv3Scale,uv3Offset,(int(uv3EnableAnimation)!=0),(int(ENABLE_UV3)!=0));
vec4 l9_19;
#if (ENABLE_BASE_TEX)
{
vec2 l9_20=N35_getUV(NODE_27_DROPLIST_ITEM);
vec4 l9_21;
#if (baseTexLayout==2)
{
bool l9_22=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0)&&(!(int(SC_USE_UV_MIN_MAX_baseTex)!=0));
float l9_23=l9_20.x;
sc_SoftwareWrapEarly(l9_23,ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex).x);
float l9_24=l9_23;
float l9_25=l9_20.y;
sc_SoftwareWrapEarly(l9_25,ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex).y);
float l9_26=l9_25;
vec2 l9_27;
float l9_28;
#if (SC_USE_UV_MIN_MAX_baseTex)
{
bool l9_29;
#if (SC_USE_CLAMP_TO_BORDER_baseTex)
{
l9_29=ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex).x==3;
}
#else
{
l9_29=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
}
#endif
float l9_30=l9_24;
float l9_31=1.0;
sc_ClampUV(l9_30,baseTexUvMinMax.x,baseTexUvMinMax.z,l9_29,l9_31);
float l9_32=l9_30;
float l9_33=l9_31;
bool l9_34;
#if (SC_USE_CLAMP_TO_BORDER_baseTex)
{
l9_34=ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex).y==3;
}
#else
{
l9_34=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
}
#endif
float l9_35=l9_26;
float l9_36=l9_33;
sc_ClampUV(l9_35,baseTexUvMinMax.y,baseTexUvMinMax.w,l9_34,l9_36);
l9_28=l9_36;
l9_27=vec2(l9_32,l9_35);
}
#else
{
l9_28=1.0;
l9_27=vec2(l9_24,l9_26);
}
#endif
vec2 l9_37=sc_TransformUV(l9_27,(int(SC_USE_UV_TRANSFORM_baseTex)!=0),baseTexTransform);
float l9_38=l9_37.x;
float l9_39=l9_28;
sc_SoftwareWrapLate(l9_38,ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex).x,l9_22,l9_39);
float l9_40=l9_37.y;
float l9_41=l9_39;
sc_SoftwareWrapLate(l9_40,ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex).y,l9_22,l9_41);
float l9_42=l9_41;
vec3 l9_43=sc_SamplingCoordsViewToGlobal(vec2(l9_38,l9_40),baseTexLayout,baseTexGetStereoViewIndex());
vec4 l9_44=texture(baseTexArrSC,l9_43,0.0);
vec4 l9_45;
#if (SC_USE_CLAMP_TO_BORDER_baseTex)
{
l9_45=mix(baseTexBorderColor,l9_44,vec4(l9_42));
}
#else
{
l9_45=l9_44;
}
#endif
l9_21=l9_45;
}
#else
{
bool l9_46=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0)&&(!(int(SC_USE_UV_MIN_MAX_baseTex)!=0));
float l9_47=l9_20.x;
sc_SoftwareWrapEarly(l9_47,ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex).x);
float l9_48=l9_47;
float l9_49=l9_20.y;
sc_SoftwareWrapEarly(l9_49,ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex).y);
float l9_50=l9_49;
vec2 l9_51;
float l9_52;
#if (SC_USE_UV_MIN_MAX_baseTex)
{
bool l9_53;
#if (SC_USE_CLAMP_TO_BORDER_baseTex)
{
l9_53=ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex).x==3;
}
#else
{
l9_53=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
}
#endif
float l9_54=l9_48;
float l9_55=1.0;
sc_ClampUV(l9_54,baseTexUvMinMax.x,baseTexUvMinMax.z,l9_53,l9_55);
float l9_56=l9_54;
float l9_57=l9_55;
bool l9_58;
#if (SC_USE_CLAMP_TO_BORDER_baseTex)
{
l9_58=ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex).y==3;
}
#else
{
l9_58=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
}
#endif
float l9_59=l9_50;
float l9_60=l9_57;
sc_ClampUV(l9_59,baseTexUvMinMax.y,baseTexUvMinMax.w,l9_58,l9_60);
l9_52=l9_60;
l9_51=vec2(l9_56,l9_59);
}
#else
{
l9_52=1.0;
l9_51=vec2(l9_48,l9_50);
}
#endif
vec2 l9_61=sc_TransformUV(l9_51,(int(SC_USE_UV_TRANSFORM_baseTex)!=0),baseTexTransform);
float l9_62=l9_61.x;
float l9_63=l9_52;
sc_SoftwareWrapLate(l9_62,ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex).x,l9_46,l9_63);
float l9_64=l9_61.y;
float l9_65=l9_63;
sc_SoftwareWrapLate(l9_64,ivec2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex).y,l9_46,l9_65);
float l9_66=l9_65;
vec3 l9_67=sc_SamplingCoordsViewToGlobal(vec2(l9_62,l9_64),baseTexLayout,baseTexGetStereoViewIndex());
vec4 l9_68=texture(baseTex,l9_67.xy,0.0);
vec4 l9_69;
#if (SC_USE_CLAMP_TO_BORDER_baseTex)
{
l9_69=mix(baseTexBorderColor,l9_68,vec4(l9_66));
}
#else
{
l9_69=l9_68;
}
#endif
l9_21=l9_69;
}
#endif
l9_19=baseColor*l9_21;
}
#else
{
l9_19=baseColor;
}
#endif
vec4 l9_70;
#if (ENABLE_RECOLOR)
{
vec3 l9_71=((recolorRed*l9_19.x)+(recolorGreen*l9_19.y))+(recolorBlue*l9_19.z);
l9_70=vec4(l9_71.x,l9_71.y,l9_71.z,l9_19.w);
}
#else
{
l9_70=l9_19;
}
#endif
float l9_72;
#if (ENABLE_OPACITY_TEX)
{
vec2 l9_73=N35_getUV(NODE_69_DROPLIST_ITEM);
vec4 l9_74;
#if (opacityTexLayout==2)
{
bool l9_75=(int(SC_USE_CLAMP_TO_BORDER_opacityTex)!=0)&&(!(int(SC_USE_UV_MIN_MAX_opacityTex)!=0));
float l9_76=l9_73.x;
sc_SoftwareWrapEarly(l9_76,ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex).x);
float l9_77=l9_76;
float l9_78=l9_73.y;
sc_SoftwareWrapEarly(l9_78,ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex).y);
float l9_79=l9_78;
vec2 l9_80;
float l9_81;
#if (SC_USE_UV_MIN_MAX_opacityTex)
{
bool l9_82;
#if (SC_USE_CLAMP_TO_BORDER_opacityTex)
{
l9_82=ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex).x==3;
}
#else
{
l9_82=(int(SC_USE_CLAMP_TO_BORDER_opacityTex)!=0);
}
#endif
float l9_83=l9_77;
float l9_84=1.0;
sc_ClampUV(l9_83,opacityTexUvMinMax.x,opacityTexUvMinMax.z,l9_82,l9_84);
float l9_85=l9_83;
float l9_86=l9_84;
bool l9_87;
#if (SC_USE_CLAMP_TO_BORDER_opacityTex)
{
l9_87=ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex).y==3;
}
#else
{
l9_87=(int(SC_USE_CLAMP_TO_BORDER_opacityTex)!=0);
}
#endif
float l9_88=l9_79;
float l9_89=l9_86;
sc_ClampUV(l9_88,opacityTexUvMinMax.y,opacityTexUvMinMax.w,l9_87,l9_89);
l9_81=l9_89;
l9_80=vec2(l9_85,l9_88);
}
#else
{
l9_81=1.0;
l9_80=vec2(l9_77,l9_79);
}
#endif
vec2 l9_90=sc_TransformUV(l9_80,(int(SC_USE_UV_TRANSFORM_opacityTex)!=0),opacityTexTransform);
float l9_91=l9_90.x;
float l9_92=l9_81;
sc_SoftwareWrapLate(l9_91,ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex).x,l9_75,l9_92);
float l9_93=l9_90.y;
float l9_94=l9_92;
sc_SoftwareWrapLate(l9_93,ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex).y,l9_75,l9_94);
float l9_95=l9_94;
vec3 l9_96=sc_SamplingCoordsViewToGlobal(vec2(l9_91,l9_93),opacityTexLayout,opacityTexGetStereoViewIndex());
vec4 l9_97=texture(opacityTexArrSC,l9_96,0.0);
vec4 l9_98;
#if (SC_USE_CLAMP_TO_BORDER_opacityTex)
{
l9_98=mix(opacityTexBorderColor,l9_97,vec4(l9_95));
}
#else
{
l9_98=l9_97;
}
#endif
l9_74=l9_98;
}
#else
{
bool l9_99=(int(SC_USE_CLAMP_TO_BORDER_opacityTex)!=0)&&(!(int(SC_USE_UV_MIN_MAX_opacityTex)!=0));
float l9_100=l9_73.x;
sc_SoftwareWrapEarly(l9_100,ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex).x);
float l9_101=l9_100;
float l9_102=l9_73.y;
sc_SoftwareWrapEarly(l9_102,ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex).y);
float l9_103=l9_102;
vec2 l9_104;
float l9_105;
#if (SC_USE_UV_MIN_MAX_opacityTex)
{
bool l9_106;
#if (SC_USE_CLAMP_TO_BORDER_opacityTex)
{
l9_106=ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex).x==3;
}
#else
{
l9_106=(int(SC_USE_CLAMP_TO_BORDER_opacityTex)!=0);
}
#endif
float l9_107=l9_101;
float l9_108=1.0;
sc_ClampUV(l9_107,opacityTexUvMinMax.x,opacityTexUvMinMax.z,l9_106,l9_108);
float l9_109=l9_107;
float l9_110=l9_108;
bool l9_111;
#if (SC_USE_CLAMP_TO_BORDER_opacityTex)
{
l9_111=ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex).y==3;
}
#else
{
l9_111=(int(SC_USE_CLAMP_TO_BORDER_opacityTex)!=0);
}
#endif
float l9_112=l9_103;
float l9_113=l9_110;
sc_ClampUV(l9_112,opacityTexUvMinMax.y,opacityTexUvMinMax.w,l9_111,l9_113);
l9_105=l9_113;
l9_104=vec2(l9_109,l9_112);
}
#else
{
l9_105=1.0;
l9_104=vec2(l9_101,l9_103);
}
#endif
vec2 l9_114=sc_TransformUV(l9_104,(int(SC_USE_UV_TRANSFORM_opacityTex)!=0),opacityTexTransform);
float l9_115=l9_114.x;
float l9_116=l9_105;
sc_SoftwareWrapLate(l9_115,ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex).x,l9_99,l9_116);
float l9_117=l9_114.y;
float l9_118=l9_116;
sc_SoftwareWrapLate(l9_117,ivec2(SC_SOFTWARE_WRAP_MODE_U_opacityTex,SC_SOFTWARE_WRAP_MODE_V_opacityTex).y,l9_99,l9_118);
float l9_119=l9_118;
vec3 l9_120=sc_SamplingCoordsViewToGlobal(vec2(l9_115,l9_117),opacityTexLayout,opacityTexGetStereoViewIndex());
vec4 l9_121=texture(opacityTex,l9_120.xy,0.0);
vec4 l9_122;
#if (SC_USE_CLAMP_TO_BORDER_opacityTex)
{
l9_122=mix(opacityTexBorderColor,l9_121,vec4(l9_119));
}
#else
{
l9_122=l9_121;
}
#endif
l9_74=l9_122;
}
#endif
l9_72=l9_74.x;
}
#else
{
l9_72=1.0;
}
#endif
float l9_123=l9_72*l9_70.w;
vec4 l9_124;
float l9_125;
if (NODE_38_DROPLIST_ITEM==1)
{
l9_125=l9_123*tempGlobals.VertexColor.w;
l9_124=l9_70*tempGlobals.VertexColor;
}
else
{
l9_125=l9_123;
l9_124=l9_70;
}
vec3 l9_126;
if (int(float(Port_Value_N064))==1)
{
l9_126=normalize(mat3(tempGlobals.VertexTangent_WorldSpace,tempGlobals.VertexBinormal_WorldSpace,tempGlobals.VertexNormal_WorldSpace)*l9_18);
}
else
{
l9_126=l9_18;
}
vec3 l9_127;
if ((int(ENABLE_MATCAP)!=0)&&(int(ENABLE_MATCAP_NORMAL)!=0))
{
vec2 l9_128=N35_getUV(Tweak_N56);
vec4 l9_129;
#if (matcapNormalLayout==2)
{
bool l9_130=(int(SC_USE_CLAMP_TO_BORDER_matcapNormal)!=0)&&(!(int(SC_USE_UV_MIN_MAX_matcapNormal)!=0));
float l9_131=l9_128.x;
sc_SoftwareWrapEarly(l9_131,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapNormal,SC_SOFTWARE_WRAP_MODE_V_matcapNormal).x);
float l9_132=l9_131;
float l9_133=l9_128.y;
sc_SoftwareWrapEarly(l9_133,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapNormal,SC_SOFTWARE_WRAP_MODE_V_matcapNormal).y);
float l9_134=l9_133;
vec2 l9_135;
float l9_136;
#if (SC_USE_UV_MIN_MAX_matcapNormal)
{
bool l9_137;
#if (SC_USE_CLAMP_TO_BORDER_matcapNormal)
{
l9_137=ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapNormal,SC_SOFTWARE_WRAP_MODE_V_matcapNormal).x==3;
}
#else
{
l9_137=(int(SC_USE_CLAMP_TO_BORDER_matcapNormal)!=0);
}
#endif
float l9_138=l9_132;
float l9_139=1.0;
sc_ClampUV(l9_138,matcapNormalUvMinMax.x,matcapNormalUvMinMax.z,l9_137,l9_139);
float l9_140=l9_138;
float l9_141=l9_139;
bool l9_142;
#if (SC_USE_CLAMP_TO_BORDER_matcapNormal)
{
l9_142=ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapNormal,SC_SOFTWARE_WRAP_MODE_V_matcapNormal).y==3;
}
#else
{
l9_142=(int(SC_USE_CLAMP_TO_BORDER_matcapNormal)!=0);
}
#endif
float l9_143=l9_134;
float l9_144=l9_141;
sc_ClampUV(l9_143,matcapNormalUvMinMax.y,matcapNormalUvMinMax.w,l9_142,l9_144);
l9_136=l9_144;
l9_135=vec2(l9_140,l9_143);
}
#else
{
l9_136=1.0;
l9_135=vec2(l9_132,l9_134);
}
#endif
vec2 l9_145=sc_TransformUV(l9_135,(int(SC_USE_UV_TRANSFORM_matcapNormal)!=0),matcapNormalTransform);
float l9_146=l9_145.x;
float l9_147=l9_136;
sc_SoftwareWrapLate(l9_146,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapNormal,SC_SOFTWARE_WRAP_MODE_V_matcapNormal).x,l9_130,l9_147);
float l9_148=l9_145.y;
float l9_149=l9_147;
sc_SoftwareWrapLate(l9_148,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapNormal,SC_SOFTWARE_WRAP_MODE_V_matcapNormal).y,l9_130,l9_149);
float l9_150=l9_149;
vec3 l9_151=sc_SamplingCoordsViewToGlobal(vec2(l9_146,l9_148),matcapNormalLayout,matcapNormalGetStereoViewIndex());
vec4 l9_152=texture(matcapNormalArrSC,l9_151,0.0);
vec4 l9_153;
#if (SC_USE_CLAMP_TO_BORDER_matcapNormal)
{
l9_153=mix(matcapNormalBorderColor,l9_152,vec4(l9_150));
}
#else
{
l9_153=l9_152;
}
#endif
l9_129=l9_153;
}
#else
{
bool l9_154=(int(SC_USE_CLAMP_TO_BORDER_matcapNormal)!=0)&&(!(int(SC_USE_UV_MIN_MAX_matcapNormal)!=0));
float l9_155=l9_128.x;
sc_SoftwareWrapEarly(l9_155,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapNormal,SC_SOFTWARE_WRAP_MODE_V_matcapNormal).x);
float l9_156=l9_155;
float l9_157=l9_128.y;
sc_SoftwareWrapEarly(l9_157,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapNormal,SC_SOFTWARE_WRAP_MODE_V_matcapNormal).y);
float l9_158=l9_157;
vec2 l9_159;
float l9_160;
#if (SC_USE_UV_MIN_MAX_matcapNormal)
{
bool l9_161;
#if (SC_USE_CLAMP_TO_BORDER_matcapNormal)
{
l9_161=ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapNormal,SC_SOFTWARE_WRAP_MODE_V_matcapNormal).x==3;
}
#else
{
l9_161=(int(SC_USE_CLAMP_TO_BORDER_matcapNormal)!=0);
}
#endif
float l9_162=l9_156;
float l9_163=1.0;
sc_ClampUV(l9_162,matcapNormalUvMinMax.x,matcapNormalUvMinMax.z,l9_161,l9_163);
float l9_164=l9_162;
float l9_165=l9_163;
bool l9_166;
#if (SC_USE_CLAMP_TO_BORDER_matcapNormal)
{
l9_166=ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapNormal,SC_SOFTWARE_WRAP_MODE_V_matcapNormal).y==3;
}
#else
{
l9_166=(int(SC_USE_CLAMP_TO_BORDER_matcapNormal)!=0);
}
#endif
float l9_167=l9_158;
float l9_168=l9_165;
sc_ClampUV(l9_167,matcapNormalUvMinMax.y,matcapNormalUvMinMax.w,l9_166,l9_168);
l9_160=l9_168;
l9_159=vec2(l9_164,l9_167);
}
#else
{
l9_160=1.0;
l9_159=vec2(l9_156,l9_158);
}
#endif
vec2 l9_169=sc_TransformUV(l9_159,(int(SC_USE_UV_TRANSFORM_matcapNormal)!=0),matcapNormalTransform);
float l9_170=l9_169.x;
float l9_171=l9_160;
sc_SoftwareWrapLate(l9_170,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapNormal,SC_SOFTWARE_WRAP_MODE_V_matcapNormal).x,l9_154,l9_171);
float l9_172=l9_169.y;
float l9_173=l9_171;
sc_SoftwareWrapLate(l9_172,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapNormal,SC_SOFTWARE_WRAP_MODE_V_matcapNormal).y,l9_154,l9_173);
float l9_174=l9_173;
vec3 l9_175=sc_SamplingCoordsViewToGlobal(vec2(l9_170,l9_172),matcapNormalLayout,matcapNormalGetStereoViewIndex());
vec4 l9_176=texture(matcapNormal,l9_175.xy,0.0);
vec4 l9_177;
#if (SC_USE_CLAMP_TO_BORDER_matcapNormal)
{
l9_177=mix(matcapNormalBorderColor,l9_176,vec4(l9_174));
}
#else
{
l9_177=l9_176;
}
#endif
l9_129=l9_177;
}
#endif
vec3 l9_178=l9_126+vec3(0.0,0.0,1.0);
vec3 l9_179=normalize(mat3(tempGlobals.VertexTangent_WorldSpace,tempGlobals.VertexBinormal_WorldSpace,tempGlobals.VertexNormal_WorldSpace)*((l9_129.xyz*1.9921875)-vec3(1.0)))*vec3(-1.0,-1.0,1.0);
l9_127=normalize((l9_178*dot(l9_178,l9_179))-(l9_179*l9_178.z));
}
else
{
l9_127=l9_126;
}
vec3 l9_180;
#if (ENABLE_EMISSIVE)
{
vec2 l9_181=N35_getUV(NODE_76_DROPLIST_ITEM);
vec4 l9_182;
#if (emissiveTexLayout==2)
{
bool l9_183=(int(SC_USE_CLAMP_TO_BORDER_emissiveTex)!=0)&&(!(int(SC_USE_UV_MIN_MAX_emissiveTex)!=0));
float l9_184=l9_181.x;
sc_SoftwareWrapEarly(l9_184,ivec2(SC_SOFTWARE_WRAP_MODE_U_emissiveTex,SC_SOFTWARE_WRAP_MODE_V_emissiveTex).x);
float l9_185=l9_184;
float l9_186=l9_181.y;
sc_SoftwareWrapEarly(l9_186,ivec2(SC_SOFTWARE_WRAP_MODE_U_emissiveTex,SC_SOFTWARE_WRAP_MODE_V_emissiveTex).y);
float l9_187=l9_186;
vec2 l9_188;
float l9_189;
#if (SC_USE_UV_MIN_MAX_emissiveTex)
{
bool l9_190;
#if (SC_USE_CLAMP_TO_BORDER_emissiveTex)
{
l9_190=ivec2(SC_SOFTWARE_WRAP_MODE_U_emissiveTex,SC_SOFTWARE_WRAP_MODE_V_emissiveTex).x==3;
}
#else
{
l9_190=(int(SC_USE_CLAMP_TO_BORDER_emissiveTex)!=0);
}
#endif
float l9_191=l9_185;
float l9_192=1.0;
sc_ClampUV(l9_191,emissiveTexUvMinMax.x,emissiveTexUvMinMax.z,l9_190,l9_192);
float l9_193=l9_191;
float l9_194=l9_192;
bool l9_195;
#if (SC_USE_CLAMP_TO_BORDER_emissiveTex)
{
l9_195=ivec2(SC_SOFTWARE_WRAP_MODE_U_emissiveTex,SC_SOFTWARE_WRAP_MODE_V_emissiveTex).y==3;
}
#else
{
l9_195=(int(SC_USE_CLAMP_TO_BORDER_emissiveTex)!=0);
}
#endif
float l9_196=l9_187;
float l9_197=l9_194;
sc_ClampUV(l9_196,emissiveTexUvMinMax.y,emissiveTexUvMinMax.w,l9_195,l9_197);
l9_189=l9_197;
l9_188=vec2(l9_193,l9_196);
}
#else
{
l9_189=1.0;
l9_188=vec2(l9_185,l9_187);
}
#endif
vec2 l9_198=sc_TransformUV(l9_188,(int(SC_USE_UV_TRANSFORM_emissiveTex)!=0),emissiveTexTransform);
float l9_199=l9_198.x;
float l9_200=l9_189;
sc_SoftwareWrapLate(l9_199,ivec2(SC_SOFTWARE_WRAP_MODE_U_emissiveTex,SC_SOFTWARE_WRAP_MODE_V_emissiveTex).x,l9_183,l9_200);
float l9_201=l9_198.y;
float l9_202=l9_200;
sc_SoftwareWrapLate(l9_201,ivec2(SC_SOFTWARE_WRAP_MODE_U_emissiveTex,SC_SOFTWARE_WRAP_MODE_V_emissiveTex).y,l9_183,l9_202);
float l9_203=l9_202;
vec3 l9_204=sc_SamplingCoordsViewToGlobal(vec2(l9_199,l9_201),emissiveTexLayout,emissiveTexGetStereoViewIndex());
vec4 l9_205=texture(emissiveTexArrSC,l9_204,0.0);
vec4 l9_206;
#if (SC_USE_CLAMP_TO_BORDER_emissiveTex)
{
l9_206=mix(emissiveTexBorderColor,l9_205,vec4(l9_203));
}
#else
{
l9_206=l9_205;
}
#endif
l9_182=l9_206;
}
#else
{
bool l9_207=(int(SC_USE_CLAMP_TO_BORDER_emissiveTex)!=0)&&(!(int(SC_USE_UV_MIN_MAX_emissiveTex)!=0));
float l9_208=l9_181.x;
sc_SoftwareWrapEarly(l9_208,ivec2(SC_SOFTWARE_WRAP_MODE_U_emissiveTex,SC_SOFTWARE_WRAP_MODE_V_emissiveTex).x);
float l9_209=l9_208;
float l9_210=l9_181.y;
sc_SoftwareWrapEarly(l9_210,ivec2(SC_SOFTWARE_WRAP_MODE_U_emissiveTex,SC_SOFTWARE_WRAP_MODE_V_emissiveTex).y);
float l9_211=l9_210;
vec2 l9_212;
float l9_213;
#if (SC_USE_UV_MIN_MAX_emissiveTex)
{
bool l9_214;
#if (SC_USE_CLAMP_TO_BORDER_emissiveTex)
{
l9_214=ivec2(SC_SOFTWARE_WRAP_MODE_U_emissiveTex,SC_SOFTWARE_WRAP_MODE_V_emissiveTex).x==3;
}
#else
{
l9_214=(int(SC_USE_CLAMP_TO_BORDER_emissiveTex)!=0);
}
#endif
float l9_215=l9_209;
float l9_216=1.0;
sc_ClampUV(l9_215,emissiveTexUvMinMax.x,emissiveTexUvMinMax.z,l9_214,l9_216);
float l9_217=l9_215;
float l9_218=l9_216;
bool l9_219;
#if (SC_USE_CLAMP_TO_BORDER_emissiveTex)
{
l9_219=ivec2(SC_SOFTWARE_WRAP_MODE_U_emissiveTex,SC_SOFTWARE_WRAP_MODE_V_emissiveTex).y==3;
}
#else
{
l9_219=(int(SC_USE_CLAMP_TO_BORDER_emissiveTex)!=0);
}
#endif
float l9_220=l9_211;
float l9_221=l9_218;
sc_ClampUV(l9_220,emissiveTexUvMinMax.y,emissiveTexUvMinMax.w,l9_219,l9_221);
l9_213=l9_221;
l9_212=vec2(l9_217,l9_220);
}
#else
{
l9_213=1.0;
l9_212=vec2(l9_209,l9_211);
}
#endif
vec2 l9_222=sc_TransformUV(l9_212,(int(SC_USE_UV_TRANSFORM_emissiveTex)!=0),emissiveTexTransform);
float l9_223=l9_222.x;
float l9_224=l9_213;
sc_SoftwareWrapLate(l9_223,ivec2(SC_SOFTWARE_WRAP_MODE_U_emissiveTex,SC_SOFTWARE_WRAP_MODE_V_emissiveTex).x,l9_207,l9_224);
float l9_225=l9_222.y;
float l9_226=l9_224;
sc_SoftwareWrapLate(l9_225,ivec2(SC_SOFTWARE_WRAP_MODE_U_emissiveTex,SC_SOFTWARE_WRAP_MODE_V_emissiveTex).y,l9_207,l9_226);
float l9_227=l9_226;
vec3 l9_228=sc_SamplingCoordsViewToGlobal(vec2(l9_223,l9_225),emissiveTexLayout,emissiveTexGetStereoViewIndex());
vec4 l9_229=texture(emissiveTex,l9_228.xy,0.0);
vec4 l9_230;
#if (SC_USE_CLAMP_TO_BORDER_emissiveTex)
{
l9_230=mix(emissiveTexBorderColor,l9_229,vec4(l9_227));
}
#else
{
l9_230=l9_229;
}
#endif
l9_182=l9_230;
}
#endif
l9_180=l9_182.xyz;
}
#else
{
l9_180=vec3(0.0);
}
#endif
bool l9_231=NODE_38_DROPLIST_ITEM==2;
vec3 l9_232;
if (l9_231)
{
l9_232=l9_180+tempGlobals.VertexColor.xyz;
}
else
{
l9_232=l9_180;
}
vec3 l9_233;
if (l9_231||(int(ENABLE_EMISSIVE)!=0))
{
l9_233=ssPow((l9_232*emissiveColor)*vec3(emissiveIntensity),vec3(2.2));
}
else
{
l9_233=l9_232;
}
vec3 l9_234=tempGlobals.ViewDirWS;
vec3 l9_235=normalize(-l9_234);
vec3 l9_236;
if (((Port_Value_N079 ? 1.001 : 0.001)-0.001)!=0.0)
{
int l9_237=sc_GetStereoViewIndex();
l9_236=mat3(sc_ViewMatrixArray[l9_237][0].xyz,sc_ViewMatrixArray[l9_237][1].xyz,sc_ViewMatrixArray[l9_237][2].xyz)*sc_ViewMatrixInverseArray[sc_GetStereoViewIndex()][1].xyz;
}
else
{
l9_236=sc_ViewMatrixInverseArray[sc_GetStereoViewIndex()][1].xyz;
}
vec3 l9_238=cross(l9_235,l9_236);
vec3 l9_239=normalize(l9_238);
vec3 l9_240=cross(l9_239,l9_235);
vec3 l9_241=mat3(vec3(l9_239.x,l9_240.x,l9_235.x),vec3(l9_239.y,l9_240.y,l9_235.y),vec3(l9_239.z,l9_240.z,l9_235.z))*l9_127;
vec2 l9_242=(l9_241.xy*0.5)+vec2(0.5);
vec3 l9_243;
#if (ENABLE_MATCAP)
{
vec4 l9_244;
#if (matcapTexLayout==2)
{
bool l9_245=(int(SC_USE_CLAMP_TO_BORDER_matcapTex)!=0)&&(!(int(SC_USE_UV_MIN_MAX_matcapTex)!=0));
float l9_246=l9_242.x;
sc_SoftwareWrapEarly(l9_246,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapTex,SC_SOFTWARE_WRAP_MODE_V_matcapTex).x);
float l9_247=l9_246;
float l9_248=l9_242.y;
sc_SoftwareWrapEarly(l9_248,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapTex,SC_SOFTWARE_WRAP_MODE_V_matcapTex).y);
float l9_249=l9_248;
vec2 l9_250;
float l9_251;
#if (SC_USE_UV_MIN_MAX_matcapTex)
{
bool l9_252;
#if (SC_USE_CLAMP_TO_BORDER_matcapTex)
{
l9_252=ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapTex,SC_SOFTWARE_WRAP_MODE_V_matcapTex).x==3;
}
#else
{
l9_252=(int(SC_USE_CLAMP_TO_BORDER_matcapTex)!=0);
}
#endif
float l9_253=l9_247;
float l9_254=1.0;
sc_ClampUV(l9_253,matcapTexUvMinMax.x,matcapTexUvMinMax.z,l9_252,l9_254);
float l9_255=l9_253;
float l9_256=l9_254;
bool l9_257;
#if (SC_USE_CLAMP_TO_BORDER_matcapTex)
{
l9_257=ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapTex,SC_SOFTWARE_WRAP_MODE_V_matcapTex).y==3;
}
#else
{
l9_257=(int(SC_USE_CLAMP_TO_BORDER_matcapTex)!=0);
}
#endif
float l9_258=l9_249;
float l9_259=l9_256;
sc_ClampUV(l9_258,matcapTexUvMinMax.y,matcapTexUvMinMax.w,l9_257,l9_259);
l9_251=l9_259;
l9_250=vec2(l9_255,l9_258);
}
#else
{
l9_251=1.0;
l9_250=vec2(l9_247,l9_249);
}
#endif
vec2 l9_260=sc_TransformUV(l9_250,(int(SC_USE_UV_TRANSFORM_matcapTex)!=0),matcapTexTransform);
float l9_261=l9_260.x;
float l9_262=l9_251;
sc_SoftwareWrapLate(l9_261,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapTex,SC_SOFTWARE_WRAP_MODE_V_matcapTex).x,l9_245,l9_262);
float l9_263=l9_260.y;
float l9_264=l9_262;
sc_SoftwareWrapLate(l9_263,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapTex,SC_SOFTWARE_WRAP_MODE_V_matcapTex).y,l9_245,l9_264);
float l9_265=l9_264;
vec3 l9_266=sc_SamplingCoordsViewToGlobal(vec2(l9_261,l9_263),matcapTexLayout,matcapTexGetStereoViewIndex());
vec4 l9_267=texture(matcapTexArrSC,l9_266,0.0);
vec4 l9_268;
#if (SC_USE_CLAMP_TO_BORDER_matcapTex)
{
l9_268=mix(matcapTexBorderColor,l9_267,vec4(l9_265));
}
#else
{
l9_268=l9_267;
}
#endif
l9_244=l9_268;
}
#else
{
bool l9_269=(int(SC_USE_CLAMP_TO_BORDER_matcapTex)!=0)&&(!(int(SC_USE_UV_MIN_MAX_matcapTex)!=0));
float l9_270=l9_242.x;
sc_SoftwareWrapEarly(l9_270,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapTex,SC_SOFTWARE_WRAP_MODE_V_matcapTex).x);
float l9_271=l9_270;
float l9_272=l9_242.y;
sc_SoftwareWrapEarly(l9_272,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapTex,SC_SOFTWARE_WRAP_MODE_V_matcapTex).y);
float l9_273=l9_272;
vec2 l9_274;
float l9_275;
#if (SC_USE_UV_MIN_MAX_matcapTex)
{
bool l9_276;
#if (SC_USE_CLAMP_TO_BORDER_matcapTex)
{
l9_276=ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapTex,SC_SOFTWARE_WRAP_MODE_V_matcapTex).x==3;
}
#else
{
l9_276=(int(SC_USE_CLAMP_TO_BORDER_matcapTex)!=0);
}
#endif
float l9_277=l9_271;
float l9_278=1.0;
sc_ClampUV(l9_277,matcapTexUvMinMax.x,matcapTexUvMinMax.z,l9_276,l9_278);
float l9_279=l9_277;
float l9_280=l9_278;
bool l9_281;
#if (SC_USE_CLAMP_TO_BORDER_matcapTex)
{
l9_281=ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapTex,SC_SOFTWARE_WRAP_MODE_V_matcapTex).y==3;
}
#else
{
l9_281=(int(SC_USE_CLAMP_TO_BORDER_matcapTex)!=0);
}
#endif
float l9_282=l9_273;
float l9_283=l9_280;
sc_ClampUV(l9_282,matcapTexUvMinMax.y,matcapTexUvMinMax.w,l9_281,l9_283);
l9_275=l9_283;
l9_274=vec2(l9_279,l9_282);
}
#else
{
l9_275=1.0;
l9_274=vec2(l9_271,l9_273);
}
#endif
vec2 l9_284=sc_TransformUV(l9_274,(int(SC_USE_UV_TRANSFORM_matcapTex)!=0),matcapTexTransform);
float l9_285=l9_284.x;
float l9_286=l9_275;
sc_SoftwareWrapLate(l9_285,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapTex,SC_SOFTWARE_WRAP_MODE_V_matcapTex).x,l9_269,l9_286);
float l9_287=l9_284.y;
float l9_288=l9_286;
sc_SoftwareWrapLate(l9_287,ivec2(SC_SOFTWARE_WRAP_MODE_U_matcapTex,SC_SOFTWARE_WRAP_MODE_V_matcapTex).y,l9_269,l9_288);
float l9_289=l9_288;
vec3 l9_290=sc_SamplingCoordsViewToGlobal(vec2(l9_285,l9_287),matcapTexLayout,matcapTexGetStereoViewIndex());
vec4 l9_291=texture(matcapTex,l9_290.xy,0.0);
vec4 l9_292;
#if (SC_USE_CLAMP_TO_BORDER_matcapTex)
{
l9_292=mix(matcapTexBorderColor,l9_291,vec4(l9_289));
}
#else
{
l9_292=l9_291;
}
#endif
l9_244=l9_292;
}
#endif
l9_243=l9_244.xyz*matcapIntensity;
}
#else
{
l9_243=vec3(0.0);
}
#endif
vec3 l9_293;
#if (Tweak_N46)
{
vec3 l9_294=rimColor*rimIntensity;
vec3 l9_295;
#if (rimTex)
{
vec2 l9_296=N35_getUV(NODE_315_DROPLIST_ITEM);
vec4 l9_297;
#if (rimColorTexLayout==2)
{
bool l9_298=(int(SC_USE_CLAMP_TO_BORDER_rimColorTex)!=0)&&(!(int(SC_USE_UV_MIN_MAX_rimColorTex)!=0));
float l9_299=l9_296.x;
sc_SoftwareWrapEarly(l9_299,ivec2(SC_SOFTWARE_WRAP_MODE_U_rimColorTex,SC_SOFTWARE_WRAP_MODE_V_rimColorTex).x);
float l9_300=l9_299;
float l9_301=l9_296.y;
sc_SoftwareWrapEarly(l9_301,ivec2(SC_SOFTWARE_WRAP_MODE_U_rimColorTex,SC_SOFTWARE_WRAP_MODE_V_rimColorTex).y);
float l9_302=l9_301;
vec2 l9_303;
float l9_304;
#if (SC_USE_UV_MIN_MAX_rimColorTex)
{
bool l9_305;
#if (SC_USE_CLAMP_TO_BORDER_rimColorTex)
{
l9_305=ivec2(SC_SOFTWARE_WRAP_MODE_U_rimColorTex,SC_SOFTWARE_WRAP_MODE_V_rimColorTex).x==3;
}
#else
{
l9_305=(int(SC_USE_CLAMP_TO_BORDER_rimColorTex)!=0);
}
#endif
float l9_306=l9_300;
float l9_307=1.0;
sc_ClampUV(l9_306,rimColorTexUvMinMax.x,rimColorTexUvMinMax.z,l9_305,l9_307);
float l9_308=l9_306;
float l9_309=l9_307;
bool l9_310;
#if (SC_USE_CLAMP_TO_BORDER_rimColorTex)
{
l9_310=ivec2(SC_SOFTWARE_WRAP_MODE_U_rimColorTex,SC_SOFTWARE_WRAP_MODE_V_rimColorTex).y==3;
}
#else
{
l9_310=(int(SC_USE_CLAMP_TO_BORDER_rimColorTex)!=0);
}
#endif
float l9_311=l9_302;
float l9_312=l9_309;
sc_ClampUV(l9_311,rimColorTexUvMinMax.y,rimColorTexUvMinMax.w,l9_310,l9_312);
l9_304=l9_312;
l9_303=vec2(l9_308,l9_311);
}
#else
{
l9_304=1.0;
l9_303=vec2(l9_300,l9_302);
}
#endif
vec2 l9_313=sc_TransformUV(l9_303,(int(SC_USE_UV_TRANSFORM_rimColorTex)!=0),rimColorTexTransform);
float l9_314=l9_313.x;
float l9_315=l9_304;
sc_SoftwareWrapLate(l9_314,ivec2(SC_SOFTWARE_WRAP_MODE_U_rimColorTex,SC_SOFTWARE_WRAP_MODE_V_rimColorTex).x,l9_298,l9_315);
float l9_316=l9_313.y;
float l9_317=l9_315;
sc_SoftwareWrapLate(l9_316,ivec2(SC_SOFTWARE_WRAP_MODE_U_rimColorTex,SC_SOFTWARE_WRAP_MODE_V_rimColorTex).y,l9_298,l9_317);
float l9_318=l9_317;
vec3 l9_319=sc_SamplingCoordsViewToGlobal(vec2(l9_314,l9_316),rimColorTexLayout,rimColorTexGetStereoViewIndex());
vec4 l9_320=texture(rimColorTexArrSC,l9_319,0.0);
vec4 l9_321;
#if (SC_USE_CLAMP_TO_BORDER_rimColorTex)
{
l9_321=mix(rimColorTexBorderColor,l9_320,vec4(l9_318));
}
#else
{
l9_321=l9_320;
}
#endif
l9_297=l9_321;
}
#else
{
bool l9_322=(int(SC_USE_CLAMP_TO_BORDER_rimColorTex)!=0)&&(!(int(SC_USE_UV_MIN_MAX_rimColorTex)!=0));
float l9_323=l9_296.x;
sc_SoftwareWrapEarly(l9_323,ivec2(SC_SOFTWARE_WRAP_MODE_U_rimColorTex,SC_SOFTWARE_WRAP_MODE_V_rimColorTex).x);
float l9_324=l9_323;
float l9_325=l9_296.y;
sc_SoftwareWrapEarly(l9_325,ivec2(SC_SOFTWARE_WRAP_MODE_U_rimColorTex,SC_SOFTWARE_WRAP_MODE_V_rimColorTex).y);
float l9_326=l9_325;
vec2 l9_327;
float l9_328;
#if (SC_USE_UV_MIN_MAX_rimColorTex)
{
bool l9_329;
#if (SC_USE_CLAMP_TO_BORDER_rimColorTex)
{
l9_329=ivec2(SC_SOFTWARE_WRAP_MODE_U_rimColorTex,SC_SOFTWARE_WRAP_MODE_V_rimColorTex).x==3;
}
#else
{
l9_329=(int(SC_USE_CLAMP_TO_BORDER_rimColorTex)!=0);
}
#endif
float l9_330=l9_324;
float l9_331=1.0;
sc_ClampUV(l9_330,rimColorTexUvMinMax.x,rimColorTexUvMinMax.z,l9_329,l9_331);
float l9_332=l9_330;
float l9_333=l9_331;
bool l9_334;
#if (SC_USE_CLAMP_TO_BORDER_rimColorTex)
{
l9_334=ivec2(SC_SOFTWARE_WRAP_MODE_U_rimColorTex,SC_SOFTWARE_WRAP_MODE_V_rimColorTex).y==3;
}
#else
{
l9_334=(int(SC_USE_CLAMP_TO_BORDER_rimColorTex)!=0);
}
#endif
float l9_335=l9_326;
float l9_336=l9_333;
sc_ClampUV(l9_335,rimColorTexUvMinMax.y,rimColorTexUvMinMax.w,l9_334,l9_336);
l9_328=l9_336;
l9_327=vec2(l9_332,l9_335);
}
#else
{
l9_328=1.0;
l9_327=vec2(l9_324,l9_326);
}
#endif
vec2 l9_337=sc_TransformUV(l9_327,(int(SC_USE_UV_TRANSFORM_rimColorTex)!=0),rimColorTexTransform);
float l9_338=l9_337.x;
float l9_339=l9_328;
sc_SoftwareWrapLate(l9_338,ivec2(SC_SOFTWARE_WRAP_MODE_U_rimColorTex,SC_SOFTWARE_WRAP_MODE_V_rimColorTex).x,l9_322,l9_339);
float l9_340=l9_337.y;
float l9_341=l9_339;
sc_SoftwareWrapLate(l9_340,ivec2(SC_SOFTWARE_WRAP_MODE_U_rimColorTex,SC_SOFTWARE_WRAP_MODE_V_rimColorTex).y,l9_322,l9_341);
float l9_342=l9_341;
vec3 l9_343=sc_SamplingCoordsViewToGlobal(vec2(l9_338,l9_340),rimColorTexLayout,rimColorTexGetStereoViewIndex());
vec4 l9_344=texture(rimColorTex,l9_343.xy,0.0);
vec4 l9_345;
#if (SC_USE_CLAMP_TO_BORDER_rimColorTex)
{
l9_345=mix(rimColorTexBorderColor,l9_344,vec4(l9_342));
}
#else
{
l9_345=l9_344;
}
#endif
l9_297=l9_345;
}
#endif
l9_295=l9_294*l9_297.xyz;
}
#else
{
l9_295=l9_294;
}
#endif
vec3 l9_346=tempGlobals.ViewDirWS;
float l9_347=dot(l9_127,l9_346);
float l9_348=abs(l9_347);
float l9_349;
if (!(int(ENABLE_RIM_INVERT)!=0))
{
l9_349=1.0-l9_348;
}
else
{
l9_349=l9_348;
}
float l9_350;
if (l9_349<=0.0)
{
l9_350=0.0;
}
else
{
l9_350=pow(l9_349,rimExponent);
}
vec3 l9_351;
#if (SC_DEVICE_CLASS>=2)
{
l9_351=vec3(pow(l9_295.x,2.2),pow(l9_295.y,2.2),pow(l9_295.z,2.2));
}
#else
{
l9_351=l9_295*l9_295;
}
#endif
l9_293=vec3(0.0)+(l9_351*l9_350);
}
#else
{
l9_293=vec3(0.0);
}
#endif
vec3 l9_352=(l9_124.xyz+ssPow((l9_233+vec3(0.0))+l9_293,vec3(0.45454547)))+l9_243;
vec4 l9_353=vec4(l9_352.x,l9_352.y,l9_352.z,vec4(0.0).w);
l9_353.w=l9_125;
#if (sc_BlendMode_AlphaTest)
{
if (l9_125<alphaTestThreshold)
{
discard;
}
}
#endif
#if (ENABLE_STIPPLE_PATTERN_TEST)
{
if (l9_125<((mod(dot(floor(mod(gl_FragCoord.xy,vec2(4.0))),vec2(4.0,1.0))*9.0,16.0)+1.0)/17.0))
{
discard;
}
}
#endif
if (l9_0)
{
vec4 l9_354;
#if (sc_RayTracingCasterForceOpaque)
{
vec4 l9_355=l9_353;
l9_355.w=1.0;
l9_354=l9_355;
}
#else
{
l9_354=l9_353;
}
#endif
sc_writeFragData0(max(l9_354,vec4(0.0)));
return;
}
vec4 l9_356;
#if (sc_ProjectiveShadowsCaster)
{
float l9_357;
#if (((sc_BlendMode_Normal||sc_BlendMode_AlphaToCoverage)||sc_BlendMode_PremultipliedAlphaHardware)||sc_BlendMode_PremultipliedAlphaAuto)
{
l9_357=l9_125;
}
#else
{
float l9_358;
#if (sc_BlendMode_PremultipliedAlpha)
{
l9_358=clamp(l9_125*2.0,0.0,1.0);
}
#else
{
float l9_359;
#if (sc_BlendMode_AddWithAlphaFactor)
{
l9_359=clamp(dot(l9_353.xyz,vec3(l9_125)),0.0,1.0);
}
#else
{
float l9_360;
#if (sc_BlendMode_AlphaTest)
{
l9_360=1.0;
}
#else
{
float l9_361;
#if (sc_BlendMode_Multiply)
{
l9_361=(1.0-dot(l9_353.xyz,vec3(0.33333001)))*l9_125;
}
#else
{
float l9_362;
#if (sc_BlendMode_MultiplyOriginal)
{
l9_362=(1.0-clamp(dot(l9_353.xyz,vec3(1.0)),0.0,1.0))*l9_125;
}
#else
{
float l9_363;
#if (sc_BlendMode_ColoredGlass)
{
l9_363=clamp(dot(l9_353.xyz,vec3(1.0)),0.0,1.0)*l9_125;
}
#else
{
float l9_364;
#if (sc_BlendMode_Add)
{
l9_364=clamp(dot(l9_353.xyz,vec3(1.0)),0.0,1.0);
}
#else
{
float l9_365;
#if (sc_BlendMode_AddWithAlphaFactor)
{
l9_365=clamp(dot(l9_353.xyz,vec3(1.0)),0.0,1.0)*l9_125;
}
#else
{
float l9_366;
#if (sc_BlendMode_Screen)
{
l9_366=dot(l9_353.xyz,vec3(0.33333001))*l9_125;
}
#else
{
float l9_367;
#if (sc_BlendMode_Min)
{
l9_367=1.0-clamp(dot(l9_353.xyz,vec3(1.0)),0.0,1.0);
}
#else
{
float l9_368;
#if (sc_BlendMode_Max)
{
l9_368=clamp(dot(l9_353.xyz,vec3(1.0)),0.0,1.0);
}
#else
{
l9_368=1.0;
}
#endif
l9_367=l9_368;
}
#endif
l9_366=l9_367;
}
#endif
l9_365=l9_366;
}
#endif
l9_364=l9_365;
}
#endif
l9_363=l9_364;
}
#endif
l9_362=l9_363;
}
#endif
l9_361=l9_362;
}
#endif
l9_360=l9_361;
}
#endif
l9_359=l9_360;
}
#endif
l9_358=l9_359;
}
#endif
l9_357=l9_358;
}
#endif
l9_356=vec4(mix(sc_ShadowColor.xyz,sc_ShadowColor.xyz*l9_353.xyz,vec3(sc_ShadowColor.w)),sc_ShadowDensity*l9_357);
}
#else
{
vec4 l9_369;
#if (sc_RenderAlphaToColor)
{
l9_369=vec4(l9_125);
}
#else
{
vec4 l9_370;
#if (sc_BlendMode_Custom)
{
vec4 l9_371;
#if (sc_FramebufferFetch)
{
l9_371=sc_readFragData0();
}
#else
{
vec2 l9_372=sc_ScreenCoordsGlobalToView(gl_FragCoord.xy*sc_CurrentRenderTargetDims.zw);
vec4 l9_373;
#if (sc_ScreenTextureLayout==2)
{
l9_373=texture(sc_ScreenTextureArrSC,sc_SamplingCoordsViewToGlobal(l9_372,sc_ScreenTextureLayout,sc_ScreenTextureGetStereoViewIndex()),0.0);
}
#else
{
l9_373=texture(sc_ScreenTexture,sc_SamplingCoordsViewToGlobal(l9_372,sc_ScreenTextureLayout,sc_ScreenTextureGetStereoViewIndex()).xy,0.0);
}
#endif
l9_371=l9_373;
}
#endif
vec3 l9_374=mix(l9_371.xyz,definedBlend(l9_371.xyz,l9_353.xyz).xyz,vec3(l9_125));
vec4 l9_375=vec4(l9_374.x,l9_374.y,l9_374.z,vec4(0.0).w);
l9_375.w=1.0;
l9_370=l9_375;
}
#else
{
vec4 l9_376;
#if (sc_Voxelization)
{
l9_376=vec4(varScreenPos.xyz,1.0);
}
#else
{
vec4 l9_377;
#if (sc_OutputBounds)
{
float l9_378=clamp(abs(gl_FragCoord.z),0.0,1.0);
l9_377=vec4(l9_378,1.0-l9_378,1.0,1.0);
}
#else
{
vec4 l9_379;
#if (sc_BlendMode_MultiplyOriginal)
{
l9_379=vec4(mix(vec3(1.0),l9_353.xyz,vec3(l9_125)),l9_125);
}
#else
{
vec4 l9_380;
#if (sc_BlendMode_Screen||sc_BlendMode_PremultipliedAlphaAuto)
{
float l9_381;
#if (sc_BlendMode_PremultipliedAlphaAuto)
{
l9_381=clamp(l9_125,0.0,1.0);
}
#else
{
l9_381=l9_125;
}
#endif
l9_380=vec4(l9_353.xyz*l9_381,l9_381);
}
#else
{
l9_380=l9_353;
}
#endif
l9_379=l9_380;
}
#endif
l9_377=l9_379;
}
#endif
l9_376=l9_377;
}
#endif
l9_370=l9_376;
}
#endif
l9_369=l9_370;
}
#endif
l9_356=l9_369;
}
#endif
vec4 l9_382;
if (PreviewEnabled==1)
{
vec4 l9_383;
if (((PreviewVertexSaved*1.0)!=0.0) ? true : false)
{
l9_383=PreviewVertexColor;
}
else
{
l9_383=vec4(0.0);
}
l9_382=l9_383;
}
else
{
l9_382=l9_356;
}
vec4 l9_384=sc_OutputMotionVectorIfNeeded(max(l9_382,vec4(0.0)));
vec4 l9_385=clamp(l9_384,vec4(0.0),vec4(1.0));
#if (sc_OITDepthBoundsPass)
{
#if (sc_OITDepthBoundsPass)
{
float l9_386=clamp(viewSpaceDepth()/1000.0,0.0,1.0);
sc_writeFragData0(vec4(max(0.0,1.0-(l9_386-0.0039215689)),min(1.0,l9_386+0.0039215689),0.0,0.0));
}
#endif
}
#else
{
#if (sc_OITDepthPrepass)
{
sc_writeFragData0(vec4(1.0));
}
#else
{
#if (sc_OITDepthGatherPass)
{
#if (sc_OITDepthGatherPass)
{
vec2 l9_387=sc_ScreenCoordsGlobalToView(gl_FragCoord.xy*sc_CurrentRenderTargetDims.zw);
#if (sc_OITMaxLayers4Plus1)
{
if ((gl_FragCoord.z-texture(sc_OITFrontDepthTexture,l9_387).x)<=getFrontLayerZTestEpsilon())
{
discard;
}
}
#endif
int l9_388=encodeDepth(viewSpaceDepth(),texture(sc_OITFilteredDepthBoundsTexture,l9_387).xy);
float l9_389=packValue(l9_388);
int l9_396=int(l9_385.w*255.0);
float l9_397=packValue(l9_396);
sc_writeFragData0(vec4(packValue(l9_388),packValue(l9_388),packValue(l9_388),packValue(l9_388)));
}
#endif
}
#else
{
#if (sc_OITCompositingPass)
{
#if (sc_OITCompositingPass)
{
vec2 l9_400=sc_ScreenCoordsGlobalToView(gl_FragCoord.xy*sc_CurrentRenderTargetDims.zw);
#if (sc_OITMaxLayers4Plus1)
{
if ((gl_FragCoord.z-texture(sc_OITFrontDepthTexture,l9_400).x)<=getFrontLayerZTestEpsilon())
{
discard;
}
}
#endif
int l9_401[8];
int l9_402[8];
int l9_403=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_403<8)
{
l9_401[l9_403]=0;
l9_402[l9_403]=0;
l9_403++;
continue;
}
else
{
break;
}
}
int l9_404;
#if (sc_OITMaxLayers8)
{
l9_404=2;
}
#else
{
l9_404=1;
}
#endif
int l9_405=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_405<l9_404)
{
vec4 l9_406;
vec4 l9_407;
vec4 l9_408;
if (l9_405==0)
{
l9_408=texture(sc_OITAlpha0,l9_400);
l9_407=texture(sc_OITDepthLow0,l9_400);
l9_406=texture(sc_OITDepthHigh0,l9_400);
}
else
{
l9_408=vec4(0.0);
l9_407=vec4(0.0);
l9_406=vec4(0.0);
}
vec4 l9_409;
vec4 l9_410;
vec4 l9_411;
if (l9_405==1)
{
l9_411=texture(sc_OITAlpha1,l9_400);
l9_410=texture(sc_OITDepthLow1,l9_400);
l9_409=texture(sc_OITDepthHigh1,l9_400);
}
else
{
l9_411=l9_408;
l9_410=l9_407;
l9_409=l9_406;
}
if (any(notEqual(l9_409,vec4(0.0)))||any(notEqual(l9_410,vec4(0.0))))
{
int l9_412[8]=l9_401;
unpackValues(l9_409.w,l9_405,l9_412);
unpackValues(l9_409.z,l9_405,l9_412);
unpackValues(l9_409.y,l9_405,l9_412);
unpackValues(l9_409.x,l9_405,l9_412);
unpackValues(l9_410.w,l9_405,l9_412);
unpackValues(l9_410.z,l9_405,l9_412);
unpackValues(l9_410.y,l9_405,l9_412);
unpackValues(l9_410.x,l9_405,l9_412);
int l9_421[8]=l9_402;
unpackValues(l9_411.w,l9_405,l9_421);
unpackValues(l9_411.z,l9_405,l9_421);
unpackValues(l9_411.y,l9_405,l9_421);
unpackValues(l9_411.x,l9_405,l9_421);
}
l9_405++;
continue;
}
else
{
break;
}
}
vec4 l9_426=texture(sc_OITFilteredDepthBoundsTexture,l9_400);
vec2 l9_427=l9_426.xy;
int l9_428;
#if (sc_SkinBonesCount>0)
{
l9_428=encodeDepth(((1.0-l9_426.x)*1000.0)+getDepthOrderingEpsilon(),l9_427);
}
#else
{
l9_428=0;
}
#endif
int l9_429=encodeDepth(viewSpaceDepth(),l9_427);
vec4 l9_430;
l9_430=l9_385*l9_385.w;
vec4 l9_431;
int l9_432=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_432<8)
{
int l9_433=l9_401[l9_432];
int l9_434=l9_429-l9_428;
bool l9_435=l9_433<l9_434;
bool l9_436;
if (l9_435)
{
l9_436=l9_401[l9_432]>0;
}
else
{
l9_436=l9_435;
}
if (l9_436)
{
vec3 l9_437=l9_430.xyz*(1.0-(float(l9_402[l9_432])/255.0));
l9_431=vec4(l9_437.x,l9_437.y,l9_437.z,l9_430.w);
}
else
{
l9_431=l9_430;
}
l9_430=l9_431;
l9_432++;
continue;
}
else
{
break;
}
}
sc_writeFragData0(l9_430);
#if (sc_OITMaxLayersVisualizeLayerCount)
{
discard;
}
#endif
}
#endif
}
#else
{
#if (sc_OITFrontLayerPass)
{
#if (sc_OITFrontLayerPass)
{
if (abs(gl_FragCoord.z-texture(sc_OITFrontDepthTexture,sc_ScreenCoordsGlobalToView(gl_FragCoord.xy*sc_CurrentRenderTargetDims.zw)).x)>getFrontLayerZTestEpsilon())
{
discard;
}
sc_writeFragData0(l9_385);
}
#endif
}
#else
{
sc_writeFragData0(l9_384);
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif // #elif defined FRAGMENT_SHADER // #if defined VERTEX_SHADER
