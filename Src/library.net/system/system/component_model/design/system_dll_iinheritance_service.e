indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IInheritanceService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IINHERITANCE_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	add_inherited_components (component: SYSTEM_DLL_ICOMPONENT; container: SYSTEM_DLL_ICONTAINER) is
		external
			"IL deferred signature (System.ComponentModel.IComponent, System.ComponentModel.IContainer): System.Void use System.ComponentModel.Design.IInheritanceService"
		alias
			"AddInheritedComponents"
		end

	get_inheritance_attribute (component: SYSTEM_DLL_ICOMPONENT): SYSTEM_DLL_INHERITANCE_ATTRIBUTE is
		external
			"IL deferred signature (System.ComponentModel.IComponent): System.ComponentModel.InheritanceAttribute use System.ComponentModel.Design.IInheritanceService"
		alias
			"GetInheritanceAttribute"
		end

end -- class SYSTEM_DLL_IINHERITANCE_SERVICE
