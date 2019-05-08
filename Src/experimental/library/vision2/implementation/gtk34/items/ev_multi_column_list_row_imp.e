note

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
			interface
		end

	EV_PND_DEFERRED_ITEM
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create a row with one empty column.
		do
			assign_interface (an_interface)
		end

	make
			-- Create the linked lists.
		do
			tooltip := ""
			set_is_initialized (True)
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is the item selected.
		do
			if attached parent_imp as l_parent_imp then
				Result := (l_parent_imp.selected_item = interface)
			 	or else (l_parent_imp.selected_items.has (attached_interface))
			end
		end

feature -- Status setting

	destroy
			-- Destroy actual object.
		do
			if attached parent_imp as l_parent_imp then
				l_parent_imp.prune (attached_interface)
			end
			set_is_destroyed (True)
		end

	enable_select
			-- Select the row in the list.
		do
			if not is_selected then
				if attached parent_imp as l_parent_imp then
					l_parent_imp.select_item (index)
				else
					check False end
				end
			end
		end

	disable_select
			-- Deselect the row from the list.
		do
			if is_selected then
				if attached parent_imp as l_parent_imp then
					l_parent_imp.deselect_item (index)
				else
					check False end
				end
			end
		end

feature -- PND

	enable_transport
		do
			is_transport_enabled := True
			if attached parent_imp as l_parent_imp then
				l_parent_imp.update_pnd_connection (True)
			end
		end

	disable_transport
		do
			is_transport_enabled := False
			if attached parent_imp as l_parent_imp then
				l_parent_imp.update_pnd_status
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
        	a_x, a_y, a_button: INTEGER; a_press: BOOLEAN
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

	set_pointer_style, internal_set_pointer_style (c: EV_POINTER_STYLE)
		do
			check
				do_not_call: False
			end
		end

feature -- Element Change

	set_pixmap (a_pix: EV_PIXMAP)
			-- Set the rows `pixmap' to `a_pix'.
		local
			l_internal_pixmap: like internal_pixmap
		do
			l_internal_pixmap := a_pix.twin
			internal_pixmap := l_internal_pixmap
			if attached parent_imp as l_parent_imp then
				l_parent_imp.set_row_pixmap (index, l_internal_pixmap)
			end
		end

	remove_pixmap
			-- Remove the rows pixmap.
		do
			internal_pixmap := Void
			if attached parent_imp as l_parent_imp then
				l_parent_imp.remove_row_pixmap (index)
			end
		end

	set_tooltip (a_tooltip: READABLE_STRING_GENERAL)
			-- Assign `a_tooltip' to `tooltip'.
		do
			tooltip := a_tooltip.as_string_32.twin
		end

	tooltip: STRING_32
			-- Tooltip displayed on `Current'.

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		local
			l_h_adjust: POINTER
		do
			-- Return parents horizontal scrollbar offset.
			if attached parent_imp as l_parent_imp then
				l_h_adjust := {GTK}.gtk_scrolled_window_get_hadjustment (l_parent_imp.scrollable_area)
				if l_h_adjust /= default_pointer then
					Result := - {GTK}.gtk_adjustment_get_value (l_h_adjust).rounded
				end
			end
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		local
			l_v_adjust: POINTER
		do
			if attached parent_imp as l_parent_imp then
				Result := (index - 1) * l_parent_imp.row_height
				l_v_adjust := {GTK}.gtk_scrolled_window_get_vadjustment (l_parent_imp.scrollable_area)
				if l_v_adjust /= default_pointer then
					Result := Result - {GTK}.gtk_adjustment_get_value (l_v_adjust).rounded
				end
			end
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.screen_x + x_position
			end
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.screen_y + y_position
			end
		end

	width: INTEGER
			-- Horizontal size in pixels.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.width
			end
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.attached_interface.row_height
			end
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.minimum_width
			end
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.row_height
			end
		end

feature {NONE} -- Implementation

	on_item_added_at (an_item: READABLE_STRING_GENERAL; item_index: INTEGER)
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

	on_item_removed_at (an_item: READABLE_STRING_GENERAL; item_index: INTEGER)
			-- `an_item' has been removed from index `item_index'.
		do
			if attached parent_imp as l_parent_imp then
				l_parent_imp.set_text_on_position (item_index, index, "")
			end
		end

feature {EV_MULTI_COLUMN_LIST_IMP} -- Implementation

	set_pebble_void
			-- Resets pebble from MCL_Imp.
		do
			pebble := Void
		end

	able_to_transport (a_button: INTEGER_32): BOOLEAN
			-- Is `Current' able to initiate transport with `a_button'.
		do
			Result := (mode_is_drag_and_drop and then a_button = 1) or (mode_is_pick_and_drop and then a_button = 3 and then not mode_is_configurable_target_menu)
		end

	real_pointed_target: detachable EV_PICK_AND_DROPABLE
		do
			check do_not_call: False end
		end

	ready_for_pnd_menu (a_button: INTEGER_32; a_press: BOOLEAN): BOOLEAN
			-- Will `Current' display a menu with button `a_button'.
		do
			Result := ((mode_is_target_menu or else mode_is_configurable_target_menu) and a_button = 3) and then not a_press
		end

feature {EV_ANY_I} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
			-- Do nothing
		end

	set_list_iter (a_iter: detachable EV_GTK_TREE_ITER_STRUCT)
			-- Set `list_iter' to `a_iter'
		do
			list_iter := a_iter
		end

	list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		-- Object representing position of `Current' in parent tree model


	set_parent_imp (par_imp: detachable EV_MULTI_COLUMN_LIST_IMP)
			-- Set the rows parent to `par_imp'.
		do
			parent_imp := par_imp
		end

	parent_imp: detachable EV_MULTI_COLUMN_LIST_IMP
			-- Implementation of the rows parent.

	index: INTEGER
			-- Index of the row in the list
			-- (starting from 1).
		local
			l_parent_imp: like parent_imp
		do
			-- The `ev_children' array has to contain
			-- the same rows in the same order than in the gtk
			-- part.
			l_parent_imp := parent_imp
			check l_parent_imp /= Void then end
			Result := l_parent_imp.ev_children.index_of (Current, 1)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_MULTI_COLUMN_LIST_ROW note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_MULTI_COLUMN_LIST_ROW_IMP
