indexing
	description: "EiffelVision container. Allows only one children.%
				 % Deferred class, parent of all the containers.   %
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
		redefine
			parent_ask_resize,
			set_move_and_size,
			set_insensitive
		end

	WEL_COMPOSITE_WINDOW
		rename
			parent as wel_parent
		undefine
				-- We undefine the features that have been redefined
				-- by EV_WIDGET_IMP
			remove_command,
				-- Then, we undefine what is redefine later
			set_width,
			set_height,
			minimal_width,
			minimal_height,
			maximal_width,
			maximal_height,
			move_and_resize,
			move,
			set_default_window_procedure,
			call_default_window_procedure,
			process_message,
			on_wm_menu_command,
			on_wm_control_id_command,
			on_show,
			on_size,
			on_get_min_max_info,
			on_destroy,
			on_menu_command,
			on_set_cursor,
			on_mouse_move,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_char,
			on_key_up,
			on_paint
		redefine
			destroy
		end
			

feature -- Access
	
	client_width: INTEGER is
			-- Width of the client area of container
		do
			Result := client_rect.width
		end
	
	client_height: INTEGER is
			-- Height of the client area of container
		do
			Result := client_rect.height
		end

feature -- Status report

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
   			-- `flag'.
		do
			if child /= Void then
				child.set_insensitive (flag)
			end
			Precursor (flag)
		end

feature -- Status setting

	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				parent_imp.set_insensitive (False)
			end
			{WEL_COMPOSITE_WINDOW} Precursor
		end

feature -- Element change

	add_child (child_imp: EV_WIDGET_I) is
			-- Add child into composite
		do
			child ?= child_imp
		end

feature {EV_WIDGET_IMP, EV_WEL_FRAME_WINDOW} -- Implementation

	parent_ask_resize (new_width, new_height: INTEGER) is
			-- When the parent asks the resize, it's not 
			-- necessary to send him back the information
		do
			Precursor (new_width, new_height)
			if child /= Void then
				child.parent_ask_resize (client_width, client_height)
			end
		end
	
	child_width_changed (new_child_width: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the size of the container because of the child.
		do
			set_width (new_child_width)
		end

	child_height_changed (new_child_height: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the size of the container because of the child.
		do
			set_height (new_child_height)
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
			if child /= void then
				child.parent_ask_resize (client_width, client_height)
			end
		end

end -- class EV_CONTAINER_IMP

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
