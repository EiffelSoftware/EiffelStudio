indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyCopyrightAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYCOPYRIGHTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assemblycopyrightattribute

feature {NONE} -- Initialization

	frozen make_assemblycopyrightattribute (copyright: STRING) is
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
