indexing
	description: "A picture color button without border."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

create
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
			Precursor {PICT_COLOR_B_IMP}
			if active then
				mouse_in := True
				if exists then
					invalidate
				end
			end
		end

	on_mouse_leave is
		do
			Precursor {PICT_COLOR_B_IMP}
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
				Precursor {PICT_COLOR_B_IMP} (a_dc)
			end
		end

	draw_unselected_no_border (a_dc: WEL_DC) is
			-- Draw the button without any border.
		local
			pen: WEL_PEN;
			color: WEL_COLOR_REF
		do
			create color.make_system (Color_btnface);
			create pen.make (ps_solid, 1, color);
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
			create color.make_system (color_btnhighlight)
			create pen.make (ps_solid, 1, color);
			a_dc.select_pen (pen);
			a_dc.line (0, 0, width - 1, 0);
			a_dc.line (0, 0, 0, height - 1);
			a_dc.unselect_pen
			pen.delete

			create color.make_system (color_btnshadow)
			create pen.make (ps_solid, 1, color);
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
				Precursor {PICT_COLOR_B_IMP} (a_dc)
			else
				create color.make_system (color_btnshadow)
				create pen.make (ps_solid, 1, color)
				a_dc.select_pen (pen)
				a_dc.line (0, 0, width, 0);
				a_dc.line (0, 0, 0, height);
				a_dc.unselect_pen
				pen.delete

				create color.make_system (color_btnhighlight)
				create pen.make (ps_solid, 1, color);
				a_dc.select_pen (pen);
				a_dc.line (width - 1, 1, width - 1, height);
				a_dc.line (1, height - 1, width, height - 1)
				a_dc.unselect_pen
				pen.delete
			end
		end

feature {NONE} -- Attributes

	mouse_in: BOOLEAN;
			-- Is the cursor inside the button?

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ACTIVE_PICT_COLOR_B_IMP
