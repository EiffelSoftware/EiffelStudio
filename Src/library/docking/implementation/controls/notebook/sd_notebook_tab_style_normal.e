indexing
	description: "Objects that responsible for drawing SD_NOTEBOOK_TAB."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_NOTEBOOK_TAB_DRAWER_I

feature {NONE} -- Initlization

	make is
			-- Creation method
		do
			create internal_shared
			is_draw_pixmap := True
			text := ""
			create pixmap
		end

feature -- Command

	expose_unselected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO) is
			-- Draw unselected tab.
		require
			setted: pixmap /= Void
			vaild: a_width > 0
			not_void: a_tab_info /= Void
		deferred
		end

	expose_selected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO) is
			-- Draw selected tab.
		require
			setted: pixmap /= Void
			vaild: a_width > 0
			not_void: a_tab_info /= Void
		deferred
		end

	expose_hot (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO) is
			-- Draw hot tab.
		require
			setted: pixmap /= Void
			vaild: a_width > 0
			not_void: a_tab_info /= Void
		deferred
		end

feature -- Key setting

	set_drawing_area (a_tab: SD_NOTEBOOK_TAB) is
			-- Set `internal_tab' with `a_tab'
		require
			not_void: a_tab /= Void
		do
			internal_tab := a_tab
		ensure
			set: internal_tab = a_tab
		end

	set_is_draw_at_top (a_draw_at_top: BOOLEAN) is
			-- Set `is_top_side_tab' with `a_draw_at_top'
		do
			is_top_side_tab := a_draw_at_top
		ensure
			set: is_top_side_tab = a_draw_at_top
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
			Result := internal_tab.width
		end

	height: INTEGER is
			-- Height of Current will draw.
		do
			Result := internal_tab.height
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
				l_font := internal_tab.font
				if l_font /= Void then
					l_font.set_weight ({EV_FONT_CONSTANTS}.Weight_bold)
				end
			else
				l_font := internal_tab.font
				if l_font /= Void then
					l_font.set_weight ({EV_FONT_CONSTANTS}.Weight_regular)
				end
			end
			if l_font /= Void then
				internal_tab.set_font (l_font)
			end
		ensure
			set: is_selected = a_selected
		end

	is_top_side_tab: BOOLEAN
			-- If Current the tabs which at top side.
			-- Otherwise it's bottom side tabs.

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

	start_x_close: INTEGER is
			-- Start x position where should draw close
		require
			avialable: is_top_side_tab
		local
			l_width: INTEGER
			l_font: EV_FONT
		do
			l_font := internal_tab.font
			if l_font /= Void then
				l_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
				l_width := l_font.string_width (text)

				if is_top_side_tab then
					if is_enough_space then
						Result := start_x_text_internal + l_width + padding_width
					end
				end
			end
		end

	start_x_tail_internal: INTEGER is
			-- Start x position where should draw tail area.
		local
			l_width: INTEGER
		do
			if is_enough_space then
				if is_top_side_tab then
					Result := start_x_close + internal_shared.icons.close.width + padding_width
				else
					l_width := internal_tab.font.string_width (text)
					Result := start_x_text_internal + l_width + padding_width
				end
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
				Result := start_x_text_internal + internal_tab.font.string_width (text) + padding_width - 1
			end
		end

	start_y_position: INTEGER is 0
			-- Start y position of drawing a pixmap.

	start_y_close: INTEGER is
			-- Start y position of drawing a close button
		do
			Result := height  - internal_shared.icons.close.height - close_background_expand * 2
		end

	close_rectangle: EV_RECTANGLE is
			-- Close button rectangle
		require
			has_close_button: is_top_side_tab
		do
			create Result.make (start_x_close - close_background_expand, start_y_close - close_background_expand, internal_shared.icons.close.width + 2 * close_background_expand, internal_shared.icons.close.height + 2 * close_background_expand)
		ensure
			not_void: Result /= Void
		end

	close_rectangle_parent_box: EV_RECTANGLE is
			-- Close button rectangle relative to parent box
		do
			Result := close_rectangle
			if internal_tab.parent /= Void then
				Result.move (Result.x + internal_tab.x, Result.y)
			end
		end

feature {NONE} -- Implementation

	start_draw is
			-- We make a buffer pixmap
			-- Should call `end_draw' after every thing is done.
		require
			not_called: buffer_pixmap = Void
			size_valid: internal_tab.width > 0 and internal_tab.height > 0

		do
			create buffer_pixmap.make_with_size (internal_tab.width, internal_tab.height)
			buffer_pixmap.set_font (internal_tab.font)

			buffer_pixmap.set_background_color (internal_shared.default_background_color)
			buffer_pixmap.clear
		ensure
			created: buffer_pixmap /= Void
		end

	end_draw is
			-- Draw `buffer_pixmap' to `internal_drawing_area'
			-- Call `start_draw' before call this function.
		require
			not_void: buffer_pixmap /= Void
		do
			internal_tab.parent.draw_pixmap (internal_tab.x, 0, buffer_pixmap)
			buffer_pixmap := Void
		ensure
			cleared: buffer_pixmap = Void
		end

	draw_pixmap_text_unselected (a_pixmap: EV_DRAWABLE; a_width: INTEGER) is
			-- Draw pixmap and text when unselected.
		require
			not_void: a_pixmap /= Void
		do
			a_pixmap.set_foreground_color (internal_shared.tab_text_color)
			if is_top_side_tab then
				-- Draw pixmap
				a_pixmap.draw_pixmap (start_x_pixmap_internal, start_y_position + gap_height + 1, pixmap)
				a_pixmap.draw_text_top_left (start_x_text_internal, gap_height, text)
			else
				-- Draw pixmap
				a_pixmap.draw_pixmap (start_x_pixmap_internal, 0, pixmap)
				-- Draw text
				a_pixmap.draw_text_top_left (start_x_text_internal, 0, text)
			end

			draw_close_button (a_pixmap, internal_shared.icons.close)
		end

	draw_pixmap_text_selected (a_pixmap: EV_DRAWABLE; a_width: INTEGER) is
			-- Draw pixmap and text when selected.
		require
			not_void: a_pixmap /= Void
		do
			if a_pixmap.height > 0 then
				-- Draw text
				a_pixmap.set_foreground_color (internal_shared.tab_text_color)
				if a_width - start_x_text_internal >= 0 then
					if is_top_side_tab then
						a_pixmap.draw_ellipsed_text_top_left (start_x_text_internal, start_y_position + gap_height, text, a_width - start_x_text_internal)
					else
						a_pixmap.draw_ellipsed_text_top_left (start_x_text_internal, start_y_position + gap_height, text, a_width - start_x_text_internal)
					end
				end
				-- Draw pixmap
				if is_draw_pixmap then
					if is_top_side_tab then
						a_pixmap.draw_pixmap (start_x_pixmap_internal, start_y_position + gap_height, pixmap)
					else
						a_pixmap.draw_pixmap (start_x_pixmap_internal, start_y_position, pixmap)
					end
				end

				draw_close_button (a_pixmap, internal_shared.icons.close)
			end
		end

	draw_close_button (a_drawable: EV_DRAWABLE; a_close_pixmap: EV_PIXMAP)
			-- Draw close button if possible
		require
			not_void: a_drawable /= Void
			not_void: a_close_pixmap /= Void
		deferred
		end

	close_background_expand: INTEGER is 3
			-- close button background expand size.

	internal_tab: SD_NOTEBOOK_TAB
			-- Drawing area to draw tab.

	internal_shared: SD_SHARED
			-- ALl singletons.

	buffer_pixmap: EV_PIXMAP
			-- Buffer pixmap

invariant

	not_void: internal_tab /= Void

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
