indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.CryptoStreamMode"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	CRYPTO_STREAM_MODE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen read: CRYPTO_STREAM_MODE is
		external
			"IL enum signature :System.Security.Cryptography.CryptoStreamMode use System.Security.Cryptography.CryptoStreamMode"
		alias
			"0"
		end

	frozen write: CRYPTO_STREAM_MODE is
		external
			"IL enum signature :System.Security.Cryptography.CryptoStreamMode use System.Security.Cryptography.CryptoStreamMode"
		alias
			"1"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

	from_integer (a_value: INTEGER): like Current is
		do
			--Built-in
		end

	to_integer: INTEGER is
		do
			--Built-in
		end

end -- class CRYPTO_STREAM_MODE
