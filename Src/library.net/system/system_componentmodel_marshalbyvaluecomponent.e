indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.MarshalByValueComponent"

external class
	SYSTEM_COMPONENTMODEL_MARSHALBYVALUECOMPONENT

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_IDISPOSABLE
	SYSTEM_ISERVICEPROVIDER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.ComponentModel.MarshalByValueComponent"
		end

feature -- Access

	get_site: SYSTEM_COMPONENTMODEL_ISITE is
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

	get_container: SYSTEM_COMPONENTMODEL_ICONTAINER is
		external
			"IL signature (): System.ComponentModel.IContainer use System.ComponentModel.MarshalByValueComponent"
		alias
			"get_Container"
		end

feature -- Element Change

	frozen add_disposed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.ComponentModel.MarshalByValueComponent"
		alias
			"add_Disposed"
		end

	set_site (value: SYSTEM_COMPONENTMODEL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.ComponentModel.MarshalByValueComponent"
		alias
			"set_Site"
		end

	frozen remove_disposed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.ComponentModel.MarshalByValueComponent"
		alias
			"remove_Disposed"
		end

feature -- Basic Operations

	get_service (service: SYSTEM_TYPE): ANY is
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

	dispose is
		external
			"IL signature (): System.Void use System.ComponentModel.MarshalByValueComponent"
		alias
			"Dispose"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.MarshalByValueComponent"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

	frozen get_events: SYSTEM_COMPONENTMODEL_EVENTHANDLERLIST is
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

end -- class SYSTEM_COMPONENTMODEL_MARSHALBYVALUECOMPONENT
