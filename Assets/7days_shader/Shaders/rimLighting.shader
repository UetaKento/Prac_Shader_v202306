Shader "Custom/rimLighting"
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
            float3 worldNormal;
            float3 viewDir;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        fixed4 _BaseColor;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 baseColor = fixed4(1, 1, 1, 1);
			fixed4 rimColor  = fixed4(1,0,0,1);
            o.Albedo = baseColor;
            float abdot = abs(dot(IN.viewDir, IN.worldNormal)); // カメラからのベクトルと物体の法線ベクトルの内積。直行すれば0になる。
			float rim = 1 - abdot; // alphaが0なら透明、1なら不透明。物体の正面は透明に、輪郭は不透明にするために1 - abdotをする。

            o.Emission = rimColor * dot(rim,2);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
