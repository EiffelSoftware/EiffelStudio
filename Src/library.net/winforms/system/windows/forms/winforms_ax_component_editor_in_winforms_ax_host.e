indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.AxHost+AxComponentEditor"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_AX_COMPONENT_EDITOR_IN_WINFORMS_AX_HOST

inherit
	WINFORMS_WINDOWS_FORMS_COMPONENT_EDITOR
		redefine
			edit_component_itype_descriptor_context2
		end

create
	make_winforms_ax_component_editor_in_winforms_ax_host

feature {NONE} -- Initialization

	frozen make_winforms_ax_component_editor_in_winforms_ax_host is
		external
			"IL creator use System.Windows.Forms.AxHost+AxComponentEditor"
		end

feature -- Basic Operations

	edit_component_itype_descriptor_context2 (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; obj: SYSTEM_OBJECT; parent: WINFORMS_IWIN32_WINDOW): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Windows.Forms.IWin32Window): System.Boolean use System.Windows.Forms.AxHost+AxComponentEditor"
		alias
			"EditComponent"
		end

end -- class WINFORMS_AX_COMPONENT_EDITOR_IN_WINFORMS_AX_HOST
