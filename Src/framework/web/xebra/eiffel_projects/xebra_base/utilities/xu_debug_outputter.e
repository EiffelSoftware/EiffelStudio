note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XU_DEBUG_OUTPUTTER

feature -- Access

	debug_level: INTEGER = 10
			-- Set the current debug level

feature

	dprint (a_msg: STRING; a_debug_level: INTEGER)
			-- Prints a message only if debug level is >= a_debug_level
		do
			if a_debug_level <= debug_level then
				print ("[DEBUG] " + a_msg + "%N")
			end
		end

end
