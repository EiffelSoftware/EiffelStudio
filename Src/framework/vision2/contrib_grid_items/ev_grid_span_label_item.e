note
	description: "Objects that represents a span grid label."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
	make_span, make_master, make_master_with_text

feature {NONE} -- Initialization

	make_master (a_master_col: INTEGER)
			-- Make as `master' cell which holds the text data
		do
			is_master := True
			make_span (a_master_col)
		end

	make_master_with_text (a_master_col: INTEGER; a_text: STRING_32)
			-- Make as `master' cell which holds the `text' data
		do
			is_master := True
			set_text (a_text)
			make_span (a_master_col)
		end

	make_span (a_master_col: INTEGER)
			-- Make as `slave' cell which "span" the master's cell's text data	
		do
			default_create
			expose_actions.extend (agent redraw_span (?))
			span_master_column := a_master_col
		end

feature -- Access

	text: detachable STRING_32
			-- Item's spanned text

	font: detachable EV_FONT
			-- Text's font.

	pixmap: detachable EV_PIXMAP
			-- Master pixmap.

	required_width: INTEGER
			-- Require width when resize_to_content occurs.
		do
			Result := Precursor
			if is_master and attached pixmap as pix then
				Result := Result + pix.width + extra_space_after_pixmap
			end
		end

feature -- Properties

	is_master: BOOLEAN
			-- Is Current the master's spawn item ?

	span_master_column: INTEGER
			-- Master item's column index

	extra_space_after_pixmap: INTEGER = 5
			-- Space between pixmap and text.

feature -- change

	set_text (v: STRING_GENERAL)
			-- Set text
			--  available only for the master cell
		require
			is_master: is_master
		do
			if is_master then
				text := v
			end
		end

	set_font (v: like font)
			-- Set font
			--  available only for the master cell	
		require
			is_master: is_master
		do
			if is_master then
				font := v
			end
		end

	set_pixmap (v: like pixmap)
			-- Set pixmap
			--  available only for the master cell	
		require
			is_master: is_master
		do
			if is_master then
				pixmap := v
				if attached parent as p then
					p.implementation.redraw_item (implementation)
				end
			end
		end

	remove_pixmap
			-- Remove pixmap
			--  available only for the master cell	
		require
			is_master: is_master
		do
			if is_master then
				pixmap := Void
				if attached parent as p then
					p.implementation.redraw_item (implementation)
				end
			end
		end

feature {NONE} -- Implementation

	master_item: detachable like Current
			-- Master cell's item
		require
			row /= Void
		do
			if is_master then
				Result := Current
			elseif attached row as l_row then
				Result := {like Current} / l_row.item (span_master_column)
			else
				check row_set: False end
			end
		ensure
			Result /= Void
		end

	redraw_span (a_drawable: EV_DRAWABLE)
			-- Redraw span cell
		local
			l_text: like text
			focused: BOOLEAN
			c: INTEGER
			prev_width: INTEGER
			w: INTEGER
			bg,fg: detachable EV_COLOR
			ft: detachable EV_FONT
			m: like master_item
		do
			if attached parent as g then
				focused := g.implementation.drawables_have_focus
				m := master_item

				bg := background_color
				if bg = Void then
					bg := row.background_color
				end
				fg := foreground_color
				if fg = Void then
					fg := row.foreground_color
				end
				if bg = Void then
					if is_selected or else (m /= Void and then m.is_selected) then
						if focused then
							bg := g.focused_selection_color
							fg := g.focused_selection_text_color
						else
							bg := g.non_focused_selection_color
							fg := g.non_focused_selection_text_color
						end
					else
						bg := g.background_color
						if fg = Void then
							fg := g.foreground_color
						end
					end
				elseif fg = Void then
					fg := g.foreground_color
				end

				a_drawable.set_foreground_color (bg)
				a_drawable.fill_rectangle (0, 0, width, height)
				if not g.pre_draw_overlay_actions.is_empty then
					g.pre_draw_overlay_actions.call ([a_drawable, Current, column.index, row.index])
					a_drawable.set_foreground_color (bg)
					a_drawable.fill_rectangle (0, 0, width, height - 1)
				end

				w := 0
				if is_master then
					l_text := text
					if attached pixmap as pix  then
						a_drawable.draw_pixmap (3 + w, 2, pix)
						w := w + pix.width + extra_space_after_pixmap
					end
--FIXME: is it needed?
--					if is_selected then
--						a_drawable.set_foreground_color (create {EV_COLOR})
--						a_drawable.enable_dashed_line_style
--						a_drawable.draw_rectangle (1, 1, width - 2, height - 2)
--						a_drawable.disable_dashed_line_style
--					end
				elseif m /= Void then
					l_text := m.text
				else
					check has_master: False end
				end

				if l_text /= Void then
					a_drawable.set_foreground_color (fg)

					if is_master then
						ft := font
						if ft /= Void then
							a_drawable.set_font (ft)
						end
					else
						if m /= Void then
							ft := m.font
						else
							ft := font
						end
						if ft /= Void then
							a_drawable.set_font (ft)
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
								spawned_item: attached row.item(c) as cl and then cl.conforms_to (Current)
							end
							if attached row.item (c) as l_c_item then
								prev_width := prev_width + l_c_item.width
							else
								check has_row_item_at_c: False end
							end

							c := c - 1
						end

						if m /= Void and then attached m.pixmap as m_pixmap then
							prev_width := prev_width - m_pixmap.width - extra_space_after_pixmap
						end
						w := w - prev_width
					end
					a_drawable.draw_text_top_left (3 + w, 2, l_text)
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
