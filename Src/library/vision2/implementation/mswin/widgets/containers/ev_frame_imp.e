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
			default_style,
			default_ex_style,
			on_paint,
			background_brush
		end

	WEL_PS_CONSTANTS
		export
			{NONE} all
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
				move_and_resize ((child_cell.width - width)//2 + child_cell.x, child_cell.y, minimum_width, child_cell.height, True)
			elseif resize_type = 1 then
				move_and_resize (child_cell.x, (child_cell.height - height)//2 + child_cell.y, child_cell.width, minimum_height, True)
			else
				move_and_resize ((child_cell.width - width)//2 + child_cell.x, (child_cell.height - height)//2 + child_cell.y, minimum_width, minimum_height, True)
			end
			if child /= Void then
				child.set_move_and_size (box_width, box_text_height + box_height, 
										client_width, client_height)
			end
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

	default_style: INTEGER is
		do
			Result := {WEL_CONTROL_WINDOW} Precursor + Ws_clipchildren
					+ Ws_clipsiblings
		end

	default_ex_style: INTEGER is
		do
			Result := Ws_ex_controlparent
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

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
		local
			top: INTEGER
		do
			paint_dc.select_font (private_font)
			paint_dc.set_background_color (background_color)
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

	shadow_pen: WEL_PEN is
			-- Pen with the shadow color
		local
			color: WEL_COLOR_REF
		once
			!! color.make_system (Color_btnshadow)
			!! Result.make (ps_solid, 1, color)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	highlight_pen: WEL_PEN is
			-- Pen with the highlight color
		local
			color: WEL_COLOR_REF
		once
			!! color.make_system (Color_btnhighlight)
			!! Result.make (ps_solid, 1, color)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
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
