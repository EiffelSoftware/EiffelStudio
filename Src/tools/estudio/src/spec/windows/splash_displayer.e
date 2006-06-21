indexing
	description: "Splash displayer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SPLASH_DISPLAYER

create
	make_with_text

feature

	make_with_text (s: STRING_GENERAL) is
		do
			text := s
		end

	show is
		local
			sc: WEL_SCREEN_DC
			ico: WEL_ICON
			bitmap: WEL_BITMAP
			rect: WEL_RECT
			x,y,w,h: INTEGER
			c: WEL_COLOR_REF
			f: WEL_FONT
			wlf: WEL_LOG_FONT
		do
			create bitmap.make_by_id (1024)
			if bitmap.exists then
				create sc
				sc.get
				x := (sc.width - bitmap.width) // 2
				y := (sc.height - bitmap.height) // 2
				w := bitmap.width
				h := bitmap.height
				sc.draw_bitmap (bitmap,x, y ,w, h)
				sc.set_background_transparent

				if text /= Void then
					f := (create {WEL_SHARED_FONTS}).Gui_font

					create wlf.make_by_font (f)
					wlf.set_weight (600)
					wlf.set_height (12)
					wlf.set_stroke_output_precision
					wlf.set_stroke_clipping_precision
					wlf.set_proof_quality
					wlf.set_decorative_family
					f.set_indirect (wlf)
					sc.select_font (f)

					debug ("launcher")
						if debug_text /= Void then
							wlf.set_height (20)
							wlf.set_weight (600)
							f.set_indirect (wlf)
							sc.select_font (f)

							create rect.make (x + 1, y + 1, x + w - 2, y + f.height + 2)
							create c.make_rgb (255, 0, 0)
							sc.set_text_color (c)
							sc.draw_text (debug_text, rect, {WEL_DT_CONSTANTS}.Dt_center)

							wlf.set_height (12)
							f.set_indirect (wlf)
							sc.select_font (f)
						end
					end

					create rect.make (x + 3, y + h - f.height - 4, x + w - 6, y + h - 2)
					create c.make_rgb (255, 255, 255)
					sc.set_text_color (c)

					sc.draw_text (text, rect, {WEL_DT_CONSTANTS}.Dt_right)
				end
			end
		end

feature {NONE} -- Properties

	text: STRING_GENERAL

	debug_text: STRING_GENERAL;

feature -- debug

	set_debug_text (s: STRING_GENERAL) is
		do
			debug_text := s
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
