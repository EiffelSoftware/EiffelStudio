indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.BitConverter"

frozen external class
	SYSTEM_BITCONVERTER

create {NONE}

feature -- Access

	frozen is_little_endian: BOOLEAN is
		external
			"IL static_field signature :System.Boolean use System.BitConverter"
		alias
			"IsLittleEndian"
		end

feature -- Basic Operations

	frozen get_bytes_single (value: REAL): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Single): System.Byte[] use System.BitConverter"
		alias
			"GetBytes"
		end

	frozen to_double (value: ARRAY [INTEGER_8]; start_index: INTEGER): DOUBLE is
		external
			"IL static signature (System.Byte[], System.Int32): System.Double use System.BitConverter"
		alias
			"ToDouble"
		end

	frozen get_bytes_double (value: DOUBLE): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Double): System.Byte[] use System.BitConverter"
		alias
			"GetBytes"
		end

	frozen to_boolean (value: ARRAY [INTEGER_8]; start_index: INTEGER): BOOLEAN is
		external
			"IL static signature (System.Byte[], System.Int32): System.Boolean use System.BitConverter"
		alias
			"ToBoolean"
		end

	frozen to_int16 (value: ARRAY [INTEGER_8]; start_index: INTEGER): INTEGER_16 is
		external
			"IL static signature (System.Byte[], System.Int32): System.Int16 use System.BitConverter"
		alias
			"ToInt16"
		end

	frozen to_int64 (value: ARRAY [INTEGER_8]; start_index: INTEGER): INTEGER_64 is
		external
			"IL static signature (System.Byte[], System.Int32): System.Int64 use System.BitConverter"
		alias
			"ToInt64"
		end

	frozen to_string_array_byte_int32 (value: ARRAY [INTEGER_8]; start_index: INTEGER): STRING is
		external
			"IL static signature (System.Byte[], System.Int32): System.String use System.BitConverter"
		alias
			"ToString"
		end

	frozen to_string_array_byte (value: ARRAY [INTEGER_8]): STRING is
		external
			"IL static signature (System.Byte[]): System.String use System.BitConverter"
		alias
			"ToString"
		end

	frozen get_bytes_int32 (value: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Int32): System.Byte[] use System.BitConverter"
		alias
			"GetBytes"
		end

	frozen to_single (value: ARRAY [INTEGER_8]; start_index: INTEGER): REAL is
		external
			"IL static signature (System.Byte[], System.Int32): System.Single use System.BitConverter"
		alias
			"ToSingle"
		end

	frozen get_bytes_int16 (value: INTEGER_16): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Int16): System.Byte[] use System.BitConverter"
		alias
			"GetBytes"
		end

	frozen to_int32 (value: ARRAY [INTEGER_8]; start_index: INTEGER): INTEGER is
		external
			"IL static signature (System.Byte[], System.Int32): System.Int32 use System.BitConverter"
		alias
			"ToInt32"
		end

	frozen int64_bits_to_double (value: INTEGER_64): DOUBLE is
		external
			"IL static signature (System.Int64): System.Double use System.BitConverter"
		alias
			"Int64BitsToDouble"
		end

	frozen get_bytes_boolean (value: BOOLEAN): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Boolean): System.Byte[] use System.BitConverter"
		alias
			"GetBytes"
		end

	frozen get_bytes (value: INTEGER_64): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Int64): System.Byte[] use System.BitConverter"
		alias
			"GetBytes"
		end

	frozen to_string_array_byte_int32_int32 (value: ARRAY [INTEGER_8]; start_index: INTEGER; length: INTEGER): STRING is
		external
			"IL static signature (System.Byte[], System.Int32, System.Int32): System.String use System.BitConverter"
		alias
			"ToString"
		end

	frozen double_to_int64_bits (value: DOUBLE): INTEGER_64 is
		external
			"IL static signature (System.Double): System.Int64 use System.BitConverter"
		alias
			"DoubleToInt64Bits"
		end

	frozen to_char (value: ARRAY [INTEGER_8]; start_index: INTEGER): CHARACTER is
		external
			"IL static signature (System.Byte[], System.Int32): System.Char use System.BitConverter"
		alias
			"ToChar"
		end

	frozen get_bytes_char (value: CHARACTER): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Char): System.Byte[] use System.BitConverter"
		alias
			"GetBytes"
		end

end -- class SYSTEM_BITCONVERTER
