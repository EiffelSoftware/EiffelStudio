indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.AxHost+AxComponentEditor"

external class
	AXCOMPONENTEDITOR_IN_SYSTEM_WINDOWS_FORMS_AXHOST

inherit
	SYSTEM_WINDOWS_FORMS_DESIGN_WINDOWSFORMSCOMPONENTEDITOR
		redefine
			edit_component_itype_descriptor_context2
		end

create
	make_axcomponenteditor

feature {NONE} -- Initialization

	frozen make_axcomponenteditor is
		external
			"IL creator use System.Windows.Forms.AxHost+AxComponentEditor"
		end

feature -- Basic Operations

	edit_component_itype_descriptor_context2 (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; obj: ANY; parent: SYSTEM_WINDOWS_FORMS_IWIN32WINDOW): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Windows.Forms.IWin32Window): System.Boolean use System.Windows.Forms.AxHost+AxComponentEditor"
		alias
			"EditComponent"
		end

end -- class AXCOMPONENTEDITOR_IN_SYSTEM_WINDOWS_FORMS_AXHOST
