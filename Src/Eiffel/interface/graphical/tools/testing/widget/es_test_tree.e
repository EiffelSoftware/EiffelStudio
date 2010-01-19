note
	description: "[
		Widget displaying {TEST_SUITE_S}.tag_tree, providing a text box for filtering shown items.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_TREE

inherit
	ES_TEST_SESSION_WIDGET
		rename
			make as make_session_widget
		redefine
			on_before_initialize,
			on_after_initialized
		end

create
	make

feature {NONE} -- Initialization: pre

	make (a_window: like develop_window; a_icon_provider: ES_TOOL_ICONS_PROVIDER_I [ES_TESTING_TOOL_ICONS])
			-- Initialize `Current'.
		do
			create tag_filter.make
			create tag_tree.make (a_window,
			                      tag_filter,
			                      create {ES_TEST_TAG_TREE_GRID_LAYOUT}.make (a_icon_provider))
			tag_tree.set_hide_outside_nodes (True)
			tag_tree.set_update_timer (2)
			make_session_widget (a_window)
		end

	on_before_initialize
			-- <Precursor>
		local
			l_et: KL_STRING_EQUALITY_TESTER_A [STRING]
		do
			Precursor {ES_TEST_SESSION_WIDGET}
			create l_et
			create view_templates.make (5)
			view_templates.set_equality_tester (l_et)
			create view_template_descriptions.make (5)
			view_template_descriptions.set_equality_tester (l_et)
			create view_history.make
			view_history.set_equality_tester (l_et)
		end

feature {NONE} -- Initialization

	build_widget_interface (a_widget: EV_VERTICAL_BOX)
			-- <Precursor>
		do
			build_view_bar (a_widget)

			a_widget.extend (tag_tree.widget)
		end

	build_view_bar (a_widget: like create_widget)
			-- Build tool bar containing view and filter box
		local
			l_tool_bar: SD_TOOL_BAR
			l_hbox: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
		do
			create l_hbox
			l_hbox.set_padding (10)
			l_hbox.set_border_width (5)

				-- Create and add `filter_box' with label
			create l_label.make_with_text (locale_formatter.translation (l_filter))
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)
			create filter_box
			register_action (filter_box.return_actions, agent on_return_filter)
			register_action (filter_box.select_actions, agent on_select_filter)
			l_hbox.extend (filter_box)

			create clear_filter_button.make
			clear_filter_button.set_pixel_buffer (stock_pixmaps.general_reset_icon_buffer)
			clear_filter_button.set_pixmap (stock_pixmaps.general_reset_icon)
			clear_filter_button.set_tooltip (locale_formatter.translation (tt_clear_filter))
			register_action (clear_filter_button.select_actions, agent on_clear_filter)
			create l_tool_bar.make
			l_tool_bar.extend (clear_filter_button)
			l_tool_bar.compute_minimum_size
			l_hbox.extend (l_tool_bar)
			l_hbox.disable_item_expand (l_tool_bar)

			a_widget.extend (l_hbox)
			a_widget.disable_item_expand (l_hbox)
		end

feature {NONE} -- Initialization (post)

	on_after_initialized
			-- <Precursor>
		do
			Precursor {ES_TEST_SESSION_WIDGET}
			perform_with_test_suite (
				agent (a_test_suite: TEST_SUITE_S)
					do
						tag_tree.connect (a_test_suite.tag_tree)
					end)
			initialize_view_bar
		end

	initialize_view_bar
			-- Initialize view bar combo boxes
		do
			view_templates.force_last ("")
			view_template_descriptions.force_last ("")
			view_templates.force_last (default_filter_expression)
			view_template_descriptions.force_last (locale_formatter.translation (c_class))
			view_templates.force_last ("^covers")
			view_template_descriptions.force_last (locale_formatter.translation (c_covers))
			view_templates.force_last ("^result")
			view_template_descriptions.force_last (locale_formatter.translation (c_results))
			--view_templates.force_last ("^type")
			--view_template_descriptions.force_last (locale_formatter.translation (c_types))
			view_templates.force_last ("^user")
			view_template_descriptions.force_last (locale_formatter.translation (c_user))

			update_filter_box
			filter_box.i_th (2).enable_select
		end

feature -- Access

	tag_tree: ES_TAG_TREE_GRID [TEST_I]
			-- Widget showing tag tree

feature {NONE} -- Access: widgets

	tag_filter: TAG_REGEX_FILTER [TEST_I]
			-- Filter used to sort out visible tags

	filter_box: EV_COMBO_BOX
			-- Combo box containing pattern for filtering tests

	clear_filter_button: SD_TOOL_BAR_BUTTON
			-- Button for clearing any filter

feature {NONE} -- Access: filter

	view_templates: DS_ARRAYED_LIST [STRING]
			-- List of predefined tags to be used in `tree_view'

	view_template_descriptions: DS_ARRAYED_LIST [STRING]
			-- List of readable descriptions for each tag in `view_templates'

	view_history: DS_LINKED_LIST [STRING]
			-- List of tags user has entered recently

feature {NONE} -- Status report

	is_updating_filter_box: BOOLEAN
			-- Is `filter_box' currently being updated?

feature -- Status setting

	set_filter (an_expression: STRING_GENERAL)
			-- Set expression for filtering tags.
		do
			filter_box.set_text (an_expression)
			update_tag_tree
		end

feature {NONE} -- Status setting: view

	on_return_filter
			-- Called when user presses enter in `filter_box'.
		local
			l_expr: STRING
		do
			l_expr := filter_box.text.as_string_8
			if not l_expr.is_empty then
				if not view_templates.has (l_expr) then
					view_history.start
					view_history.search_forth (l_expr)
					if not view_history.after then
						view_history.remove_at
					end
					view_history.put_first (l_expr)
					if view_history.count > 3 then
						view_history.remove_last
					end
					update_filter_box
					filter_box.set_text (l_expr)
				end
			end
			execute_with_busy_cursor (agent update_tag_tree)
		end

	on_select_filter
			-- Called when a view new view is selected
		do
			if
				not is_updating_filter_box and
				attached filter_box.selected_item as l_item and then
				attached {STRING} l_item.data as l_tag
			then
				filter_box.set_text (l_tag)
				execute_with_busy_cursor (agent update_tag_tree)
			end
		end

	on_clear_filter
			-- Called when `clear_filter_button' is pressed.
		do
			filter_box.set_text ("")
			execute_with_busy_cursor (agent update_tag_tree)
		end

	update_filter_box
			-- Update proposal list for `view_box'
		require
			not_updating: not is_updating_filter_box
		local
			l_cursor: DS_LINEAR_CURSOR [STRING]
			i: INTEGER
			l_item: EV_LIST_ITEM
		do
			is_updating_filter_box := True
			filter_box.wipe_out
			from
				l_cursor := view_history.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				create l_item.make_with_text (l_cursor.item)
				l_item.set_data (l_cursor.item)
				filter_box.extend (l_item)
				l_cursor.forth
			end
			from
				i := 1
			until
				i > view_templates.count
			loop
				create l_item.make_with_text (view_template_descriptions.item (i))
				l_item.set_data (view_templates.item (i))
				filter_box.extend (l_item)
				i := i + 1
			end
			is_updating_filter_box := False
		ensure
			not_updating: not is_updating_filter_box
		end

	update_tag_tree
			-- Refresh `tree_view' according to current view definition.
		local
			l_expr: STRING
		do
			develop_window.lock_update
			l_expr := filter_box.text.to_string_8
			check l_expr /= Void end
			if not l_expr.is_empty then
				tag_filter.set_expression (l_expr)
				tag_tree.reset
			elseif tag_filter.has_expression then
				tag_filter.remove_expression
				tag_tree.reset
			end
			develop_window.unlock_update
		end

feature {NONE} -- Query

	is_valid_session (a_session: TEST_SESSION_I): BOOLEAN
			-- <Precursor>
		do
			Result := attached {TEST_RETRIEVAL_I} a_session
		end

feature {NONE} -- Factory

	create_widget: like widget
			-- <Precursor>
		do
			create Result
		end

feature {NONE} -- Internationalization

	tt_clear_filter: STRING = "Clear filter"
	l_filter: STRING = "Filter"

	c_class: STRING = "Test classes"
	c_covers: STRING = "Classes under test"
	c_results: STRING = "Results"
	c_types: STRING = "Type of test"
	c_user: STRING = "User-defined tags"

invariant
	predefined_view_count_correct: view_template_descriptions.count = view_templates.count

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
