indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.OpenFileDialog"

frozen external class
	SYSTEM_WINDOWS_FORMS_OPENFILEDIALOG

inherit
	SYSTEM_WINDOWS_FORMS_FILEDIALOG
		redefine
			set_check_file_exists,
			get_check_file_exists,
			reset
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ICOMPONENT

create
	make_openfiledialog

feature {NONE} -- Initialization

	frozen make_openfiledialog is
		external
			"IL creator use System.Windows.Forms.OpenFileDialog"
		end

feature -- Access

	get_check_file_exists: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.OpenFileDialog"
		alias
			"get_CheckFileExists"
		end

	frozen get_read_only_checked: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.OpenFileDialog"
		alias
			"get_ReadOnlyChecked"
		end

	frozen get_multiselect: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.OpenFileDialog"
		alias
			"get_Multiselect"
		end

	frozen get_show_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.OpenFileDialog"
		alias
			"get_ShowReadOnly"
		end

feature -- Element Change

	frozen set_multiselect (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.OpenFileDialog"
		alias
			"set_Multiselect"
		end

	frozen set_read_only_checked (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.OpenFileDialog"
		alias
			"set_ReadOnlyChecked"
		end

	set_check_file_exists (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.OpenFileDialog"
		alias
			"set_CheckFileExists"
		end

	frozen set_show_read_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.OpenFileDialog"
		alias
			"set_ShowReadOnly"
		end

feature -- Basic Operations

	frozen open_file: SYSTEM_IO_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Windows.Forms.OpenFileDialog"
		alias
			"OpenFile"
		end

	reset is
		external
			"IL signature (): System.Void use System.Windows.Forms.OpenFileDialog"
		alias
			"Reset"
		end

end -- class SYSTEM_WINDOWS_FORMS_OPENFILEDIALOG
