indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.InvalidComObjectException"

external class
	SYSTEM_RUNTIME_INTEROPSERVICES_INVALIDCOMOBJECTEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_invalidcomobjectexception_2,
	make_invalidcomobjectexception_1,
	make_invalidcomobjectexception

feature {NONE} -- Initialization

	frozen make_invalidcomobjectexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.InvalidComObjectException"
		end

	frozen make_invalidcomobjectexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.InvalidComObjectException"
		end

	frozen make_invalidcomobjectexception is
		external
			"IL creator use System.Runtime.InteropServices.InvalidComObjectException"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_INVALIDCOMOBJECTEXCEPTION
