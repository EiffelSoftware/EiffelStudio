indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.DuplicateWaitObjectException"

external class
	SYSTEM_DUPLICATEWAITOBJECTEXCEPTION

inherit
	SYSTEM_ARGUMENTEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_duplicatewaitobjectexception,
	make_duplicatewaitobjectexception_2,
	make_duplicatewaitobjectexception_1

feature {NONE} -- Initialization

	frozen make_duplicatewaitobjectexception is
		external
			"IL creator use System.DuplicateWaitObjectException"
		end

	frozen make_duplicatewaitobjectexception_2 (parameter_name: STRING; message: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.DuplicateWaitObjectException"
		end

	frozen make_duplicatewaitobjectexception_1 (parameter_name: STRING) is
		external
			"IL creator signature (System.String) use System.DuplicateWaitObjectException"
		end

end -- class SYSTEM_DUPLICATEWAITOBJECTEXCEPTION
