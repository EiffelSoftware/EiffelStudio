indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.Specialized.BitVector32"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	SYSTEM_DLL_BIT_VECTOR32

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end

feature -- Initialization

	frozen make_system_dll_bit_vector32 (data: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Collections.Specialized.BitVector32"
		end

	frozen make_system_dll_bit_vector32_1 (value: SYSTEM_DLL_BIT_VECTOR32) is
		external
			"IL creator signature (System.Collections.Specialized.BitVector32) use System.Collections.Specialized.BitVector32"
		end

feature -- Access

	frozen get_item (section: SYSTEM_DLL_SECTION_IN_SYSTEM_DLL_BIT_VECTOR32): INTEGER is
		external
			"IL signature (System.Collections.Specialized.BitVector32+Section): System.Int32 use System.Collections.Specialized.BitVector32"
		alias
			"get_Item"
		end

	frozen get_data: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.BitVector32"
		alias
			"get_Data"
		end

	frozen get_item_int32 (bit_: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Collections.Specialized.BitVector32"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item_int32 (bit_: INTEGER; value: BOOLEAN) is
		external
			"IL signature (System.Int32, System.Boolean): System.Void use System.Collections.Specialized.BitVector32"
		alias
			"set_Item"
		end

	frozen set_item (section: SYSTEM_DLL_SECTION_IN_SYSTEM_DLL_BIT_VECTOR32; value: INTEGER) is
		external
			"IL signature (System.Collections.Specialized.BitVector32+Section, System.Int32): System.Void use System.Collections.Specialized.BitVector32"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.Specialized.BitVector32"
		alias
			"ToString"
		end

	frozen create_mask: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Collections.Specialized.BitVector32"
		alias
			"CreateMask"
		end

	frozen create_section_int16_section (max_value: INTEGER_16; previous: SYSTEM_DLL_SECTION_IN_SYSTEM_DLL_BIT_VECTOR32): SYSTEM_DLL_SECTION_IN_SYSTEM_DLL_BIT_VECTOR32 is
		external
			"IL static signature (System.Int16, System.Collections.Specialized.BitVector32+Section): System.Collections.Specialized.BitVector32+Section use System.Collections.Specialized.BitVector32"
		alias
			"CreateSection"
		end

	frozen create_mask_int32 (previous: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32): System.Int32 use System.Collections.Specialized.BitVector32"
		alias
			"CreateMask"
		end

	frozen create_section (max_value: INTEGER_16): SYSTEM_DLL_SECTION_IN_SYSTEM_DLL_BIT_VECTOR32 is
		external
			"IL static signature (System.Int16): System.Collections.Specialized.BitVector32+Section use System.Collections.Specialized.BitVector32"
		alias
			"CreateSection"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.BitVector32"
		alias
			"Equals"
		end

	frozen to_string_bit_vector32 (value: SYSTEM_DLL_BIT_VECTOR32): SYSTEM_STRING is
		external
			"IL static signature (System.Collections.Specialized.BitVector32): System.String use System.Collections.Specialized.BitVector32"
		alias
			"ToString"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.BitVector32"
		alias
			"GetHashCode"
		end

end -- class SYSTEM_DLL_BIT_VECTOR32
