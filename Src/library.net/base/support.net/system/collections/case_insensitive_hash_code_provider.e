indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.CaseInsensitiveHashCodeProvider"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CASE_INSENSITIVE_HASH_CODE_PROVIDER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IHASH_CODE_PROVIDER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Collections.CaseInsensitiveHashCodeProvider"
		end

	frozen make_1 (culture: CULTURE_INFO) is
		external
			"IL creator signature (System.Globalization.CultureInfo) use System.Collections.CaseInsensitiveHashCodeProvider"
		end

feature -- Access

	frozen get_default: CASE_INSENSITIVE_HASH_CODE_PROVIDER is
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

	frozen get_hash_code_object (obj: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.CaseInsensitiveHashCodeProvider"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.CaseInsensitiveHashCodeProvider"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

end -- class CASE_INSENSITIVE_HASH_CODE_PROVIDER
