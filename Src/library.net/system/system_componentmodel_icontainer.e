indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.IContainer"

deferred external class
	SYSTEM_COMPONENTMODEL_ICONTAINER

inherit
	SYSTEM_IDISPOSABLE

feature -- Access

	get_components: SYSTEM_COMPONENTMODEL_COMPONENTCOLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.ComponentCollection use System.ComponentModel.IContainer"
		alias
			"get_Components"
		end

feature -- Basic Operations

	add_icomponent_string (component: SYSTEM_COMPONENTMODEL_ICOMPONENT; name: STRING) is
		external
			"IL deferred signature (System.ComponentModel.IComponent, System.String): System.Void use System.ComponentModel.IContainer"
		alias
			"Add"
		end

	add (component: SYSTEM_COMPONENTMODEL_ICOMPONENT) is
		external
			"IL deferred signature (System.ComponentModel.IComponent): System.Void use System.ComponentModel.IContainer"
		alias
			"Add"
		end

	remove (component: SYSTEM_COMPONENTMODEL_ICOMPONENT) is
		external
			"IL deferred signature (System.ComponentModel.IComponent): System.Void use System.ComponentModel.IContainer"
		alias
			"Remove"
		end

end -- class SYSTEM_COMPONENTMODEL_ICONTAINER
