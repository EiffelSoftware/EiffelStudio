indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.ComponentModel.IContainer"
	assembly: "System", "1.0.3200.0", "neutral", "b77a5c561934e089"

deferred external class
	ICONTAINER

inherit
	IDISPOSABLE

feature -- Access

	get_components: COMPONENTCOLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.ComponentCollection use System.ComponentModel.IContainer"
		alias
			"get_Components"
		end

feature -- Basic Operations

	add_icomponent_string (component: ICOMPONENT; name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.ComponentModel.IComponent, System.String): System.Void use System.ComponentModel.IContainer"
		alias
			"Add"
		end

	add (component: ICOMPONENT) is
		external
			"IL deferred signature (System.ComponentModel.IComponent): System.Void use System.ComponentModel.IContainer"
		alias
			"Add"
		end

	remove (component: ICOMPONENT) is
		external
			"IL deferred signature (System.ComponentModel.IComponent): System.Void use System.ComponentModel.IContainer"
		alias
			"Remove"
		end

end -- class ICONTAINER
