indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.IContainer"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ICONTAINER

inherit
	IDISPOSABLE

feature -- Access

	get_components: SYSTEM_DLL_COMPONENT_COLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.ComponentCollection use System.ComponentModel.IContainer"
		alias
			"get_Components"
		end

feature -- Basic Operations

	add_icomponent_string (component: SYSTEM_DLL_ICOMPONENT; name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.ComponentModel.IComponent, System.String): System.Void use System.ComponentModel.IContainer"
		alias
			"Add"
		end

	add (component: SYSTEM_DLL_ICOMPONENT) is
		external
			"IL deferred signature (System.ComponentModel.IComponent): System.Void use System.ComponentModel.IContainer"
		alias
			"Add"
		end

	remove (component: SYSTEM_DLL_ICOMPONENT) is
		external
			"IL deferred signature (System.ComponentModel.IComponent): System.Void use System.ComponentModel.IContainer"
		alias
			"Remove"
		end

end -- class SYSTEM_DLL_ICONTAINER
