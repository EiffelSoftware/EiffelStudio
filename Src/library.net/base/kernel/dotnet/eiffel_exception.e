indexing
	description: "Representation of an Eiffel developer exception."
	external_name: "EiffelSoftware.Runtime.EIFFEL_EXCEPTION"
	assembly: "EiffelSoftware.Runtime", "5.5.0.0", "neutral", "def26f296efef469"
	date: "$Date$"
	revision: "$Revision$"

external class
	EIFFEL_EXCEPTION

inherit
	APPLICATION_EXCEPTION
		rename
			make as exc_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_code: INTEGER; a_tag: SYSTEM_STRING) is
			-- Create an exception with the given Eiffel code.
		external
			"IL creator signature (System.Int32, System.String) use EiffelSoftware.Runtime.EIFFEL_EXCEPTION"
		end

feature -- Access

	code: INTEGER is
			-- Eiffel code describing the type of exception
			-- (see EXCEPT_CONST for more information).
		external
			"IL field signature : System.Int32 use EiffelSoftware.Runtime.EIFFEL_EXCEPTION"
		alias
			"code"
		end

	tag: SYSTEM_STRING is
			-- Additional information concerning current exception.
		external
			"IL field signature : System.String use EiffelSoftware.Runtime.EIFFEL_EXCEPTION"
		alias
			"tag"
		end

end -- class EIFFEL_EXCEPTION
