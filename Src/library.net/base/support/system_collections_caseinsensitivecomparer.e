indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Collections.CaseInsensitiveComparer"

external class
	SYSTEM_COLLECTIONS_CASEINSENSITIVECOMPARER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOMPARER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Collections.CaseInsensitiveComparer"
		end

	frozen make_1 (culture: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL creator signature (System.Globalization.CultureInfo) use System.Collections.CaseInsensitiveComparer"
		end

feature -- Access

	frozen get_default: SYSTEM_COLLECTIONS_CASEINSENSITIVECOMPARER is
		external
			"IL static signature (): System.Collections.CaseInsensitiveComparer use System.Collections.CaseInsensitiveComparer"
		alias
			"get_Default"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.CaseInsensitiveComparer"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.CaseInsensitiveComparer"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.CaseInsensitiveComparer"
		alias
			"Equals"
		end

	frozen compare (a: ANY; b: ANY): INTEGER is
		external
			"IL signature (System.Object, System.Object): System.Int32 use System.Collections.CaseInsensitiveComparer"
		alias
			"Compare"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.CaseInsensitiveComparer"
		alias
			"Finalize"
		end

end -- class SYSTEM_COLLECTIONS_CASEINSENSITIVECOMPARER
