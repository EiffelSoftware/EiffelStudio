indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Design.WindowsFormsComponentEditor"

deferred external class
	SYSTEM_WINDOWS_FORMS_DESIGN_WINDOWSFORMSCOMPONENTEDITOR

inherit
	SYSTEM_COMPONENTMODEL_COMPONENTEDITOR

feature -- Basic Operations

	frozen edit_component_object_iwin32_window (component: ANY; owner: SYSTEM_WINDOWS_FORMS_IWIN32WINDOW): BOOLEAN is
		external
			"IL signature (System.Object, System.Windows.Forms.IWin32Window): System.Boolean use System.Windows.Forms.Design.WindowsFormsComponentEditor"
		alias
			"EditComponent"
		end

	edit_component_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; component: ANY): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object): System.Boolean use System.Windows.Forms.Design.WindowsFormsComponentEditor"
		alias
			"EditComponent"
		end

	edit_component_itype_descriptor_context2 (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; component: ANY; owner: SYSTEM_WINDOWS_FORMS_IWIN32WINDOW): BOOLEAN is
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

	get_component_editor_pages: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Windows.Forms.Design.WindowsFormsComponentEditor"
		alias
			"GetComponentEditorPages"
		end

end -- class SYSTEM_WINDOWS_FORMS_DESIGN_WINDOWSFORMSCOMPONENTEDITOR
