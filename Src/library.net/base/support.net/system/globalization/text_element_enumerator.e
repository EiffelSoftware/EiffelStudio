indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.TextElementEnumerator"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	TEXT_ELEMENT_ENUMERATOR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IENUMERATOR

create {NONE}

feature -- Access

	frozen get_element_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.TextElementEnumerator"
		alias
			"get_ElementIndex"
		end

	frozen get_current: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Globalization.TextElementEnumerator"
		alias
			"get_Current"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.TextElementEnumerator"
		alias
			"GetHashCode"
		end

	frozen get_text_element: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.TextElementEnumerator"
		alias
			"GetTextElement"
		end

	frozen reset is
		external
			"IL signature (): System.Void use System.Globalization.TextElementEnumerator"
		alias
			"Reset"
		end

	frozen move_next: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Globalization.TextElementEnumerator"
		alias
			"MoveNext"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.TextElementEnumerator"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Globalization.TextElementEnumerator"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Globalization.TextElementEnumerator"
		alias
			"Finalize"
		end

end -- class TEXT_ELEMENT_ENUMERATOR
