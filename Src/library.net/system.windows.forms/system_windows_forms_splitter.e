indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Splitter"

external class
	SYSTEM_WINDOWS_FORMS_SPLITTER

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WINDOWS_FORMS_IMESSAGEFILTER
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_CONTROL
		redefine
			set_bounds_core,
			on_mouse_up,
			on_mouse_move,
			on_mouse_down,
			on_key_down,
			set_text,
			get_text,
			set_fore_color,
			get_fore_color,
			set_font,
			get_font,
			set_dock,
			get_dock,
			get_default_size,
			get_default_ime_mode,
			get_create_params,
			set_background_image,
			get_background_image,
			set_anchor,
			get_anchor,
			set_allow_drop,
			get_allow_drop,
			to_string
		end
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_splitter

feature {NONE} -- Initialization

	frozen make_splitter is
		external
			"IL creator use System.Windows.Forms.Splitter"
		end

feature -- Access

	frozen get_min_extra: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Splitter"
		alias
			"get_MinExtra"
		end

	get_background_image: SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.Splitter"
		alias
			"get_BackgroundImage"
		end

	get_font: SYSTEM_DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.Splitter"
		alias
			"get_Font"
		end

	get_allow_drop: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Splitter"
		alias
			"get_AllowDrop"
		end

	get_dock: SYSTEM_WINDOWS_FORMS_DOCKSTYLE is
		external
			"IL signature (): System.Windows.Forms.DockStyle use System.Windows.Forms.Splitter"
		alias
			"get_Dock"
		end

	frozen get_min_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Splitter"
		alias
			"get_MinSize"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Splitter"
		alias
			"get_Text"
		end

	frozen get_ime_mode_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.Splitter"
		alias
			"get_ImeMode"
		end

	frozen get_border_style: SYSTEM_WINDOWS_FORMS_BORDERSTYLE is
		external
			"IL signature (): System.Windows.Forms.BorderStyle use System.Windows.Forms.Splitter"
		alias
			"get_BorderStyle"
		end

	frozen get_tab_stop_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Splitter"
		alias
			"get_TabStop"
		end

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.Splitter"
		alias
			"get_ForeColor"
		end

	get_anchor: SYSTEM_WINDOWS_FORMS_ANCHORSTYLES is
		external
			"IL signature (): System.Windows.Forms.AnchorStyles use System.Windows.Forms.Splitter"
		alias
			"get_Anchor"
		end

	frozen get_split_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Splitter"
		alias
			"get_SplitPosition"
		end

feature -- Element Change

	frozen set_min_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Splitter"
		alias
			"set_MinSize"
		end

	set_allow_drop (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Splitter"
		alias
			"set_AllowDrop"
		end

	frozen remove_splitter_moved (value: SYSTEM_WINDOWS_FORMS_SPLITTEREVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.SplitterEventHandler): System.Void use System.Windows.Forms.Splitter"
		alias
			"remove_SplitterMoved"
		end

	frozen add_splitter_moved (value: SYSTEM_WINDOWS_FORMS_SPLITTEREVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.SplitterEventHandler): System.Void use System.Windows.Forms.Splitter"
		alias
			"add_SplitterMoved"
		end

	frozen remove_splitter_moving (value: SYSTEM_WINDOWS_FORMS_SPLITTEREVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.SplitterEventHandler): System.Void use System.Windows.Forms.Splitter"
		alias
			"remove_SplitterMoving"
		end

	set_anchor (value: SYSTEM_WINDOWS_FORMS_ANCHORSTYLES) is
		external
			"IL signature (System.Windows.Forms.AnchorStyles): System.Void use System.Windows.Forms.Splitter"
		alias
			"set_Anchor"
		end

	set_font (value: SYSTEM_DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.Splitter"
		alias
			"set_Font"
		end

	frozen remove_enter_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Splitter"
		alias
			"remove_Enter"
		end

	frozen set_split_position (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Splitter"
		alias
			"set_SplitPosition"
		end

	frozen set_border_style (value: SYSTEM_WINDOWS_FORMS_BORDERSTYLE) is
		external
			"IL signature (System.Windows.Forms.BorderStyle): System.Void use System.Windows.Forms.Splitter"
		alias
			"set_BorderStyle"
		end

	frozen set_tab_stop_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Splitter"
		alias
			"set_TabStop"
		end

	frozen add_key_press_key_press_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.Splitter"
		alias
			"add_KeyPress"
		end

	frozen add_splitter_moving (value: SYSTEM_WINDOWS_FORMS_SPLITTEREVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.SplitterEventHandler): System.Void use System.Windows.Forms.Splitter"
		alias
			"add_SplitterMoving"
		end

	frozen add_key_down_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Splitter"
		alias
			"add_KeyDown"
		end

	frozen remove_leave_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Splitter"
		alias
			"remove_Leave"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.Splitter"
		alias
			"set_ForeColor"
		end

	frozen remove_key_down_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Splitter"
		alias
			"remove_KeyDown"
		end

	frozen add_leave_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Splitter"
		alias
			"add_Leave"
		end

	frozen set_min_extra (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Splitter"
		alias
			"set_MinExtra"
		end

	set_dock (value: SYSTEM_WINDOWS_FORMS_DOCKSTYLE) is
		external
			"IL signature (System.Windows.Forms.DockStyle): System.Void use System.Windows.Forms.Splitter"
		alias
			"set_Dock"
		end

	frozen remove_key_press_key_press_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.Splitter"
		alias
			"remove_KeyPress"
		end

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.Splitter"
		alias
			"set_Text"
		end

	frozen add_key_up_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Splitter"
		alias
			"add_KeyUp"
		end

	frozen remove_key_up_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Splitter"
		alias
			"remove_KeyUp"
		end

	frozen set_ime_mode_ime_mode (value: SYSTEM_WINDOWS_FORMS_IMEMODE) is
		external
			"IL signature (System.Windows.Forms.ImeMode): System.Void use System.Windows.Forms.Splitter"
		alias
			"set_ImeMode"
		end

	frozen add_enter_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Splitter"
		alias
			"add_Enter"
		end

	set_background_image (value: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.Splitter"
		alias
			"set_BackgroundImage"
		end

feature -- Basic Operations

	frozen pre_filter_message (m: SYSTEM_WINDOWS_FORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.Splitter"
		alias
			"PreFilterMessage"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Splitter"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Splitter"
		alias
			"get_DefaultSize"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.Splitter"
		alias
			"get_CreateParams"
		end

	on_splitter_moving (sevent: SYSTEM_WINDOWS_FORMS_SPLITTEREVENTARGS) is
		external
			"IL signature (System.Windows.Forms.SplitterEventArgs): System.Void use System.Windows.Forms.Splitter"
		alias
			"OnSplitterMoving"
		end

	on_mouse_move (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.Splitter"
		alias
			"OnMouseMove"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: SYSTEM_WINDOWS_FORMS_BOUNDSSPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.Splitter"
		alias
			"SetBoundsCore"
		end

	get_default_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.Splitter"
		alias
			"get_DefaultImeMode"
		end

	on_splitter_moved (sevent: SYSTEM_WINDOWS_FORMS_SPLITTEREVENTARGS) is
		external
			"IL signature (System.Windows.Forms.SplitterEventArgs): System.Void use System.Windows.Forms.Splitter"
		alias
			"OnSplitterMoved"
		end

	on_mouse_up (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.Splitter"
		alias
			"OnMouseUp"
		end

	on_key_down (e: SYSTEM_WINDOWS_FORMS_KEYEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.Splitter"
		alias
			"OnKeyDown"
		end

	on_mouse_down (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.Splitter"
		alias
			"OnMouseDown"
		end

end -- class SYSTEM_WINDOWS_FORMS_SPLITTER
