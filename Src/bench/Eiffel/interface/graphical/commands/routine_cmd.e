indexing
	description: "Command executed through an agent call"
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_CMD

	-- Replace ANY below by the name of parent class if any (adding more parents
	-- if necessary); otherwise you can remove inheritance clause altogether.
inherit
	COMMAND

create
	make

feature -- Initialization

	make (p: PROCEDURE [ANY, TUPLE]) is
		do
			action_routine := p
		end

feature -- Access

	execute (arg: ANY) is
		do
			action_routine.call (Void)
		end

feature {NONE} -- Implementation

	action_routine: PROCEDURE [ANY, TUPLE]
			-- Agent called when `execute' is called.

end -- class ROUTINE_CMD
