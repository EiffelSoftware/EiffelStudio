indexing
	Generator: "Eiffel Emitter 2.6b2"
	external_name: "ISE.Reflection.Support"
deferred external class
	ISE_REFLECTION_SUPPORT

feature -- Access

	frozen last_error: ISE_REFLECTION_ERRORINFO is
		external
			"IL field signature :ISE.Reflection.ErrorInfo use ISE.Reflection.Support"
		alias
			"LastError"
		end

feature -- Basic Operations

	create_error (a_name: STRING; a_description: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.Support"
		alias
			"CreateError"
		end

	create_error_from_info (a_code: INTEGER; a_name: STRING; a_description: STRING) is
		external
			"IL signature (System.Int32, System.String, System.String): System.Void use ISE.Reflection.Support"
		alias
			"CreateErrorFromInfo"
		end

	errors_table: ISE_REFLECTION_ERRORSTABLE is
		external
			"IL signature (): ISE.Reflection.ErrorsTable use ISE.Reflection.Support"
		alias
			"ErrorsTable"
		end

end -- class ISE_REFLECTION_SUPPORT
