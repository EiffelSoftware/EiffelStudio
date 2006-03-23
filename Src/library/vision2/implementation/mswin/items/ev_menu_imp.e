indexing
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
			make,
			initialize,
			has_parent,
			disable_sensitive,
			enable_sensitive,
			wel_set_text,
			dispose,
			destroy
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			interface,
			make,
			initialize,
			dispose
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			Precursor {EV_MENU_ITEM_IMP} (an_interface)
			create ev_children.make (2)
			make_track
			make_id
			create radio_group.make
		end

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_MENU_ITEM_IMP}
			Precursor {EV_MENU_ITEM_LIST_IMP}
		end

feature {EV_ANY_I} -- Basic operations

	disable_sensitive is
   			-- Set `Current' insensitive.
   		local
   			menu_bar_imp: EV_MENU_BAR_IMP
		do
			is_sensitive := False
			set_insensitive (True)
			if has_parent then
				parent_imp.disable_position (parent_imp.index_of (interface, 1) - 1)
					--| Only disabling the position is not enough if we are parented in
					--| a menu bar (i.e. always visible on the window). We must call
					--| `draw_menu' on the window for the visual appearence of `Current' to
					--| be updated immediately.
				menu_bar_imp ?= parent_imp
				if menu_bar_imp /= Void then
					if menu_bar_imp.parent_imp /= Void then
						menu_bar_imp.parent_imp.draw_menu
					end
				end
			end
   		end

	enable_sensitive is
			-- Set `Current' insensitive.
		local
   			menu_bar_imp: EV_MENU_BAR_IMP
		do
			is_sensitive := True
			set_insensitive (False)
			if has_parent then
				parent_imp.enable_position (parent_imp.index_of (interface, 1) - 1)
					--| Only enabling the position is not enough if we are parented in
					--| a menu bar (i.e. always visible on the window). We must call
					--| `draw_menu' on the window for the visual appearence of `Current' to
					--| be updated immediately.
				menu_bar_imp ?= parent_imp
				if menu_bar_imp /= Void then
					if menu_bar_imp.parent_imp /= Void then
						menu_bar_imp.parent_imp.draw_menu
					end
				end
			end
		end

	show is
			-- Pop up on the current pointer position.
		local
			wel_point: WEL_POINT
			l_popup: EV_POPUP_MENU_HANDLER
		do
			if count > 0 then
				create wel_point.make (0, 0)
				wel_point.set_cursor_position
				create l_popup.make_with_menu (Current)
				show_track (wel_point.x, wel_point.y, l_popup)
					-- If we do not process events now, the fact we remove the
					-- menu from `l_popup' will prevent the action to be executed.
				application_imp.process_events
					-- We need to remove menu from `l_popup' as destroying the
					-- window would also destroy the menu and we do not want that.
				l_popup.unset_menu
				l_popup.destroy
			end
		end

	set_insensitive (flag: BOOLEAN) is
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

	show_at (a_widget: EV_WIDGET; a_x, a_y: INTEGER) is
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		local
			wel_point: WEL_POINT
			wel_win: WEL_WINDOW
			l_popup: EV_POPUP_MENU_HANDLER
		do
			if count > 0 then
				create wel_point.make (a_x, a_y)
				wel_win ?= a_widget.implementation
				if wel_win /= Void then
					create wel_point.make (a_x, a_y)
					wel_point.client_to_screen (wel_win)
				else
					create wel_point.make (0, 0)
				end
				create l_popup.make_with_menu (Current)
				show_track (wel_point.x, wel_point.y, l_popup)
					-- If we do not process events now, the fact we remove the
					-- menu from `l_popup' will prevent the action to be executed.
				application_imp.process_events
					-- We need to remove menu from `l_popup' as destroying the
					-- window would also destroy the menu and we do not want that.
				l_popup.unset_menu
				l_popup.destroy
			end
		end

feature {EV_ANY_I} -- Implementation

	on_measure_menu_item (measure_item_struct: WEL_MEASURE_ITEM_STRUCT) is
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
			border_width: INTEGER
		do
			space_width := menu_font.string_width ("W")
			border_width := menu_font.string_width ("WC")
			from
				ev_children.start
			until
				ev_children.after
			loop
				a_menu_item_imp := ev_children.item
				max_plain_text_width := max_plain_text_width.max (menu_font.string_width (a_menu_item_imp.plain_text_without_ampersands))
				max_accel_text_width := max_accel_text_width.max (menu_font.string_width (a_menu_item_imp.accelerator_text))
				if a_menu_item_imp.pixmap_imp /= Void then
					max_pixmap_width := max_pixmap_width.max (a_menu_item_imp.pixmap_imp.width)
				end
				max_height := max_height.max (a_menu_item_imp.desired_height)

				ev_children.forth
			end

			if max_pixmap_width = 0 then
				plain_text_pos := border_width
				if max_accel_text_width = 0 then
					max_width := border_width + max_plain_text_width + border_width
					accelerator_text_pos := 0
				else
					max_width := border_width + max_plain_text_width + space_width + max_accel_text_width + border_width
					accelerator_text_pos := plain_text_pos + max_plain_text_width + space_width
				end
			else
				plain_text_pos := max_pixmap_width + 6
				if max_accel_text_width = 0 then
					max_width := max_pixmap_width + 6 + max_plain_text_width + border_width
					accelerator_text_pos := 0
				else
					max_width := max_pixmap_width + 6 + max_plain_text_width + space_width + max_accel_text_width + border_width
					accelerator_text_pos := plain_text_pos + max_plain_text_width + space_width
				end
			end
			max_width := max_width - 2 * menu_font.string_width ("B")
			measure_item_struct.set_item_width (max_width)
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

	update_parent_size is
			-- Update size of parent
		do
			--| No need to do anything here. Deferred from EV_MENU_ITEM_LIST_IMP.
		end

	wel_set_text (a_text: STRING_GENERAL) is
			-- Assign `a_text' to `Current' and refresh `Current'.
		local
			wel_string: WEL_STRING
			pos: INTEGER
		do

			real_text := a_text.twin
			if has_parent then
				create wel_string.make (real_text)
					-- Retrieve the index of `Current'.
				pos := parent_imp.interface.index_of (interface, 1)
					-- Modify `Current'.
				cwin_modify_menu (parent_imp.wel_item, pos - 1, Mf_Byposition +	Mf_String + Mf_popup,
					wel_item, wel_string.item)
					-- Re-draw the menu bar.
				if top_level_window_imp /= Void then
					cwin_draw_menu_bar (top_level_window_imp.wel_item)
				end
			end
		end

	has_parent: BOOLEAN is
			-- Is `Current' parented?
		do
			Result := parent_imp /= Void
		end

	disable_default_processing is
			-- Disable default window processing.
		do
			--| FIXME To be implemented for pick-and-dropable.
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item
			-- event. Called on a pointer press.
		do
			--| FIXME To be implemented for pick-and-dropable.
		end

	internal_propagate_pointer_double_press (keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item event.
			-- Called on a pointer double press.
		do
			--| FIXME To be implemented for pick-and-dropable.
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_MENU_ITEM_IMP is
			-- `Result' is menu_item at pixel position `x_pos', `y_pos'.
		do
			--| FIXME to be implemented for pick-and-dropable.
		end

	screen_x: INTEGER is
			-- Horizontal offset of `Current' relative to screen.
		do
		end

	screen_y: INTEGER is
			-- Vertical offset of `Current' relative to screen.
		do
		end

	dragable_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
			-- Process `a_button' to start/stop the drag/pick and
			-- drop mechanism.
		do
			-- Not applicable. Required by implementation of EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
			-- as for widgets that contain items, there are correct implementations. It is
			-- of no harm to call this, as it will just do nothing and docking will not occur.
		end

	check_dragable_release (x_pos, y_pos: INTEGER) is
			-- End transport if in drag and drop.
		do
			-- Not applicable. Required by implementation of EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
			-- as for widgets that contain items, there are correct implementations. It is
			-- of no harm to call this, as it will just do nothing and docking will not occur.
		end

	client_to_screen (a_x, a_y: INTEGER): WEL_POINT is
			-- `Result' is absolute screen coordinates in pixels
			-- of coordinates `a_x', a_y_' on `Current'.
		do
			--| FIXME To be implemented for pick-and-dropable.
			check
				to_be_implemented: False
			end
		end

	dispose is
			-- Destroy the inner structure of `Current'.
			--
			-- This function should be called by the GC when the
			-- object is collected or by the user if `Current' is
			-- no more usefull.
		do
			Precursor {EV_MENU_ITEM_IMP}
			Precursor {EV_MENU_ITEM_LIST_IMP}
		end

	destroy is
			-- Destroy underlying native toolkit objects.
			-- Render `Current' unusable.
			-- Any feature calls after a call to destroy are
			-- invalid.
		do
			interface.wipe_out
			Precursor {EV_MENU_ITEM_IMP}
			destroy_item
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU;

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




end -- class EV_MENU_IMP

