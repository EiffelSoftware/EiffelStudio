indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.NotImplementedException"

external class
	SYSTEM_NOTIMPLEMENTEDEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_notimplementedexception_1,
	make_notimplementedexception_2,
	make_notimplementedexception

feature {NONE} -- Initialization

	frozen make_notimplementedexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.NotImplementedException"
		end

	frozen make_notimplementedexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.NotImplementedException"
		end

	frozen make_notimplementedexception is
		external
			"IL creator use System.NotImplementedException"
		end

end -- class SYSTEM_NOTIMPLEMENTEDEXCEPTION
