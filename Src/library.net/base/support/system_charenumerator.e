indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CharEnumerator"

frozen external class
	SYSTEM_CHARENUMERATOR

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_IENUMERATOR
		rename
			get_current as ienumerator_get_current
		end
	SYSTEM_ICLONEABLE

create {NONE}

feature -- Access

	frozen get_current: CHARACTER is
		external
			"IL signature (): System.Char use System.CharEnumerator"
		alias
			"get_Current"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.CharEnumerator"
		alias
			"GetHashCode"
		end

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.CharEnumerator"
		alias
			"Clone"
		end

	frozen reset is
		external
			"IL signature (): System.Void use System.CharEnumerator"
		alias
			"Reset"
		end

	frozen move_next: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CharEnumerator"
		alias
			"MoveNext"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.CharEnumerator"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.CharEnumerator"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.CharEnumerator"
		alias
			"Finalize"
		end

	frozen ienumerator_get_current: ANY is
		external
			"IL signature (): System.Object use System.CharEnumerator"
		alias
			"System.Collections.IEnumerator.get_Current"
		end

end -- class SYSTEM_CHARENUMERATOR
