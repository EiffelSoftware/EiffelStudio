indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.SortKey"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SORT_KEY

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create {NONE}

feature -- Access

	get_key_data: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Globalization.SortKey"
		alias
			"get_KeyData"
		end

	get_original_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.SortKey"
		alias
			"get_OriginalString"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.SortKey"
		alias
			"GetHashCode"
		end

	frozen compare (sortkey1: SORT_KEY; sortkey2: SORT_KEY): INTEGER is
		external
			"IL static signature (System.Globalization.SortKey, System.Globalization.SortKey): System.Int32 use System.Globalization.SortKey"
		alias
			"Compare"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.SortKey"
		alias
			"ToString"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Globalization.SortKey"
		alias
			"Equals"
		end

end -- class SORT_KEY
