indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.IWin32Window"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_IWIN32_WINDOW

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_handle: POINTER is
		external
			"IL deferred signature (): System.IntPtr use System.Windows.Forms.IWin32Window"
		alias
			"get_Handle"
		end

end -- class WINFORMS_IWIN32_WINDOW
