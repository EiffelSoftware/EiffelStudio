indexing
	description: "This class represents a MS_WINDOWS Ownerdraw button";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	OWNER_DRAW_BUTTON_WINDOWS

inherit
	BUTTON_IMP
		redefine
			realize,
			realized,
			unrealize
		end

	WEL_OWNER_DRAW_BUTTON
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
			item as wel_item,
			font as wel_font,
			set_font as wel_set_font,
			foreground_color as wel_foreground_color,
			background_color as wel_background_color
		undefine
			on_hide, on_show, on_size, on_move,
			on_right_button_up, on_left_button_down,
			on_bn_clicked, on_left_button_up,
			on_right_button_down, on_mouse_move,
			on_destroy, on_set_cursor, on_key_up,
			on_key_down, background_brush
		redefine
			wel_foreground_color,
			wel_background_color
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

	WEL_PS_CONSTANTS
		export
			{NONE} all
		end

	WEL_ODS_CONSTANTS
		export
			{NONE} all
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

feature -- Status report

	realized: BOOLEAN
			-- Is the button realized?

feature -- Status setting

	realize is
			-- Realize current widget.
		local
			wc: WEL_COMPOSITE_WINDOW
			mp: MENU_PULL_IMP
			op: OPT_PULL_IMP
		do
			if not realized then
				realized := true
				if is_parent_menu_pull then
					mp ?= parent
					if mp.realized then
						mp.add_a_child (Current)
					end
				elseif is_parent_option_pull then
					op ?= parent
					if op.realized then
						op.add_a_child (Current)
					end
				else
					if not exists then
						if width = 0 then set_width (20) end
						if height = 0 then set_height (20) end
						resize_for_shell
						wc ?= parent
						wel_make (wc, "", x, y, width, height, id_default)
					end
				end
				shown := true
			end
		end

feature -- Basic operations

	draw_all_selected (a_dc: WEL_DC) is
			-- Draw current button when selected.
			-- With the borders.
		require
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			draw_selected (a_dc)
			draw_selected_border (a_dc)
		end

	draw_all_unselected (a_dc: WEL_DC) is
			-- Draw current button when unselected.
			-- With the borders.
		require
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			draw_unselected (a_dc)
			draw_border (a_dc)
		end

	draw_unselected (a_dc: WEL_DC) is
			-- Draw current button when unselected.
		require
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		deferred
		end

	draw_selected (a_dc: WEL_DC) is
			-- Draw current button when selected.
		require
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		deferred
		end

	draw_selected_border (a_dc: WEL_DC) is
			-- Draw selected borders on `a_dc'.
		require
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		local
			pen: WEL_PEN
			color: WEL_COLOR_REF
		do
			!! color.make_rgb (255, 255, 255)
			!! pen.make (Ps_solid, 1, color)
			a_dc.select_pen (pen)
			a_dc.line (width - 1, 0, width - 1, height)
			a_dc.line (0, height - 1, width, height - 1)
			!! color.make_rgb (0, 0, 0)
			!! pen.make (Ps_solid, 1, color)
			a_dc.select_pen (pen)
			a_dc.line (0, 0, width - 1, 0)
			a_dc.line (0, 0, 0, height - 1)
			!! color.make_system (Color_btnshadow)
			!! pen.make (Ps_solid, 1, color)
			a_dc.select_pen (pen)
			a_dc.line (1, 1, 1 , height - 2)
			a_dc.line (1, 1, width - 2, 1)
		end

	draw_border (a_dc: WEL_DC) is
			-- Draw borders on `a_dc'.
		require
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		local
			pen: WEL_PEN
			color: WEL_COLOR_REF
		do
			!! color.make_rgb (255, 255, 255)
			!! pen.make (Ps_solid, 1, color)
			a_dc.select_pen (pen)
			a_dc.line (0, 0, width, 0)
			a_dc.line (0, 0, 0, height)
			!! color.make_system (Color_btnshadow)
			!! pen.make (Ps_solid, 1, color)
			a_dc.select_pen (pen)
			a_dc.line (1, height - 2, width - 1 , height - 2)
			a_dc.line (width - 2, 1, width - 2 , height - 1)
			!! color.make_rgb (0, 0, 0)
			!! pen.make (Ps_solid, 1, color)
			a_dc.select_pen (pen)
			a_dc.line (width - 1, 0, width - 1, height)
			a_dc.line (0, height - 1, width, height - 1)
		end

	on_draw (a_draw_item_struct: WEL_DRAW_ITEM_STRUCT) is
			-- Respond to a draw_item message.
		require
			a_draw_item_struct_not_void: a_draw_item_struct /= Void
			a_draw_item_struct_exists: a_draw_item_struct.exists
		local
			dc: WEL_DC
			brush: WEL_BRUSH
		do
			dc := a_draw_item_struct.dc
			!! brush.make_solid (wel_background_color)
			dc.select_brush (brush)
			dc.rectangle (0, 0, width, height)
			dc.unselect_brush
			if flag_set (a_draw_item_struct.item_state, Ods_selected) then
				draw_all_selected (dc)	
			else
				draw_all_unselected (dc)	
			end
		end

feature -- Removal

	unrealize is
			-- Destroy current primitive.
		do
			if exists then
				wel_destroy
			end
			realized := False
		end

feature {NONE} -- Implementation

	wel_foreground_color: WEL_COLOR_REF is
			-- Foreground color
		do
			if private_foreground_color /= Void then
				Result ?= private_foreground_color.implementation
				check
					result_not_void: Result /= Void
				end
			else
				!! Result.make_system (color_btntext)
			end
		end

	wel_background_color: WEL_COLOR_REF is
			-- Background color
		do
			if private_background_color /= Void then
				Result ?= private_background_color.implementation
				check
					result_not_void: Result /= Void
				end
			else
				!! Result.make_system (color_btnface)
			end
		end

	on_bn_clicked is
			-- Button is clicked, execute activate action.
		do
			activate_actions.execute (Current, Void)
		end

end -- class OWNER_DRAW_BUTTON_WINDOWS

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

