indexing

	description: "This class represents a MS_WINDOWS separator";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	SEPARATOR_WINDOWS

inherit

	PRIMITIVE_WINDOWS
		redefine
			realize,
			realized,
			set_width, 
			set_height,
			set_x,
			set_y
		end

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			show as wel_show,
			hide as wel_hide,
			destroy as wel_destroy,
			x as wel_x,
			y as wel_y,
			width as wel_width,
			height as wel_height,
			set_x as wel_set_x,
			set_y as wel_set_y,
			set_width as wel_set_width,
			set_height as wel_set_height,
			shown as wel_shown,
			parent as wel_parent,
			text as wel_text,
			text_length as wel_text_length,
			set_text as wel_set_text,
			move as wel_move,
			set_focus as wel_set_focus,
			set_capture as wel_set_capture,
			release_capture as wel_release_capture,
			item as wel_item
		undefine
			on_right_button_up, on_left_button_down,
			on_left_button_up, on_right_button_down,
			on_mouse_move, on_destroy, on_set_cursor,
			on_key_up,
			on_key_down
		redefine
			on_paint,
			class_name
		end
		
	SEPARATOR_I

	WEL_PS_CONSTANTS

creation

	make

feature -- Initialization

	make (a_separator: SEPARATOR; man: BOOLEAN; oui_parent: COMPOSITE) is
		local
			local_menu: WEL_MENU
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			local_menu ?= parent
			if local_menu /= Void then
				in_menu:= True
			end
			managed := man
			set_horizontal (true)
			set_single_line
			set_size (1,1)
		end

feature -- Status report

	is_horizontal: BOOLEAN
			-- Is this separator horizontal?

	in_menu: BOOLEAN
			-- Is current separator in a menu?

	realized: BOOLEAN is
		do
			if not in_menu then
				Result := exists
			else
				result := parent.realized
			end
		end

	double: BOOLEAN
			-- Has current separator a double line?
		
feature -- Status setting

	set_width (a_width: INTEGER) is
		do
			if in_menu then
				debug ("WINDOWS")
					check
						inapplicable: False
					end
				end
			else
				if exists then
					wel_set_width (a_width)
				end
			end
			private_attributes.set_width (a_width)
		end

	set_height (a_height: INTEGER) is
		do
			if in_menu then
				debug ("WINDOWS")
					check
						inapplicable: False
					end
				end
			else
				if exists then
					wel_set_height (a_height)
				end
			end
			private_attributes.set_height (a_height)
		end

	set_x (a_x: INTEGER) is
		do
			if in_menu then
				debug ("WINDOWS")
					check
						inapplicable: False
					end
				end
			else
				if exists then
					wel_set_x (a_x)
				end
			end
			private_attributes.set_x (a_x)
		end

	set_y (a_y: INTEGER) is
		do
			if in_menu then
				debug ("WINDOWS")
					check
						inapplicable: False
					end
				end
			else
				if exists then
					wel_set_y (a_y)
				end
			end
			private_attributes.set_y (a_y)
		end

	realize is
			-- Display a separator.
		local
			local_menu: WEL_MENU
			wc:WEL_COMPOSITE_WINDOW
		do
			if not realized then
				if not in_menu then
					wc ?= parent
					make_with_coordinates (wc, "", x, y, width, height)
				else
					local_menu ?= parent
					check
						local_menu_exists: local_menu /= Void
					end
					local_menu.append_separator
				end
			end
		end

	set_double_dashed_line is
		do
			!! pen.make (Ps_dash, 1, black_color)
			double := True
			if realized then
				invalidate
			end
		ensure then
			is_horizontal implies (height >= 5)
			not is_horizontal implies (width >= 5)
		end

	set_double_line is
		do
			!! pen.make (Ps_solid, 1, black_color)
			double := True
			if realized then
				invalidate
			end
		ensure then
			is_horizontal implies (height >= 5)
			not is_horizontal implies (width >= 5)
		end

	set_horizontal (flag: BOOLEAN) is
			-- Set `is_horizontal' to `flag'
		local
			w: INTEGER
		do
			if is_horizontal /= flag then
				if exists then
					invalidate
				end
				is_horizontal := flag
			end
			if realized then
				invalidate
			end
		ensure then
			is_horizontal_equals_flag: is_horizontal = flag
		end		

	set_no_line is
		do
			!! pen.make (Ps_null, 1, black_color)
			if realized then
				invalidate
			end
		end

	set_single_dashed_line is
		do
			!! pen.make (Ps_dash, 1, black_color)
			double := False
			if realized then
				invalidate
			end
		end

	set_single_line is
		do
			!! pen.make (Ps_solid, 1, black_color)
			double := False
			if realized then
				invalidate
			end
		end

feature {NONE} -- Implementation

	on_paint (a_paint_dc: WEL_PAINT_DC; a_rect: WEL_RECT) is
		do
			a_paint_dc.select_pen (pen)
			a_paint_dc.set_bk_color (c_background)
			if is_horizontal then
				if double then
					a_paint_dc.line (0, height // 2 - 1, width, height // 2 - 1)
					a_paint_dc.line (0, height // 2 + 1, width, height // 2 + 1)
				else
					a_paint_dc.line (0, height // 2, width, height // 2)
				end
			else
				if double then
					a_paint_dc.line (width // 2 - 1, 0, width // 2 - 1, height)
					a_paint_dc.line (width // 2 + 1, 0, width // 2 + 1, height)
				else
					a_paint_dc.line (width // 2, 0, width // 2, height)
				end
			end
		end

	pen: WEL_PEN

	c_background: WEL_COLOR_REF is
		once
			!! Result.make_system (Color_window)
		end

	black_color: WEL_COLOR_REF is
		once
			!! Result.make_rgb (0, 0, 0)
		ensure
			result_exists: Result /= Void
		end

	class_name: STRING is
		do
			Result := "EVisionSeparator"
		end

	wel_font: WEL_FONT

	wel_set_font (f:WEL_FONT) is
		do
		end

end -- class SEPARATOR_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
