indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.UITypeEditor"

external class
	SYSTEM_DRAWING_DESIGN_UITYPEEDITOR

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Design.UITypeEditor"
		end

feature -- Basic Operations

	get_paint_value_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Drawing.Design.UITypeEditor"
		alias
			"GetPaintValueSupported"
		end

	frozen paint_value_object (value: ANY; canvas: SYSTEM_DRAWING_GRAPHICS; rectangle: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Object, System.Drawing.Graphics, System.Drawing.Rectangle): System.Void use System.Drawing.Design.UITypeEditor"
		alias
			"PaintValue"
		end

	frozen edit_value (provider: SYSTEM_ISERVICEPROVIDER; value: ANY): ANY is
		external
			"IL signature (System.IServiceProvider, System.Object): System.Object use System.Drawing.Design.UITypeEditor"
		alias
			"EditValue"
		end

	edit_value_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; provider: SYSTEM_ISERVICEPROVIDER; value: ANY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.IServiceProvider, System.Object): System.Object use System.Drawing.Design.UITypeEditor"
		alias
			"EditValue"
		end

	frozen get_edit_style: SYSTEM_DRAWING_DESIGN_UITYPEEDITOREDITSTYLE is
		external
			"IL signature (): System.Drawing.Design.UITypeEditorEditStyle use System.Drawing.Design.UITypeEditor"
		alias
			"GetEditStyle"
		end

	get_edit_style_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): SYSTEM_DRAWING_DESIGN_UITYPEEDITOREDITSTYLE is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Drawing.Design.UITypeEditorEditStyle use System.Drawing.Design.UITypeEditor"
		alias
			"GetEditStyle"
		end

	frozen get_paint_value_supported: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Design.UITypeEditor"
		alias
			"GetPaintValueSupported"
		end

	paint_value (e: SYSTEM_DRAWING_DESIGN_PAINTVALUEEVENTARGS) is
		external
			"IL signature (System.Drawing.Design.PaintValueEventArgs): System.Void use System.Drawing.Design.UITypeEditor"
		alias
			"PaintValue"
		end

end -- class SYSTEM_DRAWING_DESIGN_UITYPEEDITOR
