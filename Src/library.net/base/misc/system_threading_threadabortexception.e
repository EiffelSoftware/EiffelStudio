indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Threading.ThreadAbortException"

frozen external class
	SYSTEM_THREADING_THREADABORTEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create {NONE}

feature -- Access

	frozen get_exception_state: ANY is
		external
			"IL signature (): System.Object use System.Threading.ThreadAbortException"
		alias
			"get_ExceptionState"
		end

end -- class SYSTEM_THREADING_THREADABORTEXCEPTION
