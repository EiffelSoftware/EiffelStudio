indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IInheritanceService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_IINHERITANCESERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	add_inherited_components (component: SYSTEM_COMPONENTMODEL_ICOMPONENT; container: SYSTEM_COMPONENTMODEL_ICONTAINER) is
		external
			"IL deferred signature (System.ComponentModel.IComponent, System.ComponentModel.IContainer): System.Void use System.ComponentModel.Design.IInheritanceService"
		alias
			"AddInheritedComponents"
		end

	get_inheritance_attribute (component: SYSTEM_COMPONENTMODEL_ICOMPONENT): SYSTEM_COMPONENTMODEL_INHERITANCEATTRIBUTE is
		external
			"IL deferred signature (System.ComponentModel.IComponent): System.ComponentModel.InheritanceAttribute use System.ComponentModel.Design.IInheritanceService"
		alias
			"GetInheritanceAttribute"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_IINHERITANCESERVICE
