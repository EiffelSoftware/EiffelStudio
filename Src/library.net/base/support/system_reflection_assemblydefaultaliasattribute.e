indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyDefaultAliasAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYDEFAULTALIASATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assemblydefaultaliasattribute

feature {NONE} -- Initialization

	frozen make_assemblydefaultaliasattribute (default_alias: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyDefaultAliasAttribute"
		end

feature -- Access

	frozen get_default_alias: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyDefaultAliasAttribute"
		alias
			"get_DefaultAlias"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYDEFAULTALIASATTRIBUTE
