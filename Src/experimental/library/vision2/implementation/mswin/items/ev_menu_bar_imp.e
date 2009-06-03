note
	description: "Eiffel Vision menu bar. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_BAR_IMP

inherit
	EV_MENU_BAR_I
		redefine
			interface
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			make,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create `Current' with interface `an_interface'.
		do
			Precursor {EV_MENU_ITEM_LIST_IMP} (an_interface)
			wel_make
		end

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
			if parent /= Void then
				Result := screen_x - parent.screen_x
			end
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		do
			if parent /= Void then
				Result := screen_y - parent.screen_y
			end
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		do
			if parent_imp /= Void then
				if {WEL_API}.get_menu_bar_info (parent_imp.wel_item, {WEL_OBJID_CONSTANTS}.objid_menu, 0, info.item) /= 0 then
					Result := info.rc_bar.left
				end
			end
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		do
			if parent_imp /= Void then
				if {WEL_API}.get_menu_bar_info (parent_imp.wel_item, {WEL_OBJID_CONSTANTS}.objid_menu, 0, info.item) /= 0 then
					Result := info.rc_bar.top
				end
			end
		end

	width: INTEGER
			-- Horizontal size in pixels.
		do
			if parent_imp /= Void then
				if {WEL_API}.get_menu_bar_info (parent_imp.wel_item, {WEL_OBJID_CONSTANTS}.objid_menu, 0, info.item) /= 0 then
					Result := info.rc_bar.width
				end
			end
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			if parent_imp /= Void then
				if {WEL_API}.get_menu_bar_info (parent_imp.wel_item, {WEL_OBJID_CONSTANTS}.Objid_menu, 0, info.item) /= 0 then
					Result := info.rc_bar.height
				end
			end
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
		do
			Result := width
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
			Result := height
		end

feature {EV_ANY_I} -- Status report

	parent: EV_WINDOW
			-- Parent of `Current'.
		do
			if parent_imp /= Void then
				Result := parent_imp.interface
			end
		end

feature {NONE} -- Implementation

	is_sensitive: BOOLEAN = True
			-- `Current' is always sensitive as it cannot be disabled
			-- in the interface.

	destroy
			-- destroy `Current'.
		do
			if parent_imp /= Void then
				parent_imp.remove_menu_bar
			end
			set_is_destroyed (True)
		end

	update_parent_size
			-- Update size of `Parent_imp'.
		do
			if parent_imp /= Void then
				parent_imp.compute_minimum_size
			end
		end

feature {NONE} -- Pick and drop support

	--| FIXME All these features to be implemented are required by PND.
	-- Due to the way that windows handles messaging with menu's, implementing
	-- pick and drop may be difficult.
	-- I think that the pick and drop can be done using WM_MENURBUTTONUP,
	-- although drag and drop may be a lot more difficult.
	-- Julian Rogers 08/22/2000

	disable_default_processing
			-- Disable default window processing.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER)
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item
			-- event. Called on pointer press.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	internal_propagate_pointer_double_press
		(keys, x_pos, y_pos, button: INTEGER)
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item
			-- event. Called on pointer double press.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_MENU_IMP
			-- `Result' is menu at pixel position `x_pos', `y_pos'.
		do
		end

	set_pointer_style (value: EV_POINTER_STYLE)
			-- Make `value' the new cursor of the widget
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	client_to_screen (a_x, a_y: INTEGER): WEL_POINT
			-- `Result' is absolute screen coordinates in pixels
			-- of coordinates `a_x', a_y_' on `Current'.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	cursor_on_widget: CELL [EV_WIDGET_IMP]
			-- This cell contains the widget_imp that currently
			-- has the pointer of the mouse. As it is a once
			-- feature, it is a shared data.
			-- it is used for the `mouse_enter' and `mouse_leave'
			-- events.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	set_heavy_capture
			-- Grab user input.
			-- Works on all windows threads.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	release_heavy_capture
			-- Release user input
			-- Works on all windows threads.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	set_capture
			-- Grab user input.
			-- Works only on current windows thread.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	release_capture
			-- Release user input.
			-- Works only on current windows thread.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
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

feature {EV_ANY_I} -- Status Report

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window implementation containing `Current'.
		do
			Result := parent_imp
		end

	set_parent_imp (window: EV_WINDOW_IMP)
			-- Assign `window' to `parent_imp'.
		do
			if window /= Void then
				parent_imp := window
			else
				parent_imp := Void
			end
		end

	wel_count_empty: BOOLEAN
			-- Is `Current' empty?
			--| In some places, we wish to externally query if `Current'
			--| is empty. However, if this is done during a remove_item,
			--| the interface will still return the count as 1. See
			--|`Extra_minimum_height' from EV_TITLED_WINDOW_IMP.
		do
			Result := wel_count = 0
		end

	parent_imp: EV_WINDOW_IMP
		-- Parent of `Current'.

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_BAR;

feature {NONE} -- Implementation

	info: WEL_MENU_BAR_INFO
			-- Menu bar info struct used for API calls.
			-- This instance is shared.
		once
			create Result.make
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_MENU_BAR_IMP

