indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.AssemblyCultureAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYCULTUREATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assembly_culture_attribute

feature {NONE} -- Initialization

	frozen make_assembly_culture_attribute (culture2: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyCultureAttribute"
		end

feature -- Access

	frozen get_culture: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyCultureAttribute"
		alias
			"get_Culture"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYCULTUREATTRIBUTE
