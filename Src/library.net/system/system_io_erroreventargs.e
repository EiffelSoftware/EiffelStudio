indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.ErrorEventArgs"

external class
	SYSTEM_IO_ERROREVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_erroreventargs

feature {NONE} -- Initialization

	frozen make_erroreventargs (exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.Exception) use System.IO.ErrorEventArgs"
		end

feature -- Basic Operations

	get_exception: SYSTEM_EXCEPTION is
		external
			"IL signature (): System.Exception use System.IO.ErrorEventArgs"
		alias
			"GetException"
		end

end -- class SYSTEM_IO_ERROREVENTARGS
