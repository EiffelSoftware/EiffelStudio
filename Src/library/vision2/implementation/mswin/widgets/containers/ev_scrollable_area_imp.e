indexing
	description: "EiffelVision scrollable area. %
				% Mswindows implementation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLLABLE_AREA_IMP

inherit
	EV_SCROLLABLE_AREA_I

	EV_CONTAINER_IMP
		redefine
			child_minwidth_changed,
			child_minheight_changed,
			update_display
		end

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			set_parent as wel_set_parent,
			destroy as wel_destroy
		undefine
				-- We undefine the features refined by EV_CONTAINER_IMP
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
			on_key_up,
			on_draw_item,
			background_brush,
			on_menu_command
		redefine
			default_style,
			move_and_resize
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		local
			par_imp: WEL_COMPOSITE_WINDOW
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
			wel_make (par_imp, "Scrollable Area")
			!! scroller.make_with_options (Current, 0, 10, 0, 10, 1, 20, 1, 20)
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
			{WEL_CONTROL_WINDOW} Precursor (a_x, a_y, a_width, a_height, repaint)
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

feature {NONE} -- WEL implementation

	default_style: INTEGER is
			-- Default style used to create the window.
			-- See class WEL_WS_CONSTANTS.
		do
			Result := {WEL_CONTROL_WINDOW} Precursor 
					+ Ws_clipchildren + Ws_clipsiblings
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
