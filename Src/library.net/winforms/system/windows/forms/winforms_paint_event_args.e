indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.PaintEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_PAINT_EVENT_ARGS

inherit
	EVENT_ARGS
		redefine
			finalize
		end
	IDISPOSABLE

create
	make_winforms_paint_event_args

feature {NONE} -- Initialization

	frozen make_winforms_paint_event_args (graphics: DRAWING_GRAPHICS; clip_rect: DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.Drawing.Graphics, System.Drawing.Rectangle) use System.Windows.Forms.PaintEventArgs"
		end

feature -- Access

	frozen get_graphics: DRAWING_GRAPHICS is
		external
			"IL signature (): System.Drawing.Graphics use System.Windows.Forms.PaintEventArgs"
		alias
			"get_Graphics"
		end

	frozen get_clip_rectangle: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.PaintEventArgs"
		alias
			"get_ClipRectangle"
		end

feature -- Basic Operations

	frozen dispose is
		external
			"IL signature (): System.Void use System.Windows.Forms.PaintEventArgs"
		alias
			"Dispose"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PaintEventArgs"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.PaintEventArgs"
		alias
			"Finalize"
		end

end -- class WINFORMS_PAINT_EVENT_ARGS
