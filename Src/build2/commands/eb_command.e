indexing
	description	: "Abstract notion of a command"
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	EB_COMMAND

inherit
	E_CMD

--	EB_CONSTANTS
--		export
--			{NONE} all
--		end

feature -- Access

	accelerator: EV_ACCELERATOR
			-- Key combination that executes `Current'.

	Key_constants: EV_KEY_CONSTANTS is
			-- All key codes.
		once
			create Result
		end

end -- class EB_COMMAND
