indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyFileVersionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_FILE_VERSION_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_assembly_file_version_attribute

feature {NONE} -- Initialization

	frozen make_assembly_file_version_attribute (version: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyFileVersionAttribute"
		end

feature -- Access

	frozen get_version: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyFileVersionAttribute"
		alias
			"get_Version"
		end

end -- class ASSEMBLY_FILE_VERSION_ATTRIBUTE
