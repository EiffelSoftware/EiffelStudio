indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.GCHandle"

frozen expanded external class
	SYSTEM_RUNTIME_INTEROPSERVICES_GCHANDLE

inherit
	VALUE_TYPE

feature -- Access

	frozen get_target: ANY is
		external
			"IL signature (): System.Object use System.Runtime.InteropServices.GCHandle"
		alias
			"get_Target"
		end

	frozen get_is_allocated: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.InteropServices.GCHandle"
		alias
			"get_IsAllocated"
		end

feature -- Element Change

	frozen set_target (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.InteropServices.GCHandle"
		alias
			"set_Target"
		end

feature -- Basic Operations

	frozen alloc (value: ANY): SYSTEM_RUNTIME_INTEROPSERVICES_GCHANDLE is
		external
			"IL static signature (System.Object): System.Runtime.InteropServices.GCHandle use System.Runtime.InteropServices.GCHandle"
		alias
			"Alloc"
		end

	frozen addr_of_pinned_object: POINTER is
		external
			"IL signature (): System.IntPtr use System.Runtime.InteropServices.GCHandle"
		alias
			"AddrOfPinnedObject"
		end

	frozen free is
		external
			"IL signature (): System.Void use System.Runtime.InteropServices.GCHandle"
		alias
			"Free"
		end

	frozen alloc_object_gchandle_type (value: ANY; type: SYSTEM_RUNTIME_INTEROPSERVICES_GCHANDLETYPE): SYSTEM_RUNTIME_INTEROPSERVICES_GCHANDLE is
		external
			"IL static signature (System.Object, System.Runtime.InteropServices.GCHandleType): System.Runtime.InteropServices.GCHandle use System.Runtime.InteropServices.GCHandle"
		alias
			"Alloc"
		end

feature -- Specials

	frozen op_explicit_int_ptr (value: POINTER): SYSTEM_RUNTIME_INTEROPSERVICES_GCHANDLE is
		external
			"IL static signature (System.IntPtr): System.Runtime.InteropServices.GCHandle use System.Runtime.InteropServices.GCHandle"
		alias
			"op_Explicit"
		end

	frozen op_explicit (value: SYSTEM_RUNTIME_INTEROPSERVICES_GCHANDLE): POINTER is
		external
			"IL static signature (System.Runtime.InteropServices.GCHandle): System.IntPtr use System.Runtime.InteropServices.GCHandle"
		alias
			"op_Explicit"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_GCHANDLE
