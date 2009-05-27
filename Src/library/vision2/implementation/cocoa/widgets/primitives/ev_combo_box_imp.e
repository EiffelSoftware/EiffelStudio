note

	description:
		"EiffelVision combo box, Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		undefine
			create_focus_in_actions,
			create_focus_out_actions,
			pre_pick_steps,
			call_pebble_function,
			enable_transport,
			hide_border
		redefine
			initialize,
			make,
			interface,
			has_focus,
			dispose,
			cocoa_set_size
		end

	EV_LIST_ITEM_LIST_IMP
		undefine
			set_default_colors,
			destroy,
			on_key_event,
			default_key_processing_blocked,
			on_focus_changed,
			has_focus,
			set_focus,
			dispose,
			set_default_minimum_size
		redefine
			initialize,
			make,
			interface,
			cocoa_set_size
		end

	EV_COMBO_BOX_ACTION_SEQUENCES_IMP

	EV_KEY_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a Cocoa combo-box.
		do
			base_make (an_interface)
			create combo_box.make
			text_field := combo_box
			cocoa_item := combo_box
		end

feature {NONE} -- Initialization

	call_selection_action_sequences
			-- Call the appropriate selection action sequences
		do
			select_actions.call ([])
		end

	initialize
			-- Connect action sequences to signals.
		do
			Precursor {EV_LIST_ITEM_LIST_IMP}
			Precursor {EV_TEXT_FIELD_IMP}
		end

	insert_item (item_imp: EV_LIST_ITEM_IMP; pos: INTEGER)
			-- Insert `item_imp' at the one-based index `an_index'.
		do
			combo_box.insert_item_with_object_value_at_index (create {NS_STRING}.make_with_string (item_imp.text), pos - 1)
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

	selected_item: EV_LIST_ITEM
			-- Item which is currently selected, for a multiple
			-- selection.
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
		do
			create Result.make (1)
			Result.put (i_th (combo_box.index_of_selected_item + 1))
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

	interface: EV_COMBO_BOX;

	combo_box: NS_COMBO_BOX;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_COMBO_BOX_IMP

