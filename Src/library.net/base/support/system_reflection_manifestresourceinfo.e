indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.ManifestResourceInfo"

external class
	SYSTEM_REFLECTION_MANIFESTRESOURCEINFO

create {NONE}

feature -- Access

	get_referenced_assembly: SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (): System.Reflection.Assembly use System.Reflection.ManifestResourceInfo"
		alias
			"get_ReferencedAssembly"
		end

	get_resource_location: SYSTEM_REFLECTION_RESOURCELOCATION is
		external
			"IL signature (): System.Reflection.ResourceLocation use System.Reflection.ManifestResourceInfo"
		alias
			"get_ResourceLocation"
		end

	get_file_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.ManifestResourceInfo"
		alias
			"get_FileName"
		end

end -- class SYSTEM_REFLECTION_MANIFESTRESOURCEINFO
