indexing
	description:
		"This kind of format is long to process. Ask %
			%for a confirmation before executing it."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_LONG_FORMATTER

inherit
	EB_FILTERABLE
		redefine
			launch_cmd
		end

feature -- Commands

	launch_cmd: EB_LONG_FORMAT_COMMAND

end -- class EB_LONG_FORMATTER
