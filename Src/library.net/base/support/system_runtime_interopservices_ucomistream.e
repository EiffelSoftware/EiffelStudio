indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	write (pv: ARRAY [INTEGER_8]; cb: INTEGER; pcbWritten: INTEGER) is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Write"
		end

	copy_to (pstm: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMISTREAM; cb: INTEGER_64; pcbRead: INTEGER_64; pcbWritten: INTEGER_64) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIStream, System.Int64, System.Int64&, System.Int64&): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"CopyTo"
		end

	lock_region (libOffset: INTEGER_64; cb: INTEGER_64; dwLockType: INTEGER) is
		external
			"IL deferred signature (System.Int64, System.Int64, System.Int32): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"LockRegion"
		end

	read (pv: ARRAY [INTEGER_8]; cb: INTEGER; pcbRead: INTEGER) is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Read"
		end

	revert is
		external
			"IL deferred signature (): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Revert"
		end

	clone (ppstm: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMISTREAM) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIStream&): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Clone"
		end

	set_size (libNewSize: INTEGER_64) is
		external
			"IL deferred signature (System.Int64): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"SetSize"
		end

	stat (pstatstg: SYSTEM_RUNTIME_INTEROPSERVICES_STATSTG; grfStatFlag: INTEGER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.STATSTG&, System.Int32): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Stat"
		end

	seek (dlibMove: INTEGER_64; dwOrigin: INTEGER; plibNewPosition: INTEGER_64) is
		external
			"IL deferred signature (System.Int64, System.Int32, System.Int64&): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Seek"
		end

	unlock_region (libOffset: INTEGER_64; cb: INTEGER_64; dwLockType: INTEGER) is
		external
			"IL deferred signature (System.Int64, System.Int64, System.Int32): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"UnlockRegion"
		end

	commit (grfCommitFlags: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Runtime.InteropServices.UCOMIStream"
		alias
			"Commit"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMISTREAM
