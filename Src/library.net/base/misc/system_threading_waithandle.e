indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Threading.WaitHandle"

deferred external class
	SYSTEM_THREADING_WAITHANDLE

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

feature -- Access

	get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Threading.WaitHandle"
		alias
			"get_Handle"
		end

feature -- Element Change

	set_handle (value: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Threading.WaitHandle"
		alias
			"set_Handle"
		end

feature -- Basic Operations

	wait_one: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Threading.WaitHandle"
		alias
			"WaitOne"
		end

	frozen wait_all_array_wait_handle_time_span (wait_handles: ARRAY [SYSTEM_THREADING_WAITHANDLE]; timeout: SYSTEM_TIMESPAN; exit_context: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Threading.WaitHandle[], System.TimeSpan, System.Boolean): System.Boolean use System.Threading.WaitHandle"
		alias
			"WaitAll"
		end

	close is
		external
			"IL signature (): System.Void use System.Threading.WaitHandle"
		alias
			"Close"
		end

	wait_one_time_span (timeout: SYSTEM_TIMESPAN; exit_context: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.TimeSpan, System.Boolean): System.Boolean use System.Threading.WaitHandle"
		alias
			"WaitOne"
		end

	frozen wait_any_array_wait_handle_time_span (wait_handles: ARRAY [SYSTEM_THREADING_WAITHANDLE]; timeout: SYSTEM_TIMESPAN; exit_context: BOOLEAN): INTEGER is
		external
			"IL static signature (System.Threading.WaitHandle[], System.TimeSpan, System.Boolean): System.Int32 use System.Threading.WaitHandle"
		alias
			"WaitAny"
		end

	frozen wait_all (wait_handles: ARRAY [SYSTEM_THREADING_WAITHANDLE]): BOOLEAN is
		external
			"IL static signature (System.Threading.WaitHandle[]): System.Boolean use System.Threading.WaitHandle"
		alias
			"WaitAll"
		end

	frozen wait_any (wait_handles: ARRAY [SYSTEM_THREADING_WAITHANDLE]): INTEGER is
		external
			"IL static signature (System.Threading.WaitHandle[]): System.Int32 use System.Threading.WaitHandle"
		alias
			"WaitAny"
		end

	frozen wait_any_array_wait_handle_int32 (wait_handles: ARRAY [SYSTEM_THREADING_WAITHANDLE]; milliseconds_timeout: INTEGER; exit_context: BOOLEAN): INTEGER is
		external
			"IL static signature (System.Threading.WaitHandle[], System.Int32, System.Boolean): System.Int32 use System.Threading.WaitHandle"
		alias
			"WaitAny"
		end

	wait_one_int32 (milliseconds_timeout: INTEGER; exit_context: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Int32, System.Boolean): System.Boolean use System.Threading.WaitHandle"
		alias
			"WaitOne"
		end

	frozen wait_all_array_wait_handle_int32 (wait_handles: ARRAY [SYSTEM_THREADING_WAITHANDLE]; milliseconds_timeout: INTEGER; exit_context: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Threading.WaitHandle[], System.Int32, System.Boolean): System.Boolean use System.Threading.WaitHandle"
		alias
			"WaitAll"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Threading.WaitHandle"
		alias
			"Finalize"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.Threading.WaitHandle"
		alias
			"System.IDisposable.Dispose"
		end

end -- class SYSTEM_THREADING_WAITHANDLE
