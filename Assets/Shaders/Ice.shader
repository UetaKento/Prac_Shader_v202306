Shader "Custom/Ice"
{
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha:fade 
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
            o.Albedo = fixed4(0.1, 0.3, 1, 1);
            float abdot = abs(dot(IN.viewDir, IN.worldNormal)); // カメラからのベクトルと物体の法線ベクトルの内積。直行すれば0になる。
			float alpha = 1 - abdot; // alphaが0なら透明、1なら不透明。物体の正面は透明に、輪郭は不透明にするために1 - abdotをする。
     		o.Alpha =  alpha*1.5f;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
