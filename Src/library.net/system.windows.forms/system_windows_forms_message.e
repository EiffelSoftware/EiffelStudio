indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Message"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_MESSAGE

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	frozen get_msg: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Message"
		alias
			"get_Msg"
		end

	frozen get_result: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.Message"
		alias
			"get_Result"
		end

	frozen get_hwnd: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.Message"
		alias
			"get_HWnd"
		end

	frozen get_wparam: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.Message"
		alias
			"get_WParam"
		end

	frozen get_lparam: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.Message"
		alias
			"get_LParam"
		end

feature -- Element Change

	frozen set_msg (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Message"
		alias
			"set_Msg"
		end

	frozen set_hwnd (value: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Windows.Forms.Message"
		alias
			"set_HWnd"
		end

	frozen set_lparam (value: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Windows.Forms.Message"
		alias
			"set_LParam"
		end

	frozen set_result (value: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Windows.Forms.Message"
		alias
			"set_Result"
		end

	frozen set_wparam (value: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Windows.Forms.Message"
		alias
			"set_WParam"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Message"
		alias
			"GetHashCode"
		end

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.Message"
		alias
			"Equals"
		end

	frozen Create_ (h_wnd: POINTER; msg: INTEGER; wparam: POINTER; lparam: POINTER): SYSTEM_WINDOWS_FORMS_MESSAGE is
		external
			"IL static signature (System.IntPtr, System.Int32, System.IntPtr, System.IntPtr): System.Windows.Forms.Message use System.Windows.Forms.Message"
		alias
			"Create"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Message"
		alias
			"ToString"
		end

	frozen get_lparam_type (cls: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Type): System.Object use System.Windows.Forms.Message"
		alias
			"GetLParam"
		end

end -- class SYSTEM_WINDOWS_FORMS_MESSAGE
