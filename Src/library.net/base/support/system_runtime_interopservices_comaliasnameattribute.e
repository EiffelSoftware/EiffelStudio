indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.ComAliasNameAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_COMALIASNAMEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_com_alias_name_attribute

feature {NONE} -- Initialization

	frozen make_com_alias_name_attribute (alias_: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.ComAliasNameAttribute"
		end

feature -- Access

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.ComAliasNameAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_COMALIASNAMEATTRIBUTE
