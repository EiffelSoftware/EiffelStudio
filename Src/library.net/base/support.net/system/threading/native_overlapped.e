indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.NativeOverlapped"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	NATIVE_OVERLAPPED

inherit
	VALUE_TYPE

feature -- Access

	frozen event_handle: INTEGER is
		external
			"IL field signature :System.Int32 use System.Threading.NativeOverlapped"
		alias
			"EventHandle"
		end

	frozen internal_low: INTEGER is
		external
			"IL field signature :System.Int32 use System.Threading.NativeOverlapped"
		alias
			"InternalLow"
		end

	frozen internal_high: INTEGER is
		external
			"IL field signature :System.Int32 use System.Threading.NativeOverlapped"
		alias
			"InternalHigh"
		end

	frozen offset_high: INTEGER is
		external
			"IL field signature :System.Int32 use System.Threading.NativeOverlapped"
		alias
			"OffsetHigh"
		end

	frozen offset_low: INTEGER is
		external
			"IL field signature :System.Int32 use System.Threading.NativeOverlapped"
		alias
			"OffsetLow"
		end

end -- class NATIVE_OVERLAPPED
