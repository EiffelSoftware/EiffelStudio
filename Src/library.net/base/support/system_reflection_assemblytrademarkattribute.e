indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.AssemblyTrademarkAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYTRADEMARKATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assembly_trademark_attribute

feature {NONE} -- Initialization

	frozen make_assembly_trademark_attribute (trademark2: STRING) is
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
