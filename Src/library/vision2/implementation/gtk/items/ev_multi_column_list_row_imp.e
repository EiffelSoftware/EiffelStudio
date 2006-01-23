indexing

	description:
		"EiffelVision multi-column list row, gtk implementation."
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

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a row with one empty column.
		do
			base_make (an_interface)
		end

	initialize is
			-- Create the linked lists.
		do	
			tooltip := ""
			set_is_initialized (True)
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected.
		do			
			Result := (parent_imp.selected_item = interface)
			 or else (parent_imp.selected_items.has (interface))
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			if parent_imp /= Void then
				parent_imp.interface.prune_all (interface)
			end
			set_is_destroyed (True)
		end

	enable_select is
			-- Select the row in the list.
		do
			if not is_selected then
				parent_imp.select_item (index)
			end
		end

	disable_select is
			-- Deselect the row from the list.
		do
			if is_selected then
				parent_imp.deselect_item (index)
			end
		end

feature -- PND

	enable_transport is 
		do
			is_transport_enabled := True
			if parent_imp /= Void then
				parent_imp.update_pnd_connection (True)
			end
		end

	disable_transport is
		do
			is_transport_enabled := False
			if parent_imp /= Void then
				parent_imp.update_pnd_status
			end
		end

	draw_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	erase_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	enable_capture is
		do
			check
				do_not_call: False
			end
		end

	disable_capture is
		do
			check
				do_not_call: False
			end
		end

	start_transport (
        	a_x, a_y, a_button: INTEGER;
        	a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        	a_screen_x, a_screen_y: INTEGER) is 
		do
			check
				do_not_call: False
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER) is
		do
			check
				do_not_call: False
			end
		end

	set_pointer_style, internal_set_pointer_style (curs: EV_CURSOR) is
		do
			check
				do_not_call: False
			end
		end

feature -- Element Change

	set_pixmap (a_pix: EV_PIXMAP) is
			-- Set the rows `pixmap' to `a_pix'.
		do
			internal_pixmap := a_pix.twin
			if parent_imp /= Void then
				parent_imp.set_row_pixmap (index, internal_pixmap)
			end
		end

	remove_pixmap is
			-- Remove the rows pixmap.
		do
			internal_pixmap := Void
			if parent_imp /= Void then
				parent_imp.remove_row_pixmap (index)
			end
		end

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
		do
			tooltip := a_tooltip.twin
		end

	tooltip: STRING
			-- Tooltip displayed on `Current'.
		
feature {NONE} -- Implementation
		
	on_item_added_at (an_item: STRING; item_index: INTEGER) is
			-- `an_item' has been added to index `item_index'.
		local
			a_parent_imp: like parent_imp
		do
			a_parent_imp := parent_imp
			if a_parent_imp /= Void then
				if a_parent_imp.column_count < item_index then
					a_parent_imp.expand_column_count_to (item_index)
				end
				a_parent_imp.set_text_on_position (item_index, index, an_item)
			end
		end

	on_item_removed_at (an_item: STRING; item_index: INTEGER) is
			-- `an_item' has been removed from index `item_index'.
		do
			if parent_imp /= Void then
				parent_imp.set_text_on_position (item_index, index, "")
			end
		end

feature {EV_MULTI_COLUMN_LIST_IMP} -- Implementation

	set_pebble_void is
			-- Resets pebble from MCL_Imp.
		do
			pebble := Void
		end

	able_to_transport (a_button: INTEGER): BOOLEAN is
			-- Is the row able to transport data with `a_button' click.
		do
			Result := is_transport_enabled and
			((a_button = 1 and mode_is_drag_and_drop) or
			(a_button = 3 and (mode_is_pick_and_drop or mode_is_target_menu)))
		end

	real_pointed_target: EV_PICK_AND_DROPABLE is
		do
			check do_not_call: False end
		end

feature {EV_ANY_I} -- Implementation

	set_list_iter (a_iter: EV_GTK_TREE_ITER_STRUCT) is
			-- Set `list_iter' to `a_iter'
		do
			list_iter := a_iter
		end

	list_iter: EV_GTK_TREE_ITER_STRUCT
		-- Object representing position of `Current' in parent tree model
		

	set_parent_imp (par_imp: EV_MULTI_COLUMN_LIST_IMP) is
			-- Set the rows parent to `par_imp'.
		do
			parent_imp := par_imp
		end
	
	parent_imp: EV_MULTI_COLUMN_LIST_IMP
			-- Implementation of the rows parent.

	index: INTEGER is
			-- Index of the row in the list
			-- (starting from 1).
		do
			-- The `ev_children' array has to contain
			-- the same rows in the same order than in the gtk
			-- part.
			Result := parent_imp.ev_children.index_of (Current, 1)
		end

	interface: EV_MULTI_COLUMN_LIST_ROW;

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




end -- class EV_MULTI_COLUMN_LIST_ROW_IMP

