indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.HScrollBar"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_HSCROLL_BAR

inherit
	WINFORMS_SCROLL_BAR
		redefine
			get_default_size,
			get_create_params
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISYNCHRONIZE_INVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	WINFORMS_IWIN32_WINDOW

create
	make_winforms_hscroll_bar

feature {NONE} -- Initialization

	frozen make_winforms_hscroll_bar is
		external
			"IL creator use System.Windows.Forms.HScrollBar"
		end

feature {NONE} -- Implementation

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.HScrollBar"
		alias
			"get_DefaultSize"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.HScrollBar"
		alias
			"get_CreateParams"
		end

end -- class WINFORMS_HSCROLL_BAR
