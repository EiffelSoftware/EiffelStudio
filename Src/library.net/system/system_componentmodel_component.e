indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Component"

external class
	SYSTEM_COMPONENTMODEL_COMPONENT

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize,
			to_string
		end
	SYSTEM_IDISPOSABLE

create
	make_component

feature {NONE} -- Initialization

	frozen make_component is
		external
			"IL creator use System.ComponentModel.Component"
		end

feature -- Access

	get_site: SYSTEM_COMPONENTMODEL_ISITE is
		external
			"IL signature (): System.ComponentModel.ISite use System.ComponentModel.Component"
		alias
			"get_Site"
		end

	frozen get_container: SYSTEM_COMPONENTMODEL_ICONTAINER is
		external
			"IL signature (): System.ComponentModel.IContainer use System.ComponentModel.Component"
		alias
			"get_Container"
		end

feature -- Element Change

	frozen add_disposed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.ComponentModel.Component"
		alias
			"add_Disposed"
		end

	set_site (value: SYSTEM_COMPONENTMODEL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.ComponentModel.Component"
		alias
			"set_Site"
		end

	frozen remove_disposed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.ComponentModel.Component"
		alias
			"remove_Disposed"
		end

feature -- Basic Operations

	dispose is
		external
			"IL signature (): System.Void use System.ComponentModel.Component"
		alias
			"Dispose"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Component"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	get_service (service: SYSTEM_TYPE): ANY is
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

	frozen get_events: SYSTEM_COMPONENTMODEL_EVENTHANDLERLIST is
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

end -- class SYSTEM_COMPONENTMODEL_COMPONENT
