indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.OwnerDrawPropertyBag"

external class
	SYSTEM_WINDOWS_FORMS_OWNERDRAWPROPERTYBAG

inherit
	SYSTEM_MARSHALBYREFOBJECT

create
	make_ownerdrawpropertybag

feature {NONE} -- Initialization

	frozen make_ownerdrawpropertybag is
		external
			"IL creator use System.Windows.Forms.OwnerDrawPropertyBag"
		end

feature -- Access

	frozen get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"get_ForeColor"
		end

	frozen get_font: SYSTEM_DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"get_Font"
		end

	frozen get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"get_BackColor"
		end

feature -- Element Change

	frozen set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"set_ForeColor"
		end

	frozen set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"set_BackColor"
		end

	frozen set_font (value: SYSTEM_DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"set_Font"
		end

feature -- Basic Operations

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"IsEmpty"
		end

	frozen copy (value: SYSTEM_WINDOWS_FORMS_OWNERDRAWPROPERTYBAG): SYSTEM_WINDOWS_FORMS_OWNERDRAWPROPERTYBAG is
		external
			"IL static signature (System.Windows.Forms.OwnerDrawPropertyBag): System.Windows.Forms.OwnerDrawPropertyBag use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"Copy"
		end

end -- class SYSTEM_WINDOWS_FORMS_OWNERDRAWPROPERTYBAG
