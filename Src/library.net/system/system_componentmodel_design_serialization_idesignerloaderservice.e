indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.Serialization.IDesignerLoaderService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_IDESIGNERLOADERSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	reload: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.Design.Serialization.IDesignerLoaderService"
		alias
			"Reload"
		end

	dependent_load_complete (successful: BOOLEAN; error_collection: SYSTEM_COLLECTIONS_ICOLLECTION) is
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

end -- class SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_IDESIGNERLOADERSERVICE
