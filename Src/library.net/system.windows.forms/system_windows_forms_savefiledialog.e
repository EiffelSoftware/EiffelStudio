indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.SaveFileDialog"

frozen external class
	SYSTEM_WINDOWS_FORMS_SAVEFILEDIALOG

inherit
	SYSTEM_WINDOWS_FORMS_FILEDIALOG
		redefine
			reset
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ICOMPONENT

create
	make_savefiledialog

feature {NONE} -- Initialization

	frozen make_savefiledialog is
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

	frozen open_file: SYSTEM_IO_STREAM is
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

end -- class SYSTEM_WINDOWS_FORMS_SAVEFILEDIALOG
