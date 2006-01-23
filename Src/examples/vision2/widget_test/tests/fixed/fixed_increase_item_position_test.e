indexing
	description: "Objects that demonstrate an EV_FIXED%
		%being enlarged as a result of the positions of its items."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FIXED_INCREASE_ITEM_POSITION_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create fixed
			create move_right.make_with_text ("Move right")
			create move_down.make_with_text ("Move down")
			create move_diagonal.make_with_text ("Move diagonal")
			fixed.extend (move_right)
			fixed.extend (move_down)
			fixed.extend (move_diagonal)
			fixed.set_item_position (move_right, move_down.width, 0)
			fixed.set_item_position (move_down, 0, move_right.height)
			fixed.set_item_position (move_diagonal, move_down.width, move_right.height)
			
			move_right.select_actions.extend (agent move_button (move_right, 10, 0))
			move_down.select_actions.extend (agent move_button (move_down, 0, 10))
			move_diagonal.select_actions.extend (agent move_button (move_diagonal, 10, 10))
			
			widget := fixed
		end

feature {NONE} -- Implementation
		
	move_button (a_button: EV_BUTTON; x, y: INTEGER) is
			-- Move `a_button' by `x' and `y' within `fixed'.
		require
			fixed_has_button: fixed.has (a_button)
		do
			fixed.set_item_position (a_button, a_button.x_position + x, a_button.y_position + y)
		end
		
	fixed: EV_FIXED
		-- Widget that test is to be performed on.
	
	move_right, move_down, move_diagonal: EV_BUTTON;
		-- Widgets placed in `fixed' that show its operation.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class FIXED_INCREASE_ITEM_POSITION_TEST
