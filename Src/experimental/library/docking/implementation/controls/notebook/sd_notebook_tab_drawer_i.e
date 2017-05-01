note
	description: "Objects that responsible for drawing SD_NOTEBOOK_TAB."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_NOTEBOOK_TAB_DRAWER_I

feature {NONE} -- Initlization

	make (a_tab: SD_NOTEBOOK_TAB)
			-- Associate drawer with initial tab `a_tab'.
			-- The tab can be changed with `set_drawing_area'.
		do
			create internal_shared
			is_draw_pixmap := True
			text := ""
			create pixmap
			set_drawing_area (a_tab)
		end

feature -- Command

	expose_unselected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- Draw unselected tab
		require
			setted: pixmap /= Void
			vaild: a_width > 0
			not_void: a_tab_info /= Void
		do
			current_total_width := a_width
		end

	expose_selected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- Draw selected tab
		require
			setted: pixmap /= Void
			vaild: a_width > 0
			not_void: a_tab_info /= Void
		do
			current_total_width := a_width
		end

	expose_hot (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- Draw hot tab
		require
			setted: pixmap /= Void
			vaild: a_width > 0
			not_void: a_tab_info /= Void
		do
			current_total_width := a_width
		end

	draw_focus_rect (a_rect: EV_RECTANGLE)
			-- Draw focus rectangle
		require
			not_void: a_rect /= Void
		do
		end

feature -- Key setting

	set_drawing_area (a_tab: SD_NOTEBOOK_TAB)
			-- Set `tab' to `a_tab'.
		require
			not_void: a_tab /= Void
		do
			tab := a_tab
		ensure
			set: tab = a_tab
		end

	set_is_draw_at_top (a_draw_at_top: BOOLEAN)
			-- Set `is_top_side_tab' with `a_draw_at_top'
		do
			is_top_side_tab := a_draw_at_top
		ensure
			set: is_top_side_tab = a_draw_at_top
		end

feature -- Properties

	text: STRING_32
			-- Text

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Set `text'
		require
			not_void: a_text /= Void
		do
			text := a_text.as_string_32
		ensure
			set: text.same_string_general (a_text)
		end

	pixmap: EV_PIXMAP
			-- Pixmap Current will draw

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Set `pixmap'
		require
			not_void: a_pixmap /= Void
		do
			pixmap := a_pixmap
		ensure
			set: pixmap = a_pixmap
		end

	padding_width: INTEGER
			-- Padding width

	set_padding_width (a_width: INTEGER)
			-- Set `padding_width'
		require
			valid: a_width >= 0
		do
			padding_width := a_width
		ensure
			set: padding_width = a_width
		end

	gap_height: INTEGER
			-- Gap height
		deferred
		end

	width: INTEGER
			-- Width of Current will draw
		do
			Result := tab.width
		end

	height: INTEGER
			-- Height of Current will draw
		do
			Result := tab.height
		end

	is_draw_pixmap: BOOLEAN
			-- If Current will draw pixmap?

	set_draw_pixmap (a_draw: BOOLEAN)
			-- Set `is_draw_pixmap'
		do
			is_draw_pixmap := a_draw
		ensure
			set: is_draw_pixmap = a_draw
		end

	is_enough_space: BOOLEAN
			-- Enough space now?

	set_enough_space (a_enough: BOOLEAN)
			-- Set `is_enough_space'.
		do
			is_enough_space := a_enough
		ensure
			set: is_enough_space = a_enough
		end

	is_selected: BOOLEAN
			-- Draw selected?

	set_selected (a_selected: BOOLEAN; a_focused: BOOLEAN)
			-- Set `is_selected'
		local
			l_font: detachable EV_FONT
		do
			if a_selected then
				l_font := tab.font
				if l_font /= Void then
					l_font.set_weight ({EV_FONT_CONSTANTS}.Weight_bold)
				end
			else
				l_font := tab.font
				if l_font /= Void then
					l_font.set_weight ({EV_FONT_CONSTANTS}.Weight_regular)
				end
			end
			if l_font /= Void then
				tab.set_font (l_font)
			end
			is_selected := a_selected
		ensure
			set: is_selected = a_selected
		end

	is_top_side_tab: BOOLEAN
			-- If Current the tabs which at top side
			-- Otherwise it's bottom side tabs

	current_total_width: INTEGER
			-- Current total width during one drawing tab action

feature -- Size issues

	start_x_separator_before_internal: INTEGER
			-- Start x position where should draw separator before
		do
			Result := 0
		end

	start_x_pixmap_internal: INTEGER
			-- Start x position where should draw `pixmap'
		do
			Result := start_x_separator_before_internal + padding_width
		end

	start_x_text_internal: INTEGER
			-- Start x position where should draw `text'
		do
			Result := start_x_pixmap_internal
			if is_draw_pixmap then
				Result := Result + pixmap.width + padding_width
			end
		end

	start_x_close: INTEGER
			-- Start x position where should draw close
		require
			avialable: is_top_side_tab
		local
			l_width: INTEGER
			l_font: EV_FONT
		do
			l_font := internal_shared.tool_bar_font
			if l_font /= Void then
				l_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
				l_width := l_font.string_width (text)
				l_font.set_weight ({EV_FONT_CONSTANTS}.weight_regular)

				if is_top_side_tab then
					if is_enough_space then
							-- Crop the size if it exceeds the maximum tab header size
						Result := (start_x_text_internal + l_width + padding_width).min
									(internal_shared.Notebook_tab_maximum_size - close_width)
					else
						Result := current_total_width - close_width
					end
				end
			end
		end

	start_x_tail_internal: INTEGER
			-- Start x position where should draw tail area
		local
			l_width: INTEGER
			l_font: EV_FONT
		do
			if is_enough_space then
				if is_top_side_tab then
					Result := start_x_close + internal_shared.icons.close.width + padding_width
				else
					l_font := internal_shared.tool_bar_font

					l_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
					l_width := l_font.string_width (text)
					l_font.set_weight ({EV_FONT_CONSTANTS}.weight_regular)

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

	start_x_separator_after_internal: INTEGER
			-- Start x position where should draw separator after
		do
			if is_selected then
				if is_enough_space then
					Result := start_x_tail_internal + internal_shared.highlight_tail_width + padding_width - 1
				else
					Result := width - 1
				end
			else
				if attached tab.font as l_font then
					Result := start_x_text_internal + l_font.string_width (text) + padding_width - 1
				else
					check False end -- FIXME: Implied by ...?
				end
			end
		end

	start_y_position: INTEGER
			-- Start y position of drawing a pixmap
		deferred
		end

	start_y_position_text: INTEGER
			-- Start y position of drawing a pixmap
		deferred
		end

	start_y_close: INTEGER
			-- Start y position of drawing a close button
		do
			Result :=(height / 2  - (internal_shared.icons.close.height - close_background_expand * 2) / 2).floor - 1
		end

	close_rectangle: EV_RECTANGLE
			-- Close button rectangle
		require
			has_close_button: is_top_side_tab
		do
			create Result.make (start_x_close - close_background_expand, start_y_close - close_background_expand, close_width, internal_shared.icons.close.height + 2 * close_background_expand)
		ensure
			not_void: Result /= Void
		end

	close_width: INTEGER
			-- Width of the close button
		require
			has_close_button: is_top_side_tab
		do
			Result := internal_shared.icons.close.width + 2 * close_background_expand
		end

	close_rectangle_parent_box: EV_RECTANGLE
			-- Close button rectangle relative to parent box
		do
			Result := close_rectangle
			if tab.parent /= Void then
				Result.move (Result.x + tab.x, Result.y)
			end
		end

	text_clipping_width (a_total_width: INTEGER): INTEGER
			-- Clipping width of text when close button not exist
		do
			Result := a_total_width - start_x_text_internal
			if Result < 0 then
				Result := 0
			end
		ensure
			positive: Result >= 0
		end

	close_clipping_width (a_total_width: INTEGER): INTEGER
			-- Clipping width of text when close button exist
		require
			has_close_button: is_top_side_tab
		do
			Result := a_total_width - start_x_text_internal - close_width
			if Result < 0 then
				Result := 0
			end
		ensure
			positive: Result >= 0
		end

feature {NONE} -- Implementation

	start_draw
			-- We make a buffer pixmap
			-- Should call `end_draw' after every thing is done
		require
			size_valid: tab.width > 0 and tab.height > 0
		local
			l_buffer_pixmap: like buffer_pixmap
		do
			l_buffer_pixmap := buffer_pixmap
			if l_buffer_pixmap = Void then
				create l_buffer_pixmap.make_with_size (tab.width, tab.height)
				buffer_pixmap := l_buffer_pixmap
			else
				if tab.width > l_buffer_pixmap.width or tab.height > l_buffer_pixmap.height then
					l_buffer_pixmap.reset_for_buffering (tab.width, tab.height)
				end
			end
			if attached tab.font as l_font then
				l_buffer_pixmap.set_font (l_font)
			end
			l_buffer_pixmap.set_background_color (internal_shared.default_background_color)
			l_buffer_pixmap.clear_rectangle (0, 0, tab.width, tab.height)
		ensure
			created: buffer_pixmap /= Void
		end

	end_draw
			-- Draw `buffer_pixmap' to `internal_drawing_area'
			-- Call `start_draw' before call this function
		require
			buffer_pixmap_attached: attached buffer_pixmap
			tab_parent_attached: tab.parent /= Void
		do
			if
				attached buffer_pixmap as l_buffer_pixmap and then
				attached tab.parent as l_parent
			then
				l_parent.draw_sub_pixmap (tab.x, 0, l_buffer_pixmap, create {EV_RECTANGLE}.make (0, 0, tab.width, tab.height))
			else
				check
					from_precondition_buffer_pixmap_attached: attached buffer_pixmap
					from_precondition_tab_parent_attached: attached tab.parent
				end
			end
		end

	draw_pixmap_text_unselected (a_pixmap: EV_DRAWABLE; a_start_x, a_width: INTEGER)
			-- Draw pixmap and text when unselected
		require
			not_void: a_pixmap /= Void
		deferred
		end

	draw_pixmap_text_selected (a_pixmap: EV_DRAWABLE; a_start_x, a_width: INTEGER)
			-- Draw pixmap and text when selected
		require
			not_void: a_pixmap /= Void
		deferred
		end

	draw_close_button (a_drawable: EV_DRAWABLE; a_close_pixmap: EV_PIXMAP)
			-- Draw close button if possible
		require
			not_void: a_drawable /= Void
			not_void: a_close_pixmap /= Void
		deferred
		end

	close_background_expand: INTEGER = 3
			-- close button background expand size

	tab: SD_NOTEBOOK_TAB
			-- Drawing area to draw tab.

	internal_shared: SD_SHARED
			-- ALl singletons

	buffer_pixmap: detachable EV_PIXMAP;
			-- Buffer pixmap

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
