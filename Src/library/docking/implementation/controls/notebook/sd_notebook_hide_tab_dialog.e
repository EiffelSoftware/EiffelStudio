indexing
	description: "Used by SD_NOTEBOOK_TAB_AREA, to hold SD_NOTEBOOK_HIDE_TAB_LABELs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_HIDE_TAB_DIALOG

inherit
	EV_POPUP_WINDOW
		rename
			extend as extend_dialog,
			has as has_dialog
		redefine
			show
		end
create
	make

feature {NONE}  -- Initlization

	make (a_note_book: SD_NOTEBOOK) is
			-- Creation method
		require
			a_note_book_not_void: a_note_book /= Void
		do
			default_create
			create internal_shared
			internal_notebook := a_note_book
			create internal_vertical_box
			create internal_text_box
			create internal_label_box.make
			create internal_tab_labels.make (1)

			extend_dialog (internal_vertical_box)
			internal_vertical_box.set_border_width (internal_shared.border_width)
			internal_vertical_box.set_padding_width (internal_shared.padding_width)
			internal_vertical_box.extend (internal_text_box)
			internal_vertical_box.disable_item_expand (internal_text_box)

			internal_text_box.enable_edit
			internal_text_box.change_actions.extend (agent on_search_text_change)

			internal_vertical_box.extend (internal_label_box)
			internal_label_box.key_press_actions.extend (agent on_label_box_key_press)
			internal_label_box.set_background_color (internal_shared.tool_tip_color)

			internal_text_box.key_press_actions.extend (agent on_text_key_press)

			internal_text_box.focus_out_actions.extend (agent on_focus_out)
			internal_label_box.focus_out_actions.extend (agent on_focus_out)

			enable_border
			enable_user_resize
		ensure
			set: internal_notebook = a_note_book
			extended: has_dialog (internal_vertical_box) and internal_vertical_box.has (internal_text_box)
				and internal_vertical_box.has (internal_label_box)
		end

feature -- Command

	init is
			-- Update size and initilize search issues before show.
		do
			init_search
			update_size
		end

	show is
			-- Redefine
		do
			Precursor {EV_POPUP_WINDOW}
			internal_text_box.set_focus
		end

	extend_hide_tab (a_tab: SD_NOTEBOOK_TAB) is
			-- Extend a_tab which is hide.
		require
			not_void: a_tab /= Void
		do
			extend_tab_imp (a_tab, False)
		end

	extend_shown_tab (a_tab: SD_NOTEBOOK_TAB) is
			-- Extend a_tab which is shown.
		require
			not_void: a_tab /= Void
		do
			extend_tab_imp (a_tab, True)
		end

feature {NONE} -- Implementation agents.

	on_text_key_press (a_key: EV_KEY) is
			-- Handle `internal_text_box' key press.
		local
			l_stop: BOOLEAN
			l_selected_tab: SD_NOTEBOOK_TAB
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.Key_escape then
				destroy
			when {EV_KEY_CONSTANTS}.Key_enter then
				if internal_label_box.current_focus_label /= Void then
					l_selected_tab := find_tab_by_label (internal_label_box.current_focus_label)
					internal_notebook.select_item (internal_notebook.content_by_tab (l_selected_tab), True)
					l_stop := True
				end
				destroy
			when {EV_KEY_CONSTANTS}.Key_down then
				internal_label_box.set_focus
			when {EV_KEY_CONSTANTS}.Key_tab then
				internal_label_box.set_focus
			else

			end
		end

	on_focus_out is
			-- Handle focus out.
		do
			if not internal_text_box.has_focus and not internal_label_box.has_focus then
				destroy
			end
		ensure
			destroyed: not internal_text_box.has_focus and not internal_label_box.has_focus implies
				is_destroyed
		end

	on_label_selected (a_index: INTEGER) is
			-- Handle user click one label.
		require
			a_index_valid: a_index > 0 and a_index <= internal_tab_labels.count
		do
			internal_notebook.select_item (internal_notebook.content_by_tab (internal_tab_labels.i_th (a_index)), True)
			destroy
		ensure
			destroyed: is_destroyed
		end

	on_search_text_change is
			-- Handle `internal_text_box' text change.
		local
			l_search_result: ARRAYED_LIST [INTEGER]
			l_passed_first: BOOLEAN
			l_label: SD_CONTENT_LABEL
		do
			if internal_text_box.text.is_equal ("") then
				from
					internal_label_box.start
				until
					internal_label_box.after
				loop
					internal_label_box.item.show
					internal_label_box.forth
				end
			else
				text_finder.search (internal_text_box.text)
				l_search_result := text_finder.found_indexs_in_texts
				l_search_result.compare_objects
				from
					internal_label_box.start
				until
					internal_label_box.after
				loop
					l_label ?= internal_label_box.item
					check not_void: l_label /= Void end
					if l_search_result.has (internal_label_box.index) then
						internal_label_box.item.show
						if not l_passed_first then
							l_label.enable_non_focus_color
							l_passed_first := True
						else
							l_label.disable_focus_color
						end
					else
						l_label.disable_focus_color
						internal_label_box.item.hide
					end
					internal_label_box.forth
				end
			end
			update_size
		end

	on_label_box_key_press (a_key: EV_KEY) is
			-- Handle `internal_label_box' tab key press.
		local
			l_label: SD_CONTENT_LABEL
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.Key_tab then
				internal_text_box.set_focus
			when {EV_KEY_CONSTANTS}.Key_enter then
				l_label := internal_label_box.current_focus_label
				on_label_selected (internal_label_box.index_of (l_label))
				destroy
			when {EV_KEY_CONSTANTS}.Key_escape then
				destroy
			end

		end

feature {NONE} -- Implementation functions.

	update_size is
			-- Update current size base on current minmum size.
		local
			l_max_height: INTEGER
			l_screen: EV_SCREEN
--			l_popup_window: EV_POPUP_WINDOW
		do
			create l_screen
			l_max_height := (l_screen.height * max_screen_height_proportion).ceiling

			if minimum_height + internal_label_box.prefered_height <= l_max_height then
				set_height (minimum_height + internal_label_box.prefered_height)
				internal_label_box.hide_scroll_bar
			else
				set_height (l_max_height)
				internal_label_box.show_scroll_bar
			end
			-- FIXIT: How to get border width of a window? Why uncommnet follow 3 line, exceptions happen?
--			create l_popup_window
--			l_popup_window.enable_border
			if not is_destroyed then
--				set_width (internal_label_box.prefered_width + l_popup_window.minimum_width * 2)
				set_width (internal_label_box.prefered_width + 12)
			end
		end

	extend_tab_imp (a_tab: SD_NOTEBOOK_TAB; a_show: BOOLEAN) is
			-- Extend a_tab.
		require
			not_void: a_tab /= Void
		local
			l_tab_indicator: SD_CONTENT_LABEL
		do
			create l_tab_indicator.make (not a_show, internal_label_box)
			l_tab_indicator.set_pixmap (a_tab.pixmap)
			l_tab_indicator.set_text (a_tab.text)

			internal_label_box.extend (l_tab_indicator)
			internal_label_box.disable_item_expand (l_tab_indicator)
			internal_tab_labels.extend (a_tab)
			l_tab_indicator.pointer_button_press_actions.force_extend (agent on_label_selected (internal_tab_labels.count))
		ensure
--			extended: old internal_label_box.count = internal_label_box.count - 1
		end

	find_tab_by_label (a_label: SD_CONTENT_LABEL): SD_NOTEBOOK_TAB is
			-- Find a tab by a_label.
		require
			a_label_not_void: a_label /= Void
			has: internal_label_box.has (a_label)
		local
			l_index: INTEGER
		do
			l_index := internal_label_box.index_of (a_label)
			Result := internal_tab_labels.i_th (l_index)
		ensure
			not_void: Result /= Void
		end

	init_search is
			-- Initialize search issues.
		local
			l_texts: ARRAYED_LIST [STRING]
		do
			create l_texts.make (internal_tab_labels.count)
			from
				internal_tab_labels.start
			until
				internal_tab_labels.after
			loop
				l_texts.extend (internal_tab_labels.item.text)
				internal_tab_labels.forth
			end
			create text_finder.make (l_texts)
		ensure
			created: text_finder /= Void
		end

	widget_has_x_y (a_widget: EV_WIDGET;  a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- If a_widget has a_screen_x, a_screen_y?
		require
			a_widget_not_void: a_widget /= Void
		do
			Result := a_widget.screen_x <= a_screen_x and a_widget.screen_y <= a_screen_y and
				a_widget.screen_x + a_widget.width >= a_screen_x and a_widget.screen_y + a_widget.height >= a_screen_y
		end

feature {NONE}  --Implementation attributes.

	internal_label_box: SD_NOTEBOOK_HIDE_TAB_LABEL_BOX
			-- Vertical box hold SD_NOTEBOOK_HIDE_TAB_LABELs.

	internal_notebook: SD_NOTEBOOK
			-- Notebook which current is belong to.

	internal_tab_labels: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			-- All tab labels.

	internal_vertical_box: EV_VERTICAL_BOX
			-- Box which has `internal_text_box' and `internal_label_box'.

	internal_text_box: EV_TEXT_FIELD
			-- Text field for search input.

	text_finder: SD_TEXT_FINDER
			-- Find text.

	internal_shared: SD_SHARED
			-- All singletons.

	max_screen_height_proportion: REAL is 0.50
			-- Max proprotion of height base on screen.

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_vertical_box_not_void: internal_vertical_box /= Void
	internal_text_box_not_void: internal_text_box /= Void
	internal_label_box_not_void:	internal_label_box /= Void
	internal_tab_labels_not_void: internal_tab_labels /= Void

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
