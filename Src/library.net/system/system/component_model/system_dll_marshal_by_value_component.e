indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.MarshalByValueComponent"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_MARSHAL_BY_VALUE_COMPONENT

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	ISERVICE_PROVIDER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.ComponentModel.MarshalByValueComponent"
		end

feature -- Access

	get_site: SYSTEM_DLL_ISITE is
		external
			"IL signature (): System.ComponentModel.ISite use System.ComponentModel.MarshalByValueComponent"
		alias
			"get_Site"
		end

	get_design_mode: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.MarshalByValueComponent"
		alias
			"get_DesignMode"
		end

	get_container: SYSTEM_DLL_ICONTAINER is
		external
			"IL signature (): System.ComponentModel.IContainer use System.ComponentModel.MarshalByValueComponent"
		alias
			"get_Container"
		end

feature -- Element Change

	frozen add_disposed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.ComponentModel.MarshalByValueComponent"
		alias
			"add_Disposed"
		end

	set_site (value: SYSTEM_DLL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.ComponentModel.MarshalByValueComponent"
		alias
			"set_Site"
		end

	frozen remove_disposed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.ComponentModel.MarshalByValueComponent"
		alias
			"remove_Disposed"
		end

feature -- Basic Operations

	get_service (service: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Type): System.Object use System.ComponentModel.MarshalByValueComponent"
		alias
			"GetService"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.MarshalByValueComponent"
		alias
			"GetHashCode"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.ComponentModel.MarshalByValueComponent"
		alias
			"Dispose"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.MarshalByValueComponent"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.MarshalByValueComponent"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.ComponentModel.MarshalByValueComponent"
		alias
			"Dispose"
		end

	frozen get_events: SYSTEM_DLL_EVENT_HANDLER_LIST is
		external
			"IL signature (): System.ComponentModel.EventHandlerList use System.ComponentModel.MarshalByValueComponent"
		alias
			"get_Events"
		end

	finalize is
		external
			"IL signature (): System.Void use System.ComponentModel.MarshalByValueComponent"
		alias
			"Finalize"
		end

end -- class SYSTEM_DLL_MARSHAL_BY_VALUE_COMPONENT
