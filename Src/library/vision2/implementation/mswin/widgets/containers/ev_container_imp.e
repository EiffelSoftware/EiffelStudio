indexing

	description: 
		"EiffelVision container. Allows only one children.%
		 % Deferred class, parent of all the containers.  %
		 % Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_CONTAINER_IMP
	
inherit
	EV_CONTAINER_I	
		

	EV_WIDGET_IMP
		export
			{EV_WEL_FRAME_WINDOW} parent_imp
		redefine
			parent_ask_resize,
			set_move_and_size,
			set_insensitive
		end

	WEL_WM_CONSTANTS


feature {EV_CONTAINER}
	
	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite
		do
			child_imp.set_parent_imp (Current)
			the_child := child_imp
			set_minimum_size (the_child.minimum_width, the_child.minimum_height)
			if the_child.width /= 0 or the_child.height /= 0 then
				child_has_resized (the_child.width, the_child.height, the_child)
			end
		end

feature -- Access
	
	client_width: INTEGER is
			-- Width of the client area of container
		do
			Result := wel_window.client_rect.width
		end
	
	client_height: INTEGER is
			-- Height of the client area of container
		do
			Result := wel_window.client_rect.height
		end

feature -- Status report

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
   			-- `flag'.
		do
			if the_child /= Void then
				the_child.set_insensitive (flag)
			end
			Precursor (flag)
		end

feature {EV_WIDGET_IMP, EV_WEL_FRAME_WINDOW} -- Implementation

	parent_ask_resize (new_width, new_height: INTEGER) is
			-- When the parent asks the resize, it's not 
			-- necessary to send him back the information
		do
			Precursor (new_width, new_height)
			if the_child /= Void then
				the_child.parent_ask_resize (client_width, client_height)
			end
		end
	
	child_has_resized (new_width, new_height: INTEGER; child: EV_WIDGET_IMP) is
			-- Resize the container according to the 
			-- resize of the child
		do
			set_size (new_width, new_height)
		end

	child_minwidth_changed (new_child_minimum: INTEGER) is
			-- Change the minimum width of the container because
			-- the child changed his own minimum width.
			-- By default, the minimum width of a container is
			-- the one of its child, to change this, just use
			-- set_minimum_width
		do
			set_minimum_width (new_child_minimum)
		end

	child_minheight_changed (new_child_minimum: INTEGER) is
			-- Change the minimum width of the container because
			-- the child changed his own minimum width.
			-- By default, the minimum width of a container is
			-- the one of its child, to change this, just use
			-- set_minimum_width
		do
			set_minimum_height (new_child_minimum)
		end

	set_move_and_size (a_x, a_y, new_width, new_height: INTEGER) is
			-- When the parent asks to move and resize, it does it
			-- and the notice the child.
		do
			Precursor (a_x, a_y, new_width, new_height)
			if the_child /= void then
				the_child.parent_ask_resize (client_width, client_height)
			end
		end

feature {EV_WEL_CONTROL_WINDOW, EV_WEL_FRAME_WINDOW} -- Implementation

	on_show is
			-- Is called by the `wel_window' when the window
			-- is displayed on the screen. Is usefull to resize
			-- the container and the child.
			-- Is redefine by some heir.
		do
		end

feature -- Implementation

	the_child: EV_WIDGET_IMP
			-- The child of the composite

	wel_window: WEL_COMPOSITE_WINDOW is
			-- The current wel_window
		deferred
		end

end

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
