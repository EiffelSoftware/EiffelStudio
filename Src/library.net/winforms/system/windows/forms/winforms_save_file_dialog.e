indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.SaveFileDialog"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_SAVE_FILE_DIALOG

inherit
	WINFORMS_FILE_DIALOG
		redefine
			reset
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_winforms_save_file_dialog

feature {NONE} -- Initialization

	frozen make_winforms_save_file_dialog is
		external
			"IL creator use System.Windows.Forms.SaveFileDialog"
		end

feature -- Access

	frozen get_create_prompt: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.SaveFileDialog"
		alias
			"get_CreatePrompt"
		end

	frozen get_overwrite_prompt: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.SaveFileDialog"
		alias
			"get_OverwritePrompt"
		end

feature -- Element Change

	frozen set_create_prompt (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.SaveFileDialog"
		alias
			"set_CreatePrompt"
		end

	frozen set_overwrite_prompt (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.SaveFileDialog"
		alias
			"set_OverwritePrompt"
		end

feature -- Basic Operations

	frozen open_file: SYSTEM_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Windows.Forms.SaveFileDialog"
		alias
			"OpenFile"
		end

	reset is
		external
			"IL signature (): System.Void use System.Windows.Forms.SaveFileDialog"
		alias
			"Reset"
		end

end -- class WINFORMS_SAVE_FILE_DIALOG
