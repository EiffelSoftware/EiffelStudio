indexing
	description: "Commands available in metric interface."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_COMMAND

inherit
	EB_TOOLBARABLE_COMMAND

	EB_TARGET_COMMAND
		rename
			target as tool
		redefine
			tool,
			make
		end

feature {NONE} -- Initialization

	make (a_target: like tool) is
			-- Initialize the command with target `a_target'.
		require else
			valid_target: a_target /= Void
		do
			Precursor (a_target)
		ensure then
			tool /= Void
		end

feature -- Access

	tool: EB_METRIC_TOOL
			-- Associated with `Current'.

end -- class EB_METRIC_COMMAND
