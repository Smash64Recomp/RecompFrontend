SamplerState gSampler : register(s1, space0);
Texture2D<float4> gTexture : register(t2, space1);

void PSMain(
    in float4 iColor : COLOR,
    in float2 iUV : TEXCOORD,
    in nointerpolation uint iTexturePremultiplied : TEXCOORD1,
    out float4 oColor : SV_TARGET
)
{
    float4 texel = gTexture.Sample(gSampler, iUV);
    if (iTexturePremultiplied != 0) {
        texel.rgb = texel.a > 0.0f ? texel.rgb / texel.a : 0.0f;
    }
    oColor = texel * iColor;
}
