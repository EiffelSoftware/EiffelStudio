indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.HandleRef"

frozen expanded external class
	SYSTEM_RUNTIME_INTEROPSERVICES_HANDLEREF

inherit
	SYSTEM_VALUETYPE



feature {NONE} -- Initialization

	frozen make_handle_ref (wrapper2: ANY; handle2: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Runtime.InteropServices.HandleRef"
		end

feature -- Access

	frozen get_wrapper: ANY is
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

	frozen op_explicit (value: SYSTEM_RUNTIME_INTEROPSERVICES_HANDLEREF): POINTER is
		external
			"IL static signature (System.Runtime.InteropServices.HandleRef): System.IntPtr use System.Runtime.InteropServices.HandleRef"
		alias
			"op_Explicit"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_HANDLEREF
