indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.TypeUnloadedException"

external class
	SYSTEM_TYPEUNLOADEDEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_typeunloadedexception_2,
	make_typeunloadedexception_1,
	make_typeunloadedexception

feature {NONE} -- Initialization

	frozen make_typeunloadedexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.TypeUnloadedException"
		end

	frozen make_typeunloadedexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.TypeUnloadedException"
		end

	frozen make_typeunloadedexception is
		external
			"IL creator use System.TypeUnloadedException"
		end

end -- class SYSTEM_TYPEUNLOADEDEXCEPTION
