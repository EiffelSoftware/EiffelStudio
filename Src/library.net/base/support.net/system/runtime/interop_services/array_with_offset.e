indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ArrayWithOffset"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	ARRAY_WITH_OFFSET

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals
		end

feature -- Initialization

	frozen make_array_with_offset (array: SYSTEM_OBJECT; offset: INTEGER) is
		external
			"IL creator signature (System.Object, System.Int32) use System.Runtime.InteropServices.ArrayWithOffset"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.ArrayWithOffset"
		alias
			"GetHashCode"
		end

	frozen get_offset: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.ArrayWithOffset"
		alias
			"GetOffset"
		end

	frozen get_array: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.InteropServices.ArrayWithOffset"
		alias
			"GetArray"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.InteropServices.ArrayWithOffset"
		alias
			"Equals"
		end

end -- class ARRAY_WITH_OFFSET
