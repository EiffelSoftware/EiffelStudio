indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.IWin32Window"

deferred external class
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_handle: POINTER is
		external
			"IL deferred signature (): System.IntPtr use System.Windows.Forms.IWin32Window"
		alias
			"get_Handle"
		end

end -- class SYSTEM_WINDOWS_FORMS_IWIN32WINDOW
