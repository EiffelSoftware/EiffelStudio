indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IDesigner"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNER

inherit
	SYSTEM_IDISPOSABLE

feature -- Access

	get_verbs: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERVERBCOLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.Design.DesignerVerbCollection use System.ComponentModel.Design.IDesigner"
		alias
			"get_Verbs"
		end

	get_component: SYSTEM_COMPONENTMODEL_ICOMPONENT is
		external
			"IL deferred signature (): System.ComponentModel.IComponent use System.ComponentModel.Design.IDesigner"
		alias
			"get_Component"
		end

feature -- Basic Operations

	initialize (component: SYSTEM_COMPONENTMODEL_ICOMPONENT) is
		external
			"IL deferred signature (System.ComponentModel.IComponent): System.Void use System.ComponentModel.Design.IDesigner"
		alias
			"Initialize"
		end

	do_default_action is
		external
			"IL deferred signature (): System.Void use System.ComponentModel.Design.IDesigner"
		alias
			"DoDefaultAction"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNER
