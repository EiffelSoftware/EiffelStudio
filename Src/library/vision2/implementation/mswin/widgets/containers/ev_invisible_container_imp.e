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
		undefine
			add_child_ok
		redefine
			add_child,
			set_insensitive
		end

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_parent,
			destroy as wel_destroy
		undefine
			set_width,
			set_height,
			remove_command,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_char,
			on_key_up
		redefine
			default_style,
			background_brush
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize the container by creating ev_children
		do 
			!! ev_children.make (2)
		end

feature {NONE} -- Access
	
	ev_children: ARRAYED_LIST [EV_WIDGET_IMP]
			-- List of the children of the box

feature -- Implementation

	add_child (child_imp: EV_WIDGET_IMP) is
		do
			child := child_imp
			ev_children.extend (child_imp)
		end

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
   			-- `flag'.
		do
			if not ev_children.empty then
				from
					ev_children.start
				until
					ev_children.after
				loop
					ev_children.item.set_insensitive (flag)
					ev_children.forth
				end
			end
			{EV_CONTAINER_IMP} Precursor (flag)
		end

feature {NONE} -- Implementation : WEL features

	default_style: INTEGER is
		once
			Result := Ws_child + Ws_visible 
				+ Ws_clipchildren + Ws_clipsiblings
		end

	background_brush: WEL_BRUSH is
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
			-- By default there is no background
		do
			if background_color /= Void then
				!! Result.make_solid (background_color)
				disable_default_processing
			end
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
