indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.IEnumerator"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IENUMERATOR

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_current: SYSTEM_OBJECT is
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

end -- class IENUMERATOR
