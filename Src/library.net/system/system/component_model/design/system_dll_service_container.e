indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.ServiceContainer"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_SERVICE_CONTAINER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_DLL_ISERVICE_CONTAINER
	ISERVICE_PROVIDER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.ComponentModel.Design.ServiceContainer"
		end

	frozen make_1 (parent_provider: ISERVICE_PROVIDER) is
		external
			"IL creator signature (System.IServiceProvider) use System.ComponentModel.Design.ServiceContainer"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.ServiceContainer"
		alias
			"ToString"
		end

	frozen add_service_type_object_boolean (service_type: TYPE; service_instance: SYSTEM_OBJECT; promote: BOOLEAN) is
		external
			"IL signature (System.Type, System.Object, System.Boolean): System.Void use System.ComponentModel.Design.ServiceContainer"
		alias
			"AddService"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.Design.ServiceContainer"
		alias
			"Equals"
		end

	frozen add_service_type_service_creator_callback (service_type: TYPE; callback: SYSTEM_DLL_SERVICE_CREATOR_CALLBACK) is
		external
			"IL signature (System.Type, System.ComponentModel.Design.ServiceCreatorCallback): System.Void use System.ComponentModel.Design.ServiceContainer"
		alias
			"AddService"
		end

	frozen remove_service_type_boolean (service_type: TYPE; promote: BOOLEAN) is
		external
			"IL signature (System.Type, System.Boolean): System.Void use System.ComponentModel.Design.ServiceContainer"
		alias
			"RemoveService"
		end

	frozen add_service (service_type: TYPE; service_instance: SYSTEM_OBJECT) is
		external
			"IL signature (System.Type, System.Object): System.Void use System.ComponentModel.Design.ServiceContainer"
		alias
			"AddService"
		end

	frozen get_service (service_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Type): System.Object use System.ComponentModel.Design.ServiceContainer"
		alias
			"GetService"
		end

	frozen add_service_type_service_creator_callback_boolean (service_type: TYPE; callback: SYSTEM_DLL_SERVICE_CREATOR_CALLBACK; promote: BOOLEAN) is
		external
			"IL signature (System.Type, System.ComponentModel.Design.ServiceCreatorCallback, System.Boolean): System.Void use System.ComponentModel.Design.ServiceContainer"
		alias
			"AddService"
		end

	frozen remove_service (service_type: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.ComponentModel.Design.ServiceContainer"
		alias
			"RemoveService"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.Design.ServiceContainer"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.ComponentModel.Design.ServiceContainer"
		alias
			"Finalize"
		end

end -- class SYSTEM_DLL_SERVICE_CONTAINER
