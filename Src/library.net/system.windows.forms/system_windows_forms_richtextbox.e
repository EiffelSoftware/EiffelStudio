indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.RichTextBox"

external class
	SYSTEM_WINDOWS_FORMS_RICHTEXTBOX

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WINDOWS_FORMS_TEXTBOXBASE
		redefine
			set_selection_length,
			get_selection_length,
			set_selected_text,
			get_selected_text,
			set_multiline,
			get_multiline,
			set_max_length,
			get_max_length,
			set_auto_size,
			get_auto_size,
			wnd_proc,
			on_style_changed,
			on_handle_destroyed,
			on_handle_created,
			on_text_changed,
			on_right_to_left_changed,
			on_context_menu_changed,
			on_back_color_changed,
			set_text,
			get_text,
			set_fore_color,
			get_fore_color,
			set_font,
			get_font,
			get_default_size,
			get_create_params,
			set_background_image,
			get_background_image,
			set_allow_drop,
			get_allow_drop
		end
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_richtextbox

feature {NONE} -- Initialization

	frozen make_richtextbox is
		external
			"IL creator use System.Windows.Forms.RichTextBox"
		end

feature -- Access

	frozen get_detect_urls: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.RichTextBox"
		alias
			"get_DetectUrls"
		end

	frozen get_scroll_bars: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXSCROLLBARS is
		external
			"IL signature (): System.Windows.Forms.RichTextBoxScrollBars use System.Windows.Forms.RichTextBox"
		alias
			"get_ScrollBars"
		end

	frozen get_can_redo: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.RichTextBox"
		alias
			"get_CanRedo"
		end

	get_background_image: SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.RichTextBox"
		alias
			"get_BackgroundImage"
		end

	frozen get_right_margin: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"get_RightMargin"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.RichTextBox"
		alias
			"get_Text"
		end

	frozen get_auto_word_selection: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.RichTextBox"
		alias
			"get_AutoWordSelection"
		end

	get_allow_drop: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.RichTextBox"
		alias
			"get_AllowDrop"
		end

	frozen get_show_selection_margin: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.RichTextBox"
		alias
			"get_ShowSelectionMargin"
		end

	frozen get_undo_action_name: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.RichTextBox"
		alias
			"get_UndoActionName"
		end

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.RichTextBox"
		alias
			"get_ForeColor"
		end

	get_max_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"get_MaxLength"
		end

	frozen get_selection_tabs: ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Windows.Forms.RichTextBox"
		alias
			"get_SelectionTabs"
		end

	frozen get_selection_alignment: SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT is
		external
			"IL signature (): System.Windows.Forms.HorizontalAlignment use System.Windows.Forms.RichTextBox"
		alias
			"get_SelectionAlignment"
		end

	frozen get_selection_hanging_indent: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"get_SelectionHangingIndent"
		end

	get_font: SYSTEM_DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.RichTextBox"
		alias
			"get_Font"
		end

	frozen get_selection_protected: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.RichTextBox"
		alias
			"get_SelectionProtected"
		end

	get_multiline: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.RichTextBox"
		alias
			"get_Multiline"
		end

	frozen get_zoom_factor: REAL is
		external
			"IL signature (): System.Single use System.Windows.Forms.RichTextBox"
		alias
			"get_ZoomFactor"
		end

	frozen get_selected_rtf: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.RichTextBox"
		alias
			"get_SelectedRtf"
		end

	frozen get_selection_type: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXSELECTIONTYPES is
		external
			"IL signature (): System.Windows.Forms.RichTextBoxSelectionTypes use System.Windows.Forms.RichTextBox"
		alias
			"get_SelectionType"
		end

	frozen get_selection_bullet: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.RichTextBox"
		alias
			"get_SelectionBullet"
		end

	get_auto_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.RichTextBox"
		alias
			"get_AutoSize"
		end

	get_selected_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.RichTextBox"
		alias
			"get_SelectedText"
		end

	frozen get_redo_action_name: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.RichTextBox"
		alias
			"get_RedoActionName"
		end

	frozen get_selection_font: SYSTEM_DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.RichTextBox"
		alias
			"get_SelectionFont"
		end

	frozen get_selection_char_offset: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"get_SelectionCharOffset"
		end

	frozen get_bullet_indent: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"get_BulletIndent"
		end

	frozen get_selection_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.RichTextBox"
		alias
			"get_SelectionColor"
		end

	frozen get_selection_indent: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"get_SelectionIndent"
		end

	get_selection_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"get_SelectionLength"
		end

	frozen get_rtf: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.RichTextBox"
		alias
			"get_Rtf"
		end

	frozen get_selection_right_indent: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"get_SelectionRightIndent"
		end

feature -- Element Change

	frozen add_double_click_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"add_DoubleClick"
		end

	frozen remove_drag_leave_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"remove_DragLeave"
		end

	frozen add_hscroll (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"add_HScroll"
		end

	frozen set_selection_char_offset (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_SelectionCharOffset"
		end

	frozen set_selected_rtf (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_SelectedRtf"
		end

	frozen add_drag_enter_drag_event_handler (value: SYSTEM_WINDOWS_FORMS_DRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"add_DragEnter"
		end

	frozen set_selection_indent (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_SelectionIndent"
		end

	frozen add_link_clicked (value: SYSTEM_WINDOWS_FORMS_LINKCLICKEDEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.LinkClickedEventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"add_LinkClicked"
		end

	frozen add_drag_leave_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"add_DragLeave"
		end

	frozen set_selection_bullet (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_SelectionBullet"
		end

	frozen set_selection_alignment (value: SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT) is
		external
			"IL signature (System.Windows.Forms.HorizontalAlignment): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_SelectionAlignment"
		end

	frozen set_show_selection_margin (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_ShowSelectionMargin"
		end

	frozen remove_give_feedback_give_feedback_event_handler (value: SYSTEM_WINDOWS_FORMS_GIVEFEEDBACKEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.GiveFeedbackEventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"remove_GiveFeedback"
		end

	frozen add_ime_change (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"add_ImeChange"
		end

	frozen remove_vscroll (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"remove_VScroll"
		end

	frozen set_zoom_factor (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_ZoomFactor"
		end

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_Text"
		end

	frozen remove_drag_enter_drag_event_handler (value: SYSTEM_WINDOWS_FORMS_DRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"remove_DragEnter"
		end

	frozen add_protected (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"add_Protected"
		end

	frozen add_drag_over_drag_event_handler (value: SYSTEM_WINDOWS_FORMS_DRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"add_DragOver"
		end

	set_selected_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_SelectedText"
		end

	set_font (value: SYSTEM_DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_Font"
		end

	frozen remove_query_continue_drag_query_continue_drag_event_handler (value: SYSTEM_WINDOWS_FORMS_QUERYCONTINUEDRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.QueryContinueDragEventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"remove_QueryContinueDrag"
		end

	frozen remove_ime_change (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"remove_ImeChange"
		end

	frozen remove_hscroll (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"remove_HScroll"
		end

	frozen set_selection_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_SelectionColor"
		end

	frozen add_drag_drop_drag_event_handler (value: SYSTEM_WINDOWS_FORMS_DRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"add_DragDrop"
		end

	frozen set_detect_urls (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_DetectUrls"
		end

	frozen remove_double_click_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"remove_DoubleClick"
		end

	frozen set_rtf (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_Rtf"
		end

	frozen remove_link_clicked (value: SYSTEM_WINDOWS_FORMS_LINKCLICKEDEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.LinkClickedEventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"remove_LinkClicked"
		end

	set_background_image (value: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_BackgroundImage"
		end

	frozen remove_contents_resized (value: SYSTEM_WINDOWS_FORMS_CONTENTSRESIZEDEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ContentsResizedEventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"remove_ContentsResized"
		end

	set_auto_size (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_AutoSize"
		end

	frozen set_selection_tabs (value: ARRAY [INTEGER]) is
		external
			"IL signature (System.Int32[]): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_SelectionTabs"
		end

	frozen set_bullet_indent (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_BulletIndent"
		end

	frozen remove_drag_over_drag_event_handler (value: SYSTEM_WINDOWS_FORMS_DRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"remove_DragOver"
		end

	frozen add_selection_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"add_SelectionChanged"
		end

	frozen set_selection_hanging_indent (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_SelectionHangingIndent"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_ForeColor"
		end

	frozen set_selection_right_indent (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_SelectionRightIndent"
		end

	frozen add_query_continue_drag_query_continue_drag_event_handler (value: SYSTEM_WINDOWS_FORMS_QUERYCONTINUEDRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.QueryContinueDragEventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"add_QueryContinueDrag"
		end

	set_max_length (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_MaxLength"
		end

	frozen remove_selection_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"remove_SelectionChanged"
		end

	frozen add_vscroll (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"add_VScroll"
		end

	frozen set_scroll_bars (value: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXSCROLLBARS) is
		external
			"IL signature (System.Windows.Forms.RichTextBoxScrollBars): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_ScrollBars"
		end

	frozen set_auto_word_selection (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_AutoWordSelection"
		end

	frozen remove_protected (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"remove_Protected"
		end

	set_multiline (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_Multiline"
		end

	set_selection_length (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_SelectionLength"
		end

	frozen add_give_feedback_give_feedback_event_handler (value: SYSTEM_WINDOWS_FORMS_GIVEFEEDBACKEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.GiveFeedbackEventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"add_GiveFeedback"
		end

	frozen set_right_margin (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_RightMargin"
		end

	frozen add_contents_resized (value: SYSTEM_WINDOWS_FORMS_CONTENTSRESIZEDEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ContentsResizedEventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"add_ContentsResized"
		end

	set_allow_drop (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_AllowDrop"
		end

	frozen set_selection_protected (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_SelectionProtected"
		end

	frozen set_selection_font (value: SYSTEM_DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"set_SelectionFont"
		end

	frozen remove_drag_drop_drag_event_handler (value: SYSTEM_WINDOWS_FORMS_DRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"remove_DragDrop"
		end

feature -- Basic Operations

	frozen find_string (str: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"Find"
		end

	frozen save_file (path: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"SaveFile"
		end

	frozen load_file (path: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"LoadFile"
		end

	frozen can_paste (clip_format: FORMAT_IN_SYSTEM_WINDOWS_FORMS_DATAFORMATS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.DataFormats+Format): System.Boolean use System.Windows.Forms.RichTextBox"
		alias
			"CanPaste"
		end

	frozen redo is
		external
			"IL signature (): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"Redo"
		end

	frozen load_file_string_rich_text_box_stream_type (path: STRING; file_type: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXSTREAMTYPE) is
		external
			"IL signature (System.String, System.Windows.Forms.RichTextBoxStreamType): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"LoadFile"
		end

	frozen get_position_from_char_index (index: INTEGER): SYSTEM_DRAWING_POINT is
		external
			"IL signature (System.Int32): System.Drawing.Point use System.Windows.Forms.RichTextBox"
		alias
			"GetPositionFromCharIndex"
		end

	frozen find_string_int32_int32_rich_text_box_finds (str: STRING; start: INTEGER; end_: INTEGER; options: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXFINDS): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Int32, System.Windows.Forms.RichTextBoxFinds): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"Find"
		end

	frozen find (character_set: ARRAY [CHARACTER]): INTEGER is
		external
			"IL signature (System.Char[]): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"Find"
		end

	frozen save_file_stream (data: SYSTEM_IO_STREAM; file_type: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXSTREAMTYPE) is
		external
			"IL signature (System.IO.Stream, System.Windows.Forms.RichTextBoxStreamType): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"SaveFile"
		end

	frozen find_string_int32_rich_text_box_finds (str: STRING; start: INTEGER; options: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXFINDS): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Windows.Forms.RichTextBoxFinds): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"Find"
		end

	frozen save_file_string_rich_text_box_stream_type (path: STRING; file_type: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXSTREAMTYPE) is
		external
			"IL signature (System.String, System.Windows.Forms.RichTextBoxStreamType): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"SaveFile"
		end

	frozen get_line_from_char_index (index: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"GetLineFromCharIndex"
		end

	frozen find_array_char_int32_int32 (character_set: ARRAY [CHARACTER]; start: INTEGER; end_: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"Find"
		end

	frozen find_array_char_int32 (character_set: ARRAY [CHARACTER]; start: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"Find"
		end

	frozen get_char_index_from_position (pt: SYSTEM_DRAWING_POINT): INTEGER is
		external
			"IL signature (System.Drawing.Point): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"GetCharIndexFromPosition"
		end

	frozen load_file_stream (data: SYSTEM_IO_STREAM; file_type: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXSTREAMTYPE) is
		external
			"IL signature (System.IO.Stream, System.Windows.Forms.RichTextBoxStreamType): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"LoadFile"
		end

	frozen paste_format (clip_format: FORMAT_IN_SYSTEM_WINDOWS_FORMS_DATAFORMATS) is
		external
			"IL signature (System.Windows.Forms.DataFormats+Format): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"Paste"
		end

	frozen get_char_from_position (pt: SYSTEM_DRAWING_POINT): CHARACTER is
		external
			"IL signature (System.Drawing.Point): System.Char use System.Windows.Forms.RichTextBox"
		alias
			"GetCharFromPosition"
		end

	frozen find_string_rich_text_box_finds (str: STRING; options: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXFINDS): INTEGER is
		external
			"IL signature (System.String, System.Windows.Forms.RichTextBoxFinds): System.Int32 use System.Windows.Forms.RichTextBox"
		alias
			"Find"
		end

feature {NONE} -- Implementation

	create_rich_edit_ole_callback: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.RichTextBox"
		alias
			"CreateRichEditOleCallback"
		end

	on_right_to_left_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"OnRightToLeftChanged"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.RichTextBox"
		alias
			"get_CreateParams"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"WndProc"
		end

	on_selection_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"OnSelectionChanged"
		end

	on_handle_created (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"OnHandleCreated"
		end

	on_back_color_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"OnBackColorChanged"
		end

	on_contents_resized (e: SYSTEM_WINDOWS_FORMS_CONTENTSRESIZEDEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.ContentsResizedEventArgs): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"OnContentsResized"
		end

	on_ime_change (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"OnImeChange"
		end

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.RichTextBox"
		alias
			"get_DefaultSize"
		end

	on_protected (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"OnProtected"
		end

	on_hscroll (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"OnHScroll"
		end

	on_text_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"OnTextChanged"
		end

	on_vscroll (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"OnVScroll"
		end

	on_style_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"OnStyleChanged"
		end

	on_context_menu_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"OnContextMenuChanged"
		end

	on_handle_destroyed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"OnHandleDestroyed"
		end

	on_link_clicked (e: SYSTEM_WINDOWS_FORMS_LINKCLICKEDEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.LinkClickedEventArgs): System.Void use System.Windows.Forms.RichTextBox"
		alias
			"OnLinkClicked"
		end

end -- class SYSTEM_WINDOWS_FORMS_RICHTEXTBOX
