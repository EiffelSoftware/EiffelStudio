indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ToolTip"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_TOOL_TIP

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean,
			finalize,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_IEXTENDER_PROVIDER

create
	make_winforms_tool_tip,
	make_winforms_tool_tip_1

feature {NONE} -- Initialization

	frozen make_winforms_tool_tip (cont: SYSTEM_DLL_ICONTAINER) is
		external
			"IL creator signature (System.ComponentModel.IContainer) use System.Windows.Forms.ToolTip"
		end

	frozen make_winforms_tool_tip_1 is
		external
			"IL creator use System.Windows.Forms.ToolTip"
		end

feature -- Access

	frozen get_initial_delay: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ToolTip"
		alias
			"get_InitialDelay"
		end

	frozen get_auto_pop_delay: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ToolTip"
		alias
			"get_AutoPopDelay"
		end

	frozen get_reshow_delay: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ToolTip"
		alias
			"get_ReshowDelay"
		end

	frozen get_show_always: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ToolTip"
		alias
			"get_ShowAlways"
		end

	frozen get_automatic_delay: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ToolTip"
		alias
			"get_AutomaticDelay"
		end

	frozen get_active: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ToolTip"
		alias
			"get_Active"
		end

feature -- Element Change

	frozen set_auto_pop_delay (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ToolTip"
		alias
			"set_AutoPopDelay"
		end

	frozen set_automatic_delay (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ToolTip"
		alias
			"set_AutomaticDelay"
		end

	frozen set_initial_delay (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ToolTip"
		alias
			"set_InitialDelay"
		end

	frozen set_active (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ToolTip"
		alias
			"set_Active"
		end

	frozen set_show_always (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ToolTip"
		alias
			"set_ShowAlways"
		end

	frozen set_reshow_delay (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ToolTip"
		alias
			"set_ReshowDelay"
		end

feature -- Basic Operations

	frozen can_extend (target: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ToolTip"
		alias
			"CanExtend"
		end

	frozen set_tool_tip (control: WINFORMS_CONTROL; caption: SYSTEM_STRING) is
		external
			"IL signature (System.Windows.Forms.Control, System.String): System.Void use System.Windows.Forms.ToolTip"
		alias
			"SetToolTip"
		end

	frozen get_tool_tip (control: WINFORMS_CONTROL): SYSTEM_STRING is
		external
			"IL signature (System.Windows.Forms.Control): System.String use System.Windows.Forms.ToolTip"
		alias
			"GetToolTip"
		end

	frozen remove_all is
		external
			"IL signature (): System.Void use System.Windows.Forms.ToolTip"
		alias
			"RemoveAll"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ToolTip"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ToolTip"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.ToolTip"
		alias
			"Finalize"
		end

end -- class WINFORMS_TOOL_TIP
