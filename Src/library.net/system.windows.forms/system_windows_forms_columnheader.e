indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ColumnHeader"

external class
	SYSTEM_WINDOWS_FORMS_COLUMNHEADER

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose_boolean,
			to_string
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_ICLONEABLE

create
	make_columnheader

feature {NONE} -- Initialization

	frozen make_columnheader is
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

	frozen get_text_align: SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT is
		external
			"IL signature (): System.Windows.Forms.HorizontalAlignment use System.Windows.Forms.ColumnHeader"
		alias
			"get_TextAlign"
		end

	frozen get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ColumnHeader"
		alias
			"get_Text"
		end

	frozen get_list_view: SYSTEM_WINDOWS_FORMS_LISTVIEW is
		external
			"IL signature (): System.Windows.Forms.ListView use System.Windows.Forms.ColumnHeader"
		alias
			"get_ListView"
		end

feature -- Element Change

	frozen set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ColumnHeader"
		alias
			"set_Text"
		end

	frozen set_text_align (value: SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT) is
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

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ColumnHeader"
		alias
			"Clone"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ColumnHeader"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ColumnHeader"
		alias
			"Dispose"
		end

end -- class SYSTEM_WINDOWS_FORMS_COLUMNHEADER
