indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.ErrorWrapper"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_ERRORWRAPPER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (error_code: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Runtime.InteropServices.ErrorWrapper"
		end

	frozen make_1 (e: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.Exception) use System.Runtime.InteropServices.ErrorWrapper"
		end

feature -- Access

	frozen get_error_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.ErrorWrapper"
		alias
			"get_ErrorCode"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_ERRORWRAPPER
