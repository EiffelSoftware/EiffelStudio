indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.UCOMIStream"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMISTREAM

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	read (pv: ARRAY [INTEGER_8]; cb: INTEGER; pcb_read: INTEGER) is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMIStream"
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

	lock_region (lib_offset: INTEGER_64; cb: INTEGER_64; dw_lock_type: INTEGER) is
		external
			"IL deferred signature (System.Int64, System.Int64, System.Int32): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"LockRegion"
		end

	copy_to (pstm: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMISTREAM; cb: INTEGER_64; pcb_read: INTEGER_64; pcb_written: INTEGER_64) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIStream, System.Int64, System.Int64&, System.Int64&): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"CopyTo"
		end

	clone (ppstm: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMISTREAM) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIStream&): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Clone"
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

	stat (pstatstg: SYSTEM_RUNTIME_INTEROPSERVICES_STATSTG; grf_stat_flag: INTEGER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.STATSTG&, System.Int32): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Stat"
		end

	write (pv: ARRAY [INTEGER_8]; cb: INTEGER; pcb_written: INTEGER) is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Write"
		end

	seek (dlib_move: INTEGER_64; dw_origin: INTEGER; plib_new_position: INTEGER_64) is
		external
			"IL deferred signature (System.Int64, System.Int32, System.Int64&): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Seek"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMISTREAM
