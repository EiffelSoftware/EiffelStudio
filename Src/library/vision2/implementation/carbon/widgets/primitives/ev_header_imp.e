indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_IMP

inherit
	EV_HEADER_I
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_HEADER_ITEM]
		redefine
			interface,
			initialize
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			call_button_event_actions
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			initialize
		end

	EV_HEADER_ACTION_SEQUENCES_IMP

create
	make

feature -- Initialization

	needs_event_box: BOOLEAN is True
		-- Does `Current' need a GtkEventBox as its `c_object' to receive events.

	make (an_interface: like interface) is
			-- Create an empty Tree.
		do

		end

	initialize is
			-- Initialize `Current'
		do

		end

	dummy_item: EV_HEADER_ITEM

	resize_model  (a_columns: INTEGER) is
			-- Resize the data model to match the number of columns
		do

		end

feature

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		do

		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item a`a_position'
		do

		end

feature {EV_HEADER_ITEM_IMP} -- Implemnentation

	item_resize_tuple: TUPLE [EV_HEADER_ITEM]
		-- Reusable item resize tuple.

	set_call_item_resize_start_actions (a_flag: BOOLEAN) is
			-- Set `call_item_resize_start_actions' to `a_flag'.
		do

		end

	item_has_resized is
			-- The item has finished resizing so call `item_resize_end_actions'.
		do

		end

	on_resize (a_item: EV_HEADER_ITEM) is
			-- `a_item' has resized.
		do

		end

	call_item_resize_start_actions: BOOLEAN
	call_item_resize_end_actions: BOOLEAN
		-- Should the appropriate item resize actions be called?

feature {NONE} -- Implementation

	pointed_divider_index: INTEGER is
			-- Index of divider currently beneath the mouse pointer, or
			-- 0 if none.
		do

		end

	call_button_event_actions (a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Call pointer_button_press_actions or pointer_double_press_actions
			-- depending on event type in first position of `event_data'.
		do

		end

	call_item_resize_actions is
			-- Call the item resize end actions.
		do

		end

	model_count: INTEGER
		-- Number of cells available in model

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
		end

	interface: EV_HEADER;

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




end
