indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.COMException"

external class
	SYSTEM_RUNTIME_INTEROPSERVICES_COMEXCEPTION

inherit
	SYSTEM_RUNTIME_INTEROPSERVICES_EXTERNALEXCEPTION
		redefine
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_com_exception_3,
	make_com_exception_2,
	make_com_exception,
	make_com_exception_1

feature {NONE} -- Initialization

	frozen make_com_exception_3 (message2: STRING; errorCode2: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Runtime.InteropServices.COMException"
		end

	frozen make_com_exception_2 (message2: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.COMException"
		end

	frozen make_com_exception is
		external
			"IL creator use System.Runtime.InteropServices.COMException"
		end

	frozen make_com_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.COMException"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.COMException"
		alias
			"ToString"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_COMEXCEPTION
