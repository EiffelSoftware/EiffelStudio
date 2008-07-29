indexing
	description: "[
		Graphical panel for EiffelStudio's testing tool.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_PANEL_63

inherit
	ES_DOCKABLE_STONABLE_TOOL_PANEL [EV_VERTICAL_BOX]
		redefine
			on_before_initialize,
			on_after_initialized
		end

	EIFFEL_TEST_SUITE_OBSERVER
		redefine
			on_tests_reset
		end

	TAG_UTILITIES

create {ES_TESTING_TOOL_63}
	make

feature {NONE} -- Initialization

	on_before_initialize
			-- <Precursor>
		local
			l_et: KL_EQUALITY_TESTER [!STRING]
		do
			Precursor
			l_et ?= create {KL_STRING_EQUALITY_TESTER}
			create view_templates.make (5)
			view_templates.set_equality_tester (l_et)
			create view_template_descriptions.make (5)
			view_template_descriptions.set_equality_tester (l_et)
			create view_history.make
			view_history.set_equality_tester (l_et)
		end

feature {NONE} -- Initialization: widgets

	build_tool_interface (a_widget: like create_widget) is
			-- <Precursor>
		do
			build_control_bar (a_widget)
			build_view_bar (a_widget)

			create tree_view.make

			a_widget.extend (tree_view.widget)
		end

	build_control_bar (a_widget: like create_widget) is
			-- Build tool bar with control buttons
		do

		end

	build_view_bar (a_widget: like create_widget) is
			-- Build tool bar containing view and filter box
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
		do
			create l_hbox
			l_hbox.set_padding (10)
			l_hbox.set_border_width (5)

				-- Create and add `view_box' with label
			create view_box
			create l_label.make_with_text ("View")
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)
			l_hbox.extend (view_box)
			register_action (view_box.select_actions, agent on_select_view)
			register_action (view_box.return_actions, agent on_return_view)

				-- Create and add `filter_box' with label
			create filter_box
			create l_label.make_with_text ("Filter")
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)
			l_hbox.extend (filter_box)

			a_widget.extend (l_hbox)
			a_widget.disable_item_expand (l_hbox)
		end

feature {NONE} -- Initialization: widget status

	on_after_initialized
			-- <Precursor>
		do
			Precursor
			tree_view.set_layout (create {ES_EIFFEL_TEST_GRID_LAYOUT}.make (test_suite))
			propagate_drop_actions (Void)
			initialize_view_bar
		end

	initialize_view_bar
		do
			view_templates.put_last ("")
			view_template_descriptions.put_last ("")
			view_templates.put_last ("class.")
			view_template_descriptions.put_last ("Tests%T%T%T(class.)")
			view_templates.put_last ("outcome.")
			view_template_descriptions.put_last ("Outcomes%T%T(outcome.)")
			view_templates.put_last ("covers.")
			view_template_descriptions.put_last ("Classes under test%T(covers.)")
			view_templates.put_last ("type.")
			view_template_descriptions.put_last ("Types%T%T(type.)")

			update_view_box
			view_box.i_th (2).enable_select
		end

feature -- Access

	tree_view: ES_TBT_GRID [EIFFEL_TEST_I]

feature {NONE} -- Access

	frozen test_suite: !SERVICE_CONSUMER [!EIFFEL_TEST_SUITE_S]
			-- Access to a test suite service {EIFFEL_TEST_SUITE_S} consumer
		once
			create Result
		end

feature {NONE} -- Access: widgets

	view_box: !EV_COMBO_BOX
			-- Combo box which defines prefix for `tree_view'

	filter_box: !EV_COMBO_BOX
			-- Combo box containing pattern for filtering tests

feature {NONE} -- Access: view

	view_templates: !DS_ARRAYED_LIST [!STRING]
			-- List of predefined tags to be used in `tree_view'

	view_template_descriptions: !DS_ARRAYED_LIST [!STRING]
			-- List of readable descriptions for each tag in `view_templates'

	view_history: !DS_LINKED_LIST [!STRING]
			-- List of tags user has entered recently

feature {NONE} -- Status setting: view

	on_return_view is
			--
		local
			l_orig_tag, l_tag: !STRING
		do
			l_orig_tag ?= view_box.text.to_string_8
			l_tag := l_orig_tag
			if not l_tag.is_empty then
				if l_tag.starts_with (split_char.out) then
					l_tag := l_tag.substring (2, l_tag.count)
				end
				if l_tag.ends_with (split_char.out) then
					l_tag := l_tag.substring (1, l_tag.count - 1)
				end
			end
			if is_valid_tag (l_tag) then
				if not l_tag.is_empty then
					l_tag.append_character (split_char)
					if not view_templates.has (l_tag) then
						view_history.start
						view_history.search_forth (l_tag)
						if not view_history.after then
							view_history.remove_at
						end
						view_history.put_first (l_tag)
						if view_history.count > 3 then
							view_history.remove_last
						end
						update_view_box
					end
				end
				view_box.set_text (l_tag)
				execute_with_busy_cursor (agent update_view)
			else
				-- TODO: report bad view definition
			end
		end

	on_select_view is
			--
		local
			l_tag: STRING
		do
			l_tag ?= view_box.selected_item.data
			check
				tag_attached: l_tag /= Void
			end
			view_box.set_text (l_tag)
			execute_with_busy_cursor (agent update_view)
		end

	update_view_box is
			-- Update proposal list for `view_box'
		local
			l_cursor: !DS_LINEAR_CURSOR [!STRING]
			i: INTEGER
			l_item: EV_LIST_ITEM
		do
			view_box.wipe_out
			from
				l_cursor ?= view_history.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				create l_item.make_with_text (l_cursor.item)
				l_item.set_data (l_cursor.item)
				view_box.extend (l_item)
				l_cursor.forth
			end
			from
				i := 1
			until
				i > view_templates.count
			loop
				create l_item.make_with_text (view_template_descriptions.item (i))
				l_item.set_data (view_templates.item (i))
				view_box.extend (l_item)
				i := i + 1
			end
		end

	update_view is
			--
		local
			l_tag: !STRING
		do
			if test_suite.is_service_available then
				l_tag ?= view_box.text.to_string_8
				if l_tag.ends_with (split_char.out) then
					l_tag := l_tag.substring (1, l_tag.count - 1)
				end

				if tree_view.is_connected then
					if not tree_view.tag_prefix.is_equal (l_tag) then
						tree_view.disconnect
					end
				end
				if not tree_view.is_connected then
					tree_view.connect (test_suite.service, l_tag)
				end
			elseif tree_view.is_connected then
				tree_view.disconnect
			end
		end

feature {NONE} -- Status setting: stones

	on_stone_changed (a_old_stone: ?like stone)
			-- <Precursor>
		local
			l_class: !CLASS_C
		do
			if {l_class_stone: !CLASSC_STONE} stone then
				l_class ?= l_class_stone.e_class

				view_box.set_text ("covers.")
				filter_box.set_text ("covers." + l_class.name)
				update_view
			end
		end

feature {ACTIVE_COLLECTION_I} -- Events

	on_tests_reset (a_collection: !ACTIVE_COLLECTION_I [!EIFFEL_TEST_I])
			-- <Precursor>
		require else
			--a_collection_is_test_suite: a_collection = test_suite
		do

		end

feature -- Factory

	create_widget: !EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
			--create Result.make (0)
		end

invariant
	predefined_view_count_correct: view_template_descriptions.count = view_templates.count

end
