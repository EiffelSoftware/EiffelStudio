indexing
	Generator: "Eiffel Emitter beta 2"
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

	frozen code: INTEGER is
		external
			"IL field signature :System.Int32 use ISE.Reflection.ErrorInfo"
		alias
			"Code"
		end

feature -- Basic Operations

	description: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ErrorInfo"
		alias
			"Description"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.ErrorInfo"
		alias
			"_invariant"
		end

	errorstable: ISE_REFLECTION_ERRORSTABLE is
		external
			"IL signature (): ISE.Reflection.ErrorsTable use ISE.Reflection.ErrorInfo"
		alias
			"ErrorsTable"
		end

	name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ErrorInfo"
		alias
			"Name"
		end

	make (a_code: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use ISE.Reflection.ErrorInfo"
		alias
			"Make"
		end

end -- class ISE_REFLECTION_ERRORINFO
