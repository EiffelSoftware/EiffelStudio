indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.MeasureItemEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_MEASUREITEMEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_measureitemeventargs_1,
	make_measureitemeventargs

feature {NONE} -- Initialization

	frozen make_measureitemeventargs_1 (graphics: SYSTEM_DRAWING_GRAPHICS; index: INTEGER) is
		external
			"IL creator signature (System.Drawing.Graphics, System.Int32) use System.Windows.Forms.MeasureItemEventArgs"
		end

	frozen make_measureitemeventargs (graphics: SYSTEM_DRAWING_GRAPHICS; index: INTEGER; item_height: INTEGER) is
		external
			"IL creator signature (System.Drawing.Graphics, System.Int32, System.Int32) use System.Windows.Forms.MeasureItemEventArgs"
		end

feature -- Access

	frozen get_item_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MeasureItemEventArgs"
		alias
			"get_ItemHeight"
		end

	frozen get_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MeasureItemEventArgs"
		alias
			"get_Index"
		end

	frozen get_graphics: SYSTEM_DRAWING_GRAPHICS is
		external
			"IL signature (): System.Drawing.Graphics use System.Windows.Forms.MeasureItemEventArgs"
		alias
			"get_Graphics"
		end

	frozen get_item_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MeasureItemEventArgs"
		alias
			"get_ItemWidth"
		end

feature -- Element Change

	frozen set_item_height (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.MeasureItemEventArgs"
		alias
			"set_ItemHeight"
		end

	frozen set_item_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.MeasureItemEventArgs"
		alias
			"set_ItemWidth"
		end

end -- class SYSTEM_WINDOWS_FORMS_MEASUREITEMEVENTARGS
