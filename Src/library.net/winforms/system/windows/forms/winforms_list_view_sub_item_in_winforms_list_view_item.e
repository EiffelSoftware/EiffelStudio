indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ListViewItem+ListViewSubItem"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_LIST_VIEW_SUB_ITEM_IN_WINFORMS_LIST_VIEW_ITEM

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (owner: WINFORMS_LIST_VIEW_ITEM; text: SYSTEM_STRING; fore_color: DRAWING_COLOR; back_color: DRAWING_COLOR; font: DRAWING_FONT) is
		external
			"IL creator signature (System.Windows.Forms.ListViewItem, System.String, System.Drawing.Color, System.Drawing.Color, System.Drawing.Font) use System.Windows.Forms.ListViewItem+ListViewSubItem"
		end

	frozen make is
		external
			"IL creator use System.Windows.Forms.ListViewItem+ListViewSubItem"
		end

	frozen make_1 (owner: WINFORMS_LIST_VIEW_ITEM; text: SYSTEM_STRING) is
		external
			"IL creator signature (System.Windows.Forms.ListViewItem, System.String) use System.Windows.Forms.ListViewItem+ListViewSubItem"
		end

feature -- Access

	frozen get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"get_ForeColor"
		end

	frozen get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"get_Text"
		end

	frozen get_font: DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"get_Font"
		end

	frozen get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"get_BackColor"
		end

feature -- Element Change

	frozen set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"set_Text"
		end

	frozen set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"set_ForeColor"
		end

	frozen set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"set_BackColor"
		end

	frozen set_font (value: DRAWING_FONT) is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListViewItem+ListViewSubItem"
		alias
			"ToString"
		end

end -- class WINFORMS_LIST_VIEW_SUB_ITEM_IN_WINFORMS_LIST_VIEW_ITEM
