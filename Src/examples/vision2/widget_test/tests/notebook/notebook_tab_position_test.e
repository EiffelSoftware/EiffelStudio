note
	description: "Objects that demonstrate tab positioning within an EV_NOTEBOOK"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NOTEBOOK_TAB_POSITION_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create `Current' and initialize test in `widget'.
		local
			item_counter: INTEGER
			button: EV_BUTTON
			vertical_box: EV_VERTICAL_BOX
			combo_box: EV_COMBO_BOX
			list_item: EV_LIST_ITEM
		do
			create notebook
			notebook.set_minimum_size (200, 200)
			create combo_box
			from
				item_counter := 1
			until
				item_counter > 4
			loop
					-- Create an EV_BUTTON and add to `notebook'
				create button.make_with_text ("Button : " + item_counter.out)
				notebook.extend (button)
				notebook.set_item_text (button, item_counter.out)

					-- Create an EV_LIST_ITEM and add to `combo_box'
				create list_item.make_with_text (item_texts @ item_counter)
				combo_box.extend (list_item)
				list_item.select_actions.extend (agent notebook.set_tab_position (tab_position_constants @ item_counter))

				item_counter := item_counter + 1
			end

			create vertical_box
			vertical_box.extend (notebook)
			vertical_box.extend (combo_box)
			vertical_box.disable_item_expand (combo_box)

			widget := vertical_box
		end

feature {NONE} -- Implementation

	item_texts: ARRAY [STRING]
			-- Access to all strings for combo box entries.
		once
			create Result.make_filled ("", 1, 4)
			Result := <<"Tab_position_top", "Tab_position_bottom", "Tab_position_left", "Tab_position_right">>
		end

	tab_position_constants: ARRAY [INTEGER]
			-- Tab position constants, matching `item_texts'.
		once
			create Result.make_filled (0, 1, 4)
			Result.put (notebook.Tab_top, 1)
			Result.put (notebook.Tab_bottom, 2)
			Result.put (notebook.Tab_left, 3)
			Result.put (notebook.Tab_right, 4)
		end

	notebook: EV_NOTEBOOK;
		-- Widget that test is to be performed on.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class NOTEBOOK_TAB_POSITION_TEST
