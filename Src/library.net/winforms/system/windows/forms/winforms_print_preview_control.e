indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.PrintPreviewControl"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_PRINT_PREVIEW_CONTROL

inherit
	WINFORMS_CONTROL
		redefine
			wnd_proc,
			reset_fore_color,
			reset_back_color,
			on_resize,
			on_paint,
			set_text,
			get_text,
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
	make_winforms_print_preview_control

feature {NONE} -- Initialization

	frozen make_winforms_print_preview_control is
		external
			"IL creator use System.Windows.Forms.PrintPreviewControl"
		end

feature -- Access

	frozen get_start_page: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.PrintPreviewControl"
		alias
			"get_StartPage"
		end

	frozen get_columns: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.PrintPreviewControl"
		alias
			"get_Columns"
		end

	frozen get_auto_zoom: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewControl"
		alias
			"get_AutoZoom"
		end

	frozen get_zoom: DOUBLE is
		external
			"IL signature (): System.Double use System.Windows.Forms.PrintPreviewControl"
		alias
			"get_Zoom"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.PrintPreviewControl"
		alias
			"get_Text"
		end

	frozen get_document: DRAWING_PRINT_DOCUMENT is
		external
			"IL signature (): System.Drawing.Printing.PrintDocument use System.Windows.Forms.PrintPreviewControl"
		alias
			"get_Document"
		end

	frozen get_use_anti_alias: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewControl"
		alias
			"get_UseAntiAlias"
		end

	frozen get_rows: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.PrintPreviewControl"
		alias
			"get_Rows"
		end

feature -- Element Change

	frozen set_start_page (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"set_StartPage"
		end

	frozen set_auto_zoom (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"set_AutoZoom"
		end

	frozen set_zoom (value: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"set_Zoom"
		end

	frozen set_columns (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"set_Columns"
		end

	frozen set_document (value: DRAWING_PRINT_DOCUMENT) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"set_Document"
		end

	frozen add_start_page_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"add_StartPageChanged"
		end

	frozen set_use_anti_alias (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"set_UseAntiAlias"
		end

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"set_Text"
		end

	frozen set_rows (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"set_Rows"
		end

	frozen remove_start_page_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"remove_StartPageChanged"
		end

feature -- Basic Operations

	frozen invalidate_preview is
		external
			"IL signature (): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"InvalidatePreview"
		end

	reset_fore_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"ResetForeColor"
		end

	reset_back_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"ResetBackColor"
		end

feature {NONE} -- Implementation

	on_paint (pevent: WINFORMS_PAINT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"OnPaint"
		end

	on_start_page_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"OnStartPageChanged"
		end

	on_resize (eventargs: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"OnResize"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"WndProc"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.PrintPreviewControl"
		alias
			"get_CreateParams"
		end

end -- class WINFORMS_PRINT_PREVIEW_CONTROL
