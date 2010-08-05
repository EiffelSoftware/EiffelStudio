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
			perform_redraw
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
			l_subtext: STRING
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

	perform_redraw (an_x, a_y, a_width, a_height, an_indent: INTEGER; drawable: EV_PIXMAP)
			-- Redraw `Current'.
		local
			back_color: EV_COLOR
			l_pixmap: detachable EV_PIXMAP
			pixmap_width: INTEGER
			pixmap_height: INTEGER
			left_border, right_border, top_border, bottom_border, spacing_used: INTEGER
			space_remaining_for_text, space_remaining_for_text_vertical: INTEGER
			text_offset_into_available_space, vertical_text_offset_into_available_space: INTEGER
			client_x, client_y, client_width, client_height: INTEGER
			text_x, text_y: INTEGER
			pixmap_x, pixmap_y: INTEGER
			selection_x, selection_y, selection_width, selection_height: INTEGER
			focused: BOOLEAN
			l_clip_width, l_clip_height: INTEGER
			l_format: TUPLE [offset: INTEGER; color: detachable EV_COLOR; font: detachable EV_FONT]
			l_formats: LIST [TUPLE [offset: INTEGER; color: detachable EV_COLOR; font: detachable EV_FONT]]
			l_subtext: STRING
			l_subwidth: INTEGER
			l_subheight_delta: INTEGER
			l_color_dft: EV_COLOR
			l_color: detachable EV_COLOR
			l_font_dft: EV_FONT
			l_font: detachable EV_FONT
			l_offset: INTEGER
			l_text: STRING
			l_text_dimensions: TUPLE [w:INTEGER; h:INTEGER]
			l_grid_label_item_layout: like grid_label_item_layout
			l_interface: like interface
			l_parent_i: like parent_i
			l_column_i: like column_i
		do
			recompute_text_dimensions
				-- Update the dimensions of the text if required.

				-- Retrieve properties from interface
			l_interface := interface
			l_parent_i := parent_i
			l_column_i := column_i
			check l_interface /= Void and l_parent_i /= Void l_column_i /= Void then
				focused := l_parent_i.drawables_have_focus
				left_border := l_interface.left_border
				right_border := l_interface.right_border
				top_border := l_interface.top_border
				bottom_border := l_interface.bottom_border
				l_text := l_interface.text

				if attached l_interface.layout_procedure as l_layout_procedure then
					l_grid_label_item_layout := grid_label_item_layout
					l_grid_label_item_layout.set_pixmap_x (0)
					l_grid_label_item_layout.set_pixmap_y (0)
					l_grid_label_item_layout.set_text_x (0)
					l_grid_label_item_layout.set_text_y (0)
					l_grid_label_item_layout.set_grid_label_item (interface)
					l_pixmap := l_interface.pixmap
					if l_pixmap /= Void then
						pixmap_width := l_pixmap.width
						pixmap_height := l_pixmap.height
					end
					l_layout_procedure.call ([l_interface, l_grid_label_item_layout])
					text_x := l_grid_label_item_layout.text_x
					text_y := l_grid_label_item_layout.text_y
					pixmap_x := l_grid_label_item_layout.pixmap_x
					pixmap_y := l_grid_label_item_layout.pixmap_y

					if attached l_grid_label_item_layout.grid_label_item as l_glab then
						space_remaining_for_text := l_glab.width - text_x
						space_remaining_for_text_vertical := l_glab.height - text_y
					end
				else
						-- Retrieve properties from interface.
					l_pixmap := l_interface.pixmap
					spacing_used := l_interface.spacing

						-- Now calculate the area to be used for displaying the text and pixmap
						-- by subtracting the borders from the complete area.
					client_x := an_x + left_border
					client_y := a_y + top_border
					client_width := a_width - left_border - right_border
					client_height := a_height - top_border - bottom_border

					if l_pixmap /= Void then
						pixmap_width := l_pixmap.width
						pixmap_height := l_pixmap.height
					else
						spacing_used := 0
					end

					space_remaining_for_text := client_width - pixmap_width - spacing_used
					space_remaining_for_text_vertical := client_height

						-- Note in the following text positioning calculations, we subtract 1 from
						-- the calculation as this accounts for the 0-based drawing positions.
					if l_text /= Void and space_remaining_for_text > 0 then
						if l_interface.is_left_aligned then
							text_offset_into_available_space := 0
						elseif l_interface.is_right_aligned then
							text_offset_into_available_space := space_remaining_for_text - internal_text_width - 1
						else
							text_offset_into_available_space := space_remaining_for_text - internal_text_width - 1
							if text_offset_into_available_space /= 0 then
								text_offset_into_available_space := text_offset_into_available_space // 2
							end
						end
							-- Ensure that the text always respect the edge of the pixmap + the spacing in all alignment modes
							-- when the width of the column is not enough to display all of the contents
						text_offset_into_available_space := text_offset_into_available_space.max (0)

						if l_interface.is_top_aligned then
							vertical_text_offset_into_available_space := 0
						elseif l_interface.is_bottom_aligned then
							vertical_text_offset_into_available_space := space_remaining_for_text_vertical - internal_text_height - 1
						else
							vertical_text_offset_into_available_space := space_remaining_for_text_vertical - internal_text_height - 1
							if vertical_text_offset_into_available_space /= 0 then
								vertical_text_offset_into_available_space := vertical_text_offset_into_available_space // 2
							end
						end

							-- Ensure that the text always respects the top edge of the row in all alignment modes
							-- when the height of the row is not enough to display the text fully.
						vertical_text_offset_into_available_space := vertical_text_offset_into_available_space.max (0)
					end
					text_x := left_border + pixmap_width + spacing_used + text_offset_into_available_space
					text_y := top_border + vertical_text_offset_into_available_space
					pixmap_x := left_border
					pixmap_y := top_border + (client_height - pixmap_height) // 2
				end

				drawable.set_copy_mode
				back_color := displayed_background_color
				drawable.set_foreground_color (back_color)
				if is_selected then
					if focused then
						drawable.set_foreground_color (l_parent_i.focused_selection_color)
					else
						drawable.set_foreground_color (l_parent_i.non_focused_selection_color)
					end

						-- Calculate the area that must be selected in `Current'.
					if l_interface.is_full_select_enabled then
						selection_x := 0
						selection_width := a_width
						selection_y := 0
						selection_height := a_height
					else
						selection_x := text_x
						selection_width := text_width + 2
						selection_y := text_y
						selection_height := text_height
					end

					drawable.fill_rectangle (selection_x + an_indent, selection_y, selection_width, selection_height)
					if focused then
						drawable.set_foreground_color (l_parent_i.focused_selection_text_color)
					else
						drawable.set_foreground_color (l_parent_i.non_focused_selection_text_color)
					end
					drawable.set_copy_mode
				else
					drawable.set_foreground_color (displayed_foreground_color)
				end
					-- Now assign a clip area based on the borders of the item before we draw the text and the pixmap as they
					-- may be clipped based on the amount of space available to them based on the border settings.

				l_clip_width := l_column_i.width - right_border
				l_clip_height := height - bottom_border

				if l_clip_width > 0 and then l_clip_height > 0 then
						-- Only draw if the clipping area is not empty
					internal_rectangle.move_and_resize (left_border, top_border, l_column_i.width - right_border, height - bottom_border)
					drawable.set_clip_area (internal_rectangle)
					if l_pixmap /= Void then
							-- Now blit the pixmap
						drawable.draw_pixmap (pixmap_x + an_indent, pixmap_y, l_pixmap)
					end

					l_font := l_interface.font
					if l_font /= Void then
						drawable.set_font (l_font)
					else
						drawable.set_font (internal_default_font)
					end

						--| Formatting here ...
					if not is_selected and then l_interface.formats.count > 0 then
						l_formats := l_interface.formats
						from
							l_text := l_interface.text
							l_font_dft := drawable.font
							l_color_dft := l_parent_i.foreground_color
							l_formats.start
							l_format := l_formats.item
							l_offset := l_format.offset
						until
							l_formats.after or space_remaining_for_text <= 0 or l_offset > l_text.count
						loop
							l_color := l_format.color
							if l_color = Void then
								l_color := l_color_dft
							end
							l_font := l_format.font
							if l_font = Void then
								l_font := l_font_dft
							end
							drawable.set_foreground_color (l_color)
							drawable.set_font (l_font)
							if not l_formats.islast then
								l_formats.forth
								l_format := l_formats.item
								l_subtext := l_text.substring (l_offset, l_format.offset - 1)
								l_offset := l_format.offset
							else
								l_formats.forth
								l_subtext := l_text.substring (l_offset, l_text.count)
							end

							l_subwidth := l_font.string_width (l_subtext)
							l_text_dimensions := text_dimensions
							l_parent_i.string_size (l_subtext, l_font, l_text_dimensions)
							l_subwidth := l_text_dimensions.w
							l_subheight_delta := (internal_text_height - l_text_dimensions.h).max (0)
							if space_remaining_for_text < l_subwidth then
								drawable.draw_ellipsed_text_top_left (text_x + an_indent, text_y + l_subheight_delta, l_subtext, space_remaining_for_text)
							else
								drawable.draw_text_top_left (text_x + an_indent, text_y + l_subheight_delta, l_subtext)
							end
							text_x := text_x + l_subwidth
							space_remaining_for_text := space_remaining_for_text - l_subwidth
						end
					else
						if l_text /= Void and space_remaining_for_text > 0 and space_remaining_for_text < internal_text_width then
							drawable.draw_ellipsed_text_top_left (text_x + an_indent, text_y, l_text, space_remaining_for_text)
						else
							drawable.draw_text_top_left (text_x + an_indent, text_y, l_text)
						end
					end
					drawable.remove_clip_area
					drawable.set_copy_mode
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

