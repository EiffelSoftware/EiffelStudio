indexing
	description: "Objects that test EV_CHECKABLE_TREE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CHECKABLE_TREE_ADVANCED_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local 
			l_ev_horizontal_box_1: EV_HORIZONTAL_BOX
			l_ev_tree_item_1, l_ev_tree_item_2, l_ev_tree_item_3, l_ev_tree_item_4, l_ev_tree_item_5, 
			l_ev_tree_item_6, l_ev_tree_item_7, l_ev_tree_item_8, l_ev_tree_item_9, l_ev_tree_item_10, 
			l_ev_tree_item_11, l_ev_tree_item_12, l_ev_tree_item_13, l_ev_tree_item_14, 
			l_ev_tree_item_15, l_ev_tree_item_16, l_ev_tree_item_17, l_ev_tree_item_18, 
			l_ev_tree_item_19, l_ev_tree_item_20: EV_TREE_ITEM
			l_ev_vertical_box_1: EV_VERTICAL_BOX
			l_ev_button_1, l_ev_button_2, l_ev_button_3, l_ev_button_4: EV_BUTTON
		do
			
				-- Create all widgets.
			create l_ev_horizontal_box_1
			create test_tree
			create l_ev_tree_item_1
			create l_ev_tree_item_2
			create l_ev_tree_item_3
			create l_ev_tree_item_4
			create l_ev_tree_item_5
			create l_ev_tree_item_6
			create l_ev_tree_item_7
			create l_ev_tree_item_8
			create l_ev_tree_item_9
			create l_ev_tree_item_10
			create l_ev_tree_item_11
			create l_ev_tree_item_12
			create l_ev_tree_item_13
			create l_ev_tree_item_14
			create l_ev_tree_item_15
			create l_ev_tree_item_16
			create l_ev_tree_item_17
			create l_ev_tree_item_18
			create l_ev_tree_item_19
			create l_ev_tree_item_20
			create l_ev_vertical_box_1
			create output
			create l_ev_button_1
			create l_ev_button_2
			create l_ev_button_3
			create l_ev_button_4
			
				-- Build_widget_structure.
			l_ev_horizontal_box_1.extend (test_tree)
			test_tree.extend (l_ev_tree_item_1)
			l_ev_tree_item_1.extend (l_ev_tree_item_2)
			l_ev_tree_item_1.extend (l_ev_tree_item_3)
			l_ev_tree_item_1.extend (l_ev_tree_item_4)
			l_ev_tree_item_4.extend (l_ev_tree_item_5)
			l_ev_tree_item_4.extend (l_ev_tree_item_6)
			l_ev_tree_item_4.extend (l_ev_tree_item_7)
			l_ev_tree_item_4.extend (l_ev_tree_item_8)
			l_ev_tree_item_4.extend (l_ev_tree_item_9)
			l_ev_tree_item_1.extend (l_ev_tree_item_10)
			l_ev_tree_item_1.extend (l_ev_tree_item_11)
			test_tree.extend (l_ev_tree_item_12)
			test_tree.extend (l_ev_tree_item_13)
			test_tree.extend (l_ev_tree_item_14)
			l_ev_tree_item_14.extend (l_ev_tree_item_15)
			l_ev_tree_item_14.extend (l_ev_tree_item_16)
			l_ev_tree_item_14.extend (l_ev_tree_item_17)
			l_ev_tree_item_14.extend (l_ev_tree_item_18)
			l_ev_tree_item_14.extend (l_ev_tree_item_19)
			test_tree.extend (l_ev_tree_item_20)
			l_ev_horizontal_box_1.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (output)
			l_ev_vertical_box_1.extend (l_ev_button_1)
			l_ev_vertical_box_1.extend (l_ev_button_2)
			l_ev_vertical_box_1.extend (l_ev_button_3)
			l_ev_vertical_box_1.extend (l_ev_button_4)

			l_ev_horizontal_box_1.disable_item_expand (l_ev_vertical_box_1)
			test_tree.set_minimum_height (250)
			l_ev_tree_item_1.enable_select
			l_ev_tree_item_1.set_text ("Item 1")
			l_ev_tree_item_2.set_text ("Item 2")
			l_ev_tree_item_3.set_text ("Item 3")
			l_ev_tree_item_4.set_text ("Item 4")
			l_ev_tree_item_5.set_text ("Item 5")
			l_ev_tree_item_6.set_text ("Item 6")
			l_ev_tree_item_7.set_text ("Item 7")
			l_ev_tree_item_8.set_text ("Item 8")
			l_ev_tree_item_9.set_text ("Item 9")
			l_ev_tree_item_10.set_text ("Item 10")
			l_ev_tree_item_11.set_text ("Item 11")
			l_ev_tree_item_12.set_text ("Item 12")
			l_ev_tree_item_13.set_text ("Item 13")
			l_ev_tree_item_14.set_text ("Item 14")
			l_ev_tree_item_15.set_text ("Item 15")
			l_ev_tree_item_16.set_text ("Item 16")
			l_ev_tree_item_17.set_text ("Item 17")
			l_ev_tree_item_18.set_text ("Item 18")
			l_ev_tree_item_19.set_text ("Item 19")
			l_ev_tree_item_20.set_text ("Item 20")
			l_ev_vertical_box_1.disable_item_expand (l_ev_button_1)
			l_ev_vertical_box_1.disable_item_expand (l_ev_button_2)
			l_ev_vertical_box_1.disable_item_expand (l_ev_button_3)
			l_ev_vertical_box_1.disable_item_expand (l_ev_button_4)
			output.set_minimum_height (100)
			l_ev_button_1.set_text ("Check selected iitem")
			l_ev_button_2.set_text ("Uncheck selected item")
			l_ev_button_3.set_text ("Is item checked?")
			l_ev_button_4.set_text ("Display checked items")
			
				--Connect events.
			l_ev_button_1.select_actions.extend (agent check_selected_item)
			l_ev_button_2.select_actions.extend (agent uncheck_selected_item)
			l_ev_button_3.select_actions.extend (agent is_item_checked)
			l_ev_button_4.select_actions.extend (agent display_checked_items)
			test_tree.uncheck_actions.extend (agent item_unchecked)
			test_tree.check_actions.extend (agent item_checked)

			widget := l_ev_horizontal_box_1
			widget.set_minimum_size (300, 300)
		end
		
feature {NONE} -- Implementation

	test_tree: EV_CHECKABLE_TREE
		-- Widget that test is to be performed on.
		
	output: EV_TEXT
		-- Widget used to display all output.
	
	check_selected_item is
			-- Check selected item within `test_tree'.
		do
			if test_tree.selected_item /= Void then
				test_tree.check_item (test_tree.selected_item)
			end
		end

	uncheck_selected_item is
			-- Uncheck selected item within `test_tree'.
		do
			if test_tree.selected_item /= Void then
				test_tree.uncheck_item (test_tree.selected_item)
			end
		end

	is_item_checked is
			-- Called by `select_actions' of `l_ev_button_3'.
		do
			if test_tree.selected_item /= Void then
				if test_tree.is_item_checked (test_tree.selected_item) then
					output.append_text ("Selected item is checked%N")
				else
					output.append_text ("Selected item is not checked%N")
				end
			end
		end

	display_checked_items is
			-- Display all checked items of `test_tree' within `output'.
		local
			items: DYNAMIC_LIST [EV_TREE_NODE]
		do
			items ?= test_tree.checked_items
			output.append_text ("The following items are checked :%N")
			from
				items.start
			until
				items.off
			loop
				output.append_text (items.item.text)
				if items.index < items.count then
					output.append_text (", ")
				end
				items.forth
			end
			output.append_text ("%N")
		end
		
	item_checked (an_item: EV_TREE_ITEM) is
			-- Display notification in `output' that `an_item' has been checked.
		do
			output.append_text (an_item.text + " Checked%N")
		end
		
	item_unchecked (an_item: EV_TREE_ITEM) is
			-- Display notification in `output' that `an_item' has been unchecked.
		do
			output.append_text (an_item.text + " UnChecked%N")
		end

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


end -- class CHECKABLE_TREE_ADVANCED_TEST
