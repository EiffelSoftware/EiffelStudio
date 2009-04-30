note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_OUTPUTTER

feature -- Access

	name: detachable STRING

	set_name (a_name: STRING)
		do
			name := a_name
		end

	debug_level: INTEGER = 10
			-- Set the current debug level


feature -- Print

	dprint (a_msg: STRING; a_debug_level: INTEGER)
			-- Prints a debug message only if debug level is >= a_debug_level
		require
			name_attached: check_name
		do
			if a_debug_level <= debug_level then
				print ("[" + name + "][DEBUG] " + a_msg + "%N")
			end
		end

	eprint (a_msg: STRING; a_generating_type: ANY)
			-- Prints an error message
		require
			name_attached: check_name
		do
			print ("[" + name + "][ERROR in " + a_generating_type.out + "] " + a_msg + "%N")
		end

	iprint (a_msg: STRING)
			-- Prints an info message
		require
			name_attached: check_name
		do
			print ("[" + name + "][INFO] " + a_msg + "%N")
		end

feature  -- Impl

	check_name: BOOLEAN
			-- Checks is the name is attached
		do
			name := "noname"
			Result := True
		end


end
