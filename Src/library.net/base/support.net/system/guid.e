indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Guid"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	GUID

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end
	IFORMATTABLE
	ICOMPARABLE

feature -- Initialization

	frozen make_guid (b: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Guid"
		end

	frozen make_guid_3 (a: INTEGER; b: INTEGER_16; c: INTEGER_16; d: INTEGER_8; e: INTEGER_8; f: INTEGER_8; g: INTEGER_8; h: INTEGER_8; i: INTEGER_8; j: INTEGER_8; k: INTEGER_8) is
		external
			"IL creator signature (System.Int32, System.Int16, System.Int16, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte) use System.Guid"
		end

	frozen make_guid_2 (a: INTEGER; b: INTEGER_16; c: INTEGER_16; d: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Int32, System.Int16, System.Int16, System.Byte[]) use System.Guid"
		end

	frozen make_guid_1 (g: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Guid"
		end

feature -- Access

	frozen empty: GUID is
		external
			"IL static_field signature :System.Guid use System.Guid"
		alias
			"Empty"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Guid"
		alias
			"ToString"
		end

	frozen to_byte_array: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Guid"
		alias
			"ToByteArray"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Guid"
		alias
			"GetHashCode"
		end

	frozen to_string_string2 (format: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Guid"
		alias
			"ToString"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Guid"
		alias
			"Equals"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Guid"
		alias
			"CompareTo"
		end

	frozen new_guid: GUID is
		external
			"IL static signature (): System.Guid use System.Guid"
		alias
			"NewGuid"
		end

	frozen to_string_string (format: SYSTEM_STRING; provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Guid"
		alias
			"ToString"
		end

feature -- Binary Operators

	frozen infix "#==" (b: GUID): BOOLEAN is
		external
			"IL operator signature (System.Guid): System.Boolean use System.Guid"
		alias
			"op_Equality"
		end

	frozen infix "|=" (b: GUID): BOOLEAN is
		external
			"IL operator signature (System.Guid): System.Boolean use System.Guid"
		alias
			"op_Inequality"
		end

end -- class GUID
