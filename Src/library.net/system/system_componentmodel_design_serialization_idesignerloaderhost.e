indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.Serialization.IDesignerLoaderHost"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_IDESIGNERLOADERHOST

inherit
	SYSTEM_COMPONENTMODEL_DESIGN_ISERVICECONTAINER
	SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST
	SYSTEM_ISERVICEPROVIDER

feature -- Basic Operations

	reload is
		external
			"IL deferred signature (): System.Void use System.ComponentModel.Design.Serialization.IDesignerLoaderHost"
		alias
			"Reload"
		end

	end_load (base_class_name: STRING; successful: BOOLEAN; error_collection: SYSTEM_COLLECTIONS_ICOLLECTION) is
		external
			"IL deferred signature (System.String, System.Boolean, System.Collections.ICollection): System.Void use System.ComponentModel.Design.Serialization.IDesignerLoaderHost"
		alias
			"EndLoad"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_IDESIGNERLOADERHOST
