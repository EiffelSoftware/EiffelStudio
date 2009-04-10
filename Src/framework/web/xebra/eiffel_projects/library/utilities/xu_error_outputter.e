note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XU_ERROR_OUTPUTTER


feature

	eprint (a_msg: STRING; )
			-- Prints an error message
		do
			print ("[ERROR] " + generating_type + ": " + a_msg + "%N")
		end

end
