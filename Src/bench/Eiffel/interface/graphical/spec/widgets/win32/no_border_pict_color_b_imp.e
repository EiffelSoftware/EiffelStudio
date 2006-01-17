indexing
	description: "A picture color button without border."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	NO_BORDER_PICT_COLOR_B_IMP

inherit
	PICT_COLOR_B_IMP
		redefine
			draw_all_selected,
			draw_all_unselected,
			set_default_size,
			set_pixmap,
			set_background_pixmap
		end

create
	make

feature

	set_pixmap, set_background_pixmap (a_pixmap: PIXMAP) is
			-- Set the pixmap for the button
		do
			pixmap := a_pixmap
			set_default_size
			if exists then
				invalidate
			end
		end

	set_default_size is
			-- Set default of button
		do
			if pixmap /= Void then
				set_form_width (pixmap.width)
				set_form_height (pixmap.height)
				set_width (pixmap.width)
				set_height (pixmap.height)
			end
		end

	draw_all_selected (a_dc: WEL_DC) is
			-- Draw current button when selected.
			-- With the borders.
		require else
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			draw_pixmap (a_dc)
		end

	draw_all_unselected (a_dc: WEL_DC) is
			-- Draw current button when unselected.
			-- With the borders.
		require else
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			draw_pixmap (a_dc)
		end

	draw_pixmap (a_dc: WEL_DC) is
		local
			bitmap: WEL_BITMAP
			pixmap_w: PIXMAP_IMP
			dib: WEL_DIB
		do
			if pixmap /= Void then
				pixmap_w ?= pixmap.implementation
				dib := pixmap_w.dib
				check
					dib_exists: dib /= Void
				end
				create bitmap.make_by_dib (a_dc, dib, dib_rgb_colors)
				a_dc.draw_bitmap (bitmap, 0, 0, pixmap.width, pixmap.height)
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class NO_BORDER_PICT_COLOR_B_IMP
