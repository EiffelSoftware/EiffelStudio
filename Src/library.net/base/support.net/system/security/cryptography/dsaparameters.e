indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.DSAParameters"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DSAPARAMETERS

inherit
	VALUE_TYPE

feature -- Access

	frozen y: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL field signature :System.Byte[] use System.Security.Cryptography.DSAParameters"
		alias
			"Y"
		end

	frozen g: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL field signature :System.Byte[] use System.Security.Cryptography.DSAParameters"
		alias
			"G"
		end

	frozen p: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL field signature :System.Byte[] use System.Security.Cryptography.DSAParameters"
		alias
			"P"
		end

	frozen q: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL field signature :System.Byte[] use System.Security.Cryptography.DSAParameters"
		alias
			"Q"
		end

	frozen seed: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL field signature :System.Byte[] use System.Security.Cryptography.DSAParameters"
		alias
			"Seed"
		end

	frozen counter: INTEGER is
		external
			"IL field signature :System.Int32 use System.Security.Cryptography.DSAParameters"
		alias
			"Counter"
		end

	frozen j: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL field signature :System.Byte[] use System.Security.Cryptography.DSAParameters"
		alias
			"J"
		end

	frozen x: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL field signature :System.Byte[] use System.Security.Cryptography.DSAParameters"
		alias
			"X"
		end

end -- class DSAPARAMETERS
