indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Collections.IEnumerator"

deferred external class
	SYSTEM_COLLECTIONS_IENUMERATOR

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_current: ANY is
		external
			"IL deferred signature (): System.Object use System.Collections.IEnumerator"
		alias
			"get_Current"
		end

feature -- Basic Operations

	reset is
		external
			"IL deferred signature (): System.Void use System.Collections.IEnumerator"
		alias
			"Reset"
		end

	move_next: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Collections.IEnumerator"
		alias
			"MoveNext"
		end

end -- class SYSTEM_COLLECTIONS_IENUMERATOR
