indexing
	Generator: "Eiffel Emitter 2.7b2"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"
	external_name: "ISE.Runtime.EXCEPTION_MANAGER"

external class
	EXCEPTION_MANAGER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use ISE.Runtime.EXCEPTION_MANAGER"
		end

feature -- Access

	frozen last_exception: EXCEPTION is
		external
			"IL static_field signature :System.Exception use ISE.Runtime.EXCEPTION_MANAGER"
		alias
			"last_exception"
		end

feature -- Basic Operations

	frozen raise (e: EXCEPTION) is
		external
			"IL static signature (System.Exception): System.Void use ISE.Runtime.EXCEPTION_MANAGER"
		alias
			"raise"
		end

end -- class EXCEPTION_MANAGER
