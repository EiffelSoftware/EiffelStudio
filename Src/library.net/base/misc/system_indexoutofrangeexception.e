indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IndexOutOfRangeException"

frozen external class
	SYSTEM_INDEXOUTOFRANGEEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_indexoutofrangeexception_1,
	make_indexoutofrangeexception,
	make_indexoutofrangeexception_2

feature {NONE} -- Initialization

	frozen make_indexoutofrangeexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.IndexOutOfRangeException"
		end

	frozen make_indexoutofrangeexception is
		external
			"IL creator use System.IndexOutOfRangeException"
		end

	frozen make_indexoutofrangeexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IndexOutOfRangeException"
		end

end -- class SYSTEM_INDEXOUTOFRANGEEXCEPTION
