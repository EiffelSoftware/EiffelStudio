indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ERROR_INFO"

deferred external class
	ERROR_INFO

feature -- Basic Operations

	a_set_name (name2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use ERROR_INFO"
		alias
			"_set_name"
		end

	description: STRING is
		external
			"IL deferred signature (): STRING use ERROR_INFO"
		alias
			"description"
		end

	make (a_code: INTEGER; a_name: STRING; a_description: STRING) is
		external
			"IL deferred signature (System.Int32, STRING, STRING): System.Void use ERROR_INFO"
		alias
			"make"
		end

	name: STRING is
		external
			"IL deferred signature (): STRING use ERROR_INFO"
		alias
			"name"
		end

	code: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ERROR_INFO"
		alias
			"code"
		end

	a_set_description (description2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use ERROR_INFO"
		alias
			"_set_description"
		end

	a_set_code (code2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ERROR_INFO"
		alias
			"_set_code"
		end

end -- class ERROR_INFO
