indexing
	description: "List of states that the user can choose between %
				% when right-clicking."
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_PANEL_STATES_WND

inherit

	CHOICE_WND
		rename
			make as choice_make
		undefine
			continue_after_popdown
		end

creation

	make

feature -- Initialization

	make (a_parent: COMPOSITE; c: STATE_HOLE) is
			-- Creation routine
		do
			caller := c
			choice_make (a_parent)
		end

	caller: STATE_HOLE

feature {NONE} -- Implementation

	continue_after_popdown is
		do
			if not equal (list.selected_item.value, "Cancel") then
				caller.set_state (list.selected_item.value)
			end
		end

end -- class MAIN_PANEL_STATES_WND
