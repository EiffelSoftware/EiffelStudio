indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Design.WindowsFormsComponentEditor"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_WINDOWS_FORMS_COMPONENT_EDITOR

inherit
	SYSTEM_DLL_COMPONENT_EDITOR

feature -- Basic Operations

	frozen edit_component_object_iwin32_window (component: SYSTEM_OBJECT; owner: WINFORMS_IWIN32_WINDOW): BOOLEAN is
		external
			"IL signature (System.Object, System.Windows.Forms.IWin32Window): System.Boolean use System.Windows.Forms.Design.WindowsFormsComponentEditor"
		alias
			"EditComponent"
		end

	edit_component_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; component: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object): System.Boolean use System.Windows.Forms.Design.WindowsFormsComponentEditor"
		alias
			"EditComponent"
		end

	edit_component_itype_descriptor_context2 (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; component: SYSTEM_OBJECT; owner: WINFORMS_IWIN32_WINDOW): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Windows.Forms.IWin32Window): System.Boolean use System.Windows.Forms.Design.WindowsFormsComponentEditor"
		alias
			"EditComponent"
		end

feature {NONE} -- Implementation

	get_initial_component_editor_page_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Design.WindowsFormsComponentEditor"
		alias
			"GetInitialComponentEditorPageIndex"
		end

	get_component_editor_pages: NATIVE_ARRAY [TYPE] is
		external
			"IL signature (): System.Type[] use System.Windows.Forms.Design.WindowsFormsComponentEditor"
		alias
			"GetComponentEditorPages"
		end

end -- class WINFORMS_WINDOWS_FORMS_COMPONENT_EDITOR
