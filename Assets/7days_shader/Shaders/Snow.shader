Shader "Custom/Snow"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Snow("Snow", Range(0,2))= 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 worldNormal;
        };

		half _Snow;
		fixed4 _Color;

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float d = dot(IN.worldNormal, fixed3(0, 1, 0));
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            fixed4 white = fixed4(1,1,1,1);
            c = lerp(c, white, d*_Snow);
			o.Albedo = c.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
