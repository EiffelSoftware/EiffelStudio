indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.Specialized.BitVector32+Section"

frozen expanded external class
	SECTION_IN_SYSTEM_COLLECTIONS_SPECIALIZED_BITVECTOR32

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals_object,
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

	equals_object (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.BitVector32+Section"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.Specialized.BitVector32+Section"
		alias
			"ToString"
		end

	frozen to_string_section (value: SECTION_IN_SYSTEM_COLLECTIONS_SPECIALIZED_BITVECTOR32): STRING is
		external
			"IL static signature (System.Collections.Specialized.BitVector32+Section): System.String use System.Collections.Specialized.BitVector32+Section"
		alias
			"ToString"
		end

end -- class SECTION_IN_SYSTEM_COLLECTIONS_SPECIALIZED_BITVECTOR32
