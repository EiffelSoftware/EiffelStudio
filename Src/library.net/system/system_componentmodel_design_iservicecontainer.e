indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IServiceContainer"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_ISERVICECONTAINER

inherit
	SYSTEM_ISERVICEPROVIDER

feature -- Basic Operations

	add_service (service_type: SYSTEM_TYPE; service_instance: ANY) is
		external
			"IL deferred signature (System.Type, System.Object): System.Void use System.ComponentModel.Design.IServiceContainer"
		alias
			"AddService"
		end

	add_service_type_object_boolean (service_type: SYSTEM_TYPE; service_instance: ANY; promote: BOOLEAN) is
		external
			"IL deferred signature (System.Type, System.Object, System.Boolean): System.Void use System.ComponentModel.Design.IServiceContainer"
		alias
			"AddService"
		end

	add_service_type_service_creator_callback_boolean (service_type: SYSTEM_TYPE; callback: SYSTEM_COMPONENTMODEL_DESIGN_SERVICECREATORCALLBACK; promote: BOOLEAN) is
		external
			"IL deferred signature (System.Type, System.ComponentModel.Design.ServiceCreatorCallback, System.Boolean): System.Void use System.ComponentModel.Design.IServiceContainer"
		alias
			"AddService"
		end

	add_service_type_service_creator_callback (service_type: SYSTEM_TYPE; callback: SYSTEM_COMPONENTMODEL_DESIGN_SERVICECREATORCALLBACK) is
		external
			"IL deferred signature (System.Type, System.ComponentModel.Design.ServiceCreatorCallback): System.Void use System.ComponentModel.Design.IServiceContainer"
		alias
			"AddService"
		end

	remove_service_type_boolean (service_type: SYSTEM_TYPE; promote: BOOLEAN) is
		external
			"IL deferred signature (System.Type, System.Boolean): System.Void use System.ComponentModel.Design.IServiceContainer"
		alias
			"RemoveService"
		end

	remove_service (service_type: SYSTEM_TYPE) is
		external
			"IL deferred signature (System.Type): System.Void use System.ComponentModel.Design.IServiceContainer"
		alias
			"RemoveService"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_ISERVICECONTAINER
