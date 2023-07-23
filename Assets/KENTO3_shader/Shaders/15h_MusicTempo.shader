Shader "Unlit/15h_MusicTempo"
{
    Properties
    {
        _BPM ("Music BPM", float) = 120
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float _BPM;

            //UnityのRandomRangeのまんま
            float randRange(float2 Seed)
            {
                //返値は0.000...~0.999...の値。
                float randomno = frac(sin(dot(Seed, float2(12.9898, 78.233))) * 43758.5453);
                return randomno;
            }

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //_BPMが120の時は、1/2になる。1/2秒でビートを刻むので、1秒で2回、60秒で120回刻む。
                float beatIn1second = 60 / _BPM;
                //のこぎり波によって増え続ける_Time.yのinputに対して、0->1->0->1...というoutputが出せる。

                fixed periodChangedChainsawWave = (1/beatIn1second)*_Time.y - floor((1/beatIn1second)*_Time.y);
                
                int Zero2Three = floor((1/beatIn1second)*_Time.y);
                //fixed4 zeroOne4 = fixed4(randRange(Zero2Three+5), randRange(Zero2Three+2), randRange(Zero2Three), 1);

                fixed4 zeroOne4 = fixed4(1-periodChangedChainsawWave, 1-periodChangedChainsawWave, 1-periodChangedChainsawWave, 1);
                return zeroOne4;
            }
            ENDCG
        }
    }
}
