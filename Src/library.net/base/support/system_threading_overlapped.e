indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Threading.Overlapped"

external class
	SYSTEM_THREADING_OVERLAPPED

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Threading.Overlapped"
		end

	frozen make_1 (offset_lo: INTEGER; offset_hi: INTEGER; h_event: INTEGER; ar: SYSTEM_IASYNCRESULT) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.IAsyncResult) use System.Threading.Overlapped"
		end

feature -- Access

	frozen get_offset_low: INTEGER is
		external
			"IL signature (): System.Int32 use System.Threading.Overlapped"
		alias
			"get_OffsetLow"
		end

	frozen get_offset_high: INTEGER is
		external
			"IL signature (): System.Int32 use System.Threading.Overlapped"
		alias
			"get_OffsetHigh"
		end

	frozen get_event_handle: INTEGER is
		external
			"IL signature (): System.Int32 use System.Threading.Overlapped"
		alias
			"get_EventHandle"
		end

	frozen get_async_result: SYSTEM_IASYNCRESULT is
		external
			"IL signature (): System.IAsyncResult use System.Threading.Overlapped"
		alias
			"get_AsyncResult"
		end

feature -- Element Change

	frozen set_offset_low (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Threading.Overlapped"
		alias
			"set_OffsetLow"
		end

	frozen set_offset_high (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Threading.Overlapped"
		alias
			"set_OffsetHigh"
		end

	frozen set_async_result (value: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Threading.Overlapped"
		alias
			"set_AsyncResult"
		end

	frozen set_event_handle (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Threading.Overlapped"
		alias
			"set_EventHandle"
		end

end -- class SYSTEM_THREADING_OVERLAPPED
