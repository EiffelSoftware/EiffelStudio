note
	description: "Used by SD_NOTEBOOK_TAB_AREA, to hold SD_NOTEBOOK_HIDE_TAB_LABELs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_HIDE_TAB_DIALOG

inherit
	EV_POPUP_WINDOW
		redefine
			show
		end

create
	make

feature {NONE} -- Initlization

	make (a_note_book: SD_NOTEBOOK)
			-- Creation method
		require
			a_note_book_not_void: a_note_book /= Void
		do
			create internal_shared
			create items_and_tabs.make (50)
			internal_notebook := a_note_book
			create internal_vertical_box
			create internal_text_box
			create internal_tool_bar.make
			create internal_scroll_area
			create {EV_VERTICAL_BOX} top_box

			make_with_shadow

			extend (top_box)
			top_box.extend (internal_vertical_box)
			top_box.set_border_width (internal_shared.border_width)
			top_box.set_background_color (internal_shared.border_color)

			internal_vertical_box.set_border_width (internal_shared.border_width)
			internal_vertical_box.set_padding_width (internal_shared.padding_width)

			internal_vertical_box.extend (internal_text_box)
			internal_vertical_box.disable_item_expand (internal_text_box)

			internal_text_box.enable_edit
			internal_text_box.change_actions.extend (agent on_search_text_change)

			internal_scroll_area.hide_horizontal_scroll_bar
			internal_scroll_area.hide_vertical_scroll_bar

			internal_vertical_box.extend (internal_scroll_area)
			internal_scroll_area.extend (internal_tool_bar)

			internal_tool_bar.key_press_actions.extend (agent on_tool_bar_key_press)

			internal_text_box.key_press_actions.extend (agent on_text_key_press)

			internal_text_box.focus_out_actions.extend (agent on_focus_out)
			internal_tool_bar.focus_out_actions.extend (agent on_focus_out)

			enable_border
			disable_user_resize
		ensure
			set: internal_notebook = a_note_book
			extended: has (top_box) and internal_vertical_box.has (internal_text_box)
				and internal_vertical_box.has (internal_scroll_area) and internal_scroll_area.has (internal_tool_bar)
		end

feature -- Command

	init
			-- Update size and initilize search issues before shown
		do
			init_search
			update_size
		end

	show
			-- <Precursor>
		do
			Precursor {EV_POPUP_WINDOW}
			internal_text_box.set_focus
		end

	extend_hide_tab (a_tab: SD_NOTEBOOK_TAB)
			-- Extend `a_tab' which is hidden
		require
			not_void: a_tab /= Void
		do
			extend_tab_imp (a_tab, False)
		end

	extend_shown_tab (a_tab: SD_NOTEBOOK_TAB)
			-- Extend `a_tab' which is shown
		require
			not_void: a_tab /= Void
		do
			extend_tab_imp (a_tab, True)
		end

feature {NONE} -- Implementation agents

	on_text_key_press (a_key: EV_KEY)
			-- Handle `internal_text_box' key press
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.Key_escape then
				destroy
			when {EV_KEY_CONSTANTS}.Key_enter then
				if attached current_focus_label as l_label and then attached find_tab_by_label (l_label) as l_selected_tab then
					select_content (internal_notebook.content_by_tab (l_selected_tab))
				end
				destroy
			when {EV_KEY_CONSTANTS}.Key_down then
				internal_tool_bar.set_focus
				focus_first
			when {EV_KEY_CONSTANTS}.Key_tab then
				internal_tool_bar.set_focus
				focus_first
			else
			end
		end

	current_focus_label: detachable SD_TOOL_BAR_FONT_BUTTON
			-- Current focused label or `Void' if none.
		do
			across
				internal_tool_bar.items as c
			loop
				if
					attached {SD_TOOL_BAR_FONT_BUTTON} c as l_toggle_button and then
					l_toggle_button.is_selected
				then
					Result := l_toggle_button
				end
			end
		end

	on_focus_out
			-- Handle focus out
		do
			if not internal_text_box.has_focus and not internal_tool_bar.has_focus then
				destroy
			end
		ensure
			destroyed: not internal_text_box.has_focus and not internal_tool_bar.has_focus implies
				is_destroyed
		end

	on_label_selected (a_index: INTEGER)
			-- Handle user click one label
		require
			a_index_valid: a_index > 0 and a_index <= items_and_tabs.count
		local
			l_content: SD_CONTENT
			l_old_content: detachable SD_CONTENT
		do
			l_old_content := internal_notebook.selected_item
			l_content := internal_notebook.content_by_tab (items_and_tabs.i_th (a_index).notebook_tab)

			if l_old_content /= Void and then l_content /= l_old_content then
				l_old_content.focus_out_actions.call (Void)
			end

			select_content (l_content)
			if not is_destroyed then
				hide
					-- It will be destroyed by focus out actions.
			end
		ensure
			not_displayed: not is_displayed
		end

	on_search_text_change
			-- Handle `internal_text_box' text change
		local
			l_search_result: ARRAYED_LIST [INTEGER]
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_passed_first: BOOLEAN
		do
			if attached text_finder as l_text_finder then
				internal_tool_bar.wipe_out

					-- For Windows, if `internal_tool_bar' items changed, drawing will not be cleared by {EV_DRAWING_AREA}, so clear it here
					-- For GTK platforms, it works fine without following clearing codes. Vision2 EV_DRAWING_AREA Windows implementation bug ?
				internal_tool_bar.clear_rectangle (0, 0, internal_tool_bar.width, internal_tool_bar.height)

				if internal_text_box.text.is_equal ("") then
					from
						items_and_tabs.start
					until
						items_and_tabs.after
					loop
						internal_tool_bar.extend (items_and_tabs.item.tool_bar_item)
						items_and_tabs.forth
					end
				else
					l_text_finder.search (internal_text_box.text)
					l_search_result := l_text_finder.found_indexs_in_texts
					l_search_result.compare_objects
					from
						items_and_tabs.start
					until
						items_and_tabs.after
					loop
						check attached {SD_TOOL_BAR_FONT_BUTTON} items_and_tabs.item.tool_bar_item as l_label then
							if l_search_result.has (items_and_tabs.index) then
								internal_tool_bar.extend (items_and_tabs.item.tool_bar_item)
								if not l_passed_first then
									l_label.enable_select
									l_passed_first := True
								end
							end
						end
						items_and_tabs.forth
					end
				end
				disable_select_all_item
				l_items := internal_tool_bar.items
				if l_items.count > 0 and l_items.first /= Void then
					check attached {SD_TOOL_BAR_FONT_BUTTON} l_items.first as l_label then
						l_label.enable_hot
					end
				end
				update_size
			end
		end

	focus_first
			-- Focus first item
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			l_items := internal_tool_bar.items
			if attached {SD_TOOL_BAR_FONT_BUTTON} l_items.first as l_item then
				l_item.enable_select
			end
		end

	disable_select_all_item
			--	Disable select all items
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			from
				l_items := internal_tool_bar.items
				l_items.start
			until
				l_items.after
			loop
				check attached {SD_TOOL_BAR_FONT_BUTTON} l_items.item as l_item then
					l_item.disable_select
				end
				l_items.forth
			end
		end

	next_selected_item (a_next: BOOLEAN): detachable SD_TOOL_BAR_FONT_BUTTON
			-- Next item base on current selected item
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_item: detachable SD_TOOL_BAR_ITEM
		do
			from
				l_items := internal_tool_bar.items
				l_items.start
			until
				l_items.after or Result /= Void
			loop
				if
					attached {SD_TOOL_BAR_FONT_BUTTON} l_items.item as l_font_item and then
					l_font_item.is_selected
				then
					if a_next then
						if not l_items.islast then
							l_item := l_items.i_th (l_items.index + 1)
						else
							l_item := l_items.first
						end
					else
						if not l_items.isfirst then
							l_item := l_items.i_th (l_items.index - 1)
						else
							l_item := l_items.last
						end
					end
					if attached {like next_selected_item} l_item as res then
						Result := res
					end
				end
				l_items.forth
			end
		end

	on_tool_bar_key_press (a_key: EV_KEY)
			-- Handle `internal_label_box' tab key press
		local
			l_text: STRING_32
			l_item: detachable SD_TOOL_BAR_TOGGLE_BUTTON
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.Key_tab then
				internal_text_box.set_focus
				disable_select_all_item
			when {EV_KEY_CONSTANTS}.Key_enter then
				if attached current_focus_label as l_label then
					on_label_selected (index_of (l_label))
				end
				destroy
			when {EV_KEY_CONSTANTS}.Key_escape then
				destroy
			when {EV_KEY_CONSTANTS}.Key_down then
				l_item := next_selected_item (True)
				if l_item /= Void then
					l_item.enable_select
					show_item_in_scroll_area (l_item)
				end
			when {EV_KEY_CONSTANTS}.Key_up then
				l_item := next_selected_item (False)
				if l_item /= Void then
					l_item.enable_select
					show_item_in_scroll_area (l_item)
				end
			else
				if a_key.is_alpha or a_key.is_number or a_key.is_numpad then
					l_text := a_key.text
					if a_key.is_numpad then
							-- Remomve "NumPad " from string
						l_text.remove_substring (1, 7)
					end
					disable_select_all_item
					internal_text_box.set_text (l_text)
					internal_text_box.set_focus
					internal_text_box.set_caret_position (internal_text_box.text.count + 1)
				end
			end

		end

	show_item_in_scroll_area (a_item: SD_TOOL_BAR_ITEM)
			-- Make sure `a_item' is shown in `internal_scroll_area'
		require
			not_void: a_item /= Void
		do
			if not (internal_scroll_area.y_offset <= a_item.rectangle.y and (internal_scroll_area.y_offset + internal_scroll_area.height) > a_item.rectangle.bottom) then
				if a_item.rectangle.bottom - internal_scroll_area.height >= 0 then
					internal_scroll_area.set_y_offset (a_item.rectangle.bottom - internal_scroll_area.height)
				else
					internal_scroll_area.set_y_offset (a_item.rectangle.y)
				end

			end
		end

feature {NONE} -- Implementation functions

	update_size
			-- Update current size base on current minmum size
		local
			l_max_height: INTEGER
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_item_height: INTEGER
			l_item_count: INTEGER
		do
			l_max_height := ((create {EV_SCREEN}).height * max_screen_height_proportion).ceiling
			internal_tool_bar.compute_minimum_size
			internal_scroll_area.set_item_height (internal_tool_bar.minimum_height)
			if minimum_height + internal_tool_bar.minimum_height <= l_max_height then
				set_height (minimum_height + internal_tool_bar.minimum_height)
				internal_scroll_area.hide_vertical_scroll_bar
			else
				l_items := internal_tool_bar.items
				check at_least_one: not l_items.is_empty end
				l_item_height := l_items.first.height
					-- We should calculate a precise maximum height for the last item showing.
					-- See bug#12618
				l_item_count := (l_max_height - minimum_height) // l_item_height
				set_height (l_item_count * l_item_height + minimum_height)

				internal_scroll_area.show_vertical_scroll_bar
			end

				-- FIXIT: How to get border width of a window? Why uncommnet follow 3 line, exceptions happen?
--			create l_popup_window
--			l_popup_window.enable_border
			if not is_destroyed then
--				set_width (internal_label_box.preferred_width + l_popup_window.minimum_width * 2)
				if not internal_scroll_area.is_vertical_scroll_bar_visible then
					set_width (internal_tool_bar.width + 12)
				else
					set_width (internal_tool_bar.width + 21)
				end
			end
		end

	extend_tab_imp (a_tab: SD_NOTEBOOK_TAB; a_show: BOOLEAN)
			-- Extend `a_tab'
		require
			not_void: a_tab /= Void
		local
			l_tab_indicator: SD_TOOL_BAR_FONT_BUTTON
			l_bold_font: EV_FONT
			l_pixel_buffer: detachable EV_PIXEL_BUFFER
			l_content: SD_CONTENT
		do
			create l_tab_indicator.make

			l_content := internal_notebook.content_by_tab (a_tab)
			if l_content /= Void then
				l_pixel_buffer := l_content.pixel_buffer
				if l_pixel_buffer /= Void then
					l_tab_indicator.set_pixel_buffer (l_pixel_buffer)
				end
			end

			l_tab_indicator.set_pixmap (a_tab.pixmap)
			l_tab_indicator.set_text (a_tab.text)
			l_tab_indicator.set_wrap (True)
			if not a_show then
				l_bold_font := internal_shared.tool_bar_font.twin
				l_bold_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
				l_tab_indicator.set_font (l_bold_font)
			end
			internal_tool_bar.extend (l_tab_indicator)

			items_and_tabs.extend ([l_tab_indicator, a_tab])
			l_tab_indicator.pointer_button_press_actions.extend
				(agent (a_x, a_y, a_button: INTEGER_32; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER_32; a_count: INTEGER_32)
					do on_label_selected (a_count) end
					(?, ?, ?, ?, ?, ?, ?, ?, items_and_tabs.count))
		ensure
--			extended: old internal_label_box.count = internal_label_box.count - 1
		end

	find_tab_by_label (a_label: SD_TOOL_BAR_ITEM): detachable SD_NOTEBOOK_TAB
			-- A tab corresponding to `a_label' or `Void' if none.
		require
			a_label_not_void: a_label /= Void
		do
			across
				items_and_tabs as c
			until
				attached Result
			loop
				if c.tool_bar_item = a_label then
					Result := c.notebook_tab
				end
			end
		end

	index_of (a_item: SD_TOOL_BAR_ITEM): INTEGER
			-- Index of `a_item' in `items_and_tabs'
		require
			not_void: a_item /= Void
			has: internal_tool_bar.has (a_item)
		local
			l_items: like items_and_tabs
			l_found: BOOLEAN
		do
			from
				l_items := items_and_tabs
				l_items.start
			until
				l_items.after or l_found
			loop
				Result := Result + 1
				if l_items.item.tool_bar_item = a_item then
					l_found := True
				end

				l_items.forth
			end
		end

	init_search
			-- Initialize search issues
		local
			l_texts: ARRAYED_LIST [STRING_32]
		do
			create l_texts.make (items_and_tabs.count)
			from
				items_and_tabs.start
			until
				items_and_tabs.after
			loop
				l_texts.extend (items_and_tabs.item.notebook_tab.text)
				items_and_tabs.forth
			end
			create text_finder.make (l_texts)
		ensure
			created: text_finder /= Void
		end

	widget_has_x_y (a_widget: EV_WIDGET; a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- If `a_widget' has `a_screen_x', `a_screen_y'?
		require
			a_widget_not_void: a_widget /= Void
		do
			Result := a_widget.screen_x <= a_screen_x and a_widget.screen_y <= a_screen_y and
				a_widget.screen_x + a_widget.width >= a_screen_x and a_widget.screen_y + a_widget.height >= a_screen_y
		end

	select_content (a_content: SD_CONTENT)
			-- Select `a_content'
		require
			not_void: a_content /= Void
		do
			internal_notebook.on_content_selected (a_content)
		end

feature {NONE} --Implementation attributes.

	top_box: EV_BOX
			-- Top level box

	internal_scroll_area: EV_SCROLLABLE_AREA
			-- Scrollable area which contain `internal_vertical_box'

	internal_tool_bar: SD_TOOL_BAR
			-- Tool bar to show the tabs

	internal_notebook: SD_NOTEBOOK
			-- Notebook which current belong to

	internal_vertical_box: EV_VERTICAL_BOX
			-- Box which has `internal_text_box' and `internal_label_box'

	internal_text_box: EV_TEXT_FIELD
			-- Text field for search input

	text_finder: detachable SD_TEXT_FINDER [STRING_32]
			-- Find text

	internal_shared: SD_SHARED
			-- All singletons

	items_and_tabs: ARRAYED_LIST [TUPLE [tool_bar_item: SD_TOOL_BAR_ITEM; notebook_tab: SD_NOTEBOOK_TAB]]
			-- Tool bar items and notebook tabs which are related

	max_screen_height_proportion: REAL = 0.50
			-- Max proprotion of height base on screen

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_vertical_box_not_void: internal_vertical_box /= Void
	internal_text_box_not_void: internal_text_box /= Void
	internal_label_box_not_void: internal_tool_bar /= Void
	items_and_tabs_not_void: items_and_tabs /= Void
	tool_bar_font_buttons: ∀ i: internal_tool_bar.items ¦ attached {SD_TOOL_BAR_FONT_BUTTON} i

note
	library: "SmartDocking: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
