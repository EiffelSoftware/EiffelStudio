indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IResourceService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_IRESOURCESERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_resource_reader (info: SYSTEM_GLOBALIZATION_CULTUREINFO): SYSTEM_RESOURCES_IRESOURCEREADER is
		external
			"IL deferred signature (System.Globalization.CultureInfo): System.Resources.IResourceReader use System.ComponentModel.Design.IResourceService"
		alias
			"GetResourceReader"
		end

	get_resource_writer (info: SYSTEM_GLOBALIZATION_CULTUREINFO): SYSTEM_RESOURCES_IRESOURCEWRITER is
		external
			"IL deferred signature (System.Globalization.CultureInfo): System.Resources.IResourceWriter use System.ComponentModel.Design.IResourceService"
		alias
			"GetResourceWriter"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_IRESOURCESERVICE
