indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Screen"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_SCREEN

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create {NONE}

feature -- Access

	frozen get_device_name: SYSTEM_STRING is
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

	frozen get_working_area: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.Screen"
		alias
			"get_WorkingArea"
		end

	frozen get_bounds: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.Screen"
		alias
			"get_Bounds"
		end

	frozen get_all_screens: NATIVE_ARRAY [WINFORMS_SCREEN] is
		external
			"IL static signature (): System.Windows.Forms.Screen[] use System.Windows.Forms.Screen"
		alias
			"get_AllScreens"
		end

	frozen get_primary_screen: WINFORMS_SCREEN is
		external
			"IL static signature (): System.Windows.Forms.Screen use System.Windows.Forms.Screen"
		alias
			"get_PrimaryScreen"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Screen"
		alias
			"ToString"
		end

	frozen get_working_area_control (ctl: WINFORMS_CONTROL): DRAWING_RECTANGLE is
		external
			"IL static signature (System.Windows.Forms.Control): System.Drawing.Rectangle use System.Windows.Forms.Screen"
		alias
			"GetWorkingArea"
		end

	frozen from_control (control: WINFORMS_CONTROL): WINFORMS_SCREEN is
		external
			"IL static signature (System.Windows.Forms.Control): System.Windows.Forms.Screen use System.Windows.Forms.Screen"
		alias
			"FromControl"
		end

	frozen get_bounds_point (pt: DRAWING_POINT): DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.Point): System.Drawing.Rectangle use System.Windows.Forms.Screen"
		alias
			"GetBounds"
		end

	frozen get_bounds_control (ctl: WINFORMS_CONTROL): DRAWING_RECTANGLE is
		external
			"IL static signature (System.Windows.Forms.Control): System.Drawing.Rectangle use System.Windows.Forms.Screen"
		alias
			"GetBounds"
		end

	frozen get_bounds_rectangle (rect: DRAWING_RECTANGLE): DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.Rectangle): System.Drawing.Rectangle use System.Windows.Forms.Screen"
		alias
			"GetBounds"
		end

	frozen get_working_area_point (pt: DRAWING_POINT): DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.Point): System.Drawing.Rectangle use System.Windows.Forms.Screen"
		alias
			"GetWorkingArea"
		end

	frozen from_rectangle (rect: DRAWING_RECTANGLE): WINFORMS_SCREEN is
		external
			"IL static signature (System.Drawing.Rectangle): System.Windows.Forms.Screen use System.Windows.Forms.Screen"
		alias
			"FromRectangle"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.Screen"
		alias
			"Equals"
		end

	frozen from_handle (hwnd: POINTER): WINFORMS_SCREEN is
		external
			"IL static signature (System.IntPtr): System.Windows.Forms.Screen use System.Windows.Forms.Screen"
		alias
			"FromHandle"
		end

	frozen from_point (point: DRAWING_POINT): WINFORMS_SCREEN is
		external
			"IL static signature (System.Drawing.Point): System.Windows.Forms.Screen use System.Windows.Forms.Screen"
		alias
			"FromPoint"
		end

	frozen get_working_area_rectangle (rect: DRAWING_RECTANGLE): DRAWING_RECTANGLE is
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

end -- class WINFORMS_SCREEN
