indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.AssemblyCopyrightAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYCOPYRIGHTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assembly_copyright_attribute

feature {NONE} -- Initialization

	frozen make_assembly_copyright_attribute (copyright2: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyCopyrightAttribute"
		end

feature -- Access

	frozen get_copyright: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyCopyrightAttribute"
		alias
			"get_Copyright"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYCOPYRIGHTATTRIBUTE
