indexing
	description: "A picture color button without border.";
	date: "$Date$";
	revision: "$Revision$"

class
	ACTIVE_PICT_COLOR_B_IMP

inherit
	PICT_COLOR_B_IMP
		redefine
			draw_all_unselected,
			on_mouse_enter,
			on_mouse_leave
		end

creation
	make

feature

	draw_all_unselected (a_dc: WEL_DC) is
			-- Draw current button when unselected.
			-- With the borders.
		require else
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			draw_unselected (a_dc)
			if mouse_in then
				draw_unselected_border (a_dc)
			else
				draw_unselected_no_border (a_dc)
			end
		end

feature {NONE}

	on_mouse_enter is
		do
			{PICT_COLOR_B_IMP} Precursor
			mouse_in := True
			invalidate
		end

	on_mouse_leave is
		do
			{PICT_COLOR_B_IMP} Precursor
			mouse_in := False
			invalidate
		end

feature {NONE}

	draw_unselected_no_border (a_dc: WEL_DC) is
			-- Draw the button without any border.
		local
			pen: WEL_PEN;
			color: WEL_COLOR_REF
		do
			!! color.make_system (Color_btnface);
			!! pen.make (ps_solid, 1, color);
			a_dc.select_pen (pen);
			a_dc.line (width - 1, 0, width - 1, height);
			a_dc.line (0, height - 1, width, height - 1);
			a_dc.line (0, 0, width - 1, 0);
			a_dc.line (0, 0, 0, height - 1);
			a_dc.line (1, 1, 1, height - 2);
			a_dc.line (1, 1, width - 2, 1)
		end

	draw_unselected_border (a_dc: WEL_DC) is
			-- Draw the button with borders and unselected.
		local
			pen: WEL_PEN
			color: WEL_COLOR_REF
		do
			!! color.make_rgb (255, 255, 255);
			!! pen.make (ps_solid, 1, color);
			a_dc.select_pen (pen);
			a_dc.line (0, 0, width, 0);
			a_dc.line (0, 0, 0, height);
			!! color.make_system (color_btnshadow);
			!! pen.make (ps_solid, 1, color);
			a_dc.select_pen (pen);
			a_dc.line (1, height - 2, width - 1, height - 2);
			a_dc.line (width - 2, 1, width - 2, height - 1);
			!! color.make_rgb (0, 0, 0);
			!! pen.make (ps_solid, 1, color);
			a_dc.select_pen (pen);
			a_dc.line (width - 1, 0, width - 1, height);
			a_dc.line (0, height - 1, width, height - 1)
		end

feature {NONE} -- Attributes

	mouse_in: BOOLEAN
			-- Is the cursor inside the button?

end -- class ACTIVE_PICT_COLOR_B_IMP
