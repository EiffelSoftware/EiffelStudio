indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.InvalidComObjectException"

external class
	SYSTEM_RUNTIME_INTEROPSERVICES_INVALIDCOMOBJECTEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_invalid_com_object_exception_2,
	make_invalid_com_object_exception_1,
	make_invalid_com_object_exception

feature {NONE} -- Initialization

	frozen make_invalid_com_object_exception_2 (message2: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.InvalidComObjectException"
		end

	frozen make_invalid_com_object_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.InvalidComObjectException"
		end

	frozen make_invalid_com_object_exception is
		external
			"IL creator use System.Runtime.InteropServices.InvalidComObjectException"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_INVALIDCOMOBJECTEXCEPTION
