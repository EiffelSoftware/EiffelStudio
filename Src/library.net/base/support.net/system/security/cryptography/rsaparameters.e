indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.RSAParameters"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	RSAPARAMETERS

inherit
	VALUE_TYPE

feature -- Access

	frozen exponent: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL field signature :System.Byte[] use System.Security.Cryptography.RSAParameters"
		alias
			"Exponent"
		end

	frozen d: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL field signature :System.Byte[] use System.Security.Cryptography.RSAParameters"
		alias
			"D"
		end

	frozen p: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL field signature :System.Byte[] use System.Security.Cryptography.RSAParameters"
		alias
			"P"
		end

	frozen q: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL field signature :System.Byte[] use System.Security.Cryptography.RSAParameters"
		alias
			"Q"
		end

	frozen inverse_q: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL field signature :System.Byte[] use System.Security.Cryptography.RSAParameters"
		alias
			"InverseQ"
		end

	frozen dq: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL field signature :System.Byte[] use System.Security.Cryptography.RSAParameters"
		alias
			"DQ"
		end

	frozen dp: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL field signature :System.Byte[] use System.Security.Cryptography.RSAParameters"
		alias
			"DP"
		end

	frozen modulus: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL field signature :System.Byte[] use System.Security.Cryptography.RSAParameters"
		alias
			"Modulus"
		end

end -- class RSAPARAMETERS
