indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.TabPage"

external class
	SYSTEM_WINDOWS_FORMS_TABPAGE

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_PANEL
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
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_tabpage,
	make_tabpage_1

feature {NONE} -- Initialization

	frozen make_tabpage is
		external
			"IL creator use System.Windows.Forms.TabPage"
		end

	frozen make_tabpage_1 (text: STRING) is
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

	get_dock: SYSTEM_WINDOWS_FORMS_DOCKSTYLE is
		external
			"IL signature (): System.Windows.Forms.DockStyle use System.Windows.Forms.TabPage"
		alias
			"get_Dock"
		end

	frozen get_tool_tip_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TabPage"
		alias
			"get_ToolTipText"
		end

	get_text: STRING is
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

	get_anchor: SYSTEM_WINDOWS_FORMS_ANCHORSTYLES is
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

	set_anchor (value: SYSTEM_WINDOWS_FORMS_ANCHORSTYLES) is
		external
			"IL signature (System.Windows.Forms.AnchorStyles): System.Void use System.Windows.Forms.TabPage"
		alias
			"set_Anchor"
		end

	frozen set_tool_tip_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.TabPage"
		alias
			"set_ToolTipText"
		end

	set_dock (value: SYSTEM_WINDOWS_FORMS_DOCKSTYLE) is
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

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.TabPage"
		alias
			"set_Text"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TabPage"
		alias
			"ToString"
		end

	frozen get_tab_page_of_component (comp: ANY): SYSTEM_WINDOWS_FORMS_TABPAGE is
		external
			"IL static signature (System.Object): System.Windows.Forms.TabPage use System.Windows.Forms.TabPage"
		alias
			"GetTabPageOfComponent"
		end

feature {NONE} -- Implementation

	create_controls_instance: CONTROLCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control+ControlCollection use System.Windows.Forms.TabPage"
		alias
			"CreateControlsInstance"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: SYSTEM_WINDOWS_FORMS_BOUNDSSPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.TabPage"
		alias
			"SetBoundsCore"
		end

end -- class SYSTEM_WINDOWS_FORMS_TABPAGE
