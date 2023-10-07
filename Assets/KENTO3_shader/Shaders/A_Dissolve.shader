Shader "Unlit/A_Dissolve"
{
    Properties
    {
        [NoScaleOffset]
        _MainTex ("Texture", 2D) = "white" {}
        [NoScaleOffset]
        _DissolveTex("DissolveTexture", 2D) = "white" {}
        [NoScaleOffset]
        _MaskTex("MaskTexture", 2D) = "white" {}
        _Threshold("Threshold", Range(0,1))= 0.0
    }
    SubShader
    {
        // Tags { "RenderType"="Opaque" }
        Tags { "RenderType"="Tranparent" }
        Blend SrcAlpha OneMinusSrcAlpha
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
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _DissolveTex;
            sampler2D _MaskTex;
            half _Threshold;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                fixed4 dissolve = tex2D(_DissolveTex, i.uv);
                fixed4 mask = tex2D(_MaskTex, i.uv);
                fixed4 dissolveMask = dissolve*mask;
                // Dissolve画像の白黒度合い(GrayScale)を計算する。
                // 白色に近いほど1に、黒色に近いほど0に近い値をとる。
                // float dissolveR_abs = abs(0.3*dissolve.r - 0.3);
                // float dissolveG_abs = abs(0.6*dissolve.g - 0.6);
                // float dissolveB_abs = abs(0.1*dissolve.b - 0.1);
                // float dissolveGrayScale = 0.3*dissolve.r + 0.6*dissolve.g + 0.1*dissolve.b;
                // float abs_dissolveGrayScale = dissolveR_abs + dissolveG_abs + dissolveB_abs;

                float dissolveMaskR_abs = abs(0.3*dissolveMask.r - 0.3);
                float dissolveMaskG_abs = abs(0.6*dissolveMask.g - 0.6);
                float dissolveMaskB_abs = abs(0.1*dissolveMask.b - 0.1);
                float dissolveMaskGrayScale = 0.3*dissolveMask.r + 0.6*dissolveMask.g + 0.1*dissolveMask.b;
                float abs_dissolveMaskGrayScale = dissolveMaskR_abs + dissolveMaskG_abs + dissolveMaskB_abs;

                // clip()は引数が0以下の場合、そのpixelを描画しないという処理をする。
                // Custom Dataで設定したCurveによってi.uv.zは変化し、
                // i.uv.zを使った計算によってpixelを描画するかしないかを決める。
                // clip(abs_dissolveMaskGrayScale - _Threshold);
                clip(abs_dissolveMaskGrayScale - abs(sin(_Time.y / 2)));
                return col;
            }
            ENDCG
        }
    }
}
