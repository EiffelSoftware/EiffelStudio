indexing
	description:
		"EiffelVision option button, implementation interface";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_OPTION_BUTTON_IMP

inherit
	EV_OPTION_BUTTON_I

	EV_MENU_CONTAINER_IMP
		undefine
			on_draw,
			add_menu,
			on_selection_changed
		end

	EV_BUTTON_IMP
		redefine
			make,
			on_bn_clicked,
			draw_body,
			draw_edge,
			draw_focus
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the option button with `par' as parent.
		do
			{EV_BUTTON_IMP} Precursor (par)
			ev_children := parent_imp.menu_items
			!! menu_container.make_track
		end


feature -- Event association

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'
		do
			set_text (sitem.text)
			pixmap_imp := sitem.pixmap_imp
		end

feature {NONE} -- Basic operation

	draw_edge (dc: WEL_DC) is
			-- Draw the edge of the button.
		do
			routine_draw_edge (dc, client_rect, Edge_raised, Bf_rect + Bf_soft)
		end

	draw_focus (dc: WEL_DC) is
			-- Draw the focus line around the button.
		local
			rect: WEL_RECT
		do
			!! rect.make (3, 3, width - 3, height - 3)
			draw_focus_rect (dc, rect)
		end

	draw_body (dc: WEL_DC) is
			-- Draw the body of the button : bitmap + text
		local
			tx, ty: INTEGER
			inrect: WEL_RECT
		do
			!! inrect.make (5, 5, width - 5, height - 6)

			-- If sensitive, we draw everything normaly.
			if not insensitive then
				-- We draw a little rectangle
				!! inrect.make (width - 25, height // 2 - 5, width - 10, height // 2 + 5)
				routine_draw_edge (dc, inrect, Edge_raised, Bf_rect + Bf_soft)
				-- We draw the rest of the button
				inrect.set_rect (5, 5, width - 30, height - 6)
				if pixmap_imp /= Void and text /= "" then
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp, 0, 0, Srccopy)
					inrect.set_left (pixmap_imp.width + 5)
					dc.draw_text (text, inrect, Dt_singleline + Dt_left + Dt_vcenter)
				elseif pixmap_imp /= Void then
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp, 0, 0, Srccopy)
				elseif text /= "" then
					dc.draw_text (text, inrect, Dt_singleline + Dt_left + Dt_vcenter)
				end

			-- If insensitive, the text is gray.
			-- We don't set the pixmap gray, because the quality is bad.
			else
				-- We draw a little rectangle
				!! inrect.make (width - 25, height // 2 - 5, width - 10, height // 2 + 5)
				routine_draw_edge (dc, inrect, Edge_raised, Bf_rect + Bf_soft)
				-- We draw the rest
				if pixmap_imp /= Void and text /= "" then
					!! inrect.make (5, 5, width - 30, height - 6)
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp, 0, 0, Srccopy)
					inrect.set_left (pixmap_imp.width + 5)
					tx := inrect.left 
					ty := inrect.top + ((inrect.height - dc.string_height (text)) // 2) 
					draw_insensitive_text (dc, text, tx, ty)
				elseif pixmap_imp /= Void then
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp, 0, 0, Srccopy)
				elseif text /= "" then
					tx := inrect.left
					ty := inrect.top + ((inrect.height - dc.string_height (text)) // 2)
					draw_insensitive_text (dc, text, tx, ty)
				end
			end
		end	

feature {NONE} -- Implementation

	menu_container: WEL_MENU
			-- Actual WEL container for the menu

	add_menu (menu: EV_MENU) is
			-- Add `a_menu' into container.
		do
			{EV_MENU_CONTAINER_IMP} Precursor (menu)
			set_text (menu.text)
		end 

feature {NONE} -- WEL implementation

	on_bn_clicked is
			-- When the button is pressed
		local
			composite: WEL_COMPOSITE_WINDOW
		do
			composite ?= parent
			menu_container.show_track (absolute_x, absolute_y + height // 2 - 10, composite)
			execute_command (Cmd_click, Void)
		end

end -- class EV_OPTION_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision : library of reusable components for ISE Eiffel.
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
--|---------------------------------------------------------------
