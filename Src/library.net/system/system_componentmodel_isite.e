indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ISite"

deferred external class
	SYSTEM_COMPONENTMODEL_ISITE

inherit
	SYSTEM_ISERVICEPROVIDER

feature -- Access

	get_component: SYSTEM_COMPONENTMODEL_ICOMPONENT is
		external
			"IL deferred signature (): System.ComponentModel.IComponent use System.ComponentModel.ISite"
		alias
			"get_Component"
		end

	get_container: SYSTEM_COMPONENTMODEL_ICONTAINER is
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

	get_name: STRING is
		external
			"IL deferred signature (): System.String use System.ComponentModel.ISite"
		alias
			"get_Name"
		end

feature -- Element Change

	set_name (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.ComponentModel.ISite"
		alias
			"set_Name"
		end

end -- class SYSTEM_COMPONENTMODEL_ISITE
