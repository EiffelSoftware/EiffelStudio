indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.Serialization.IDesignerLoaderService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IDESIGNER_LOADER_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	reload: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.Design.Serialization.IDesignerLoaderService"
		alias
			"Reload"
		end

	dependent_load_complete (successful: BOOLEAN; error_collection: ICOLLECTION) is
		external
			"IL deferred signature (System.Boolean, System.Collections.ICollection): System.Void use System.ComponentModel.Design.Serialization.IDesignerLoaderService"
		alias
			"DependentLoadComplete"
		end

	add_load_dependency is
		external
			"IL deferred signature (): System.Void use System.ComponentModel.Design.Serialization.IDesignerLoaderService"
		alias
			"AddLoadDependency"
		end

end -- class SYSTEM_DLL_IDESIGNER_LOADER_SERVICE
