indexing
	description:
		"EiffelVision frame, Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	EV_FRAME_IMP

inherit

	EV_FRAME_I

	EV_CONTAINER_IMP
		redefine
			client_width,
			client_height,
			parent_ask_resize,
			child_width_changed,
			child_height_changed,
			child_minwidth_changed,
			child_minheight_changed
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
			on_size,
			on_paint,
			background_brush
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the frame with the default options.
		local
			wlf: WEL_LOG_FONT
			wel_font: WEL_FONT
		do
			!! wlf.make (1, "Arial")
			!! box_text_font.make_indirect (wlf)
			make_with_text (par, "")
			private_box.set_font (box_text_font)
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
		local
			par_imp: WEL_WINDOW
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
			make_with_coordinates (par_imp, "Frame", 0, 0, 0, 0)
			!! private_box.make (Current, txt, 0, 0, 0, 0, 0)
		end

feature -- Access

	client_width: INTEGER is
			-- Width of the client area of container
		do
			Result := client_rect.width - 2 * box_width
		end
	
	client_height: INTEGER is
			-- Height of the client area of container
		do
			Result := client_rect.height - box_text_height - 2 * box_height
		end

feature {EV_WIDGET_IMP} -- Implementation

	parent_ask_resize (a_width, a_height: INTEGER) is
			-- When the parent asks the resize, it's not 
			-- necessary to send him back the information
		do
			child_cell.resize (minimum_width.max(a_width), minimum_height.max (a_height))
			if resize_type = 3 then
				move_and_resize (child_cell.x, child_cell.y, child_cell.width, child_cell.height, True)
			elseif resize_type = 2 then
				move_and_resize ((child_cell.width - width)//2 + child_cell.x, child_cell.y, width, child_cell.height, True)
			elseif resize_type = 1 then
				move_and_resize (child_cell.x, (child_cell.height - height)//2 + child_cell.y, child_cell.width, height, True)
			else
				move ((child_cell.width - width)//2 + child_cell.x, (child_cell.height - height)//2 + child_cell.y)
			end
			if child /= Void then
				child.set_move_and_size (box_width, box_text_height + box_height, a_width - 2 * box_width,
										a_height - box_text_height - 2 * box_height)
			end
		end
	
	child_width_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the size of the container because of the child.
		do
			Precursor (value + 2 * box_width, the_child)
		end

	child_height_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the size of the container because of the child.
		do
			Precursor (value + box_text_height + 2 * box_height, the_child)
		end

	child_minwidth_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the minimum width of the container because
			-- the child changed his own minimum width.
			-- By default, the minimum width of a container is
			-- the one of its child, to change this, just use
			-- set_minimum_width
		do
			set_minimum_width (value + 2 * box_width)
		end

	child_minheight_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the minimum width of the container because
			-- the child changed his own minimum width.
			-- By default, the minimum width of a container is
			-- the one of its child, to change this, just use
			-- set_minimum_width
		do
			set_minimum_height (value + box_text_height + 2 * box_height)
		end

feature {NONE} -- Implementation : WEL features

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

	on_size (code, new_width, new_height: INTEGER) is
			-- Resize the frame according to parent.
		require else
			box_not_void: private_box /= Void
			box_exists: private_box.exists
		do
			private_box.resize ((new_width).max (minimum_width),
								(new_height).max (minimum_height))
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
		do
			if box_text_font /= Void then
				private_box.set_font (box_text_font)
			end
		end

	private_box: WEL_GROUP_BOX
			-- Frame around the container

	box_text_height: INTEGER is
			-- Text height of the box title
		local
			a_log_font: WEL_LOG_FONT
		do
			a_log_font := private_box.font.log_font
			Result := a_log_font.height
		end
	
	box_text_font: WEL_FONT
			-- Font for the box title

	box_height: INTEGER is 2
			-- Height of frame

	box_width: INTEGER is 2
			-- Width of frame

end -- class EV_FRAME_IMP

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
