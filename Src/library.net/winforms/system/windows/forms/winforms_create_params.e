indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.CreateParams"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_CREATE_PARAMS

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Windows.Forms.CreateParams"
		end

feature -- Access

	frozen get_ex_style: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.CreateParams"
		alias
			"get_ExStyle"
		end

	frozen get_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.CreateParams"
		alias
			"get_Height"
		end

	frozen get_style: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.CreateParams"
		alias
			"get_Style"
		end

	frozen get_param: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.CreateParams"
		alias
			"get_Param"
		end

	frozen get_y: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.CreateParams"
		alias
			"get_Y"
		end

	frozen get_x: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.CreateParams"
		alias
			"get_X"
		end

	frozen get_class_style: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.CreateParams"
		alias
			"get_ClassStyle"
		end

	frozen get_caption: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.CreateParams"
		alias
			"get_Caption"
		end

	frozen get_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.CreateParams"
		alias
			"get_Width"
		end

	frozen get_class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.CreateParams"
		alias
			"get_ClassName"
		end

	frozen get_parent: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.CreateParams"
		alias
			"get_Parent"
		end

feature -- Element Change

	frozen set_y (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.CreateParams"
		alias
			"set_Y"
		end

	frozen set_style (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.CreateParams"
		alias
			"set_Style"
		end

	frozen set_parent (value: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Windows.Forms.CreateParams"
		alias
			"set_Parent"
		end

	frozen set_param (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.CreateParams"
		alias
			"set_Param"
		end

	frozen set_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.CreateParams"
		alias
			"set_Width"
		end

	frozen set_class_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.CreateParams"
		alias
			"set_ClassName"
		end

	frozen set_ex_style (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.CreateParams"
		alias
			"set_ExStyle"
		end

	frozen set_height (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.CreateParams"
		alias
			"set_Height"
		end

	frozen set_x (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.CreateParams"
		alias
			"set_X"
		end

	frozen set_caption (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.CreateParams"
		alias
			"set_Caption"
		end

	frozen set_class_style (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.CreateParams"
		alias
			"set_ClassStyle"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.CreateParams"
		alias
			"ToString"
		end

end -- class WINFORMS_CREATE_PARAMS
