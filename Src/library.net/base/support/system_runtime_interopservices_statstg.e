indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.STATSTG"

frozen expanded external class
	SYSTEM_RUNTIME_INTEROPSERVICES_STATSTG

inherit
	SYSTEM_VALUETYPE

feature -- Access

	frozen type: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.STATSTG"
		alias
			"type"
		end

	frozen m_time: SYSTEM_RUNTIME_INTEROPSERVICES_FILETIME is
		external
			"IL field signature :System.Runtime.InteropServices.FILETIME use System.Runtime.InteropServices.STATSTG"
		alias
			"mtime"
		end

	frozen pwcs_name: STRING is
		external
			"IL field signature :System.String use System.Runtime.InteropServices.STATSTG"
		alias
			"pwcsName"
		end

	frozen cb_Size: INTEGER_64 is
		external
			"IL field signature :System.Int64 use System.Runtime.InteropServices.STATSTG"
		alias
			"cbSize"
		end

	frozen a_time: SYSTEM_RUNTIME_INTEROPSERVICES_FILETIME is
		external
			"IL field signature :System.Runtime.InteropServices.FILETIME use System.Runtime.InteropServices.STATSTG"
		alias
			"atime"
		end

	frozen reserved: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.STATSTG"
		alias
			"reserved"
		end

	frozen grf_locks_supported: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.STATSTG"
		alias
			"grfLocksSupported"
		end

	frozen clsid: SYSTEM_GUID is
		external
			"IL field signature :System.Guid use System.Runtime.InteropServices.STATSTG"
		alias
			"clsid"
		end

	frozen grf_state_bits: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.STATSTG"
		alias
			"grfStateBits"
		end

	frozen grf_mode: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.STATSTG"
		alias
			"grfMode"
		end

	frozen c_time: SYSTEM_RUNTIME_INTEROPSERVICES_FILETIME is
		external
			"IL field signature :System.Runtime.InteropServices.FILETIME use System.Runtime.InteropServices.STATSTG"
		alias
			"ctime"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_STATSTG
