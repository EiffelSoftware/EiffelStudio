indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.VScrollBar"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_VSCROLL_BAR

inherit
	WINFORMS_SCROLL_BAR
		redefine
			set_right_to_left,
			get_right_to_left,
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
	make_winforms_vscroll_bar

feature {NONE} -- Initialization

	frozen make_winforms_vscroll_bar is
		external
			"IL creator use System.Windows.Forms.VScrollBar"
		end

feature -- Access

	get_right_to_left: WINFORMS_RIGHT_TO_LEFT is
		external
			"IL signature (): System.Windows.Forms.RightToLeft use System.Windows.Forms.VScrollBar"
		alias
			"get_RightToLeft"
		end

feature -- Element Change

	set_right_to_left (value: WINFORMS_RIGHT_TO_LEFT) is
		external
			"IL signature (System.Windows.Forms.RightToLeft): System.Void use System.Windows.Forms.VScrollBar"
		alias
			"set_RightToLeft"
		end

feature {NONE} -- Implementation

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.VScrollBar"
		alias
			"get_DefaultSize"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.VScrollBar"
		alias
			"get_CreateParams"
		end

end -- class WINFORMS_VSCROLL_BAR
