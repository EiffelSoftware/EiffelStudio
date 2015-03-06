note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	EWF_CONSOLE_WIZARD_APPLICATION

inherit
	CONSOLE_WIZARD_APPLICATION

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			initialize
			on_start
		end

feature {NONE} -- Initialization

	new_wizard: EWF_WIZARD
		do
			create Result.make (Current)
		end

end
