indexing
	description: "Command to quit EiffelBuild"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class

	EXIT_EIFFEL_BUILD_CMD

inherit

	COMMAND

	WINDOWS

feature

	execute (arg: ANY) is
			-- Quit EiffelBuild
		do
			main_panel.close
		end

end -- class EXIT_EIFFEL_BUILD_CMD
