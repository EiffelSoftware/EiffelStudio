indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.ComponentEditor"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_COMPONENT_EDITOR

inherit
	SYSTEM_OBJECT

feature -- Basic Operations

	frozen edit_component (component: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ComponentEditor"
		alias
			"EditComponent"
		end

	edit_component_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; component: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL deferred signature (System.ComponentModel.ITypeDescriptorContext, System.Object): System.Boolean use System.ComponentModel.ComponentEditor"
		alias
			"EditComponent"
		end

end -- class SYSTEM_DLL_COMPONENT_EDITOR
