indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IServiceContainer"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ISERVICE_CONTAINER

inherit
	ISERVICE_PROVIDER

feature -- Basic Operations

	add_service (service_type: TYPE; service_instance: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Type, System.Object): System.Void use System.ComponentModel.Design.IServiceContainer"
		alias
			"AddService"
		end

	add_service_type_object_boolean (service_type: TYPE; service_instance: SYSTEM_OBJECT; promote: BOOLEAN) is
		external
			"IL deferred signature (System.Type, System.Object, System.Boolean): System.Void use System.ComponentModel.Design.IServiceContainer"
		alias
			"AddService"
		end

	add_service_type_service_creator_callback_boolean (service_type: TYPE; callback: SYSTEM_DLL_SERVICE_CREATOR_CALLBACK; promote: BOOLEAN) is
		external
			"IL deferred signature (System.Type, System.ComponentModel.Design.ServiceCreatorCallback, System.Boolean): System.Void use System.ComponentModel.Design.IServiceContainer"
		alias
			"AddService"
		end

	add_service_type_service_creator_callback (service_type: TYPE; callback: SYSTEM_DLL_SERVICE_CREATOR_CALLBACK) is
		external
			"IL deferred signature (System.Type, System.ComponentModel.Design.ServiceCreatorCallback): System.Void use System.ComponentModel.Design.IServiceContainer"
		alias
			"AddService"
		end

	remove_service_type_boolean (service_type: TYPE; promote: BOOLEAN) is
		external
			"IL deferred signature (System.Type, System.Boolean): System.Void use System.ComponentModel.Design.IServiceContainer"
		alias
			"RemoveService"
		end

	remove_service (service_type: TYPE) is
		external
			"IL deferred signature (System.Type): System.Void use System.ComponentModel.Design.IServiceContainer"
		alias
			"RemoveService"
		end

end -- class SYSTEM_DLL_ISERVICE_CONTAINER
