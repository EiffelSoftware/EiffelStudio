indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.NativeWindow"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_NATIVE_WINDOW

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize
		end

create
	make_winforms_native_window

feature {NONE} -- Initialization

	frozen make_winforms_native_window is
		external
			"IL creator use System.Windows.Forms.NativeWindow"
		end

feature -- Access

	frozen get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.NativeWindow"
		alias
			"get_Handle"
		end

feature -- Basic Operations

	create_handle (cp: WINFORMS_CREATE_PARAMS) is
		external
			"IL signature (System.Windows.Forms.CreateParams): System.Void use System.Windows.Forms.NativeWindow"
		alias
			"CreateHandle"
		end

	frozen def_wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.NativeWindow"
		alias
			"DefWndProc"
		end

	frozen from_handle (handle: POINTER): WINFORMS_NATIVE_WINDOW is
		external
			"IL static signature (System.IntPtr): System.Windows.Forms.NativeWindow use System.Windows.Forms.NativeWindow"
		alias
			"FromHandle"
		end

	release_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.NativeWindow"
		alias
			"ReleaseHandle"
		end

	frozen assign_handle (handle: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Windows.Forms.NativeWindow"
		alias
			"AssignHandle"
		end

	destroy_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.NativeWindow"
		alias
			"DestroyHandle"
		end

feature {NONE} -- Implementation

	on_thread_exception (e: EXCEPTION) is
		external
			"IL signature (System.Exception): System.Void use System.Windows.Forms.NativeWindow"
		alias
			"OnThreadException"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.NativeWindow"
		alias
			"WndProc"
		end

	on_handle_change is
		external
			"IL signature (): System.Void use System.Windows.Forms.NativeWindow"
		alias
			"OnHandleChange"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.NativeWindow"
		alias
			"Finalize"
		end

end -- class WINFORMS_NATIVE_WINDOW
