indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ColumnHeader"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_COLUMN_HEADER

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	ICLONEABLE

create
	make_winforms_column_header

feature {NONE} -- Initialization

	frozen make_winforms_column_header is
		external
			"IL creator use System.Windows.Forms.ColumnHeader"
		end

feature -- Access

	frozen get_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ColumnHeader"
		alias
			"get_Width"
		end

	frozen get_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ColumnHeader"
		alias
			"get_Index"
		end

	frozen get_text_align: WINFORMS_HORIZONTAL_ALIGNMENT is
		external
			"IL signature (): System.Windows.Forms.HorizontalAlignment use System.Windows.Forms.ColumnHeader"
		alias
			"get_TextAlign"
		end

	frozen get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ColumnHeader"
		alias
			"get_Text"
		end

	frozen get_list_view: WINFORMS_LIST_VIEW is
		external
			"IL signature (): System.Windows.Forms.ListView use System.Windows.Forms.ColumnHeader"
		alias
			"get_ListView"
		end

feature -- Element Change

	frozen set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ColumnHeader"
		alias
			"set_Text"
		end

	frozen set_text_align (value: WINFORMS_HORIZONTAL_ALIGNMENT) is
		external
			"IL signature (System.Windows.Forms.HorizontalAlignment): System.Void use System.Windows.Forms.ColumnHeader"
		alias
			"set_TextAlign"
		end

	frozen set_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ColumnHeader"
		alias
			"set_Width"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ColumnHeader"
		alias
			"ToString"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.ColumnHeader"
		alias
			"Clone"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ColumnHeader"
		alias
			"Dispose"
		end

end -- class WINFORMS_COLUMN_HEADER
