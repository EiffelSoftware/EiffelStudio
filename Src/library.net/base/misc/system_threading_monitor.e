indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Threading.Monitor"

frozen external class
	SYSTEM_THREADING_MONITOR

create {NONE}

feature -- Basic Operations

	frozen try_enter_object_time_span (obj: ANY; timeout: SYSTEM_TIMESPAN): BOOLEAN is
		external
			"IL static signature (System.Object, System.TimeSpan): System.Boolean use System.Threading.Monitor"
		alias
			"TryEnter"
		end

	frozen pulse (obj: ANY) is
		external
			"IL static signature (System.Object): System.Void use System.Threading.Monitor"
		alias
			"Pulse"
		end

	frozen wait_object_int32 (obj: ANY; milliseconds_timeout: INTEGER): BOOLEAN is
		external
			"IL static signature (System.Object, System.Int32): System.Boolean use System.Threading.Monitor"
		alias
			"Wait"
		end

	frozen wait_object_time_span (obj: ANY; timeout: SYSTEM_TIMESPAN): BOOLEAN is
		external
			"IL static signature (System.Object, System.TimeSpan): System.Boolean use System.Threading.Monitor"
		alias
			"Wait"
		end

	frozen enter (obj: ANY) is
		external
			"IL static signature (System.Object): System.Void use System.Threading.Monitor"
		alias
			"Enter"
		end

	frozen try_enter (obj: ANY): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Threading.Monitor"
		alias
			"TryEnter"
		end

	frozen wait_object_int32_boolean (obj: ANY; milliseconds_timeout: INTEGER; exit_context: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Object, System.Int32, System.Boolean): System.Boolean use System.Threading.Monitor"
		alias
			"Wait"
		end

	frozen wait_object_time_span_boolean (obj: ANY; timeout: SYSTEM_TIMESPAN; exit_context: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Object, System.TimeSpan, System.Boolean): System.Boolean use System.Threading.Monitor"
		alias
			"Wait"
		end

	frozen pulse_all (obj: ANY) is
		external
			"IL static signature (System.Object): System.Void use System.Threading.Monitor"
		alias
			"PulseAll"
		end

	frozen try_enter_object_int32 (obj: ANY; milliseconds_timeout: INTEGER): BOOLEAN is
		external
			"IL static signature (System.Object, System.Int32): System.Boolean use System.Threading.Monitor"
		alias
			"TryEnter"
		end

	frozen wait (obj: ANY): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Threading.Monitor"
		alias
			"Wait"
		end

	frozen exit (obj: ANY) is
		external
			"IL static signature (System.Object): System.Void use System.Threading.Monitor"
		alias
			"Exit"
		end

end -- class SYSTEM_THREADING_MONITOR
