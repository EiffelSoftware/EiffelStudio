indexing
	description: "Objects that responsible for drawing SD_NOTEBOOK_TAB."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB_STYLE_NORMAL

create
	make

feature {NONE} -- Initlization

	make (a_drawing_area: EV_DRAWING_AREA; a_draw_at_top: BOOLEAN) is
			-- Creation method
		require
			not_void: a_drawing_area /= Void
		do
			create internal_shared
			internal_drawing_area := a_drawing_area
			internal_draw_border_at_top := a_draw_at_top
			is_draw_pixmap := True
			text := ""
			create pixmap
		ensure
			set: internal_drawing_area = a_drawing_area
			set: internal_draw_border_at_top = a_draw_at_top
		end

feature -- Command

	expose_unselected (a_width: INTEGER; a_selected_tab_after: BOOLEAN) is
			-- Draw current when unselected.
		require
			setted: pixmap /= Void
		local
			l_helper: SD_COLOR_HELPER
		do
			internal_drawing_area.set_foreground_color ((create {EV_STOCK_COLORS}).default_background_color)
			-- Draw gap
			if internal_draw_border_at_top then
				internal_drawing_area.fill_rectangle (0, 0, width, gap_height)
			else
				internal_drawing_area.fill_rectangle (0, height - gap_height - 1, width, gap_height)
			end
			internal_drawing_area.set_foreground_color (internal_shared.border_color)
			create l_helper

			if internal_draw_border_at_top then
				-- Draw ________
				internal_drawing_area.draw_segment (0, gap_height, width, gap_height)
				-- Draw pixmap
				internal_drawing_area.draw_pixmap (start_x_pixmap_internal, start_y_position + gap_height + 1, pixmap)
				-- Draw end |
				if a_selected_tab_after then
					internal_drawing_area.draw_segment (width - 1, gap_height - 1, width - 1, height)
				else
					internal_drawing_area.draw_segment (width - 1, gap_height + 1, width - 1, height - 1)
				end
				internal_drawing_area.set_foreground_color (l_helper.text_color_by (internal_shared.non_focused_color_lightness))
				internal_drawing_area.draw_text_top_left (start_x_text_internal, gap_height, text)
			else
				-- Draw ________
				internal_drawing_area.draw_segment (0, height - gap_height - 1, width, height - gap_height - 1)
				-- Draw pixmap
				internal_drawing_area.draw_pixmap (start_x_pixmap_internal, 0, pixmap)
				-- Draw end |
				if a_selected_tab_after then
					internal_drawing_area.draw_segment (width - 1, 0, width - 1, height - gap_height)
				else
					internal_drawing_area.draw_segment (width - 1, 0, width - 1, height - gap_height - 1)
				end
				-- Draw text
				internal_drawing_area.set_foreground_color (l_helper.text_color_by (internal_shared.non_focused_color_lightness))
				internal_drawing_area.draw_text_top_left (start_x_text_internal, 0, text)
			end
		end

	expose_selected (a_width: INTEGER) is
			-- Handle draw selected events.
		require
			setted: pixmap /= Void
		local
			l_helper: SD_COLOR_HELPER
			l_rect: EV_RECTANGLE
			l_start_x: INTEGER
		do
			if internal_drawing_area.height > 0 then

				create l_helper

				if internal_draw_border_at_top then
						l_start_x := a_width - internal_shared.highlight_tail_width
						if l_start_x < 0 then
							l_start_x := 0
						end
					if internal_drawing_area.width - start_x_tail_internal > 0 then

						create l_rect.make (l_start_x, gap_height - 1, internal_drawing_area.width - start_x_tail_internal, internal_drawing_area.height - gap_height + 1)
					end
				else
					if internal_drawing_area.width - start_x_tail_internal > 0  then
						l_start_x := a_width - internal_shared.highlight_tail_width
						if l_start_x < 0 then
							l_start_x := 0
						end
						-- FIXIT: On linux, internal_drawing_area.height's value may be only 1 sometime. But actually is not 1 at that time.
						if internal_drawing_area.height - gap_height >= 0 then
							create l_rect.make (l_start_x, 0, internal_drawing_area.width - start_x_tail_internal, internal_drawing_area.height - gap_height)
						else
							create l_rect.make (l_start_x, 0, internal_drawing_area.width - start_x_tail_internal, 0)
						end
					end
				end
				if l_rect /= Void then
					l_helper.draw_color_change_gradually_in_area (internal_drawing_area, l_rect, internal_drawing_area.background_color, internal_shared.non_focused_color)
				end
				internal_drawing_area.set_foreground_color (internal_shared.non_focused_color_lightness)
				if internal_draw_border_at_top then
					internal_drawing_area.draw_segment (0, 0, width, 0)
				else
					internal_drawing_area.draw_segment (0, height - 1, width, height - 1)
				end

				internal_drawing_area.set_foreground_color (internal_shared.border_color)
				-- Draw | at end
				if internal_draw_border_at_top then
					internal_drawing_area.draw_segment (a_width - 1, 1, a_width - 1, height)
				else
					internal_drawing_area.draw_segment (a_width - 1, 0, a_width - 1, height - 2)
				end

				if internal_draw_border_at_top then
					-- Draw top ________
					internal_drawing_area.draw_segment (0, gap_height - 1, width, gap_height - 1)
				else
					internal_drawing_area.draw_segment (0, height - gap_height, width, height - gap_height)
				end

				-- Draw text
				internal_drawing_area.set_foreground_color (l_helper.text_color_by (internal_drawing_area.background_color))
				if a_width - start_x_text_internal >= 0 then
					if internal_draw_border_at_top then
						internal_drawing_area.draw_ellipsed_text_top_left (start_x_text_internal, start_y_position + gap_height, text, a_width - start_x_text_internal)
					else
						internal_drawing_area.draw_ellipsed_text_top_left (start_x_text_internal, start_y_position + gap_height, text, a_width - start_x_text_internal)
					end
				end
				-- Draw pixmap
				if is_draw_pixmap then
					if internal_draw_border_at_top then
						internal_drawing_area.draw_pixmap (start_x_pixmap_internal, start_y_position + gap_height, pixmap)
					else
						internal_drawing_area.draw_pixmap (start_x_pixmap_internal, start_y_position, pixmap)
					end
				end
			end

		end

feature -- Properties

	text: STRING
			-- Text

	set_text (a_text: STRING) is
			-- Set `text'
		require
			not_void: a_text /= Void
		do
			text := a_text
		ensure
			set: text = a_text
		end

	pixmap: EV_PIXMAP
			-- Pixmap Current will draw.

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set `pixmap'
		require
			not_void: a_pixmap /= Void
		do
			pixmap := a_pixmap
		ensure
			set: pixmap = a_pixmap
		end

	padding_width: INTEGER
			-- Padding width.

	set_padding_width (a_width: INTEGER) is
			-- Set `padding_width'.
		require
			valid: a_width >= 0
		do
			padding_width := a_width
		ensure
			set: padding_width = a_width
		end

	gap_height: INTEGER is 2
			-- Gap height

	width: INTEGER is
			-- Width of Current will draw.
		do
			Result := internal_drawing_area.width
		end

	height: INTEGER is
			-- Height of Current will draw.
		do
			Result := internal_drawing_area.height
		end

	is_draw_pixmap: BOOLEAN
			-- If Current will draw pixmap?

	set_draw_pixmap (a_draw: BOOLEAN) is
			-- Set `is_draw_pixmap'
		do
			is_draw_pixmap := a_draw
		ensure
			set: is_draw_pixmap = a_draw
		end

	is_enough_space: BOOLEAN
			-- Enough space now?

	set_enough_space (a_enough: BOOLEAN) is
			-- Set `is_enough_space'.
		do
			is_enough_space := a_enough
		ensure
			set: is_enough_space = a_enough
		end

	is_selected: BOOLEAN
			-- Draw selected?

	set_selected (a_selected: BOOLEAN; a_focused: BOOLEAN) is
			-- Set `is_selected'
		local
			l_font: EV_FONT
		do
			is_selected := a_selected
			if a_selected then
				if a_focused then
					internal_drawing_area.set_background_color (internal_shared.focused_color)
				else
					internal_drawing_area.set_background_color (internal_shared.non_focused_color_lightness)
				end
				l_font := internal_drawing_area.font
				l_font.set_weight ({EV_FONT_CONSTANTS}.Weight_bold)
			else
				internal_drawing_area.set_background_color (internal_shared.non_focused_color_lightness)
				l_font := internal_drawing_area.font
				l_font.set_weight ({EV_FONT_CONSTANTS}.Weight_regular)
			end
			internal_drawing_area.set_font (l_font)
		ensure
			set: is_selected = a_selected
		end

feature -- Size issues

	start_x_separator_before_internal: INTEGER is
			-- Start x position where should draw seperator before.
		do
			Result := 0
		end

	start_x_pixmap_internal: INTEGER is
			-- Start x position where should draw `pixmap'.
		do
			Result := start_x_separator_before_internal + padding_width
		end

	start_x_text_internal: INTEGER is
			-- Start x position where should draw `text'.
		do
			Result := start_x_pixmap_internal
			if is_draw_pixmap then
				Result := Result + pixmap.width + padding_width
			end
		end

	start_x_tail_internal: INTEGER is
			-- Start x position where should draw tail area.
		local
			l_width: INTEGER
		do
			if is_enough_space then
				l_width := internal_drawing_area.font.string_width (text)
				Result := start_x_text_internal + l_width + padding_width
			else
				Result := width - 1 - internal_shared.highlight_tail_width
				if Result < 0 then
					Result := 0
				end
			end
		ensure
			non_negative: Result >= 0
		end

	start_x_separator_after_internal: INTEGER is
			-- Start x position where should draw seperator after.
		do
			if is_selected then
				if is_enough_space then
					Result := start_x_tail_internal + internal_shared.highlight_tail_width + padding_width - 1
				else
					Result := width - 1
				end
			else
				Result := start_x_text_internal + internal_drawing_area.font.string_width (text) + padding_width - 1
			end
		end

	start_y_position: INTEGER is 0
			-- Start y position of drawing a pixmap.

feature {NONE} -- Implementation

	internal_draw_border_at_top: BOOLEAN
			-- If Current draw border at top?

	internal_drawing_area: EV_DRAWING_AREA
			-- Drawing area to draw tab.

	internal_shared: SD_SHARED
			-- ALl singletons.

invariant

	not_void: internal_drawing_area /= Void

indexing
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
