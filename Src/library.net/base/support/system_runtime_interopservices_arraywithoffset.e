indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.ArrayWithOffset"

frozen expanded external class
	SYSTEM_RUNTIME_INTEROPSERVICES_ARRAYWITHOFFSET

inherit
	SYSTEM_VALUETYPE
		redefine
			get_hash_code,
			is_equal
		end



feature {NONE} -- Initialization

	frozen make_array_with_offset (array: ANY; offset: INTEGER) is
		external
			"IL creator signature (System.Object, System.Int32) use System.Runtime.InteropServices.ArrayWithOffset"
		end

feature -- Basic Operations

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.InteropServices.ArrayWithOffset"
		alias
			"Equals"
		end

	frozen get_offset: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.ArrayWithOffset"
		alias
			"GetOffset"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.ArrayWithOffset"
		alias
			"GetHashCode"
		end

	frozen get_array: ANY is
		external
			"IL signature (): System.Object use System.Runtime.InteropServices.ArrayWithOffset"
		alias
			"GetArray"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_ARRAYWITHOFFSET
