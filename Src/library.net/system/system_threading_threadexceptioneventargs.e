indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Threading.ThreadExceptionEventArgs"

external class
	SYSTEM_THREADING_THREADEXCEPTIONEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_threadexceptioneventargs

feature {NONE} -- Initialization

	frozen make_threadexceptioneventargs (t: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.Exception) use System.Threading.ThreadExceptionEventArgs"
		end

feature -- Access

	frozen get_exception: SYSTEM_EXCEPTION is
		external
			"IL signature (): System.Exception use System.Threading.ThreadExceptionEventArgs"
		alias
			"get_Exception"
		end

end -- class SYSTEM_THREADING_THREADEXCEPTIONEVENTARGS
