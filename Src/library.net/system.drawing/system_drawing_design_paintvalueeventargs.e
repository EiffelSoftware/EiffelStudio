indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.PaintValueEventArgs"

external class
	SYSTEM_DRAWING_DESIGN_PAINTVALUEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_paintvalueeventargs

feature {NONE} -- Initialization

	frozen make_paintvalueeventargs (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; value: ANY; graphics: SYSTEM_DRAWING_GRAPHICS; bounds: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Drawing.Graphics, System.Drawing.Rectangle) use System.Drawing.Design.PaintValueEventArgs"
		end

feature -- Access

	frozen get_context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT is
		external
			"IL signature (): System.ComponentModel.ITypeDescriptorContext use System.Drawing.Design.PaintValueEventArgs"
		alias
			"get_Context"
		end

	frozen get_bounds: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Drawing.Design.PaintValueEventArgs"
		alias
			"get_Bounds"
		end

	frozen get_value: ANY is
		external
			"IL signature (): System.Object use System.Drawing.Design.PaintValueEventArgs"
		alias
			"get_Value"
		end

	frozen get_graphics: SYSTEM_DRAWING_GRAPHICS is
		external
			"IL signature (): System.Drawing.Graphics use System.Drawing.Design.PaintValueEventArgs"
		alias
			"get_Graphics"
		end

end -- class SYSTEM_DRAWING_DESIGN_PAINTVALUEEVENTARGS
