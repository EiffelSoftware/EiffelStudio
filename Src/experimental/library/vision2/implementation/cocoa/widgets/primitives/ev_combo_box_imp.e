note
	description: "EiffelVision combo box, Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COMBO_BOX_IMP

inherit
	EV_COMBO_BOX_I
		undefine
			wipe_out,
			call_pebble_function
		redefine
			interface
		end

	EV_TEXT_FIELD_IMP
		rename
			text_field as combo_box
		undefine
			pre_pick_steps,
			call_pebble_function,
			enable_transport,
			hide_border
		redefine
			make,
			interface,
			has_focus,
			dispose,
			cocoa_set_size,
			combo_box
		end

	EV_LIST_ITEM_LIST_IMP
		undefine
			set_default_colors,
			destroy,
			on_key_event,
			default_key_processing_blocked,
			has_focus,
			set_focus,
			dispose,
			set_default_minimum_size
		redefine
			make,
			interface,
			cocoa_set_size
		end

	EV_KEY_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make
			-- Create a Cocoa combo-box.
		do
			create combo_box.make
			cocoa_view := combo_box
			Precursor {EV_LIST_ITEM_LIST_IMP}
			Precursor {EV_TEXT_FIELD_IMP}
		end

feature {NONE} -- Initialization

	call_selection_action_sequences
			-- Call the appropriate selection action sequences
		do
			select_actions.call ([])
		end

	insert_item (item_imp: EV_LIST_ITEM_IMP; pos: INTEGER)
			-- Insert `item_imp' at the one-based index `an_index'.
		do
			combo_box.insert_item_with_object_value_at_index (create {NS_STRING}.make_with_string (item_imp.text), pos - 1)
			-- Select the item if it is the first:
			if combo_box.number_of_items = 1 then
				combo_box.select_item_at_index (0)
			end
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP)
			-- Remove `item_imp' from `Current'.
		local
			an_index: INTEGER
		do
			an_index := ev_children.index_of (item_imp, 1)
			combo_box.remove_item_at_index (an_index - 1)
		end

feature -- Status report

	has_focus: BOOLEAN
			-- Does widget have the keyboard focus?
		do

		end

	selected_item: detachable EV_LIST_ITEM
			-- Item which is currently selected
		local
			l_index: INTEGER
		do
			l_index := combo_box.index_of_selected_item
			if l_index > 0 then
				Result := i_th (l_index + 1)
			end -- otherwise no item is selected, return void
		end

	selected_items: ARRAYED_LIST [EV_LIST_ITEM]
			-- List of all the selected items. Used for list_item.is_selected implementation.
		local
			l_item: detachable EV_LIST_ITEM
		do
			create Result.make (1)
			l_item := i_th (combo_box.index_of_selected_item + 1)
			check l_item /= Void end
			Result.put (l_item)
		end

	select_item (a_index: INTEGER)
			-- Select an item at the one-based `index' of the list.
		do
			combo_box.select_item_at_index (a_index - 1)
		end

	deselect_item (a_index: INTEGER)
			-- Unselect the item at the one-based `index'.
		do
			combo_box.deselect_item_at_index (a_index - 1)
		end

	clear_selection
			-- Clear the item selection of `Current'.
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i < count
			loop
				combo_box.deselect_item_at_index (i)
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	is_list_shown: BOOLEAN

	dispose
			do
				Precursor {EV_LIST_ITEM_LIST_IMP}
				Precursor {EV_TEXT_FIELD_IMP}
			end

	pixmaps_size_changed
			-- The size of the displayed pixmaps has just
			-- changed.
		do
		end

	cocoa_set_size (a_x_position, a_y_position, a_width, a_height: INTEGER_32)
			-- Cococa doesn't support Combo Boxes higher than the default. Just position it right
		local
			l_y_position: INTEGER
			l_height: INTEGER
			l_max_height: INTEGER
		do
			l_max_height := 24
			if a_height <= l_max_height then
				l_y_position := a_y_position
				l_height := a_height
			else
				l_y_position := a_y_position + ((a_height - l_max_height) // 2)
				l_height := l_max_height
			end
			combo_box.set_frame (create {NS_RECT}.make_rect (a_x_position, l_y_position, a_width, l_height))
		end

feature {EV_ANY_I} -- Implementation

	combo_box: NS_COMBO_BOX

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_COMBO_BOX note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_COMBO_BOX_IMP
