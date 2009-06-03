note

	description:
		"EiffelVision multi-column list row, Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW_IMP

inherit
	EV_MULTI_COLUMN_LIST_ROW_I
		redefine
			parent_imp,
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

	EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES_IMP

	EV_PND_DEFERRED_ITEM
		redefine
			interface
		end

	EV_CARBON_DATABROWSER_ITEM
		redefine
			interface,
			text
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a row with one empty column.
		do
			base_make (an_interface)
		end

	initialize
			-- Create the linked lists.
		do
			tooltip := ""
			set_is_initialized (True)
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is the item selected.
		do
			Result := (parent_imp.selected_item = interface)
			 or else (parent_imp.selected_items.has (interface))
		end

feature -- Status setting

	destroy
			-- Destroy actual object.
		do
			if parent_imp /= Void then
				parent_imp.interface.prune_all (interface)
			end
			set_is_destroyed (True)
		end

	enable_select
			-- Select the row in the list.
		do
			if not is_selected then
				parent_imp.select_item (index)
			end
		end

	disable_select
			-- Deselect the row from the list.
		do
			if is_selected then
				parent_imp.deselect_item (index)
			end
		end

feature -- PND

	enable_transport
		do
			is_transport_enabled := True
			if parent_imp /= Void then
				parent_imp.update_pnd_connection (True)
			end
		end

	disable_transport
		do
			is_transport_enabled := False
			if parent_imp /= Void then
				parent_imp.update_pnd_status
			end
		end

	draw_rubber_band
		do
			check
				do_not_call: False
			end
		end

	erase_rubber_band
		do
			check
				do_not_call: False
			end
		end

	enable_capture
		do
			check
				do_not_call: False
			end
		end

	disable_capture
		do
			check
				do_not_call: False
			end
		end

	start_transport (
        	a_x, a_y, a_button: INTEGER; a_press: BOOLEAN;
        	a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        	a_screen_x, a_screen_y: INTEGER; a_menu_only: BOOLEAN)
		do
			check
				do_not_call: False
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER)
		do
			check
				do_not_call: False
			end
		end

	set_pointer_style, internal_set_pointer_style (curs: EV_POINTER_STYLE)
		do
			check
				do_not_call: False
			end
		end

feature -- Element Change

	set_pixmap (a_pix: EV_PIXMAP)
			-- Set the rows `pixmap' to `a_pix'.
		do
			internal_pixmap := a_pix.twin
			if parent_imp /= Void then
				parent_imp.set_row_pixmap (index, internal_pixmap)
			end
		end

	remove_pixmap
			-- Remove the rows pixmap.
		do
			internal_pixmap := Void
			if parent_imp /= Void then
				parent_imp.remove_row_pixmap (index)
			end
		end

	set_tooltip (a_tooltip: STRING_GENERAL)
			-- Assign `a_tooltip' to `tooltip'.
		do
			tooltip := a_tooltip.twin
		end

	tooltip: STRING_32
			-- Tooltip displayed on `Current'.

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
			-- Return parents horizontal scrollbar offset.
			if parent_imp /= Void then
			end
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		do
			if parent_imp /= Void then
				Result := (index - 1) * parent_imp.interface.row_height
			end
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		do
			if parent_imp /= Void then
				Result := parent_imp.screen_x + x_position
			end
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		do
			if parent_imp /= Void then
				Result := parent_imp.screen_y + y_position
			end
		end

	width: INTEGER
			-- Horizontal size in pixels.
		do
			if parent_imp /= Void then
				Result := parent_imp.width
			end
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			if parent_imp /= Void then
				Result := parent_imp.interface.row_height
			end
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
		do
			if parent_imp /= Void then
				Result := parent_imp.minimum_width
			end
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
			if parent_imp /= Void then
				Result := parent_imp.interface.row_height
			end
		end

feature {ANY} -- Implementation

	text: STRING_32
			--
		do
			Result := interface.i_th (1)
		end


	on_item_added_at (an_item: STRING_GENERAL; item_index: INTEGER)
			-- `an_item' has been added to index `item_index'.
		do
		end

	on_item_removed_at (an_item: STRING_GENERAL; item_index: INTEGER)
			-- `an_item' has been removed from index `item_index'.
		do
		end

feature {EV_MULTI_COLUMN_LIST_IMP} -- Implementation

	set_pebble_void
			-- Resets pebble from MCL_Imp.
		do
			pebble := Void
		end

	able_to_transport (a_button: INTEGER): BOOLEAN
			-- Is the row able to transport data with `a_button' click.
		do
			Result := is_transport_enabled and
			((a_button = 1 and mode_is_drag_and_drop) or
			(a_button = 3 and (mode_is_pick_and_drop or mode_is_target_menu)))
		end

	real_pointed_target: EV_PICK_AND_DROPABLE
		do
			check do_not_call: False end
		end

feature {EV_ANY_I} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
			-- Do nothing
		end

	set_list_iter (a_iter: ANY)
			-- Set `list_iter' to `a_iter'
		do
		end

	set_parent_imp (par_imp: EV_MULTI_COLUMN_LIST_IMP)
			-- Set the rows parent to `par_imp'.
		do
			parent_imp := par_imp
		end

	parent_imp: EV_MULTI_COLUMN_LIST_IMP
			-- Implementation of the rows parent.

	index: INTEGER
			-- Index of the row in the list
			-- (starting from 1).
		do
			-- The `ev_children' array has to contain
			-- the same rows in the same order than in the g.t.k.
			-- part.
			Result := parent_imp.ev_children.index_of (Current, 1)
		end

	interface: EV_MULTI_COLUMN_LIST_ROW;

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_MULTI_COLUMN_LIST_ROW_IMP

