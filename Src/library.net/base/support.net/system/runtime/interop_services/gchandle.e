indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.GCHandle"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	GCHANDLE

inherit
	VALUE_TYPE

feature -- Access

	frozen get_target: SYSTEM_OBJECT is
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

	frozen set_target (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.InteropServices.GCHandle"
		alias
			"set_Target"
		end

feature -- Basic Operations

	frozen alloc (value: SYSTEM_OBJECT): GCHANDLE is
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

	frozen alloc_object_gchandle_type (value: SYSTEM_OBJECT; type: GCHANDLE_TYPE): GCHANDLE is
		external
			"IL static signature (System.Object, System.Runtime.InteropServices.GCHandleType): System.Runtime.InteropServices.GCHandle use System.Runtime.InteropServices.GCHandle"
		alias
			"Alloc"
		end

feature -- Specials

	frozen op_explicit_int_ptr (value: POINTER): GCHANDLE is
		external
			"IL static signature (System.IntPtr): System.Runtime.InteropServices.GCHandle use System.Runtime.InteropServices.GCHandle"
		alias
			"op_Explicit"
		end

	frozen op_explicit (value: GCHANDLE): POINTER is
		external
			"IL static signature (System.Runtime.InteropServices.GCHandle): System.IntPtr use System.Runtime.InteropServices.GCHandle"
		alias
			"op_Explicit"
		end

end -- class GCHANDLE
