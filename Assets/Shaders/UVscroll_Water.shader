Shader "Custom/UVscroll_Water"
{
    Properties{
		_MainTex("Texture", 2D) = "white"{}
	}
    SubShader
    {
        Tags { "RenderType"="Opaque" }
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

        sampler2D _MainTex;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed2 uv = IN.uv_MainTex;
			uv.x += 0.4 * _Time;
			uv.y += 0.8 * _Time;
			o.Albedo = tex2D (_MainTex, uv);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
