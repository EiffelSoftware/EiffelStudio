indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyDefaultAliasAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_DEFAULT_ALIAS_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_assembly_default_alias_attribute

feature {NONE} -- Initialization

	frozen make_assembly_default_alias_attribute (default_alias: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyDefaultAliasAttribute"
		end

feature -- Access

	frozen get_default_alias: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyDefaultAliasAttribute"
		alias
			"get_DefaultAlias"
		end

end -- class ASSEMBLY_DEFAULT_ALIAS_ATTRIBUTE
