indexing
	Generator: "Eiffel Emitter v2809.1"

external class
	EXCEPTION_MANAGER
alias
	"ISE.Runtime.EXCEPTION_MANAGER"

create
	make

feature {NONE} -- Initialization

	make is
		external
			"IL creator use ISE.Runtime.EXCEPTION_MANAGER"
		end

feature -- Access

	last_exception: SYSTEM_EXCEPTION is
		external
			"IL static_field signature :System.Exception use ISE.Runtime.EXCEPTION_MANAGER"
		alias
			"last_exception"
		end

feature -- Status setting

	raise (e: SYSTEM_EXCEPTION) is
			-- Raise an exception of type `e'.
		external
			"IL static signature (System.Exception) use ISE.Runtime.EXCEPTION_MANAGER"
		alias
			"raise"
		end

feature -- Element Change

	set_last_exception is
		external
			"IL set_static_field signature (System.Exception) use ISE.Runtime.EXCEPTION_MANAGER"
		alias
			"last_exception"
		end

end -- class EXCEPTION_MANAGER
