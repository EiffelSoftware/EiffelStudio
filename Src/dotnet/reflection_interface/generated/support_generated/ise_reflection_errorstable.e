indexing
	Generator: "Eiffel Emitter 2.3b"
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

	frozen ErrorsTable: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.ErrorsTable"
		alias
			"ErrorsTable"
		end

feature -- Basic Operations

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"Make"
		end

	ErrorDescription (a_code: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use ISE.Reflection.ErrorsTable"
		alias
			"ErrorDescription"
		end

	Errors: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.ErrorsTable"
		alias
			"Errors"
		end

	RemoveError (a_code: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"RemoveError"
		end

	AddError (an_error: ISE_REFLECTION_ERRORINFO) is
		external
			"IL signature (ISE.Reflection.ErrorInfo): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"AddError"
		end

	ReplaceErrorDescription (a_code: INTEGER; new_description: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"ReplaceErrorDescription"
		end

	ReplaceErrorName (a_code: INTEGER; new_name: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"ReplaceErrorName"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"_invariant"
		end

	ErrorName (a_code: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use ISE.Reflection.ErrorsTable"
		alias
			"ErrorName"
		end

	ErrorInfo (a_code: INTEGER): ISE_REFLECTION_ERRORINFO is
		external
			"IL signature (System.Int32): ISE.Reflection.ErrorInfo use ISE.Reflection.ErrorsTable"
		alias
			"ErrorInfo"
		end

end -- class ISE_REFLECTION_ERRORSTABLE
