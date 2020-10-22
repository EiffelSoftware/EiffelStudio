 note
	description: "Eiffel wrapc console wizard."
	date: "$Date$"
	revision: "$Revision$"

class
	WRAPC_CONSOLE_WIZARD_APPLICATION

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

	new_wizard: WRAPC_WIZARD
		do
			create Result.make (Current)
		end

end
