indexing
	description: "Objects that demonstrate an EV_FIXED%
		%being enlarged as a result of the positions of its items."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FIXED_INCREASE_ITEM_POSITION_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			button1, button2: EV_BUTTON
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
		
	move_button (a_button: EV_BUTTON; x, y: INTEGER) is
			-- Move `a_button' by `x' and `y' within `fixed'.
		require
			fixed_has_button: fixed.has (a_button)
		do
			fixed.set_item_position (a_button, a_button.x_position + x, a_button.y_position + y)
		end
		
		
feature {NONE} -- Implementation

	fixed: EV_FIXED
	
	move_right, move_down, move_diagonal: EV_BUTTON

end -- class FIXED_INCREASE_ITEM_POSITION_TEST
