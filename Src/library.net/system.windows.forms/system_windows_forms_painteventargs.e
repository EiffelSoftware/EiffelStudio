indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.PaintEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_PAINTEVENTARGS

inherit
	SYSTEM_EVENTARGS
		redefine
			finalize
		end
	SYSTEM_IDISPOSABLE

create
	make_painteventargs

feature {NONE} -- Initialization

	frozen make_painteventargs (graphics: SYSTEM_DRAWING_GRAPHICS; clip_rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.Drawing.Graphics, System.Drawing.Rectangle) use System.Windows.Forms.PaintEventArgs"
		end

feature -- Access

	frozen get_graphics: SYSTEM_DRAWING_GRAPHICS is
		external
			"IL signature (): System.Drawing.Graphics use System.Windows.Forms.PaintEventArgs"
		alias
			"get_Graphics"
		end

	frozen get_clip_rectangle: SYSTEM_DRAWING_RECTANGLE is
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

end -- class SYSTEM_WINDOWS_FORMS_PAINTEVENTARGS
