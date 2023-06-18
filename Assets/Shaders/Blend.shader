Shader "Custom/Blend"
{
    Properties{
		_MainTex("Texture", 2D) = "white"{}
        _SubTex ("Sub Texture", 2D) = "white" {}
		_MaskTex ("Mask Texture", 2D) = "white" {}
	}
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _SubTex;
		sampler2D _MaskTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c1 = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 c2 = tex2D (_SubTex,  IN.uv_MainTex);
			fixed4 p  = tex2D (_MaskTex, IN.uv_MainTex); //グレースケールと同様に、pは黒いところは0、白いところは1を返す。;
            o.Albedo = lerp(c1, c2, p);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
