indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Globalization.SortKey"

external class
	SYSTEM_GLOBALIZATION_SORTKEY

inherit
	ANY
		redefine
			get_hash_code,
			is_equal,
			to_string
		end

create {NONE}

feature -- Access

	get_key_data: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Globalization.SortKey"
		alias
			"get_KeyData"
		end

	get_original_string: STRING is
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

	is_equal (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Globalization.SortKey"
		alias
			"Equals"
		end

	frozen compare (sortkey1: SYSTEM_GLOBALIZATION_SORTKEY; sortkey2: SYSTEM_GLOBALIZATION_SORTKEY): INTEGER is
		external
			"IL static signature (System.Globalization.SortKey, System.Globalization.SortKey): System.Int32 use System.Globalization.SortKey"
		alias
			"Compare"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Globalization.SortKey"
		alias
			"ToString"
		end

end -- class SYSTEM_GLOBALIZATION_SORTKEY
