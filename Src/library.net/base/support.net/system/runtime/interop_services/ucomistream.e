indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.UCOMIStream"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	UCOMISTREAM

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	read (pv: NATIVE_ARRAY [INTEGER_8]; cb: INTEGER; pcb_read: POINTER) is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.IntPtr): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Read"
		end

	set_size (lib_new_size: INTEGER_64) is
		external
			"IL deferred signature (System.Int64): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"SetSize"
		end

	commit (grf_commit_flags: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Commit"
		end

	clone_ (ppstm: UCOMISTREAM) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIStream&): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Clone"
		end

	lock_region (lib_offset: INTEGER_64; cb: INTEGER_64; dw_lock_type: INTEGER) is
		external
			"IL deferred signature (System.Int64, System.Int64, System.Int32): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"LockRegion"
		end

	copy_to (pstm: UCOMISTREAM; cb: INTEGER_64; pcb_read: POINTER; pcb_written: POINTER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIStream, System.Int64, System.IntPtr, System.IntPtr): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"CopyTo"
		end

	revert is
		external
			"IL deferred signature (): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Revert"
		end

	unlock_region (lib_offset: INTEGER_64; cb: INTEGER_64; dw_lock_type: INTEGER) is
		external
			"IL deferred signature (System.Int64, System.Int64, System.Int32): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"UnlockRegion"
		end

	stat (pstatstg: STATSTG; grf_stat_flag: INTEGER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.STATSTG&, System.Int32): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Stat"
		end

	write (pv: NATIVE_ARRAY [INTEGER_8]; cb: INTEGER; pcb_written: POINTER) is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.IntPtr): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Write"
		end

	seek (dlib_move: INTEGER_64; dw_origin: INTEGER; plib_new_position: POINTER) is
		external
			"IL deferred signature (System.Int64, System.Int32, System.IntPtr): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Seek"
		end

end -- class UCOMISTREAM
