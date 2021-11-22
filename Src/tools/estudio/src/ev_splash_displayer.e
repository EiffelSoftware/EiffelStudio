note
	description: "Splash displayer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SPLASH_DISPLAYER

inherit
	SPLASH_DISPLAYER_I
		undefine
			default_create, copy
		redefine
			make_with_text,
			set_verbose_text
		end

	EV_SHARED_APPLICATION
		undefine
			default_create, copy
		end

	EV_POPUP_WINDOW
		export
			{ANY} is_initialized
		redefine
			initialize,
			show
		end

create
	make_with_text

feature -- Access

	make_with_text (s: STRING_GENERAL)
		do
			Precursor {SPLASH_DISPLAYER_I} (s)
			default_create
		end

	initialize
		do
			Precursor
			create main_box
			extend (main_box)
			create pixmap_box
			main_box.extend (pixmap_box)
		end

	splash_pixmap: EV_PIXMAP
			-- background splash pixmaps.
		local
			pw, ph,
			x,y,w: INTEGER
			f: EV_FONT
			l_u: FILE_UTILITIES
		do
			if attached splash_pixmap_filename as l_fn and then l_u.file_path_exists (l_fn) then
				create Result
				Result.set_with_named_path (l_fn)
				print_year (Result, eiffel_layout.copyright_year)
			else
				create f.default_create
				f.set_weight ({EV_FONT_CONSTANTS}.weight_black)
				f.set_family ({EV_FONT_CONSTANTS}.family_roman)
				f.set_height_in_points (38)

				w := f.string_width ("Eiffel Studio")

				pw := (w + 60).max (350)
				ph := 180

				create Result.make_with_size (pw, ph)
				Result.set_background_color ((create {EV_COLOR}.make_with_8_bit_rgb (220,240,250)))
				Result.clear
				Result.set_foreground_color ((create {EV_COLOR}.make_with_8_bit_rgb (74,148,222)))
				Result.fill_rectangle (0, ph - 22, pw, 22)

				Result.set_font (f)
				y := (ph - f.height - 22) // 2
				x := (pw - w) // 2
				Result.set_foreground_color (Stock_colors.black)
				Result.draw_text_top_left (x, y, "Eiffel")
				Result.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (65,130,200))
				Result.draw_text_top_left (x + f.string_width ("Eiffel"), y, " Studio")

				Result.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (115, 173, 231))
				Result.draw_rectangle (0, ph - 22, pw, 22)
				Result.draw_rectangle (0, 0, pw, ph)
			end
		end

	splash_pixmap_with_text: EV_PIXMAP
			-- Splash pixmap with text.
		local
			pw, ph: INTEGER
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
				Result.set_foreground_color (Stock_colors.white)
				Result.draw_text_top_left (pw - f.string_width (text) - 3, ph - f.height - 4, text)

				debug ("launcher")
					if verbose_text /= Void then
						f.set_height_in_points (16)
						f.set_height_in_points (pw // verbose_text.count )
						f.set_weight ({EV_FONT_CONSTANTS}.weight_bold)

						size := f.string_size (verbose_text)
						Result.set_font (f)
						Result.set_foreground_color (Stock_colors.red)
						Result.draw_text_top_left ((pw - size.w) // 2, ph - 25 - size.h , verbose_text)
					end
				end
			end
		end

	show
			-- Display the splash box
		local
			pix: EV_PIXMAP
		do
			pix := splash_pixmap_with_text
			if pix /= Void then
				pix.set_minimum_size (pix.width , pix.height)
				pixmap_box.extend (pix)
				pixmap_box.disable_item_expand (pix)
				pixmap_box.extend (create {EV_CELL})

				set_size (pix.width, pix.height)
				center_splash
				Precursor
			end
		end

	print_year (a_pixmap: EV_PIXMAP; a_year: STRING)
			-- Print `a_year' onto `a_pixmap'
		require
			not_void: a_pixmap /= Void
			not_void: a_year /= Void and then not a_year.is_empty
		local
			l_font: EV_FONT
			l_font_contants: EV_FONT_CONSTANTS
		do
			create l_font_contants
			create l_font.make_with_values (l_font_contants.family_roman, l_font_contants.weight_regular, l_font_contants.shape_regular, 9)
			a_pixmap.set_font (l_font)
			a_pixmap.draw_text (61, 203, a_year)
		end

	center_splash
		local
			sc: EV_SCREEN
			x,y,w,h: INTEGER
		do
			create sc

				--| Display pixmaps
			x := (sc.width - width) // 2
			y := (sc.height - height) // 2
			w := width
			h := height

			set_position (x, y)
		end

	close
		do
			destroy
		end

	exit
		do
			close
			ev_application.destroy
		end

feature -- Change

	set_verbose_text (s: STRING_GENERAL)
		local
			l_size: TUPLE [w: INTEGER; h: INTEGER; lo: INTEGER_32; ro: INTEGER_32]
		do
			Precursor (s)
			build_verbose_panel
			l_size := verbose_panel.font.string_size (verbose_text)
			verbose_panel.set_minimum_size (l_size.w, l_size.h)
			verbose_panel.set_text (verbose_text)
			verbose_panel.refresh_now
--			center_splash
		end

	build_verbose_panel
		local
			b: EV_VERTICAL_BOX
			h: EV_HORIZONTAL_BOX
			l: EV_LABEL
			c: EV_COLOR
		do
			if verbose_panel = Void then
				create verbose_panel

				create b
				create c.make_with_8_bit_rgb (0,0,90)

				main_box.set_background_color (c)
				b.set_background_color (c)
				b.set_foreground_color (Stock_colors.white)
				b.set_border_width (10)
				b.extend (verbose_panel)
				create l.make_with_text ("Double click here to close ...")
				l.align_text_right
				l.pointer_double_press_actions.force_extend (agent exit)
				create h
				h.extend (create {EV_CELL})
				h.extend (l)
				h.disable_item_expand (l)
				b.extend (h)
				main_box.propagate_background_color
				b.propagate_background_color
				b.propagate_foreground_color
				main_box.extend (b)
				verbose_panel.show
				verbose_panel.align_text_left
			end
		end

feature {NONE} -- Properties

	Stock_colors: EV_STOCK_COLORS
		once
			create Result
		end

	main_box: EV_VERTICAL_BOX

	pixmap_box: EV_HORIZONTAL_BOX

	verbose_panel: EV_LABEL;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
