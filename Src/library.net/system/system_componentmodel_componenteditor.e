indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ComponentEditor"

deferred external class
	SYSTEM_COMPONENTMODEL_COMPONENTEDITOR

feature -- Basic Operations

	frozen edit_component (component: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ComponentEditor"
		alias
			"EditComponent"
		end

	edit_component_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; component: ANY): BOOLEAN is
		external
			"IL deferred signature (System.ComponentModel.ITypeDescriptorContext, System.Object): System.Boolean use System.ComponentModel.ComponentEditor"
		alias
			"EditComponent"
		end

end -- class SYSTEM_COMPONENTMODEL_COMPONENTEDITOR
