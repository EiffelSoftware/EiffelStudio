indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.Monitor"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	MONITOR

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen try_enter_object_time_span (obj: SYSTEM_OBJECT; timeout: TIME_SPAN): BOOLEAN is
		external
			"IL static signature (System.Object, System.TimeSpan): System.Boolean use System.Threading.Monitor"
		alias
			"TryEnter"
		end

	frozen pulse (obj: SYSTEM_OBJECT) is
		external
			"IL static signature (System.Object): System.Void use System.Threading.Monitor"
		alias
			"Pulse"
		end

	frozen wait_object_int32 (obj: SYSTEM_OBJECT; milliseconds_timeout: INTEGER): BOOLEAN is
		external
			"IL static signature (System.Object, System.Int32): System.Boolean use System.Threading.Monitor"
		alias
			"Wait"
		end

	frozen wait_object_time_span (obj: SYSTEM_OBJECT; timeout: TIME_SPAN): BOOLEAN is
		external
			"IL static signature (System.Object, System.TimeSpan): System.Boolean use System.Threading.Monitor"
		alias
			"Wait"
		end

	frozen enter (obj: SYSTEM_OBJECT) is
		external
			"IL static signature (System.Object): System.Void use System.Threading.Monitor"
		alias
			"Enter"
		end

	frozen try_enter (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Threading.Monitor"
		alias
			"TryEnter"
		end

	frozen wait_object_int32_boolean (obj: SYSTEM_OBJECT; milliseconds_timeout: INTEGER; exit_context: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Object, System.Int32, System.Boolean): System.Boolean use System.Threading.Monitor"
		alias
			"Wait"
		end

	frozen wait_object_time_span_boolean (obj: SYSTEM_OBJECT; timeout: TIME_SPAN; exit_context: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Object, System.TimeSpan, System.Boolean): System.Boolean use System.Threading.Monitor"
		alias
			"Wait"
		end

	frozen pulse_all (obj: SYSTEM_OBJECT) is
		external
			"IL static signature (System.Object): System.Void use System.Threading.Monitor"
		alias
			"PulseAll"
		end

	frozen try_enter_object_int32 (obj: SYSTEM_OBJECT; milliseconds_timeout: INTEGER): BOOLEAN is
		external
			"IL static signature (System.Object, System.Int32): System.Boolean use System.Threading.Monitor"
		alias
			"TryEnter"
		end

	frozen wait (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Threading.Monitor"
		alias
			"Wait"
		end

	frozen exit (obj: SYSTEM_OBJECT) is
		external
			"IL static signature (System.Object): System.Void use System.Threading.Monitor"
		alias
			"Exit"
		end

end -- class MONITOR
