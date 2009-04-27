indexing

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
			on_focus_changed,
			dispose,
			set_text,
			prepend_text,
			append_text,
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
			insert_i_th,
			remove_i_th,
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
			create combo_box.new
			cocoa_item := combo_box
		end

feature {NONE} -- Initialization

	call_selection_action_sequences
			-- Call the appropriate selection action sequences
		do

		end

	previous_selected_item_imp: EV_LIST_ITEM_IMP
		-- Item that was selected previously.

	initialize
			-- Connect action sequences to signals.
		do
			Precursor {EV_LIST_ITEM_LIST_IMP}
			Precursor {EV_TEXT_FIELD_IMP}
		end

	insert_i_th (v: like item; i: INTEGER)
			-- Insert `v' at position `i'.
		do
			Precursor {EV_LIST_ITEM_LIST_IMP} (v, i)
		end

	remove_i_th (an_index: INTEGER)
		do
			Precursor {EV_LIST_ITEM_LIST_IMP} (an_index)
		end

feature -- Status report

	has_focus: BOOLEAN
			-- Does widget have the keyboard focus?
		do
		end

	selected_item: EV_LIST_ITEM
			-- Item which is currently selected, for a multiple
			-- selection.
		do
			from
				start
			until
				off
			loop
				forth
			end
		end

	selected_items: ARRAYED_LIST [EV_LIST_ITEM]
			-- List of all the selected items. Used for list_item.is_selected implementation.
		do
		end

	select_item (an_index: INTEGER)
			-- Select an item at the one-based `index' of the list.
		do
		end

	deselect_item (an_index: INTEGER)
			-- Unselect the item at the one-based `index'.
		do
		end

	clear_selection
			-- Clear the item selection of `Current'.
		do
		end

feature -- Status setting

	set_maximum_text_length (len: INTEGER)
			-- Set the length of the longest text size in characters that `Current' can display.
		do
		end

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		do
		end

	append_text (a_text: STRING_GENERAL)
			-- Append `a_text' to the end of the text.
		do
		end

	prepend_text (a_text: STRING_GENERAL)
			-- Prepend `a_text' to the end of the text.
		do
		end

feature {NONE} -- Implementation

	on_focus_changed (a_has_focus: BOOLEAN)
			-- Focus for `Current' has changed'.
		do
		end

	is_list_shown: BOOLEAN
		-- Is combo list current shown?

	retrieve_toggle_button_signal_connection_id: INTEGER
		-- Signal connection id used when finding the toggle button of `Current'.

feature {NONE} -- Implementation
	dispose
			do
				precursor {EV_LIST_ITEM_LIST_IMP}
				precursor {EV_TEXT_FIELD_IMP}
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

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_COMBO_BOX_IMP

