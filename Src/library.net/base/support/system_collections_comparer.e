indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Collections.Comparer"

frozen external class
	SYSTEM_COLLECTIONS_COMPARER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOMPARER

create {NONE}

feature -- Access

	frozen Default: SYSTEM_COLLECTIONS_COMPARER is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.Comparer"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Comparer"
		alias
			"Equals"
		end

	frozen compare (a: ANY; b: ANY): INTEGER is
		external
			"IL signature (System.Object, System.Object): System.Int32 use System.Collections.Comparer"
		alias
			"Compare"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.Comparer"
		alias
			"Finalize"
		end

end -- class SYSTEM_COLLECTIONS_COMPARER
