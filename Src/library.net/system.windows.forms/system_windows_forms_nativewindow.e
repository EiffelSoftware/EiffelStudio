indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.NativeWindow"

external class
	SYSTEM_WINDOWS_FORMS_NATIVEWINDOW

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize
		end

create
	make_nativewindow

feature {NONE} -- Initialization

	frozen make_nativewindow is
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

	create_handle (cp: SYSTEM_WINDOWS_FORMS_CREATEPARAMS) is
		external
			"IL signature (System.Windows.Forms.CreateParams): System.Void use System.Windows.Forms.NativeWindow"
		alias
			"CreateHandle"
		end

	frozen def_wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.NativeWindow"
		alias
			"DefWndProc"
		end

	frozen from_handle (handle: POINTER): SYSTEM_WINDOWS_FORMS_NATIVEWINDOW is
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

	on_thread_exception (e: SYSTEM_EXCEPTION) is
		external
			"IL signature (System.Exception): System.Void use System.Windows.Forms.NativeWindow"
		alias
			"OnThreadException"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
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

end -- class SYSTEM_WINDOWS_FORMS_NATIVEWINDOW
