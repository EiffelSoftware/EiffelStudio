indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.FontDialog"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_FONT_DIALOG

inherit
	WINFORMS_COMMON_DIALOG
		redefine
			hook_proc,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_winforms_font_dialog

feature {NONE} -- Initialization

	frozen make_winforms_font_dialog is
		external
			"IL creator use System.Windows.Forms.FontDialog"
		end

feature -- Access

	frozen get_allow_simulations: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FontDialog"
		alias
			"get_AllowSimulations"
		end

	frozen get_font: DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.FontDialog"
		alias
			"get_Font"
		end

	frozen get_font_must_exist: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FontDialog"
		alias
			"get_FontMustExist"
		end

	frozen get_allow_vertical_fonts: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FontDialog"
		alias
			"get_AllowVerticalFonts"
		end

	frozen get_allow_script_change: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FontDialog"
		alias
			"get_AllowScriptChange"
		end

	frozen get_min_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.FontDialog"
		alias
			"get_MinSize"
		end

	frozen get_fixed_pitch_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FontDialog"
		alias
			"get_FixedPitchOnly"
		end

	frozen get_max_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.FontDialog"
		alias
			"get_MaxSize"
		end

	frozen get_show_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FontDialog"
		alias
			"get_ShowColor"
		end

	frozen get_show_apply: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FontDialog"
		alias
			"get_ShowApply"
		end

	frozen get_allow_vector_fonts: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FontDialog"
		alias
			"get_AllowVectorFonts"
		end

	frozen get_scripts_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FontDialog"
		alias
			"get_ScriptsOnly"
		end

	frozen get_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.FontDialog"
		alias
			"get_Color"
		end

	frozen get_show_help: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FontDialog"
		alias
			"get_ShowHelp"
		end

	frozen get_show_effects: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FontDialog"
		alias
			"get_ShowEffects"
		end

feature -- Element Change

	frozen set_min_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.FontDialog"
		alias
			"set_MinSize"
		end

	frozen set_show_help (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FontDialog"
		alias
			"set_ShowHelp"
		end

	frozen set_allow_vertical_fonts (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FontDialog"
		alias
			"set_AllowVerticalFonts"
		end

	frozen set_font (value: DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.FontDialog"
		alias
			"set_Font"
		end

	frozen set_max_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.FontDialog"
		alias
			"set_MaxSize"
		end

	frozen set_fixed_pitch_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FontDialog"
		alias
			"set_FixedPitchOnly"
		end

	frozen set_allow_script_change (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FontDialog"
		alias
			"set_AllowScriptChange"
		end

	frozen set_show_color (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FontDialog"
		alias
			"set_ShowColor"
		end

	frozen set_show_effects (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FontDialog"
		alias
			"set_ShowEffects"
		end

	frozen set_allow_vector_fonts (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FontDialog"
		alias
			"set_AllowVectorFonts"
		end

	frozen set_show_apply (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FontDialog"
		alias
			"set_ShowApply"
		end

	frozen set_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.FontDialog"
		alias
			"set_Color"
		end

	frozen add_apply (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.FontDialog"
		alias
			"add_Apply"
		end

	frozen set_allow_simulations (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FontDialog"
		alias
			"set_AllowSimulations"
		end

	frozen set_font_must_exist (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FontDialog"
		alias
			"set_FontMustExist"
		end

	frozen set_scripts_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FontDialog"
		alias
			"set_ScriptsOnly"
		end

	frozen remove_apply (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.FontDialog"
		alias
			"remove_Apply"
		end

feature -- Basic Operations

	reset is
		external
			"IL signature (): System.Void use System.Windows.Forms.FontDialog"
		alias
			"Reset"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.FontDialog"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	run_dialog (h_wnd_owner: POINTER): BOOLEAN is
		external
			"IL signature (System.IntPtr): System.Boolean use System.Windows.Forms.FontDialog"
		alias
			"RunDialog"
		end

	on_apply (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.FontDialog"
		alias
			"OnApply"
		end

	hook_proc (h_wnd: POINTER; msg: INTEGER; wparam: POINTER; lparam: POINTER): POINTER is
		external
			"IL signature (System.IntPtr, System.Int32, System.IntPtr, System.IntPtr): System.IntPtr use System.Windows.Forms.FontDialog"
		alias
			"HookProc"
		end

	frozen get_options: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.FontDialog"
		alias
			"get_Options"
		end

end -- class WINFORMS_FONT_DIALOG
