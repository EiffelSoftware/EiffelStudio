indexing
	description: "Entry in a menu used to create a new command."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_COMMAND_ENTRY

inherit

	MAIN_PANEL_TOGGLE

creation

	make

feature {NONE} -- Implementation

	toggle_pressed is
			-- Hide or show the class selector.
		do
			if armed then
				class_selector.display
			else
				class_selector.hide
			end
		end

end -- class CREATE_COMMAND_ENTRY
