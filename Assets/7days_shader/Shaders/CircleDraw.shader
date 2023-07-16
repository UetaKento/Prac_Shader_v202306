Shader "Custom/CircleDraw"
{
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        struct Input
        {
            float3 worldPos;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float dist = distance( fixed3(0,5,0), IN.worldPos );
            float val = abs(sin(dist)); // (0,5,0)からの距離(dist)をsinのθとみなす。
            if( val > 0.98 ){
				o.Albedo = fixed4(1, 1, 1, 1);
			} else {
				o.Albedo = fixed4(110/255.0, 87/255.0, 139/255.0, 1);
			}
        }
        ENDCG
    }
    FallBack "Diffuse"
}
