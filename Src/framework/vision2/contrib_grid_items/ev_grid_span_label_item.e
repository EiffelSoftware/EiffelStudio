indexing
	description: "Objects that represents a span grid label."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_SPAN_LABEL_ITEM

inherit
	EV_GRID_DRAWABLE_ITEM
		redefine
			required_width
		end

create
	make_span, make_master

feature {NONE} -- Initialization

	make_master (a_master_col: INTEGER) is
			-- Make as `master' cell which hold the text data
		do
			is_master := True
			make_span (a_master_col)
		end

	make_span (a_master_col: INTEGER) is
			-- Make as `slave' cell which "span" the master's cell's text data	
		do
			default_create
			expose_actions.extend (agent redraw_span (?))
			span_master_column := a_master_col
		end

feature -- Access

	text: STRING_32
			-- Item's spanned text

	font: EV_FONT
			-- Text's font.

	pixmap: EV_PIXMAP
			-- Master pixmap.

	required_width: INTEGER is
			-- Require width when resize_to_content occurs.
		do
			Result := Precursor
			if is_master and pixmap /= Void then
				Result := Result + pixmap.width + extra_space_after_pixmap
			end
		end

feature -- Properties

	is_master: BOOLEAN
			-- Is Current the master's spawn item ?

	span_master_column: INTEGER
			-- Master item's column index

	extra_space_after_pixmap: INTEGER is 5
			-- Space between pixmap and text.

feature -- change

	set_text (v: STRING_GENERAL) is
			-- Set text
			--  available only for the master cell
		require
			is_master: is_master
		do
			if is_master then
				text := v
			end
		end

	set_font (v: like font) is
			-- Set font
			--  available only for the master cell	
		require
			is_master: is_master
		do
			if is_master then
				font := v
			end
		end

	set_pixmap (v: like pixmap) is
			-- Set pixmap
			--  available only for the master cell	
		require
			is_master: is_master
		do
			if is_master then
				pixmap := v
				if parent /= Void then
					parent.implementation.redraw_item (implementation)
				end
			end
		end

	remove_pixmap is
			-- Remove pixmap
			--  available only for the master cell	
		require
			is_master: is_master
		do
			if is_master then
				pixmap := Void
				if parent /= Void then
					parent.implementation.redraw_item (implementation)
				end
			end
		end

feature {NONE} -- Implementation

	master_item: like Current is
			-- Master cell's item
		require
			row /= Void
		do
			Result ?= row.item (span_master_column)
		ensure
			Result /= Void
		end

	redraw_span (a_drawable: EV_DRAWABLE) is
			-- Redraw span cell
		local
			l_text: like text
			g: EV_GRID
			c: INTEGER
			prev_width: INTEGER
			w: INTEGER
			m: like master_item
			bg,fg: EV_COLOR
		do
			g := parent
			bg := background_color
			if bg = Void then
				bg := row.background_color
				if bg = Void then
					bg := g.background_color
				end
			end
			fg := foreground_color
			if fg = Void then
				fg := row.foreground_color
				if fg = Void then
					fg := g.foreground_color
				end
			end

			a_drawable.set_foreground_color (bg)
			a_drawable.fill_rectangle (0, 0, a_drawable.width, a_drawable.height)
			if not g.pre_draw_overlay_actions.is_empty then
				g.pre_draw_overlay_actions.call ([a_drawable, Current, column.index, row.index])
				a_drawable.set_foreground_color (bg)
				a_drawable.fill_rectangle (0, 0, a_drawable.width, a_drawable.height - 1)
			end

			w := 0
			if is_master then
				l_text := text
				if pixmap /= Void then
					a_drawable.draw_pixmap (3 + w, 2, pixmap)
					w := w + pixmap.width + extra_space_after_pixmap
				end
			else
				m := master_item
				l_text := m.text
			end

			if l_text /= Void then
				a_drawable.set_foreground_color (fg)

				if is_master then
					if font /= Void then
						a_drawable.set_font (font)
					end
				else
					if m.font /= Void then
						a_drawable.set_font (m.font)
					end
					check
						column.index > span_master_column
					end
					from
						c := column.index - 1
					until
						c < span_master_column
					loop
						check
							never_count_current_column: c /= column.index
							spawned_item: row.item(c).conforms_to (Current)
						end
						prev_width := prev_width + row.item (c).width
						c := c - 1
					end

					if m.pixmap /= Void then
						prev_width := prev_width - m.pixmap.width - extra_space_after_pixmap
					end
					w := w - prev_width
				end
				a_drawable.draw_text_top_left (3 + w, 2, l_text)
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
