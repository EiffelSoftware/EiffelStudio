indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyCopyrightAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_COPYRIGHT_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_assembly_copyright_attribute

feature {NONE} -- Initialization

	frozen make_assembly_copyright_attribute (copyright: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyCopyrightAttribute"
		end

feature -- Access

	frozen get_copyright: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyCopyrightAttribute"
		alias
			"get_Copyright"
		end

end -- class ASSEMBLY_COPYRIGHT_ATTRIBUTE
