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
			draw_selected_border,
			on_mouse_enter,
			on_mouse_leave,
			total_offset
		end

creation
	make

feature -- Access

	active: BOOLEAN
			-- Is the button an active one (ACTIVE_PICT_COLOR_B) or
			-- is it not (PICT_COLOR_B)

feature -- Update

	set_active (flag: BOOLEAN) is
			-- Set `active' to `flag'.
			--| True means that the button will react to the mouse_enter
			--| and mouse_leave events. False means it will behave like
			--| a PICT_COLOR_B.
		do
			active := flag
		end

feature {NONE}

	on_mouse_enter is
		do
			{PICT_COLOR_B_IMP} Precursor
			if active then
				mouse_in := True
				if exists then
					invalidate
				end
			end
		end

	on_mouse_leave is
		do
			{PICT_COLOR_B_IMP} Precursor
			if active then
				mouse_in := False
				if exists then
					invalidate
				end
			end
		end

	total_offset: INTEGER is 4

feature {NONE}

	draw_all_unselected (a_dc: WEL_DC) is
			-- Draw current button when unselected.
			-- With the borders.
		require else
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			if active then
				draw_unselected (a_dc)
				if mouse_in then
					draw_unselected_border (a_dc)
				else
					draw_unselected_no_border (a_dc)
				end
			else
				{PICT_COLOR_B_IMP} Precursor (a_dc)
			end
		end

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
			a_dc.unselect_pen
			pen.delete
		end

	draw_unselected_border (a_dc: WEL_DC) is
			-- Draw the button with borders and unselected.
		local
			pen: WEL_PEN
			color: WEL_COLOR_REF
		do
			!! color.make_system (color_btnhighlight)
			!! pen.make (ps_solid, 1, color);
			a_dc.select_pen (pen);
			a_dc.line (0, 0, width - 1, 0);
			a_dc.line (0, 0, 0, height - 1);
			a_dc.unselect_pen
			pen.delete

			!! color.make_system (color_btnshadow)
			!! pen.make (ps_solid, 1, color);
			a_dc.select_pen (pen);
			a_dc.line (width - 1, 0, width - 1, height);
			a_dc.line (0, height - 1, width, height - 1)
			a_dc.unselect_pen
			pen.delete
		end

	draw_selected_border (a_dc: WEL_DC) is
			-- Draw the button with borders and selected
		local
			pen: WEL_PEN
			color: WEL_COLOR_REF
		do
			if not active then
				{PICT_COLOR_B_IMP} Precursor (a_dc)
			else
				!! color.make_system (color_btnshadow)
				!! pen.make (ps_solid, 1, color)
				a_dc.select_pen (pen)
				a_dc.line (0, 0, width, 0);
				a_dc.line (0, 0, 0, height);
				a_dc.unselect_pen
				pen.delete

				!! color.make_system (color_btnhighlight)
				!! pen.make (ps_solid, 1, color);
				a_dc.select_pen (pen);
				a_dc.line (width - 1, 1, width - 1, height);
				a_dc.line (1, height - 1, width, height - 1)
				a_dc.unselect_pen
				pen.delete
			end
		end

feature {NONE} -- Attributes

	mouse_in: BOOLEAN
			-- Is the cursor inside the button?

end -- class ACTIVE_PICT_COLOR_B_IMP
