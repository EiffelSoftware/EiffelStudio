indexing
	description: "Objects that represent a dialog for history modification."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_HISTORY_DIALOG
	
inherit
	EV_DIALOG
		redefine
			initialize
		end
		
	EV_LAYOUT_CONSTANTS
		undefine
			default_create, copy
		end
		
	GB_ACCESSIBLE_HISTORY
		undefine
			default_create, copy
		end
		
	GB_ACCESSIBLE_COMMAND_HANDLER

create
	default_create

feature -- Initialization

	initialize is
			-- Initialize `Current'.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
		do
			Precursor {EV_DIALOG}
			set_title ("History")
			create history_list
			create close_button.make_with_text ("Close")
			create vertical_box
			create horizontal_box
			extend (vertical_box)
			vertical_box.extend (history_list)
			vertical_box.extend (horizontal_box)
			vertical_box.disable_item_expand (horizontal_box)
			horizontal_box.set_padding_width (default_padding_size)
			horizontal_box.set_border_width (default_border_size)
			set_default_size_for_button (close_button)
			horizontal_box.extend (close_button)
			set_default_push_button (close_button)
			close_button.select_actions.extend (agent close_window)
			set_minimum_size (250, 250)
		end
		
feature -- Basic operations

	add_command_representation (output: STRING) is
			--
		require
			output_valid: output /= Void and then not output.is_empty
		local
			list_item: EV_LIST_ITEM
		do
			create list_item.make_with_text (output)
			history_list.extend (list_item)
				-- We must now block the select actions on the list as we are doing it
				-- ourselves. When the user changes a selection, then we want the
				-- actions to be fired again.
			history_list.select_actions.block
			list_item.enable_select
			history_list.select_actions.resume
			if history_list.select_actions.is_empty then
				history_list.select_actions.extend (agent item_selected)
			end
			last_selected_item := history_list.count
		ensure
			history_list.count = old history_list.count + 1
			last_selected_item = history_list.count
		end
		
feature {GB_GLOBAL_HISTORY} -- Implementation

	select_item (position: INTEGER) is
			-- Select item `position' in `history_list'.
		require
			position_valid: position >= 0 and position <= history_list.count
		do
			history_list.select_actions.block;
			(history_list @ position).enable_select
			history_list.select_actions.resume
			last_selected_item := position
			command_handler.update
		ensure
			item_selected: (history_list @ position).is_selected
		end	
		
	remove_selection is
			--
		do
			history_list.selected_item.disable_select
				-- When going from no slection to a selection,
				-- without this, `last_selected_item' would still be
				-- 1 and therefore nothing would happen in `item_selected'.
			last_selected_item := 0
		end
		
	remove_items_from_position (pos: INTEGER) is
			-- Remove all items in `history_list' from
			-- position `pos'.
		do
			from
				history_list.go_i_th (pos)
			until
				history_list.off
			loop
				history_list.remove
			end
			last_selected_item := history_list.count - 1
		end
		
	remove_all_items is
			-- Clear `history_list' completely.
		do
			history_list.wipe_out
		end
		
		
feature {NONE} -- Implementation

	close_window is
			-- Close `Current' and do any required processing.
		do
			hide
			command_handler.update
		end
		

	item_selected is
			-- Peform processing when `an_item' has been selected.
		local
			index_of_current_item: INTEGER
		do
			index_of_current_item := history_list.index_of (history_list.selected_item, 1)
				if last_selected_item > index_of_current_item then
					history.step_from (last_selected_item, index_of_current_item)
				elseif last_selected_item < index_of_current_item then
					history.step_from (last_selected_item + 1, index_of_current_item)
				end	
				last_selected_item := index_of_current_item
				command_handler.update
		end

	history_list: EV_LIST
	
	close_button: EV_BUTTON
	
	last_selected_item: INTEGER

end -- class GB_HISTORY_DIALOG
