Shader "Custom/Cutout_Plane"
{
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque"
               "Queue" = "Geometry-2" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        struct Input
        {
            float2 uv_MainTex;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = fixed4(0.5f, 0.5f, 1.0f, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
