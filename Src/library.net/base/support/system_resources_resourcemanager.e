indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Resources.ResourceManager"

external class
	SYSTEM_RESOURCES_RESOURCEMANAGER

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (resource_source: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Resources.ResourceManager"
		end

	frozen make (base_name: STRING; assembly: SYSTEM_REFLECTION_ASSEMBLY) is
		external
			"IL creator signature (System.String, System.Reflection.Assembly) use System.Resources.ResourceManager"
		end

	frozen make_1 (base_name: STRING; assembly: SYSTEM_REFLECTION_ASSEMBLY; using_resource_set: SYSTEM_TYPE) is
		external
			"IL creator signature (System.String, System.Reflection.Assembly, System.Type) use System.Resources.ResourceManager"
		end

feature -- Access

	get_base_name: STRING is
		external
			"IL signature (): System.String use System.Resources.ResourceManager"
		alias
			"get_BaseName"
		end

	frozen magic_number: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Resources.ResourceManager"
		alias
			"MagicNumber"
		end

	frozen header_version_number: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Resources.ResourceManager"
		alias
			"HeaderVersionNumber"
		end

	get_resource_set_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Resources.ResourceManager"
		alias
			"get_ResourceSetType"
		end

	get_ignore_case: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Resources.ResourceManager"
		alias
			"get_IgnoreCase"
		end

feature -- Element Change

	set_ignore_case (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Resources.ResourceManager"
		alias
			"set_IgnoreCase"
		end

feature -- Basic Operations

	get_object_string_culture_info (name: STRING; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): ANY is
		external
			"IL signature (System.String, System.Globalization.CultureInfo): System.Object use System.Resources.ResourceManager"
		alias
			"GetObject"
		end

	get_string_string_culture_info (name: STRING; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): STRING is
		external
			"IL signature (System.String, System.Globalization.CultureInfo): System.String use System.Resources.ResourceManager"
		alias
			"GetString"
		end

	get_resource_set (culture: SYSTEM_GLOBALIZATION_CULTUREINFO; create_if_not_exists: BOOLEAN; try_parents: BOOLEAN): SYSTEM_RESOURCES_RESOURCESET is
		external
			"IL signature (System.Globalization.CultureInfo, System.Boolean, System.Boolean): System.Resources.ResourceSet use System.Resources.ResourceManager"
		alias
			"GetResourceSet"
		end

	release_all_resources is
		external
			"IL signature (): System.Void use System.Resources.ResourceManager"
		alias
			"ReleaseAllResources"
		end

	frozen create_file_based_resource_manager (base_name: STRING; resource_dir: STRING; using_resource_set: SYSTEM_TYPE): SYSTEM_RESOURCES_RESOURCEMANAGER is
		external
			"IL static signature (System.String, System.String, System.Type): System.Resources.ResourceManager use System.Resources.ResourceManager"
		alias
			"CreateFileBasedResourceManager"
		end

	get_string (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Resources.ResourceManager"
		alias
			"GetString"
		end

	get_object (name: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Resources.ResourceManager"
		alias
			"GetObject"
		end

feature {NONE} -- Implementation

	internal_get_resource_set (culture: SYSTEM_GLOBALIZATION_CULTUREINFO; create_if_not_exists: BOOLEAN; try_parents: BOOLEAN): SYSTEM_RESOURCES_RESOURCESET is
		external
			"IL signature (System.Globalization.CultureInfo, System.Boolean, System.Boolean): System.Resources.ResourceSet use System.Resources.ResourceManager"
		alias
			"InternalGetResourceSet"
		end

	get_resource_file_name (culture: SYSTEM_GLOBALIZATION_CULTUREINFO): STRING is
		external
			"IL signature (System.Globalization.CultureInfo): System.String use System.Resources.ResourceManager"
		alias
			"GetResourceFileName"
		end

	frozen get_satellite_contract_version (a: SYSTEM_REFLECTION_ASSEMBLY): SYSTEM_VERSION is
		external
			"IL static signature (System.Reflection.Assembly): System.Version use System.Resources.ResourceManager"
		alias
			"GetSatelliteContractVersion"
		end

	frozen get_neutral_resources_language (a: SYSTEM_REFLECTION_ASSEMBLY): SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL static signature (System.Reflection.Assembly): System.Globalization.CultureInfo use System.Resources.ResourceManager"
		alias
			"GetNeutralResourcesLanguage"
		end

end -- class SYSTEM_RESOURCES_RESOURCEMANAGER
