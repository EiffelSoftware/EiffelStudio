indexing
	Generator: "Eiffel Emitter beta 2"
	external_name: "ISE.Reflection.ErrorsTable"

external class
	ISE_REFLECTION_ERRORSTABLE

inherit
	ISE_REFLECTION_ERRORMESSAGES

create
	make_errorstable

feature {NONE} -- Initialization

	frozen make_errorstable is
		external
			"IL creator use ISE.Reflection.ErrorsTable"
		end

feature -- Access

	frozen errorstable: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.ErrorsTable"
		alias
			"ErrorsTable"
		end

feature -- Basic Operations

	replaceerrordescription (a_code: INTEGER; new_description: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"ReplaceErrorDescription"
		end

	replaceerrorname (a_code: INTEGER; new_name: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"ReplaceErrorName"
		end

	adderror (a_code: INTEGER; a_name: STRING; a_description: STRING) is
		external
			"IL signature (System.Int32, System.String, System.String): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"AddError"
		end

	errordescription (a_code: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use ISE.Reflection.ErrorsTable"
		alias
			"ErrorDescription"
		end

	fillerrorstable is
		external
			"IL signature (): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"FillErrorsTable"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"Make"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.ErrorsTable"
		alias
			"_invariant"
		end

	errorname (a_code: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use ISE.Reflection.ErrorsTable"
		alias
			"ErrorName"
		end

end -- class ISE_REFLECTION_ERRORSTABLE
