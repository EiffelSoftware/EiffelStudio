indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "ISE.Reflection.ErrorInfo"

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

	frozen Name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.ErrorInfo"
		alias
			"Name"
		end

	frozen Description: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.ErrorInfo"
		alias
			"Description"
		end

	frozen Code: INTEGER is
		external
			"IL field signature :System.Int32 use ISE.Reflection.ErrorInfo"
		alias
			"Code"
		end

feature -- Basic Operations

	Make (a_code: INTEGER; a_name: STRING; a_description: STRING) is
		external
			"IL signature (System.Int32, System.String, System.String): System.Void use ISE.Reflection.ErrorInfo"
		alias
			"Make"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.ErrorInfo"
		alias
			"_invariant"
		end

end -- class ISE_REFLECTION_ERRORINFO
