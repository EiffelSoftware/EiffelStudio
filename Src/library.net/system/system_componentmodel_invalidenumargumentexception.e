indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.InvalidEnumArgumentException"

external class
	SYSTEM_COMPONENTMODEL_INVALIDENUMARGUMENTEXCEPTION

inherit
	SYSTEM_ARGUMENTEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_invalidenumargumentexception_1,
	make_invalidenumargumentexception,
	make_invalidenumargumentexception_2

feature {NONE} -- Initialization

	frozen make_invalidenumargumentexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.InvalidEnumArgumentException"
		end

	frozen make_invalidenumargumentexception is
		external
			"IL creator use System.ComponentModel.InvalidEnumArgumentException"
		end

	frozen make_invalidenumargumentexception_2 (argument_name: STRING; invalid_value: INTEGER; enum_class: SYSTEM_TYPE) is
		external
			"IL creator signature (System.String, System.Int32, System.Type) use System.ComponentModel.InvalidEnumArgumentException"
		end

end -- class SYSTEM_COMPONENTMODEL_INVALIDENUMARGUMENTEXCEPTION
