indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ErrorWrapper"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ERROR_WRAPPER

inherit
	SYSTEM_OBJECT

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (e: EXCEPTION) is
		external
			"IL creator signature (System.Exception) use System.Runtime.InteropServices.ErrorWrapper"
		end

	frozen make (error_code: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Runtime.InteropServices.ErrorWrapper"
		end

	frozen make_1 (error_code: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object) use System.Runtime.InteropServices.ErrorWrapper"
		end

feature -- Access

	frozen get_error_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.ErrorWrapper"
		alias
			"get_ErrorCode"
		end

end -- class ERROR_WRAPPER
