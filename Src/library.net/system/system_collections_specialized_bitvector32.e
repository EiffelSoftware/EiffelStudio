indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.Specialized.BitVector32"

frozen expanded external class
	SYSTEM_COLLECTIONS_SPECIALIZED_BITVECTOR32

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals_object,
			to_string
		end



feature -- Initialization

	frozen make_bitvector32 (data: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Collections.Specialized.BitVector32"
		end

	frozen make_bitvector32_1 (value: SYSTEM_COLLECTIONS_SPECIALIZED_BITVECTOR32) is
		external
			"IL creator signature (System.Collections.Specialized.BitVector32) use System.Collections.Specialized.BitVector32"
		end

feature -- Access

	frozen get_item (section: SECTION_IN_SYSTEM_COLLECTIONS_SPECIALIZED_BITVECTOR32): INTEGER is
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

	frozen set_item (section: SECTION_IN_SYSTEM_COLLECTIONS_SPECIALIZED_BITVECTOR32; value: INTEGER) is
		external
			"IL signature (System.Collections.Specialized.BitVector32+Section, System.Int32): System.Void use System.Collections.Specialized.BitVector32"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
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

	frozen create_mask_int32 (previous: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32): System.Int32 use System.Collections.Specialized.BitVector32"
		alias
			"CreateMask"
		end

	frozen create_section (max_value: INTEGER_16): SECTION_IN_SYSTEM_COLLECTIONS_SPECIALIZED_BITVECTOR32 is
		external
			"IL static signature (System.Int16): System.Collections.Specialized.BitVector32+Section use System.Collections.Specialized.BitVector32"
		alias
			"CreateSection"
		end

	equals_object (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.BitVector32"
		alias
			"Equals"
		end

	frozen create_section_int16_section (max_value: INTEGER_16; previous: SECTION_IN_SYSTEM_COLLECTIONS_SPECIALIZED_BITVECTOR32): SECTION_IN_SYSTEM_COLLECTIONS_SPECIALIZED_BITVECTOR32 is
		external
			"IL static signature (System.Int16, System.Collections.Specialized.BitVector32+Section): System.Collections.Specialized.BitVector32+Section use System.Collections.Specialized.BitVector32"
		alias
			"CreateSection"
		end

	frozen to_string_bit_vector32 (value: SYSTEM_COLLECTIONS_SPECIALIZED_BITVECTOR32): STRING is
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

end -- class SYSTEM_COLLECTIONS_SPECIALIZED_BITVECTOR32
