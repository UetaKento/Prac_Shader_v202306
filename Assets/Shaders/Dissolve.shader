Shader "Custom/Dissolve"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _DisolveTex ("DisolveTex (RGB)", 2D) = "white" {}
		_Threshold("Threshold", Range(0,1))= 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        sampler2D _MainTex;
		sampler2D _DisolveTex;

        struct Input
        {
            float2 uv_MainTex;
        };

		half _Threshold;
		fixed4 _Color;

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 m = tex2D (_DisolveTex, IN.uv_MainTex);
			half g = m.r * 0.2 + m.g * 0.7 + m.b * 0.1;
            // _Threshold = abs(sin(_Time*10));
			if( g < _Threshold ){
				discard;
			} 

			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
