indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.ErrorInfo"
	assembly: "ISE.Reflection.Support", "0.0.0.0", "neutral", "a3b366af8d5e38c"

external class
	ISE_REFLECTION_ERRORINFO

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.ErrorInfo"
		end

feature -- Access

	frozen a_internal_code: INTEGER is
		external
			"IL field signature :System.Int32 use ISE.Reflection.ErrorInfo"
		alias
			"_internal_Code"
		end

	get_description: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ErrorInfo"
		alias
			"get_Description"
		end

	get_code: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.ErrorInfo"
		alias
			"get_Code"
		end

	frozen a_internal_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.ErrorInfo"
		alias
			"_internal_Name"
		end

	frozen a_internal_description: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.ErrorInfo"
		alias
			"_internal_Description"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ErrorInfo"
		alias
			"get_Name"
		end

feature -- Basic Operations

	frozen a_invariant (current_object: ISE_REFLECTION_ERRORINFO) is
		external
			"IL static signature (ISE.Reflection.ErrorInfo): System.Void use ISE.Reflection.ErrorInfo"
		alias
			"_invariant"
		end

	make (a_code: INTEGER; a_name: STRING; a_description: STRING) is
		external
			"IL signature (System.Int32, System.String, System.String): System.Void use ISE.Reflection.ErrorInfo"
		alias
			"Make"
		end

end -- class ISE_REFLECTION_ERRORINFO
