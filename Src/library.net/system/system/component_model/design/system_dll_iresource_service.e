indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IResourceService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IRESOURCE_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_resource_reader (info: CULTURE_INFO): IRESOURCE_READER is
		external
			"IL deferred signature (System.Globalization.CultureInfo): System.Resources.IResourceReader use System.ComponentModel.Design.IResourceService"
		alias
			"GetResourceReader"
		end

	get_resource_writer (info: CULTURE_INFO): IRESOURCE_WRITER is
		external
			"IL deferred signature (System.Globalization.CultureInfo): System.Resources.IResourceWriter use System.ComponentModel.Design.IResourceService"
		alias
			"GetResourceWriter"
		end

end -- class SYSTEM_DLL_IRESOURCE_SERVICE
