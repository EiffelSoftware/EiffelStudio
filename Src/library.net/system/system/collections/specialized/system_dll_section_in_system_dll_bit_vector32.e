indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.Specialized.BitVector32+Section"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	SYSTEM_DLL_SECTION_IN_SYSTEM_DLL_BIT_VECTOR32

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	frozen get_mask: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Collections.Specialized.BitVector32+Section"
		alias
			"get_Mask"
		end

	frozen get_offset: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Collections.Specialized.BitVector32+Section"
		alias
			"get_Offset"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.BitVector32+Section"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.Specialized.BitVector32+Section"
		alias
			"ToString"
		end

	frozen to_string_section (value: SYSTEM_DLL_SECTION_IN_SYSTEM_DLL_BIT_VECTOR32): SYSTEM_STRING is
		external
			"IL static signature (System.Collections.Specialized.BitVector32+Section): System.String use System.Collections.Specialized.BitVector32+Section"
		alias
			"ToString"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.BitVector32+Section"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_SECTION_IN_SYSTEM_DLL_BIT_VECTOR32
