indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Threading.NativeOverlapped"

frozen expanded external class
	SYSTEM_THREADING_NATIVEOVERLAPPED

inherit
	VALUE_TYPE

feature -- Access

	frozen event_handle: INTEGER is
		external
			"IL field signature :System.Int32 use System.Threading.NativeOverlapped"
		alias
			"EventHandle"
		end

	frozen internal_high: INTEGER is
		external
			"IL field signature :System.Int32 use System.Threading.NativeOverlapped"
		alias
			"InternalHigh"
		end

	frozen reserved_cor2: SYSTEM_RUNTIME_INTEROPSERVICES_GCHANDLE is
		external
			"IL field signature :System.Runtime.InteropServices.GCHandle use System.Threading.NativeOverlapped"
		alias
			"ReservedCOR2"
		end

	frozen reserved_cor1: INTEGER is
		external
			"IL field signature :System.Int32 use System.Threading.NativeOverlapped"
		alias
			"ReservedCOR1"
		end

	frozen offset_low: INTEGER is
		external
			"IL field signature :System.Int32 use System.Threading.NativeOverlapped"
		alias
			"OffsetLow"
		end

	frozen offset_high: INTEGER is
		external
			"IL field signature :System.Int32 use System.Threading.NativeOverlapped"
		alias
			"OffsetHigh"
		end

	frozen reserved_classlib: SYSTEM_RUNTIME_INTEROPSERVICES_GCHANDLE is
		external
			"IL field signature :System.Runtime.InteropServices.GCHandle use System.Threading.NativeOverlapped"
		alias
			"ReservedClasslib"
		end

	frozen internal_low: INTEGER is
		external
			"IL field signature :System.Int32 use System.Threading.NativeOverlapped"
		alias
			"InternalLow"
		end

end -- class SYSTEM_THREADING_NATIVEOVERLAPPED
