indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.CaseInsensitiveHashCodeProvider"

external class
	SYSTEM_COLLECTIONS_CASEINSENSITIVEHASHCODEPROVIDER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_IHASHCODEPROVIDER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Collections.CaseInsensitiveHashCodeProvider"
		end

	frozen make_1 (culture: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL creator signature (System.Globalization.CultureInfo) use System.Collections.CaseInsensitiveHashCodeProvider"
		end

feature -- Access

	frozen get_default: SYSTEM_COLLECTIONS_CASEINSENSITIVEHASHCODEPROVIDER is
		external
			"IL static signature (): System.Collections.CaseInsensitiveHashCodeProvider use System.Collections.CaseInsensitiveHashCodeProvider"
		alias
			"get_Default"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.CaseInsensitiveHashCodeProvider"
		alias
			"GetHashCode"
		end

	frozen get_hash_code_object (obj: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.CaseInsensitiveHashCodeProvider"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.CaseInsensitiveHashCodeProvider"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.CaseInsensitiveHashCodeProvider"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.CaseInsensitiveHashCodeProvider"
		alias
			"Finalize"
		end

end -- class SYSTEM_COLLECTIONS_CASEINSENSITIVEHASHCODEPROVIDER
