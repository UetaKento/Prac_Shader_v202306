Shader "Custom/CircleDraw_v2"
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
            float dist = distance( fixed3(0,7,0), IN.worldPos );
            float minradius = 5*abs(sin(_Time*5));
            float maxradius = 7*abs(sin(_Time*5));
            if(minradius < dist && dist < maxradius){
                o.Albedo = fixed4(1,1,1,1);
			} else {
                // fixed4 c = fixed4(0, 0, 0, 1);
                // float greyScale = c.r*0.3 + c.g*0.6 + c.b*0.1;
                // if(greyScale<=0.2){
                    // o.Alpha = 0.2;
                // }else{
                    // o.Alpha = 1;
                // }
                o.Albedo = fixed4(110/255.0, 87/255.0, 139/255.0, 1);
			}
        }
        ENDCG
    }
    FallBack "Diffuse"
}
