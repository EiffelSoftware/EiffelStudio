indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.Serialization.IDesignerLoaderHost"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IDESIGNER_LOADER_HOST

inherit
	SYSTEM_DLL_IDESIGNER_HOST
	SYSTEM_DLL_ISERVICE_CONTAINER
	ISERVICE_PROVIDER

feature -- Basic Operations

	reload is
		external
			"IL deferred signature (): System.Void use System.ComponentModel.Design.Serialization.IDesignerLoaderHost"
		alias
			"Reload"
		end

	end_load (base_class_name: SYSTEM_STRING; successful: BOOLEAN; error_collection: ICOLLECTION) is
		external
			"IL deferred signature (System.String, System.Boolean, System.Collections.ICollection): System.Void use System.ComponentModel.Design.Serialization.IDesignerLoaderHost"
		alias
			"EndLoad"
		end

end -- class SYSTEM_DLL_IDESIGNER_LOADER_HOST
