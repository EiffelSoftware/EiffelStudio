indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.HScrollBar"

external class
	SYSTEM_WINDOWS_FORMS_HSCROLLBAR

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_SCROLLBAR
		redefine
			get_default_size,
			get_create_params
		end
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_hscrollbar

feature {NONE} -- Initialization

	frozen make_hscrollbar is
		external
			"IL creator use System.Windows.Forms.HScrollBar"
		end

feature {NONE} -- Implementation

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.HScrollBar"
		alias
			"get_DefaultSize"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.HScrollBar"
		alias
			"get_CreateParams"
		end

end -- class SYSTEM_WINDOWS_FORMS_HSCROLLBAR
