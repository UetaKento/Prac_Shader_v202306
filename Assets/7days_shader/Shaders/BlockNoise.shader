Shader "Custom/BlockNoise"
{
    Properties {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
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
        };

        float random (fixed2 p) { 
            return frac(sin(dot(p, fixed2(12.9898,78.233))) * 43758.5453);
        }

        float noise(fixed2 st)
        {
            fixed2 p = floor(st); //floorメソッドは小数値の整数部分を返すメソッド。例えば、4.3なら4、5.1なら5を返す。
            return random(p);
        }

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float c = noise(IN.uv_MainTex*8); //uv座標を8倍している、つまり同じテクスチャが8枚貼られている。
            o.Albedo = fixed4(c,c,c,1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
