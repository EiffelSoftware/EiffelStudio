indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.Comparer"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	COMPARER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICOMPARER

create {NONE}

feature -- Access

	frozen default_: COMPARER is
		external
			"IL static_field signature :System.Collections.Comparer use System.Collections.Comparer"
		alias
			"Default"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Comparer"
		alias
			"GetHashCode"
		end

	frozen compare (a: SYSTEM_OBJECT; b: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object, System.Object): System.Int32 use System.Collections.Comparer"
		alias
			"Compare"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.Comparer"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Comparer"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.Comparer"
		alias
			"Finalize"
		end

end -- class COMPARER
