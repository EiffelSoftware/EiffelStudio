indexing
	description: "EiffelVision scrollable area. %
				% Mswindows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLLABLE_AREA_IMP

inherit
	EV_SCROLLABLE_AREA_I

	EV_SINGLE_CHILD_CONTAINER_IMP
		redefine
			child_minwidth_changed,
			child_minheight_changed,
			update_display
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		redefine
			make,
			default_ex_style,
			move_and_resize
		end

creation
	make

feature {NONE} -- Initialization

	make is
		do
			{EV_WEL_CONTROL_CONTAINER_IMP} Precursor
			set_text ("Scrollable Area")
			!! scroller.make_with_options (Current, 0, 10, 0, 10, 1, 20, 1, 20)
		end

feature -- Element change

	set_top_level_window_imp (a_window: WEL_WINDOW) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		do
			top_level_window_imp := a_window
			if child /= Void then
				child.set_top_level_window_imp (a_window)
			end
		end

feature {NONE} -- Implementation

	change_horizontal_range (value: INTEGER) is
			-- Change the horizontal range according to the child's size.
		do
			if value > client_width then
				set_horizontal_range (0, value - client_width)
			else
				set_horizontal_range (0, 0)
			end
		end

	change_vertical_range (value: INTEGER) is
			-- Change the vertical range according to the child's size.
		do
			if value > client_height then
				set_vertical_range (0, value - client_height)
			else
				set_vertical_range (0, 0)
			end
		end

feature {NONE} -- Implementation

	update_display is
			-- Do nothing for a non manager container.
		do
		end

feature {NONE} -- Implementation for automatic size compute.

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER;
			repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		local
			step: INTEGER
		do
			{EV_WEL_CONTROL_CONTAINER_IMP} Precursor (a_x, a_y, a_width, a_height, repaint)
			if child /= Void and then not child.destroyed then
				if client_width > child.width + child.x and child.x < 0 then
					step :=(client_width - child.width - child.x).min (-child.x)	
					set_horizontal_range (0, maximal_horizontal_position - step)
					horizontal_update (step, (horizontal_position + step).min (maximal_horizontal_position))
				else
					change_horizontal_range (child.width)
				end
				if client_height > child.height + child.y and child.y < 0 then
					step := (client_height - child.height - child.y).min (-child.y) 
					set_vertical_range (0, maximal_vertical_position - step)
					vertical_update (step , (vertical_position + step).min (maximal_vertical_position))
				else
					change_vertical_range (child.height)
				end
			end
		end

	child_minwidth_changed (new_child_minimum: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the minimum width of the container because
			-- the child changed his own minimum width.
			-- By default, the minimum width of a container is
			-- the one of its child, to change this, just use
			-- set_minimum_width
		do
		end

	child_minheight_changed (new_child_minimum: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the minimum width of the container because
			-- the child changed his own minimum width.
			-- By default, the minimum width of a container is
			-- the one of its child, to change this, just use
			-- set_minimum_width
		do
		end

feature {NONE} -- WEL Implementation

	default_ex_style: INTEGER is
		do
			Result := {EV_WEL_CONTROL_CONTAINER_IMP} Precursor + Ws_ex_clientedge
		end

end -- class EV_SCROLLABLE_AREA_IMP

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
