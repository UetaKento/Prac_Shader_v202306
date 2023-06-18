Shader "Custom/StainedGlass"
{
    Properties{
		_MainTex("Texture", 2D) = "white"{}
	}
    SubShader
    {
        Tags { "RenderType"="Opaque"
               "Queue" = "Transparent" } // ガラスの後ろに物体があることを表現したい場合"Queue" = "Transparent"が必要。
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha:fade 
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
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
            // o.Albedo = c.rgb;
            float greyScale = c.r*0.3 + c.g*0.6 + c.b*0.1;
            if(greyScale<=0.2){
                o.Alpha = 1;
            }else{
                o.Alpha = 0.5;
            }
        }
        ENDCG
    }
    FallBack "Diffuse"
}
