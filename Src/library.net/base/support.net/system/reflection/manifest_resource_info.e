indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.ManifestResourceInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	MANIFEST_RESOURCE_INFO

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	get_referenced_assembly: ASSEMBLY is
		external
			"IL signature (): System.Reflection.Assembly use System.Reflection.ManifestResourceInfo"
		alias
			"get_ReferencedAssembly"
		end

	get_resource_location: RESOURCE_LOCATION is
		external
			"IL signature (): System.Reflection.ResourceLocation use System.Reflection.ManifestResourceInfo"
		alias
			"get_ResourceLocation"
		end

	get_file_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.ManifestResourceInfo"
		alias
			"get_FileName"
		end

end -- class MANIFEST_RESOURCE_INFO
