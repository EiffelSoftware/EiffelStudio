indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.Specialized.StringEnumerator"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_STRING_ENUMERATOR

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_current: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.Specialized.StringEnumerator"
		alias
			"get_Current"
		end

feature -- Basic Operations

	frozen reset is
		external
			"IL signature (): System.Void use System.Collections.Specialized.StringEnumerator"
		alias
			"Reset"
		end

	frozen move_next: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.StringEnumerator"
		alias
			"MoveNext"
		end

end -- class SYSTEM_DLL_STRING_ENUMERATOR
