indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.CaseInsensitiveComparer"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CASE_INSENSITIVE_COMPARER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICOMPARER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Collections.CaseInsensitiveComparer"
		end

	frozen make_1 (culture: CULTURE_INFO) is
		external
			"IL creator signature (System.Globalization.CultureInfo) use System.Collections.CaseInsensitiveComparer"
		end

feature -- Access

	frozen get_default: CASE_INSENSITIVE_COMPARER is
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

	frozen compare (a: SYSTEM_OBJECT; b: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object, System.Object): System.Int32 use System.Collections.CaseInsensitiveComparer"
		alias
			"Compare"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.CaseInsensitiveComparer"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.CaseInsensitiveComparer"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.CaseInsensitiveComparer"
		alias
			"Finalize"
		end

end -- class CASE_INSENSITIVE_COMPARER
