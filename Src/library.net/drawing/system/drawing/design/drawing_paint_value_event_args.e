indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Design.PaintValueEventArgs"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_PAINT_VALUE_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_drawing_paint_value_event_args

feature {NONE} -- Initialization

	frozen make_drawing_paint_value_event_args (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; value: SYSTEM_OBJECT; graphics: DRAWING_GRAPHICS; bounds: DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Drawing.Graphics, System.Drawing.Rectangle) use System.Drawing.Design.PaintValueEventArgs"
		end

feature -- Access

	frozen get_context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT is
		external
			"IL signature (): System.ComponentModel.ITypeDescriptorContext use System.Drawing.Design.PaintValueEventArgs"
		alias
			"get_Context"
		end

	frozen get_bounds: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Drawing.Design.PaintValueEventArgs"
		alias
			"get_Bounds"
		end

	frozen get_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Drawing.Design.PaintValueEventArgs"
		alias
			"get_Value"
		end

	frozen get_graphics: DRAWING_GRAPHICS is
		external
			"IL signature (): System.Drawing.Graphics use System.Drawing.Design.PaintValueEventArgs"
		alias
			"get_Graphics"
		end

end -- class DRAWING_PAINT_VALUE_EVENT_ARGS
