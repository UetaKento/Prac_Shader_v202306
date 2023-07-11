Shader "Custom/Cutout_Sphere"
{
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque"
               "Queue" = "Geometry-1" }
        LOD 200

        Pass{
            Zwrite On
            ColorMask 0
        }
    }
    FallBack "Diffuse"
}
