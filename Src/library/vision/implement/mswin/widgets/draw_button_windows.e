indexing
	description: "This class represents a MS_WINDOWS draw button"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	DRAW_BUTTON_WINDOWS

inherit
	DRAW_B_I
			
	OWNER_DRAW_BUTTON_WINDOWS

	DRAWABLE_DEVICE_WINDOWS

creation 
	make

feature -- Initialization

	make (a_draw_b: DRAW_B; man: BOOLEAN; oui_parent: COMPOSITE) is
		do
			!! private_attributes
			a_draw_b.set_font_imp (Current)
			parent ?= oui_parent.implementation;
			set_line_width (1);
			managed := man
			!! gc_fg_color.make_system (color_windowtext)
			line_style := ps_solid
		end

feature -- Status setting

	draw_selected (a_dc: WEL_DC) is
			-- Do actions
		do
			set_drawing_dc (a_dc)
			expose_actions.execute (Current, Void)
			unset_drawing_dc
		end

	draw_unselected (a_dc: WEL_DC) is
			-- Do actions
		do
			set_drawing_dc (a_dc)
			expose_actions.execute (Current, Void)
			unset_drawing_dc
		end

end -- class DRAW_BUTTON_WINDOWS

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
