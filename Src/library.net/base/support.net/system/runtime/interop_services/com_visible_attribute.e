indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ComVisibleAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	COM_VISIBLE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_com_visible_attribute

feature {NONE} -- Initialization

	frozen make_com_visible_attribute (visibility: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Runtime.InteropServices.ComVisibleAttribute"
		end

feature -- Access

	frozen get_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.InteropServices.ComVisibleAttribute"
		alias
			"get_Value"
		end

end -- class COM_VISIBLE_ATTRIBUTE
