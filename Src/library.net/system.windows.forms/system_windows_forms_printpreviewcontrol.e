indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.PrintPreviewControl"

external class
	SYSTEM_WINDOWS_FORMS_PRINTPREVIEWCONTROL

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_CONTROL
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
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_printpreviewcontrol

feature {NONE} -- Initialization

	frozen make_printpreviewcontrol is
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

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.PrintPreviewControl"
		alias
			"get_Text"
		end

	frozen get_document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT is
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

	frozen set_document (value: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"set_Document"
		end

	frozen add_start_page_changed (value: SYSTEM_EVENTHANDLER) is
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

	set_text (value: STRING) is
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

	frozen remove_start_page_changed (value: SYSTEM_EVENTHANDLER) is
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

	on_paint (pevent: SYSTEM_WINDOWS_FORMS_PAINTEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"OnPaint"
		end

	on_start_page_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"OnStartPageChanged"
		end

	on_resize (eventargs: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"OnResize"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.PrintPreviewControl"
		alias
			"WndProc"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.PrintPreviewControl"
		alias
			"get_CreateParams"
		end

end -- class SYSTEM_WINDOWS_FORMS_PRINTPREVIEWCONTROL
