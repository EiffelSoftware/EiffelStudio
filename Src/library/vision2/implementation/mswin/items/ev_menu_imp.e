note
	description: "EiffelVision menu. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_IMP

inherit
	EV_MENU_I
		undefine
			parent
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			interface,
			old_make,
			make,
			has_parent,
			disable_sensitive,
			enable_sensitive,
			wel_set_text,
			dispose,
			destroy,
			load_bounds_rect
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			old_make,
			interface,
			make,
			dispose
		end

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			create ev_children.make (2)
			create radio_group.make
			Precursor {EV_MENU_ITEM_LIST_IMP}
			make_track
			make_id
			Precursor {EV_MENU_ITEM_IMP}
		end

feature {EV_ANY_I} -- Basic operations

	disable_sensitive
   			-- Set `Current' insensitive.
   		local
   			menu_bar_imp: detachable EV_MENU_BAR_IMP
		do
			is_sensitive := False
			set_insensitive (True)
			if has_parent and then attached parent_imp as l_parent_imp then
				l_parent_imp.disable_position (l_parent_imp.index_of (interface, 1) - 1)
					--| Only disabling the position is not enough if we are parented in
					--| a menu bar (i.e. always visible on the window). We must call
					--| `draw_menu' on the window for the visual appearence of `Current' to
					--| be updated immediately.
				menu_bar_imp ?= l_parent_imp
				if menu_bar_imp /= Void then
					if attached menu_bar_imp.parent_imp as l_menu_bar_parent_imp then
						l_menu_bar_parent_imp.draw_menu
					end
				end
			end
   		end

	enable_sensitive
			-- Set `Current' insensitive.
		local
   			menu_bar_imp: detachable EV_MENU_BAR_IMP
		do
			is_sensitive := True
			set_insensitive (False)
			if has_parent and then attached parent_imp as l_parent_imp then
				l_parent_imp.enable_position (l_parent_imp.index_of (interface, 1) - 1)
					--| Only enabling the position is not enough if we are parented in
					--| a menu bar (i.e. always visible on the window). We must call
					--| `draw_menu' on the window for the visual appearence of `Current' to
					--| be updated immediately.
				menu_bar_imp ?= l_parent_imp
				if menu_bar_imp /= Void then
					if attached menu_bar_imp.parent_imp as l_menu_bar_parent_imp then
						l_menu_bar_parent_imp.draw_menu
					end
				end
			end
		end

	show
			-- Pop up on the current pointer position.
		local
			wel_point: WEL_POINT
			l_popup: EV_POPUP_MENU_HANDLER
		do
			if count > 0 then
				create wel_point.make (0, 0)
				wel_point.set_cursor_position
				create l_popup.make_with_menu (Current, wel_point.window_at)
				show_track (wel_point.x, wel_point.y, l_popup)
					-- No need of the temporary window anymore.
				l_popup.destroy
			end
		end

	set_insensitive (flag: BOOLEAN)
			-- If `flag' then make children of `Current' insensitive else
			-- make children sensitive.
		local
			list: ARRAYED_LIST [EV_MENU_ITEM_IMP]
			child_imp: EV_MENU_ITEM_IMP
			cur: CURSOR
		do
			if not ev_children.is_empty then
				list := ev_children
				from
					cur := list.cursor
					list.start
				until
					list.after
				loop
					child_imp := list.item
					if flag then
						child_imp.disable_sensitive
					else
						if not child_imp.internal_non_sensitive then
							child_imp.enable_sensitive
						end
					end
					list.forth
				end
				list.go_to (cur)
			end
		ensure
			cursor_not_moved: old ev_children.index = ev_children.index
		end

	show_at (a_widget: detachable EV_WIDGET; a_x, a_y: INTEGER)
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		local
			wel_point: WEL_POINT
			wel_win: detachable WEL_WINDOW
			l_popup: EV_POPUP_MENU_HANDLER
		do
			if count > 0 then
				create wel_point.make (a_x, a_y)
				if a_widget /= Void then
					wel_win ?= a_widget.implementation
				end
				if wel_win /= Void then
					wel_point.client_to_screen (wel_win)
				else
						-- If no Window found, we still try to locate the window below the current
						-- coordinate. That way the window won't loose its focus due to EV_POPUP_MENU_HANDLER
						-- creating a top window.
					wel_win ?= wel_point.window_at
				end
				create l_popup.make_with_menu (Current, wel_win)
				show_track (wel_point.x, wel_point.y, l_popup)
					-- No need of the temporary window anymore.
				l_popup.destroy
			end
		end

feature {EV_ANY_I} -- Implementation

	on_measure_menu_item (measure_item_struct: WEL_MEASURE_ITEM_STRUCT)
			-- Compute and return the width of this menu, and update `tabulation_margin'.
		local
			a_menu_item_imp: EV_MENU_ITEM_IMP
			max_plain_text_width: INTEGER -- maximum size for the plain text
			max_accel_text_width: INTEGER -- maximum size for the accelerator text
			max_pixmap_width: INTEGER
			max_height: INTEGER
			space_width: INTEGER
			max_width: INTEGER
			plain_text_pos: INTEGER
			accelerator_text_pos: INTEGER
		do
				-- By default we assume that with or without a pixmap a menu item should have the same alignment.
				-- Usually pixmaps are 16 by 16 pixels, thus the default size.
			max_pixmap_width := 16
				-- Default spacing between text and accelerator, and the right border.
				-- We use the letter `o' so that the spacing is proportional to the chosen font.
			space_width := menu_font.string_width ("o")
			from
				ev_children.start
			until
				ev_children.after
			loop
				a_menu_item_imp := ev_children.item
				max_plain_text_width := max_plain_text_width.max (menu_font.string_width (a_menu_item_imp.plain_text_without_ampersands))
				max_accel_text_width := max_accel_text_width.max (menu_font.string_width (a_menu_item_imp.accelerator_text))
				if attached a_menu_item_imp.pixmap_imp as l_pixmap_imp then
					max_pixmap_width := max_pixmap_width.max (l_pixmap_imp.width)
				end
				max_height := max_height.max (a_menu_item_imp.desired_height)

				ev_children.forth
			end

				-- Put text about 6 pixels away from the pixmap to handle various
				-- ways to draw the pixmap (normal, disabled, selected).
			plain_text_pos := max_pixmap_width + 6

			if max_accel_text_width = 0 then
				accelerator_text_pos := 0
				max_width := plain_text_pos + max_plain_text_width
			else
				accelerator_text_pos := plain_text_pos + max_plain_text_width + space_width
				max_width := accelerator_text_pos + max_accel_text_width
			end

			measure_item_struct.set_item_width (max_width + space_width)
			measure_item_struct.set_item_height (max_height)

				-- Update the tabulation margins
			from
				ev_children.start
			until
				ev_children.after
			loop
				ev_children.item.set_plain_text_position (plain_text_pos)
				ev_children.item.set_accelerator_text_position (accelerator_text_pos)
				ev_children.forth
			end
		end

feature {NONE} -- Implementation

	update_parent_size
			-- Update size of parent
		do
			--| No need to do anything here. Deferred from EV_MENU_ITEM_LIST_IMP.
		end

	wel_set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `Current' and refresh `Current'.
		local
			wel_string: WEL_STRING
			pos: INTEGER
		do

			real_text := a_text.as_string_32.twin
			if has_parent and then attached parent_imp as l_parent_imp then
				create wel_string.make (a_text)
					-- Retrieve the index of `Current'.
				pos := l_parent_imp.attached_interface.index_of (attached_interface, 1)
					-- Modify `Current'.
				cwin_modify_menu (l_parent_imp.wel_item, pos - 1, Mf_Byposition +	Mf_String + Mf_popup,
					wel_item, wel_string.item)
					-- Re-draw the menu bar.
				if attached top_level_window_imp as l_top_level_window_imp then
					cwin_draw_menu_bar (l_top_level_window_imp.wel_item)
				end
			end
		end

	has_parent: BOOLEAN
			-- Is `Current' parented?
		do
			Result := parent_imp /= Void
		end

	disable_default_processing
			-- Disable default window processing.
		do
			--| FIXME To be implemented for pick-and-dropable.
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER)
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item
			-- event. Called on a pointer press.
		do
			--| FIXME To be implemented for pick-and-dropable.
		end

	internal_propagate_pointer_double_press (keys, x_pos, y_pos, button: INTEGER)
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item event.
			-- Called on a pointer double press.
		do
			--| FIXME To be implemented for pick-and-dropable.
		end

	find_item_at_position (x_pos, y_pos: INTEGER): detachable EV_MENU_ITEM_IMP
			-- `Result' is menu_item at pixel position `x_pos', `y_pos'.
		do
			--| FIXME to be implemented for pick-and-dropable.
		end

	dragable_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER)
			-- Process `a_button' to start/stop the drag/pick and
			-- drop mechanism.
		do
			-- Not applicable. Required by implementation of EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
			-- as for widgets that contain items, there are correct implementations. It is
			-- of no harm to call this, as it will just do nothing and docking will not occur.
		end

	check_dragable_release (x_pos, y_pos: INTEGER)
			-- End transport if in drag and drop.
		do
			-- Not applicable. Required by implementation of EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
			-- as for widgets that contain items, there are correct implementations. It is
			-- of no harm to call this, as it will just do nothing and docking will not occur.
		end

	client_to_screen (a_x, a_y: INTEGER): detachable WEL_POINT
			-- `Result' is absolute screen coordinates in pixels
			-- of coordinates `a_x', a_y_' on `Current'.
		do
			--| FIXME To be implemented for pick-and-dropable.
			check
				to_be_implemented: False
			end
		end

	dispose
			-- Destroy the inner structure of `Current'.
			--
			-- This function should be called by the GC when the
			-- object is collected or by the user if `Current' is
			-- no more usefull.
		do
			Precursor {EV_MENU_ITEM_IMP}
			Precursor {EV_MENU_ITEM_LIST_IMP}
		end

	destroy
			-- Destroy underlying native toolkit objects.
			-- Render `Current' unusable.
			-- Any feature calls after a call to destroy are
			-- invalid.
		do
			attached_interface.wipe_out
			Precursor {EV_MENU_ITEM_IMP}
			destroy_item
		end

	load_bounds_rect
			-- Load rect struct which holds boundary information
		local
			menu_bar: detachable EV_MENU_BAR_IMP
		do
			menu_bar ?= parent_imp

			if menu_bar /= Void and then attached menu_bar.parent_imp as l_menu_bar_parent_imp then
				if {WEL_API}.get_menu_item_rect (l_menu_bar_parent_imp.wel_item, menu_bar.wel_item, menu_bar.index_of (interface, 1)-1, bounds_rect.item) = 0 then
					bounds_rect.set_rect (0, 0, 0, 0)
				end
			else
				Precursor {EV_MENU_ITEM_IMP}
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_MENU note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_MENU_IMP
