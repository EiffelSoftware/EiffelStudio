indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Screen"

external class
	SYSTEM_WINDOWS_FORMS_SCREEN

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object,
			to_string
		end

create {NONE}

feature -- Access

	frozen get_device_name: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Screen"
		alias
			"get_DeviceName"
		end

	frozen get_primary: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Screen"
		alias
			"get_Primary"
		end

	frozen get_working_area: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.Screen"
		alias
			"get_WorkingArea"
		end

	frozen get_bounds: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.Screen"
		alias
			"get_Bounds"
		end

	frozen get_all_screens: ARRAY [SYSTEM_WINDOWS_FORMS_SCREEN] is
		external
			"IL static signature (): System.Windows.Forms.Screen[] use System.Windows.Forms.Screen"
		alias
			"get_AllScreens"
		end

	frozen get_primary_screen: SYSTEM_WINDOWS_FORMS_SCREEN is
		external
			"IL static signature (): System.Windows.Forms.Screen use System.Windows.Forms.Screen"
		alias
			"get_PrimaryScreen"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Screen"
		alias
			"ToString"
		end

	frozen get_working_area_control (ctl: SYSTEM_WINDOWS_FORMS_CONTROL): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static signature (System.Windows.Forms.Control): System.Drawing.Rectangle use System.Windows.Forms.Screen"
		alias
			"GetWorkingArea"
		end

	frozen from_control (control: SYSTEM_WINDOWS_FORMS_CONTROL): SYSTEM_WINDOWS_FORMS_SCREEN is
		external
			"IL static signature (System.Windows.Forms.Control): System.Windows.Forms.Screen use System.Windows.Forms.Screen"
		alias
			"FromControl"
		end

	frozen get_bounds_point (pt: SYSTEM_DRAWING_POINT): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.Point): System.Drawing.Rectangle use System.Windows.Forms.Screen"
		alias
			"GetBounds"
		end

	frozen get_bounds_control (ctl: SYSTEM_WINDOWS_FORMS_CONTROL): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static signature (System.Windows.Forms.Control): System.Drawing.Rectangle use System.Windows.Forms.Screen"
		alias
			"GetBounds"
		end

	frozen get_bounds_rectangle (rect: SYSTEM_DRAWING_RECTANGLE): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.Rectangle): System.Drawing.Rectangle use System.Windows.Forms.Screen"
		alias
			"GetBounds"
		end

	frozen get_working_area_point (pt: SYSTEM_DRAWING_POINT): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.Point): System.Drawing.Rectangle use System.Windows.Forms.Screen"
		alias
			"GetWorkingArea"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.Screen"
		alias
			"Equals"
		end

	frozen from_rectangle (rect: SYSTEM_DRAWING_RECTANGLE): SYSTEM_WINDOWS_FORMS_SCREEN is
		external
			"IL static signature (System.Drawing.Rectangle): System.Windows.Forms.Screen use System.Windows.Forms.Screen"
		alias
			"FromRectangle"
		end

	frozen from_handle (hwnd: POINTER): SYSTEM_WINDOWS_FORMS_SCREEN is
		external
			"IL static signature (System.IntPtr): System.Windows.Forms.Screen use System.Windows.Forms.Screen"
		alias
			"FromHandle"
		end

	frozen from_point (point: SYSTEM_DRAWING_POINT): SYSTEM_WINDOWS_FORMS_SCREEN is
		external
			"IL static signature (System.Drawing.Point): System.Windows.Forms.Screen use System.Windows.Forms.Screen"
		alias
			"FromPoint"
		end

	frozen get_working_area_rectangle (rect: SYSTEM_DRAWING_RECTANGLE): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.Rectangle): System.Drawing.Rectangle use System.Windows.Forms.Screen"
		alias
			"GetWorkingArea"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Screen"
		alias
			"GetHashCode"
		end

end -- class SYSTEM_WINDOWS_FORMS_SCREEN
