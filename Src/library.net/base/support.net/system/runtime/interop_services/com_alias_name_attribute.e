indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ComAliasNameAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	COM_ALIAS_NAME_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_com_alias_name_attribute

feature {NONE} -- Initialization

	frozen make_com_alias_name_attribute (alias_: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.ComAliasNameAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.ComAliasNameAttribute"
		alias
			"get_Value"
		end

end -- class COM_ALIAS_NAME_ATTRIBUTE
