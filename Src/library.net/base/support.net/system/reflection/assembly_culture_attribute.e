indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyCultureAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_CULTURE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_assembly_culture_attribute

feature {NONE} -- Initialization

	frozen make_assembly_culture_attribute (culture: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyCultureAttribute"
		end

feature -- Access

	frozen get_culture: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyCultureAttribute"
		alias
			"get_Culture"
		end

end -- class ASSEMBLY_CULTURE_ATTRIBUTE
