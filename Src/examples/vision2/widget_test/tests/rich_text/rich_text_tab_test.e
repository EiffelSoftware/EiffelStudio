indexing
	description: "Objects that test `tab_positions' of EV_RICH_TEXT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RICH_TEXT_TAB_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
		do
			create rich_text
			create vertical_box
			vertical_box.extend (rich_text)
			create tab_controller
			create horizontal_box
			vertical_box.extend (horizontal_box)
			vertical_box.disable_item_expand (horizontal_box)
			horizontal_box.extend (create {EV_LABEL}.make_with_text ("Tab width : "))
			horizontal_box.disable_item_expand (horizontal_box.i_th (1))
			horizontal_box.extend (tab_controller)
			
			rich_text.set_minimum_size (300, 300)
			rich_text.set_text ("1,1	2,1	3,1%N1,2	2,2	3,2%N1,3	2,3	2,4")
			tab_controller.value_range.adapt (create {INTEGER_INTERVAL}.make (20, 100))
			tab_controller.set_value (rich_text.tab_width)
			tab_controller.change_actions.extend (agent update_tabs)
			widget := vertical_box
		end
		
feature {NONE} -- Implementation
		
	update_tabs (new_value: INTEGER) is
			-- Set first five tabs for `rich_text' to `new_value'.
		local
			counter: INTEGER
			tab_positions: EV_ACTIVE_LIST [INTEGER]
		do
			create tab_positions
			from
				counter := 1
			until
				counter > 5
			loop
				tab_positions.extend (new_value)
				counter := counter + 1
			end
			rich_text.tab_positions.wipe_out
			rich_text.tab_positions.fill (tab_positions)
		end

	rich_text: EV_RICH_TEXT
		-- Widget that test is to be performed on.
		
	tab_controller: EV_SPIN_BUTTON;
		-- Spin button to control tab width

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


end -- class RICH_TEXT_TAB_TEST
