indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "ISE.Reflection.ErrorsTable"

external class
	ISE_REFLECTION_ERRORSTABLE

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.ErrorsTable"
		end

feature -- Access

	get_errors_table: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL signature (): System.Collections.Hashtable use ISE.Reflection.ErrorsTable"
		alias
			"get_ErrorsTable"
		end

	frozen a_internal_errors_table: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.ErrorsTable"
		alias
			"_internal_ErrorsTable"
		end

feature -- Basic Operations

	replace_error_description (a_code: INTEGER; new_description: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"ReplaceErrorDescription"
		end

	remove_error (a_code: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"RemoveError"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"Make"
		end

	error_info (a_code: INTEGER): ISE_REFLECTION_ERRORINFO is
		external
			"IL signature (System.Int32): ISE.Reflection.ErrorInfo use ISE.Reflection.ErrorsTable"
		alias
			"ErrorInfo"
		end

	error_name (a_code: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use ISE.Reflection.ErrorsTable"
		alias
			"ErrorName"
		end

	error_description (a_code: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use ISE.Reflection.ErrorsTable"
		alias
			"ErrorDescription"
		end

	frozen a_invariant (current_object: ISE_REFLECTION_ERRORSTABLE) is
		external
			"IL static signature (ISE.Reflection.ErrorsTable): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"_invariant"
		end

	add_error (an_error: ISE_REFLECTION_ERRORINFO) is
		external
			"IL signature (ISE.Reflection.ErrorInfo): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"AddError"
		end

	errors: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.ErrorsTable"
		alias
			"Errors"
		end

	replace_error_name (a_code: INTEGER; new_name: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"ReplaceErrorName"
		end

end -- class ISE_REFLECTION_ERRORSTABLE
