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
			child_minwidth_changed,
			child_minheight_changed
		end

	EV_SYSTEM_PEN_IMP

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			set_parent as wel_set_parent,
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
			on_key_up,
			on_draw_item,
			background_brush,
			on_menu_command
		redefine
			default_style,
			default_ex_style,
			on_paint,
			move_and_resize
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the frame with the default options.
		do
			make_with_text (par, "")
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
		local
			par_imp: WEL_WINDOW
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
			make_with_coordinates (par_imp, txt, 0, 0, 0, 0)
			!WEL_ANSI_VARIABLE_FONT! private_font.make
		end

feature -- Access

	client_width: INTEGER is
			-- Width of the client area of container
		do
			Result := (client_rect.width - 2 * box_width).max (0)
		end
	
	client_height: INTEGER is
			-- Height of the client area of container
		do
			Result := (client_rect.height - box_text_height - 2 * box_height).max (0)
		end

feature {NONE} -- Implementation for automatic size compute.

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

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER;
			repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		do
			{WEL_CONTROL_WINDOW} Precursor (a_x, a_y, a_width, a_height, True)
			if child /= Void then
				child.set_move_and_size (box_width, box_text_height + box_height, 
										client_width, client_height)
			end
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
		do
			Result := {WEL_CONTROL_WINDOW} Precursor + Ws_clipchildren
					+ Ws_clipsiblings --+ Ws_group + Ws_tabstop
		end

	default_ex_style: INTEGER is
		do
			Result := Ws_ex_controlparent
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
		local
			top: INTEGER
		do
			paint_dc.select_font (private_font)
			paint_dc.set_text_color (foreground_color_imp)
			paint_dc.set_background_color (background_color_imp)
			paint_dc.text_out (10, 0, text)
			if text.empty then
				top := 0
			else
				top := private_font.log_font.height // 2
			end
			paint_dc.select_pen (shadow_pen)
			paint_dc.line (0, top, 0, height - 1)
			paint_dc.line (0, height - 2, width - 2, height - 2)
			paint_dc.line (width - 2, height - 2, width - 2, top)
			if text.empty then
				paint_dc.line (0, top, width - 2, top)
			else
				paint_dc.line (0, top, 7, top)
				paint_dc.line (width - 2, top, paint_dc.string_size (text).width + 13 , top)
			end

			paint_dc.select_pen (highlight_pen)
			paint_dc.line (1, top + 1, 1, height - 2)
			paint_dc.line (0,  height - 1, width - 1, height - 1)
			paint_dc.line (width - 1, height - 1, width - 1, top)
			if text.empty then
				paint_dc.line (1, 1, width - 3, 1)
			else
				paint_dc.line (1, top + 1, 7, top +1)
				paint_dc.line (width - 3, top + 1, paint_dc.string_size (text).width + 13, top + 1)
			end
		end

	private_font: WEL_FONT

	box_width: INTEGER is 4

	box_height: INTEGER is 4

	box_text_height: INTEGER is
		do
			if text.empty then
				Result := 0
			else
				Result := private_font.log_font.height
			end
		end

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
