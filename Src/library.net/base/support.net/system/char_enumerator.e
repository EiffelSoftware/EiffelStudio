indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CharEnumerator"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	CHAR_ENUMERATOR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IENUMERATOR
		rename
			get_current as system_collections_ienumerator_get_current
		end
	ICLONEABLE

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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CharEnumerator"
		alias
			"ToString"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.CharEnumerator"
		alias
			"Clone"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

	frozen system_collections_ienumerator_get_current: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.CharEnumerator"
		alias
			"System.Collections.IEnumerator.get_Current"
		end

end -- class CHAR_ENUMERATOR
