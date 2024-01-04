Shader "Custom/Waves" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
        _Amplitude ("Amplitude", Float) = 1
        _Wavelength ("Wavelength", Float) = 10
        _Speed ("Speed", Float) = 1
		_Normal ("Normal", 2D) = "bump" {}
		_Emission("Emission", float) = 0
		[HDR] _EmissionColor("Color", Color) = (0, 0, 0)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows vertex:vert
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _Normal;

		struct Input {
			float2 uv_MainTex;
			float2 uv_Normal;
		};

		fixed4 _EmissionColor;
		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
        float _Amplitude, _Wavelength, _Speed, _Emission;

		void vert(inout appdata_full vertexData) {
			float3 p = vertexData.vertex.xyz;

            float k = 2 * UNITY_PI / _Wavelength;
			float f = k * (p.x - _Speed * _Time.y);
			p.y = _Amplitude * sin(f);

			float3 tangent = normalize(float3(1, k * _Amplitude * cos(f), 0));
			float3 normal = float3(-tangent.y, tangent.x, 0);

			vertexData.vertex.xyz = p;
			vertexData.normal = normal;

        }

		void surf (Input IN, inout SurfaceOutputStandard o) {
    		fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
    		o.Albedo = c.rgb;
    		o.Normal = UnpackNormal (tex2D(_Normal, IN.uv_Normal));
   			o.Alpha = c.a;
	    	o.Metallic = _Metallic;

    		o.Emission = _Emission * c.rgb * _EmissionColor.rgb;

    		o.Smoothness = _Glossiness;
		}

		ENDCG
	}
	FallBack "Diffuse"
}