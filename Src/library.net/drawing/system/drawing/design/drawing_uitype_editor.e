indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Design.UITypeEditor"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_UITYPE_EDITOR

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Design.UITypeEditor"
		end

feature -- Basic Operations

	get_paint_value_supported_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Drawing.Design.UITypeEditor"
		alias
			"GetPaintValueSupported"
		end

	frozen paint_value_object (value: SYSTEM_OBJECT; canvas: DRAWING_GRAPHICS; rectangle: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Object, System.Drawing.Graphics, System.Drawing.Rectangle): System.Void use System.Drawing.Design.UITypeEditor"
		alias
			"PaintValue"
		end

	frozen edit_value (provider: ISERVICE_PROVIDER; value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.IServiceProvider, System.Object): System.Object use System.Drawing.Design.UITypeEditor"
		alias
			"EditValue"
		end

	edit_value_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; provider: ISERVICE_PROVIDER; value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.IServiceProvider, System.Object): System.Object use System.Drawing.Design.UITypeEditor"
		alias
			"EditValue"
		end

	frozen get_edit_style: DRAWING_UITYPE_EDITOR_EDIT_STYLE is
		external
			"IL signature (): System.Drawing.Design.UITypeEditorEditStyle use System.Drawing.Design.UITypeEditor"
		alias
			"GetEditStyle"
		end

	get_edit_style_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): DRAWING_UITYPE_EDITOR_EDIT_STYLE is
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

	paint_value (e: DRAWING_PAINT_VALUE_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Design.PaintValueEventArgs): System.Void use System.Drawing.Design.UITypeEditor"
		alias
			"PaintValue"
		end

end -- class DRAWING_UITYPE_EDITOR
