indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.ServiceContainer"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGN_SERVICECONTAINER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COMPONENTMODEL_DESIGN_ISERVICECONTAINER
	SYSTEM_ISERVICEPROVIDER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.ComponentModel.Design.ServiceContainer"
		end

	frozen make_1 (parent_provider: SYSTEM_ISERVICEPROVIDER) is
		external
			"IL creator signature (System.IServiceProvider) use System.ComponentModel.Design.ServiceContainer"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.ServiceContainer"
		alias
			"ToString"
		end

	frozen add_service_type_object_boolean (service_type: SYSTEM_TYPE; service_instance: ANY; promote: BOOLEAN) is
		external
			"IL signature (System.Type, System.Object, System.Boolean): System.Void use System.ComponentModel.Design.ServiceContainer"
		alias
			"AddService"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.Design.ServiceContainer"
		alias
			"Equals"
		end

	frozen add_service_type_service_creator_callback (service_type: SYSTEM_TYPE; callback: SYSTEM_COMPONENTMODEL_DESIGN_SERVICECREATORCALLBACK) is
		external
			"IL signature (System.Type, System.ComponentModel.Design.ServiceCreatorCallback): System.Void use System.ComponentModel.Design.ServiceContainer"
		alias
			"AddService"
		end

	frozen remove_service_type_boolean (service_type: SYSTEM_TYPE; promote: BOOLEAN) is
		external
			"IL signature (System.Type, System.Boolean): System.Void use System.ComponentModel.Design.ServiceContainer"
		alias
			"RemoveService"
		end

	frozen add_service (service_type: SYSTEM_TYPE; service_instance: ANY) is
		external
			"IL signature (System.Type, System.Object): System.Void use System.ComponentModel.Design.ServiceContainer"
		alias
			"AddService"
		end

	frozen get_service (service_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Type): System.Object use System.ComponentModel.Design.ServiceContainer"
		alias
			"GetService"
		end

	frozen add_service_type_service_creator_callback_boolean (service_type: SYSTEM_TYPE; callback: SYSTEM_COMPONENTMODEL_DESIGN_SERVICECREATORCALLBACK; promote: BOOLEAN) is
		external
			"IL signature (System.Type, System.ComponentModel.Design.ServiceCreatorCallback, System.Boolean): System.Void use System.ComponentModel.Design.ServiceContainer"
		alias
			"AddService"
		end

	frozen remove_service (service_type: SYSTEM_TYPE) is
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

end -- class SYSTEM_COMPONENTMODEL_DESIGN_SERVICECONTAINER
