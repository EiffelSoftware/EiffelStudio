indexing
	description: "User specific options."
	date: "$Date$"
	revision: "$Revision$"

class
	USER_OPTIONS

feature -- Access

	eifgen: STRING
			-- EIFGEN location.

	arguments: ARRAYED_LIST [STRING]
			-- List of arguments used by current project.

feature -- Update

	set_eifgen (a_location: like eifgen) is
			-- Set `eifgen' to `a_location'.
		require
			a_location_not_void: a_location /= Void
		do
			eifgen := a_location
		ensure
			eifgen_set: eifgen = a_location
		end

	set_arguments (an_arguments: like arguments) is
			-- Set `arguments' to `an_arguments'.
		do
			arguments := an_arguments
		ensure
			arguments_set: arguments = an_arguments
		end


end
