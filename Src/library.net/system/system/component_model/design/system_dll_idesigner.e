indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IDesigner"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IDESIGNER

inherit
	IDISPOSABLE

feature -- Access

	get_verbs: SYSTEM_DLL_DESIGNER_VERB_COLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.Design.DesignerVerbCollection use System.ComponentModel.Design.IDesigner"
		alias
			"get_Verbs"
		end

	get_component: SYSTEM_DLL_ICOMPONENT is
		external
			"IL deferred signature (): System.ComponentModel.IComponent use System.ComponentModel.Design.IDesigner"
		alias
			"get_Component"
		end

feature -- Basic Operations

	initialize (component: SYSTEM_DLL_ICOMPONENT) is
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

end -- class SYSTEM_DLL_IDESIGNER
