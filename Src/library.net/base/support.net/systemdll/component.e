indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.ComponentModel.Component"
	assembly: "System", "1.0.3200.0", "neutral", "b77a5c561934e089"

external class
	COMPONENT

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize,
			to_string
		end
	ICOMPONENT
	IDISPOSABLE

create
	make_component

feature {NONE} -- Initialization

	frozen make_component is
		external
			"IL creator use System.ComponentModel.Component"
		end

feature -- Access

	get_site: ISITE is
		external
			"IL signature (): System.ComponentModel.ISite use System.ComponentModel.Component"
		alias
			"get_Site"
		end

	frozen get_container: ICONTAINER is
		external
			"IL signature (): System.ComponentModel.IContainer use System.ComponentModel.Component"
		alias
			"get_Container"
		end

feature -- Element Change

	frozen add_disposed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.ComponentModel.Component"
		alias
			"add_Disposed"
		end

	set_site (value: ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.ComponentModel.Component"
		alias
			"set_Site"
		end

	frozen remove_disposed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.ComponentModel.Component"
		alias
			"remove_Disposed"
		end

feature -- Basic Operations

	frozen dispose is
		external
			"IL signature (): System.Void use System.ComponentModel.Component"
		alias
			"Dispose"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Component"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	get_service (service: TYPE): ANY is
		external
			"IL signature (System.Type): System.Object use System.ComponentModel.Component"
		alias
			"GetService"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.ComponentModel.Component"
		alias
			"Dispose"
		end

	frozen get_events: EVENTHANDLERLIST is
		external
			"IL signature (): System.ComponentModel.EventHandlerList use System.ComponentModel.Component"
		alias
			"get_Events"
		end

	finalize is
		external
			"IL signature (): System.Void use System.ComponentModel.Component"
		alias
			"Finalize"
		end

	frozen get_design_mode: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.Component"
		alias
			"get_DesignMode"
		end

end -- class COMPONENT
