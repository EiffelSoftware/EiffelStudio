indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.TextBoxBase"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_TEXT_BOX_BASE

inherit
	WINFORMS_CONTROL
		redefine
			wnd_proc,
			set_bounds_core,
			process_dialog_key,
			on_handle_destroyed,
			on_handle_created,
			on_font_changed,
			is_input_key,
			create_handle,
			set_text,
			get_text,
			set_fore_color,
			get_fore_color,
			get_default_size,
			get_create_params,
			set_background_image,
			get_background_image,
			set_back_color,
			get_back_color,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISYNCHRONIZE_INVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	WINFORMS_IWIN32_WINDOW

feature -- Access

	frozen get_selection_start: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TextBoxBase"
		alias
			"get_SelectionStart"
		end

	frozen get_preferred_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TextBoxBase"
		alias
			"get_PreferredHeight"
		end

	frozen get_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TextBoxBase"
		alias
			"get_ReadOnly"
		end

	get_background_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.TextBoxBase"
		alias
			"get_BackgroundImage"
		end

	get_auto_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TextBoxBase"
		alias
			"get_AutoSize"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TextBoxBase"
		alias
			"get_Text"
		end

	frozen get_border_style: WINFORMS_BORDER_STYLE is
		external
			"IL signature (): System.Windows.Forms.BorderStyle use System.Windows.Forms.TextBoxBase"
		alias
			"get_BorderStyle"
		end

	frozen get_lines: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Windows.Forms.TextBoxBase"
		alias
			"get_Lines"
		end

	frozen get_modified: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TextBoxBase"
		alias
			"get_Modified"
		end

	frozen get_word_wrap: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TextBoxBase"
		alias
			"get_WordWrap"
		end

	get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.TextBoxBase"
		alias
			"get_ForeColor"
		end

	frozen get_hide_selection: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TextBoxBase"
		alias
			"get_HideSelection"
		end

	get_multiline: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TextBoxBase"
		alias
			"get_Multiline"
		end

	get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.TextBoxBase"
		alias
			"get_BackColor"
		end

	frozen get_accepts_tab: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TextBoxBase"
		alias
			"get_AcceptsTab"
		end

	frozen get_can_undo: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TextBoxBase"
		alias
			"get_CanUndo"
		end

	get_selected_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TextBoxBase"
		alias
			"get_SelectedText"
		end

	get_max_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TextBoxBase"
		alias
			"get_MaxLength"
		end

	get_text_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TextBoxBase"
		alias
			"get_TextLength"
		end

	get_selection_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TextBoxBase"
		alias
			"get_SelectionLength"
		end

feature -- Element Change

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_Text"
		end

	frozen add_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"add_Click"
		end

	frozen remove_accepts_tab_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"remove_AcceptsTabChanged"
		end

	frozen add_auto_size_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"add_AutoSizeChanged"
		end

	frozen add_hide_selection_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"add_HideSelectionChanged"
		end

	frozen set_selection_start (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_SelectionStart"
		end

	frozen remove_modified_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"remove_ModifiedChanged"
		end

	frozen remove_read_only_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"remove_ReadOnlyChanged"
		end

	frozen set_accepts_tab (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_AcceptsTab"
		end

	frozen remove_auto_size_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"remove_AutoSizeChanged"
		end

	set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_BackColor"
		end

	frozen add_border_style_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"add_BorderStyleChanged"
		end

	set_selected_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_SelectedText"
		end

	frozen add_accepts_tab_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"add_AcceptsTabChanged"
		end

	frozen set_read_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_ReadOnly"
		end

	frozen set_hide_selection (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_HideSelection"
		end

	frozen remove_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"remove_Click"
		end

	set_max_length (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_MaxLength"
		end

	frozen set_modified (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_Modified"
		end

	set_background_image (value: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_BackgroundImage"
		end

	frozen set_word_wrap (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_WordWrap"
		end

	set_auto_size (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_AutoSize"
		end

	frozen add_read_only_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"add_ReadOnlyChanged"
		end

	frozen remove_multiline_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"remove_MultilineChanged"
		end

	frozen set_border_style (value: WINFORMS_BORDER_STYLE) is
		external
			"IL signature (System.Windows.Forms.BorderStyle): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_BorderStyle"
		end

	set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_ForeColor"
		end

	frozen add_multiline_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"add_MultilineChanged"
		end

	frozen set_lines (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_Lines"
		end

	set_multiline (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_Multiline"
		end

	frozen remove_border_style_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"remove_BorderStyleChanged"
		end

	set_selection_length (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"set_SelectionLength"
		end

	frozen add_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"add_Paint"
		end

	frozen remove_hide_selection_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"remove_HideSelectionChanged"
		end

	frozen add_modified_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"add_ModifiedChanged"
		end

	frozen remove_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"remove_Paint"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TextBoxBase"
		alias
			"ToString"
		end

	frozen clear_undo is
		external
			"IL signature (): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"ClearUndo"
		end

	frozen append_text (text: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"AppendText"
		end

	frozen select_all is
		external
			"IL signature (): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"SelectAll"
		end

	frozen cut is
		external
			"IL signature (): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"Cut"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"Clear"
		end

	frozen undo is
		external
			"IL signature (): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"Undo"
		end

	frozen paste is
		external
			"IL signature (): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"Paste"
		end

	frozen copy_ is
		external
			"IL signature (): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"Copy"
		end

	frozen select__int32 (start: INTEGER; length: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"Select"
		end

	frozen scroll_to_caret is
		external
			"IL signature (): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"ScrollToCaret"
		end

feature {NONE} -- Implementation

	on_border_style_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"OnBorderStyleChanged"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.TextBoxBase"
		alias
			"get_CreateParams"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"WndProc"
		end

	create_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"CreateHandle"
		end

	on_handle_created (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"OnHandleCreated"
		end

	on_modified_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"OnModifiedChanged"
		end

	on_multiline_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"OnMultilineChanged"
		end

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.TextBoxBase"
		alias
			"get_DefaultSize"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: WINFORMS_BOUNDS_SPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"SetBoundsCore"
		end

	on_read_only_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"OnReadOnlyChanged"
		end

	on_accepts_tab_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"OnAcceptsTabChanged"
		end

	on_hide_selection_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"OnHideSelectionChanged"
		end

	process_dialog_key (key_data: WINFORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.TextBoxBase"
		alias
			"ProcessDialogKey"
		end

	on_font_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"OnFontChanged"
		end

	on_handle_destroyed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"OnHandleDestroyed"
		end

	on_auto_size_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TextBoxBase"
		alias
			"OnAutoSizeChanged"
		end

	is_input_key (key_data: WINFORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.TextBoxBase"
		alias
			"IsInputKey"
		end

end -- class WINFORMS_TEXT_BOX_BASE
