indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.TabPage"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_TAB_PAGE

inherit
	WINFORMS_PANEL
		redefine
			set_bounds_core,
			create_controls_instance,
			set_text,
			get_text,
			set_dock,
			get_dock,
			set_anchor,
			get_anchor,
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

create
	make_winforms_tab_page,
	make_winforms_tab_page_1

feature {NONE} -- Initialization

	frozen make_winforms_tab_page is
		external
			"IL creator use System.Windows.Forms.TabPage"
		end

	frozen make_winforms_tab_page_1 (text: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.TabPage"
		end

feature -- Access

	frozen get_visible_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TabPage"
		alias
			"get_Visible"
		end

	frozen get_enabled_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TabPage"
		alias
			"get_Enabled"
		end

	get_dock: WINFORMS_DOCK_STYLE is
		external
			"IL signature (): System.Windows.Forms.DockStyle use System.Windows.Forms.TabPage"
		alias
			"get_Dock"
		end

	frozen get_tool_tip_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TabPage"
		alias
			"get_ToolTipText"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TabPage"
		alias
			"get_Text"
		end

	frozen get_image_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TabPage"
		alias
			"get_ImageIndex"
		end

	get_anchor: WINFORMS_ANCHOR_STYLES is
		external
			"IL signature (): System.Windows.Forms.AnchorStyles use System.Windows.Forms.TabPage"
		alias
			"get_Anchor"
		end

	frozen get_tab_index_int32: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TabPage"
		alias
			"get_TabIndex"
		end

	frozen get_tab_stop_boolean2: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TabPage"
		alias
			"get_TabStop"
		end

feature -- Element Change

	frozen set_tab_stop_boolean2 (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TabPage"
		alias
			"set_TabStop"
		end

	frozen set_enabled_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TabPage"
		alias
			"set_Enabled"
		end

	frozen set_visible_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TabPage"
		alias
			"set_Visible"
		end

	set_anchor (value: WINFORMS_ANCHOR_STYLES) is
		external
			"IL signature (System.Windows.Forms.AnchorStyles): System.Void use System.Windows.Forms.TabPage"
		alias
			"set_Anchor"
		end

	frozen set_tool_tip_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.TabPage"
		alias
			"set_ToolTipText"
		end

	set_dock (value: WINFORMS_DOCK_STYLE) is
		external
			"IL signature (System.Windows.Forms.DockStyle): System.Void use System.Windows.Forms.TabPage"
		alias
			"set_Dock"
		end

	frozen set_tab_index_int32 (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TabPage"
		alias
			"set_TabIndex"
		end

	frozen set_image_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TabPage"
		alias
			"set_ImageIndex"
		end

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.TabPage"
		alias
			"set_Text"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TabPage"
		alias
			"ToString"
		end

	frozen get_tab_page_of_component (comp: SYSTEM_OBJECT): WINFORMS_TAB_PAGE is
		external
			"IL static signature (System.Object): System.Windows.Forms.TabPage use System.Windows.Forms.TabPage"
		alias
			"GetTabPageOfComponent"
		end

feature {NONE} -- Implementation

	create_controls_instance: WINFORMS_CONTROL_COLLECTION_IN_WINFORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control+ControlCollection use System.Windows.Forms.TabPage"
		alias
			"CreateControlsInstance"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: WINFORMS_BOUNDS_SPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.TabPage"
		alias
			"SetBoundsCore"
		end

end -- class WINFORMS_TAB_PAGE
