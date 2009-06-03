note
	description:
		"EiffelVision Tree, Carbon implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TREE_IMP

inherit
	EV_TREE_I
		redefine
			interface,
			initialize,
			call_pebble_function,
			append
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			call_button_event_actions,
			create_pointer_motion_actions,
			set_to_drag_and_drop,
			able_to_transport,
			ready_for_pnd_menu,
			disable_transport,
			on_mouse_button_event,
			pre_pick_steps,
			post_drop_steps,
			call_pebble_function,
			on_pointer_motion,
			minimum_height,
			minimum_width
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE]
		export
			{EV_TREE_IMP}
				child_array
		redefine
			interface,
			insert_i_th,
			remove_i_th,
			append,
			initialize
		end

	EV_TREE_ACTION_SEQUENCES_IMP

	EV_PND_DEFERRED_ITEM_PARENT

	EV_CARBON_DATABROWSER-- [EV_TREE_NODE]
		undefine
			destroy
		redefine
			make,
			initialize,
			interface,
			insert_i_th
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create an empty Tree.
		local
			ptr: POINTER
			rect : RECT_STRUCT
			ret: INTEGER
			window: EV_WINDOW_IMP
		do
			Precursor {EV_CARBON_DATABROWSER} (an_interface)
			set_disclosure_column
			hide_title_row
		end

	call_selection_action_sequences
			-- Call the appropriate selection action sequences
		do
			select_actions.call ([])
		end

	initialize
			-- Connect action sequences to signals.
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_TREE_I}
		end

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Create a pointer_motion action sequence.
		do
			create Result
		end

	call_button_event_actions (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		

		do

		end

	on_pointer_motion (a_motion_tuple: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER])
		do
		end

feature -- Status report

	selected_item: EV_TREE_NODE
			-- Item which is currently selected
		do
			Result ?= selected_item_imp.interface
		end


	selected: BOOLEAN
			-- Is one item selected?

feature -- Implementation

	ensure_item_visible (an_item: EV_TREE_NODE)

		do
			-- reveal_data_browser_item_external
		end

	set_to_drag_and_drop: BOOLEAN
		do
		end

	able_to_transport (a_button: INTEGER): BOOLEAN
			-- Is list or row able to transport PND data using `a_button'.
		do

		end

	ready_for_pnd_menu (a_button: INTEGER): BOOLEAN
			-- Is list or row able to display PND menu using `a_button'
		do

		end

	disable_transport
		do

		end

	update_pnd_status
			-- Update PND status of list and its children.
		do
		end

	update_pnd_connection (a_enable: BOOLEAN)
			-- Update the PND connection status for `Current'.
		do
		end

	on_mouse_button_event (
			a_type: INTEGER
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		
			-- Initialize a pick and drop transport.
		do
		end

	pnd_row_imp: EV_TREE_NODE_IMP
			-- Implementation object of the current row if in PND transport.

	temp_pebble: ANY
			-- Temporary pebble holder used for PND implementation with nodes.

	temp_pebble_function: FUNCTION [ANY, TUPLE [], ANY]
			-- Returns data to be transported by PND mechanism.

	temp_accept_cursor, temp_deny_cursor: EV_CURSOR

	call_pebble_function (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- Set `pebble' using `pebble_function' if present.
		do
		end

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- Steps to perform before transport initiated.
		do
		end

	post_drop_steps (a_button: INTEGER)
			-- Steps to perform once an attempted drop has happened.
		do
		end

feature -- Minimum size

	minimum_height: INTEGER
			-- Minimum height that the widget may occupy.
		do
			Result := 74
		end

	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		do
			if internal_minimum_width >= 0 then
				Result := internal_minimum_width
			else
				Result := 200
			end
			--io.output.put_string(Result.out +"%N")
		end

feature {EV_TREE_NODE_IMP}

	row_from_y_coord (a_y: INTEGER): EV_TREE_NODE_IMP
			-- Returns the row index at relative coordinate `a_y'.
		do
		end

feature {NONE} -- Implementation

	previous_selected_item: EV_TREE_NODE
			-- Item that was selected previously.

	append (s: SEQUENCE [EV_TREE_ITEM])
			-- Add 's' to 'Current'
		do
			Precursor (s)
		end

	insert_i_th (v: like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			item_imp: EV_TREE_NODE_IMP
			ret: INTEGER
			id: INTEGER
		do
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)

			child_array.go_i_th (i)
			child_array.put_left (v)

			Precursor {EV_CARBON_DATABROWSER} (v, i)
		end

	remove_i_th (a_position: INTEGER)
			-- Remove item at `a_position'
		local
			item_imp: EV_TREE_NODE_IMP
			ret: INTEGER
			id: INTEGER
		do
			item_imp ?= (child_array @ (a_position)).implementation
			item_imp.set_parent_imp (Void)
			child_array.go_i_th (a_position)
			child_array.remove

			remove_id (item_imp.item_id)
		end


feature {EV_TREE_NODE_IMP} -- Implementation

	get_text_from_position (a_tree_node_imp: EV_TREE_NODE_IMP): STRING_32
			-- Retrieve cell text from `a_tree_node_imp`
		do
		end

	set_text_on_position (a_tree_node_imp: EV_TREE_NODE_IMP; a_text: STRING_GENERAL)
			-- Set cell text at to `a_text'.
		do
		end

	update_row_pixmap (a_tree_node_imp: EV_TREE_NODE_IMP)
			-- Set the pixmap for `a_tree_node_imp'.
		do
		end

	set_row_height (value: INTEGER)
			-- Make `value' the new height of all the rows.
		do
		end

	row_height: INTEGER
			-- Height of rows in `Current'
		do
		end

feature {NONE} -- Implementation

	pixmaps_size_changed
			-- Not implemented
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE;

note
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_TREE_IMP

