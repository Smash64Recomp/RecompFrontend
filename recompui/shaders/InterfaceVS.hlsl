struct Input {
    float4x4 transform;
    float2 translation;
    uint texture_premultiplied;
};

[[vk::push_constant]]
ConstantBuffer<Input> gInput : register(b0, space0);

void VSMain(
    in float2 iPosition : POSITION,
    in float4 iColor : COLOR,
    in float2 iUV : TEXCOORD,
    out float4 oColor : COLOR,
    out float2 oUV : TEXCOORD,
    out nointerpolation uint oTexturePremultiplied : TEXCOORD1,
    out float4 oPosition : SV_Position
)
{
	float2 translatedPos = iPosition + gInput.translation;
	oPosition = mul(gInput.transform, float4(translatedPos, 0, 1));

	oColor = iColor;
	oUV = iUV;
    oTexturePremultiplied = gInput.texture_premultiplied;
}
