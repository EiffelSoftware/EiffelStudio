indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyTrademarkAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYTRADEMARKATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assemblytrademarkattribute

feature {NONE} -- Initialization

	frozen make_assemblytrademarkattribute (trademark: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyTrademarkAttribute"
		end

feature -- Access

	frozen get_trademark: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyTrademarkAttribute"
		alias
			"get_Trademark"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYTRADEMARKATTRIBUTE
