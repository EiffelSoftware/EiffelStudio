indexing
	description: 
		"EiffelVision invisible container. Allow several children.%
	     % Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_INVISIBLE_CONTAINER_IMP
	
inherit
	EV_INVISIBLE_CONTAINER_I

	EV_CONTAINER_IMP
		redefine
			set_insensitive,
			on_first_display
		end

	EV_WEL_CONTROL_CONTAINER_IMP

feature -- Access
	
	ev_children: ARRAYED_LIST [EV_WIDGET_IMP]
			-- List of the children of the box

feature -- Status setting

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
   			-- `flag'.
		local
			list: ARRAYED_LIST [EV_WIDGET_IMP]
		do
			if not ev_children.empty then
				list := ev_children
				from
					list.start
				until
					list.after
				loop
					list.item.set_insensitive (flag)
					list.forth
				end
			end
			{EV_CONTAINER_IMP} Precursor (flag)
		end

feature -- Element change

	set_top_level_window_imp (a_window: WEL_WINDOW) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		local
			list: ARRAYED_LIST [EV_WIDGET_IMP]
		do
			top_level_window_imp := a_window
			if not ev_children.empty then
				list := ev_children
				from
					list.start
				until
					list.after
				loop
					list.item.set_top_level_window_imp (a_window)
					list.forth
				end
			end
		end

feature -- Basic operation

	on_first_display is
			-- Called by the top_level window.
		local
			i: INTEGER
			list: ARRAYED_LIST [EV_WIDGET_IMP]
		do
			if not ev_children.empty then
				list := ev_children
				from
					i := 1
				until
					i = list.count + 1
				loop
					(list @ i).on_first_display
					i := i + 1
				end
			end
--			parent_ask_resize (minimum_width, minimum_height)
		end

feature -- Basic operations

	propagate_background_color is
			-- Propagate the current background color of the container
			-- to the children.
		local
			list: ARRAYED_LIST [EV_WIDGET_IMP]
		do
			if not ev_children.empty then
				list := ev_children
				from
					list.start
				until
					list.after
				loop
					list.item.set_background_color (background_color)
					list.forth
				end
			end
		end

	propagate_foreground_color is
			-- Propagate the current foreground color of the container
			-- to the children.
		local
			list: ARRAYED_LIST [EV_WIDGET_IMP]
		do
			if not ev_children.empty then
				list := ev_children
				from
					list.start
				until
					list.after
				loop
					list.item.set_foreground_color (foreground_color)
					list.forth
				end
			end
		end

feature -- Assertion features

	add_child_ok: BOOLEAN is
			-- Used in the precondition of
			-- 'add_child'. True, if it is ok to add a
			-- child to container.
		do
			Result := True
		end

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of the container?
		do
			Result := ev_children.has (a_child)
		end

end -- class EV_INVISIBLE_CONTAINER_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
