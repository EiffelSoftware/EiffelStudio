indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyTrademarkAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_TRADEMARK_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_assembly_trademark_attribute

feature {NONE} -- Initialization

	frozen make_assembly_trademark_attribute (trademark: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyTrademarkAttribute"
		end

feature -- Access

	frozen get_trademark: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyTrademarkAttribute"
		alias
			"get_Trademark"
		end

end -- class ASSEMBLY_TRADEMARK_ATTRIBUTE
