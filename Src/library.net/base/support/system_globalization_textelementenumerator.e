indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Globalization.TextElementEnumerator"

external class
	SYSTEM_GLOBALIZATION_TEXTELEMENTENUMERATOR

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_IENUMERATOR

create {NONE}

feature -- Access

	frozen get_element_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.TextElementEnumerator"
		alias
			"get_ElementIndex"
		end

	frozen get_current: ANY is
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

	frozen get_text_element: STRING is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Globalization.TextElementEnumerator"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_GLOBALIZATION_TEXTELEMENTENUMERATOR
