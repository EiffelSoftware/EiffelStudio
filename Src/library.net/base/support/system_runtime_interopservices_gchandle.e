indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.GCHandle"

frozen expanded external class
	SYSTEM_RUNTIME_INTEROPSERVICES_GCHANDLE

inherit
	SYSTEM_VALUETYPE

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

	frozen alloc (value: ANY): SYSTEM_RUNTIME_INTEROPSERVICES_GCHANDLE is
		external
			"IL static signature (System.Object): System.Runtime.InteropServices.GCHandle use System.Runtime.InteropServices.GCHandle"
		alias
			"Alloc"
		end

	frozen alloc_object_gc_handle_type (value: ANY; type: INTEGER): SYSTEM_RUNTIME_INTEROPSERVICES_GCHANDLE is
			-- Valid values for `type' are:
			-- Weak = 0
			-- WeakTrackResurrection = 1
			-- Normal = 2
			-- Pinned = 3
		require
			valid_gchandle_type: type = 0 or type = 1 or type = 2 or type = 3
		external
			"IL static signature (System.Object, enum System.Runtime.InteropServices.GCHandleType): System.Runtime.InteropServices.GCHandle use System.Runtime.InteropServices.GCHandle"
		alias
			"Alloc"
		end

feature -- Specials

	frozen op_explicit (value: POINTER): SYSTEM_RUNTIME_INTEROPSERVICES_GCHANDLE is
		external
			"IL static signature (System.IntPtr): System.Runtime.InteropServices.GCHandle use System.Runtime.InteropServices.GCHandle"
		alias
			"op_Explicit"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_GCHANDLE
