indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.ThreadAbortException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	THREAD_ABORT_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create {NONE}

feature -- Access

	frozen get_exception_state: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Threading.ThreadAbortException"
		alias
			"get_ExceptionState"
		end

end -- class THREAD_ABORT_EXCEPTION
