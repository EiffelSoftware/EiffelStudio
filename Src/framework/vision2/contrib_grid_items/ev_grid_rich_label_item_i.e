note
	description: "Cell consisting of only of a text label. Implementation Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_RICH_LABEL_ITEM_I

inherit
	EV_GRID_LABEL_ITEM_I
		redefine
			recompute_text_dimensions,
			interface,
			draw_text
		end

create
	make

feature {EV_GRID_DRAWER_I} -- Implementation

	recompute_text_dimensions
			-- Recompute `internal_text_width' and `internal_text_height'.
		local
			l_formats: LIST [TUPLE [offset: INTEGER; color: detachable EV_COLOR; font: detachable EV_FONT]]
			l_format: TUPLE [offset: INTEGER; color: detachable EV_COLOR; font: detachable EV_FONT]
			l_font_dft: EV_FONT
			l_font: detachable EV_FONT
			l_offset: INTEGER
			l_text,
			l_subtext: STRING_32
			l_width: INTEGER
			l_height: INTEGER
			l_text_dimensions: TUPLE [w:INTEGER; h:INTEGER]
			l_interface: like interface
			l_parent_i: like parent_i
		do
			l_interface := interface
			l_parent_i := parent_i
			check l_interface /= Void and l_parent_i /= Void then
				l_formats := l_interface.formats
				if l_formats.count > 0 then
					if must_recompute_text_dimensions then
						l_font := l_interface.font
						if l_font /= Void then
							l_font_dft := l_font
						else
							l_font_dft := internal_default_font
						end
						from
							l_width := 0
							l_height := 0
							l_text := l_interface.text
							l_formats.start
							l_format := l_formats.item
							l_offset := l_format.offset
						until
							l_formats.after or l_offset > l_text.count
						loop
							l_font := l_format.font
							if l_font = Void then
								l_font := l_font_dft
							end
							if not l_formats.islast then
								l_formats.forth
								l_format := l_formats.item
								l_subtext := l_text.substring (l_offset, l_format.offset - 1)
								l_offset := l_format.offset
							else
								l_formats.forth
								l_subtext := l_text.substring (l_offset, l_text.count)
							end
							l_text_dimensions := text_dimensions
							l_parent_i.string_size (l_subtext, l_font, l_text_dimensions)
							l_width := l_width + l_text_dimensions.w
							l_height := l_height.max (l_text_dimensions.h )
						end
						internal_text_width := l_width
						internal_text_height := l_height
					end
					must_recompute_text_dimensions := False
				else
					Precursor
				end
			end
		end

	draw_text (a_text: STRING_32; a_drawable: EV_DRAWABLE; a_layout: EV_GRID_LABEL_ITEM_LAYOUT; an_indent: INTEGER_32)
		local
			l_format: TUPLE [offset: INTEGER; color: detachable EV_COLOR; font: detachable EV_FONT]
			l_formats: LIST [TUPLE [offset: INTEGER; color: detachable EV_COLOR; font: detachable EV_FONT]]
			l_subtext: STRING_32
			l_subwidth: INTEGER
			l_color_dft: EV_COLOR
			l_color: detachable EV_COLOR
			l_font_dft: EV_FONT
			l_other_font: detachable EV_FONT
			l_subheight_delta: INTEGER
			l_offset: INTEGER
			text_x, space_remaining_for_text: INTEGER
			l_text_dimensions: TUPLE [w:INTEGER; h:INTEGER]
		do
			check
				attached interface as l_interface and
				attached parent_i as l_parent_i
			then
					--| Formatting here ...
				if not is_selected and then l_interface.formats.count > 0 then
					if attached l_interface.font as l_font then
						l_font_dft := l_font
					else
						l_font_dft := internal_default_font
					end
					l_formats := l_interface.formats
					from
						text_x := a_layout.text_x
						space_remaining_for_text := a_layout.available_text_width
						l_color_dft := l_parent_i.foreground_color
						l_formats.start
						l_format := l_formats.item
						l_offset := l_format.offset
					until
						l_formats.after or space_remaining_for_text <= 0 or l_offset > a_text.count
					loop
						l_color := l_format.color
						if l_color = Void then
							l_color := l_color_dft
						end
						l_other_font := l_format.font
						if l_other_font = Void then
							l_other_font := l_font_dft
						end
						a_drawable.set_foreground_color (l_color)
						a_drawable.set_font (l_other_font)
						if not l_formats.islast then
							l_formats.forth
							l_format := l_formats.item
							l_subtext := a_text.substring (l_offset, l_format.offset - 1)
							l_offset := l_format.offset
						else
							l_formats.forth
							l_subtext := a_text.substring (l_offset, a_text.count)
						end

						l_subwidth := l_other_font.string_width (l_subtext)
						l_text_dimensions := text_dimensions
						l_parent_i.string_size (l_subtext, l_other_font, l_text_dimensions)
						l_subwidth := l_text_dimensions.w
						l_subheight_delta := (internal_text_height - l_text_dimensions.h).max (0)
						if space_remaining_for_text < l_subwidth then
							a_drawable.draw_ellipsed_text_top_left (text_x + an_indent, a_layout.text_y + l_subheight_delta, l_subtext, space_remaining_for_text)
						else
							a_drawable.draw_text_top_left (text_x + an_indent, a_layout.text_y + l_subheight_delta, l_subtext)
						end
						text_x := text_x + l_subwidth
						space_remaining_for_text := space_remaining_for_text - l_subwidth
					end
				else
					Precursor (a_text, a_drawable, a_layout, an_indent)
				end
			end
		end
feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_GRID_RICH_LABEL_ITEM note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end

