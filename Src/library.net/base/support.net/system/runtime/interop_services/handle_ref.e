indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.HandleRef"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	HANDLE_REF

inherit
	VALUE_TYPE

feature -- Initialization

	frozen make_handle_ref (wrapper: SYSTEM_OBJECT; handle: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Runtime.InteropServices.HandleRef"
		end

feature -- Access

	frozen get_wrapper: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.InteropServices.HandleRef"
		alias
			"get_Wrapper"
		end

	frozen get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Runtime.InteropServices.HandleRef"
		alias
			"get_Handle"
		end

feature -- Specials

	frozen op_explicit (value: HANDLE_REF): POINTER is
		external
			"IL static signature (System.Runtime.InteropServices.HandleRef): System.IntPtr use System.Runtime.InteropServices.HandleRef"
		alias
			"op_Explicit"
		end

end -- class HANDLE_REF
