indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.ComponentModel.ISite"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISITE

inherit
	ISERVICE_PROVIDER

feature -- Access

	get_component: ICOMPONENT is
		external
			"IL deferred signature (): System.ComponentModel.IComponent use System.ComponentModel.ISite"
		alias
			"get_Component"
		end

	get_container: ICONTAINER is
		external
			"IL deferred signature (): System.ComponentModel.IContainer use System.ComponentModel.ISite"
		alias
			"get_Container"
		end

	get_design_mode: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.ISite"
		alias
			"get_DesignMode"
		end

	get_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.ComponentModel.ISite"
		alias
			"get_Name"
		end

feature -- Element Change

	set_name (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.ComponentModel.ISite"
		alias
			"set_Name"
		end

end -- class ISITE
