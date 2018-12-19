note
	description: "EiffelWeb console wizard application."
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_CONSOLE_WIZARD_APPLICATION

inherit
	CONSOLE_WIZARD_APPLICATION

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
