indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ListViewItem+ListViewSubItem"

external class
	LISTVIEWSUBITEM_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM

inherit
	ANY
		redefine
			to_string
		end

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (owner: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM; text: STRING; fore_color: SYSTEM_DRAWING_COLOR; back_color: SYSTEM_DRAWING_COLOR; font: SYSTEM_DRAWING_FONT) is
		external
			"IL creator signature (System.Windows.Forms.ListViewItem, System.String, System.Drawing.Color, System.Drawing.Color, System.Drawing.Font) use System.Windows.Forms.ListViewItem+ListViewSubItem"
		end

	frozen make is
		external
			"IL creator use System.Windows.Forms.ListViewItem+ListViewSubItem"
		end

	frozen make_1 (owner: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM; text: STRING) is
		external
			"IL creator signature (System.Windows.Forms.ListViewItem, System.String) use System.Windows.Forms.ListViewItem+ListViewSubItem"
		end

feature -- Access

	frozen get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"get_ForeColor"
		end

	frozen get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"get_Text"
		end

	frozen get_font: SYSTEM_DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"get_Font"
		end

	frozen get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"get_BackColor"
		end

feature -- Element Change

	frozen set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"set_Text"
		end

	frozen set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"set_ForeColor"
		end

	frozen set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"set_BackColor"
		end

	frozen set_font (value: SYSTEM_DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"set_Font"
		end

feature -- Basic Operations

	frozen reset_style is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"ResetStyle"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"ToString"
		end

end -- class LISTVIEWSUBITEM_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
