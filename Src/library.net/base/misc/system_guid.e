indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Guid"

frozen expanded external class
	SYSTEM_GUID

inherit
	SYSTEM_VALUETYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_IFORMATTABLE
	SYSTEM_ICOMPARABLE



feature {NONE} -- Initialization

	frozen make_guid (b: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Guid"
		end

	frozen make_guid_3 (a: INTEGER; b: INTEGER_16; c: INTEGER_16; d: INTEGER_8; e: INTEGER_8; f: INTEGER_8; g: INTEGER_8; h: INTEGER_8; i: INTEGER_8; j: INTEGER_8; k: INTEGER_8) is
		external
			"IL creator signature (System.Int32, System.Int16, System.Int16, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte) use System.Guid"
		end

	frozen make_guid_2 (a: INTEGER; b: INTEGER_16; c: INTEGER_16; d: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Int32, System.Int16, System.Int16, System.Byte[]) use System.Guid"
		end

	frozen make_guid_1 (g: STRING) is
		external
			"IL creator signature (System.String) use System.Guid"
		end

feature -- Access

	frozen empty: SYSTEM_GUID is
		external
			"IL static_field signature :System.Guid use System.Guid"
		alias
			"Empty"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Guid"
		alias
			"ToString"
		end

	frozen to_byte_array: ARRAY [INTEGER_8] is
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

	frozen to_string_with_format (format: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Guid"
		alias
			"ToString"
		end

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Guid"
		alias
			"Equals"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Guid"
		alias
			"CompareTo"
		end

	frozen new_guid: SYSTEM_GUID is
		external
			"IL static signature (): System.Guid use System.Guid"
		alias
			"NewGuid"
		end

	frozen to_string_with_format_and_provider (format: STRING; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Guid"
		alias
			"ToString"
		end

feature -- Binary Operators

	frozen infix "#==" (b: SYSTEM_GUID): BOOLEAN is
		external
			"IL operator signature (System.Guid): System.Boolean use System.Guid"
		alias
			"op_Equality"
		end

	frozen infix "|=" (b: SYSTEM_GUID): BOOLEAN is
		external
			"IL operator signature (System.Guid): System.Boolean use System.Guid"
		alias
			"op_Inequality"
		end

end -- class SYSTEM_GUID
