note
	description: "FIXME"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I
		redefine
			interface,
			reset_pebble_function
		end

	EV_PND_DEFERRED_ITEM
		redefine
			interface
		end
create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create a list item with an empty name.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'
		do
			internal_text := once ""
			set_is_initialized (True)
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

	able_to_transport (a_button: INTEGER_32): BOOLEAN
			-- Is `Current' able to initiate transport with `a_button'.
		do
			Result := (mode_is_drag_and_drop and then a_button = 1) or (mode_is_pick_and_drop and then a_button = 3 and then not mode_is_configurable_target_menu)
		end

	ready_for_pnd_menu (a_button: INTEGER_32; a_press: BOOLEAN): BOOLEAN
			-- Will `Current' display a menu with button `a_button'.
		do
			Result := ((mode_is_target_menu or else mode_is_configurable_target_menu) and a_button = 3) and then not a_press
		end

	reset_pebble_function
			--Reset pebble_function.
		local
			l_parent_imp: like parent_imp
		do
			l_parent_imp := parent_imp
			if l_parent_imp /= Void then
				l_parent_imp.reset_pebble_function
			else
				Precursor
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

	real_pointed_target: detachable EV_PICK_AND_DROPABLE
		do
			check do_not_call: False end
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is the item selected.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.selected_items.has (attached_interface)
			end
		end

feature -- Status setting

	enable_select
			-- Select the item.
		do
			check attached {EV_LIST_ITEM_LIST_IMP} parent_imp as l_parent_imp then
				l_parent_imp.select_item (l_parent_imp.index_of (attached_interface, 1))
			end
		end

	disable_select
			-- Deselect the item.
		do
			check attached {EV_LIST_ITEM_LIST_IMP} parent_imp as l_parent_imp then
				l_parent_imp.deselect_item (l_parent_imp.index_of (attached_interface, 1))
			end
		end

	text: STRING_32
			--
		do
			Result := internal_text.twin
		end

feature -- Element change

	set_tooltip (a_tooltip: READABLE_STRING_GENERAL)
			-- Assign `a_tooltip' to `tooltip'.
		do
			internal_tooltip := a_tooltip.as_string_32.twin
		end

	tooltip: STRING_32
			-- Tooltip displayed on `Current'.
		do
			if attached internal_tooltip as l_internal_tooltip then
				Result := l_internal_tooltip.twin
			else
				Result := ""
			end
		end

	set_text (txt: READABLE_STRING_GENERAL)
			-- Set current button text to `txt'.
		do
			internal_text := txt.as_string_32.twin
			if attached parent_imp as l_parent_imp then
				l_parent_imp.set_text_on_position (l_parent_imp.index_of (attached_interface, 1) , txt)
			end
		end

	set_pixmap (a_pix: EV_PIXMAP)
			-- Set the rows `pixmap' to `a_pix'.
		local
			l_pixmap: detachable EV_PIXMAP
		do
			l_pixmap := a_pix.twin
			pixmap := l_pixmap
			if attached parent_imp as l_parent_imp then
				l_parent_imp.set_row_pixmap (l_parent_imp.index_of (attached_interface, 1), l_pixmap)
			end
		end

	remove_pixmap
			-- Remove the rows pixmap.
		do
			pixmap := Void
			if attached parent_imp as l_parent_imp then
				l_parent_imp.remove_row_pixmap (l_parent_imp.index_of (attached_interface, 1))
			end
		end

	pixmap: detachable EV_PIXMAP

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		local
			l_h_adjust: POINTER
		do
			-- Return parents horizontal scrollbar offset.
			if attached {EV_LIST_IMP} parent_imp as l_list_imp then
					--| FIXME Combo box list needs to be attained somehow
				l_h_adjust := {GTK}.gtk_scrolled_window_get_hadjustment (l_list_imp.scrollable_area)
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
			-- Return parents horizontal scrollbar offset.
			if attached parent_imp as l_parent_imp then
				Result := (l_parent_imp.index_of (interface, 1) - 1) * l_parent_imp.row_height
				if attached {EV_LIST_IMP} l_parent_imp as l_list_imp then
						--| FIXME Combo box list needs to be attained somehow
					l_v_adjust := {GTK}.gtk_scrolled_window_get_hadjustment (l_list_imp.scrollable_area)
					if l_v_adjust /= default_pointer then
						Result := Result - {GTK}.gtk_adjustment_get_value (l_v_adjust).rounded
					end
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
				Result := l_parent_imp.height
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

	internal_text: STRING_32
		-- Text displayed in `Current'

	destroy
			-- Clean up `Current'
		do
			if attached parent_imp as l_parent_imp then
				l_parent_imp.attached_interface.prune (attached_interface)
			end
			set_is_destroyed (True)
			pixmap := Void
		end

feature {EV_LIST_ITEM_LIST_IMP} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
			-- Do nothing
		end

	internal_tooltip: detachable STRING_32
		-- Tooltip used for `Current'.

	set_list_iter (a_iter: EV_GTK_TREE_ITER_STRUCT)
			-- Set `list_iter' to `a_iter'
		do
			list_iter := a_iter
		end

	list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		-- Object representing position of `Current' in parent tree model

	parent_imp: detachable EV_LIST_ITEM_LIST_IMP

	set_parent_imp (a_parent_imp: detachable EV_LIST_ITEM_LIST_IMP)
			--
		do
			parent_imp := a_parent_imp
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_LIST_ITEM note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_LIST_ITEM_IMP
