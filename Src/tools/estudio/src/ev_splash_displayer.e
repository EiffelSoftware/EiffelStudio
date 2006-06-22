indexing
	description: "Splash displayer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SPLASH_DISPLAYER

inherit
	SPLASH_DISPLAYER_I

create
	make_with_text

feature -- Access

	splash_pixmap: EV_PIXMAP is
			-- background splash pixmaps.
		local
			pw, ph,
			x,y,w,h: INTEGER
			c: EV_COLOR
			f: EV_FONT
		do
			if splash_pixmap_filename /= Void and then (create {RAW_FILE}.make (splash_pixmap_filename)).exists then
				create Result
				Result.set_with_named_file (splash_pixmap_filename)
			else
				pw := 350
				ph := 180
				create Result.make_with_size (pw, ph)
				Result.set_background_color ((create {EV_COLOR}.make_with_8_bit_rgb (220,240,250)))
				Result.clear
				Result.set_foreground_color ((create {EV_COLOR}.make_with_8_bit_rgb (74,148,222)))
				Result.fill_rectangle (0, ph - 22, pw, 22)

				create f.default_create
				f.set_weight ({EV_FONT_CONSTANTS}.weight_black)
				f.set_family ({EV_FONT_CONSTANTS}.family_roman)
				f.set_height_in_points (38)
				Result.set_font (f)
				y := (ph - f.height - 22) // 2
				x := (pw - f.string_width ("  Eiffel Studio")) // 3
				Result.set_foreground_color ((create {EV_STOCK_COLORS}).black)
				Result.draw_text_top_left (x, y, "  Eiffel")

				Result.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (65,130,200))
				Result.draw_text_top_left (x + f.string_width ("  Eiffel"), y, " Studio")

				Result.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (115, 173, 231))
				Result.draw_rectangle (0, ph - 22, pw, 22)
				Result.draw_rectangle (0, 0, pw, ph)
			end
		end

	splash_pixmap_with_text: EV_PIXMAP is
			-- Splash pixmap with text.
		local
			pw, ph: INTEGER
			c: EV_COLOR
			f: EV_FONT
			size: TUPLE [w: INTEGER; h: INTEGER; lo: INTEGER; ro: INTEGER]
		do
			Result := splash_pixmap
			if Result /= Void and then text /= Void then
				pw := Result.width
				ph := Result.height

				create f.default_create
				f.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
				f.set_height_in_points (9)
				Result.set_font (f)
				Result.set_foreground_color ((create {EV_STOCK_COLORS}).white)
				Result.draw_text_top_left (pw - f.string_width (text) - 3, ph - f.height - 4, text)

				debug ("launcher")
					if debug_text /= Void then
						f.set_height_in_points (16)
						f.set_height_in_points (pw // debug_text.count )
						f.set_weight ({EV_FONT_CONSTANTS}.weight_bold)

						size := f.string_size (debug_text)
						Result.set_font (f)
						Result.set_foreground_color ((create {EV_STOCK_COLORS}).red)
						Result.draw_text_top_left ((pw - size.w) // 2, ph - 25 - size.h , debug_text)
					end
				end
			end
		end

	show is
			-- Display the splash box
		local
			sc: EV_SCREEN
			pix: EV_PIXMAP
			x,y,w,h: INTEGER
		do
			pix := splash_pixmap_with_text
			if pix /= Void then
				create sc

					--| Display pixmaps
				x := (sc.width - pix.width) // 2
				y := (sc.height - pix.height) // 2
				w := pix.width
				h := pix.height

				sc.draw_pixmap (x,y, pix)
			end
		end

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

end
