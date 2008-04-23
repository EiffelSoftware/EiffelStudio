indexing
	description: "[
						Third page of new unit test wizard

																			]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NEW_UNIT_TEST_WIZARD_THREE

inherit
	EB_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			make,
			wizard_information
		end

	SHARED_SERVER
		export
			{NONE}
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE}
		end

	SHARED_WORKBENCH
		export
			{NONE}
		end

create
	make

feature {NONE} -- Initialization

	make (an_info: like wizard_information) is
			-- Redefine
		do
			wizard_information := an_info
		end

feature {NONE} -- Implementation

	wizard_information: ES_NEW_UNIT_TEST_WIZARD_INFORMATION
			-- Redefine

	update_ui_with_wizard_information
			-- Fill text entries if possible
			-- This is useful when end users navigating back and forth
		local
			l_tree_items: like all_items_under
			l_features_to_test: ARRAYED_LIST [E_FEATURE]
			l_found: BOOLEAN
		do
			if wizard_information.features_to_test /= Void and then not wizard_information.features_to_test.is_empty then
				l_features_to_test := wizard_information.features_to_test
				l_tree_items := all_items_under (Void)
				from
					l_tree_items.start
				until
					l_tree_items.after
				loop
					if {l_feature: E_FEATURE} l_tree_items.item.data then

						from
							l_found := False
							l_features_to_test.start
						until
							l_features_to_test.after or l_found
						loop
							if l_features_to_test.item.is_equal (l_feature) then
								l_found := True
								feature_tree.check_item (l_tree_items.item)
							end

							l_features_to_test.forth
						end
					end
					l_tree_items.forth
				end
			end
			if wizard_information.is_add_frozen_feature_stubs_selected then
				add_frozen_feature_stubs.enable_select
			end
			if wizard_information.is_add_to_be_implemented_selected then
				add_to_be_implemented_checks.enable_select
			end
		end

feature {NONE} -- Wizard UI Implementation

	display_state_text
			-- Redefine
		do
			title.set_text (interface_names.t_test_features)
			subtitle.set_text (interface_names.t_Select_features_for_which)
		end

	update_features_to_test is
			-- Update features to test information
		do
			wizard_information.features_to_test.wipe_out
			wizard_information.features_to_test.append (all_features_checked)
		end

	proceed_with_current_info
			-- Redefine
		do
			proceed_with_new_state(create {ES_NEW_UNIT_TEST_WIZARD_FINAL}.make (wizard_information))
		end

	build
			-- Redefine
		local
			l_h_box: EV_HORIZONTAL_BOX
			l_v_box: EV_VERTICAL_BOX
			l_label: EV_LABEL
			l_button: EV_BUTTON
			l_top_container: EV_BOX
		do
			l_top_container := wizard_information.helper.parent_parent_of (choice_box)

			-- Available features
			create l_h_box
			l_h_box.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

			create l_label.make_with_text (interface_names.l_available_features)
			l_h_box.extend (l_label)
			l_h_box.disable_item_expand (l_label)

			l_h_box.extend (create {EV_CELL})

			l_top_container.extend (l_h_box)
			l_top_container.disable_item_expand (l_h_box)

			-- Feature tree
			create l_h_box
			l_h_box.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

			create feature_tree
			feature_tree.check_actions.extend (agent on_item_checked)
			feature_tree.uncheck_actions.extend (agent on_item_unchecked)
			l_h_box.extend (feature_tree)

			create l_v_box
			l_v_box.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

			create l_button.make_with_text (interface_names.b_check_all)
			l_button.select_actions.extend (agent on_check_all)
			l_v_box.extend (l_button)
			l_v_box.disable_item_expand (l_button)

			create l_button.make_with_text (interface_names.b_uncheck_all)
			l_button.select_actions.extend (agent on_uncheck_all)
			l_v_box.extend (l_button)
			l_v_box.disable_item_expand (l_button)

			l_h_box.extend (l_v_box)
			l_h_box.disable_item_expand (l_v_box)

			l_top_container.extend (l_h_box)

			-- How many features selected
			create l_h_box
			l_h_box.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

			create feature_selected_counter.make_with_text (interface_names.l_features_selected (0))
			l_h_box.extend (feature_selected_counter)
			l_h_box.disable_item_expand (feature_selected_counter)

			l_h_box.extend (create {EV_CELL})

			l_top_container.extend (l_h_box)
			l_top_container.disable_item_expand (l_h_box)

			-- Additional options
			create l_h_box
			l_h_box.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

			create l_v_box
			l_v_box.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

			create add_frozen_feature_stubs.make_with_text (interface_names.l_add_forzen_feature_stubs)
			add_frozen_feature_stubs.select_actions.extend (agent on_add_frozen_feature_stubs_selected)
			l_v_box.extend (add_frozen_feature_stubs)

			create add_to_be_implemented_checks.make_with_text (interface_names.l_add_to_be_implemented_checks)
			add_to_be_implemented_checks.select_actions.extend (agent on_add_to_be_implemented_checks_selected)
			l_v_box.extend (add_to_be_implemented_checks)

			l_h_box.extend (l_v_box)
			l_h_box.disable_item_expand (l_v_box)
			l_h_box.extend (create {EV_CELL})

			l_top_container.extend (l_h_box)
			l_top_container.disable_item_expand (l_h_box)

			-- Enable item vertical expand
			build_tree_ui

			update_ui_with_wizard_information

			expand_all_items
		end

	feature_selected_counter: EV_LABEL
			-- Display how many features are selected

	feature_tree: EV_CHECKABLE_TREE
			-- Tree to display available features.

	on_check_all
			-- Select all features' tree items.
		do
			check_all_imp (True)
		end

	on_item_unchecked (a_item: EV_TREE_ITEM)
			-- Handle uncheched actions of `a_item'
		require
			not_void: a_item /= Void
		local
			l_list: like all_features_checked
		do
			check_feature_clause_sub_notes (a_item, False)
			l_list := all_features_checked
			feature_selected_counter.set_text (interface_names.l_features_selected (l_list.count))
			update_features_to_test
		end

	on_item_checked (a_item: EV_TREE_ITEM)
			-- Handle checked actions of `a_item'
		require
			not_void: a_item /= Void
		local
			l_list: like all_features_checked
		do
			check_feature_clause_sub_notes (a_item, True)
			l_list := all_features_checked

			feature_selected_counter.set_text (interface_names.l_features_selected (l_list.count))
			update_features_to_test
		end

	on_add_to_be_implemented_checks_selected is
			-- On `add_to_be_implemented_checks' selected
		do
			wizard_information.set_add_to_be_implemented_selected (add_to_be_implemented_checks.is_selected)
		end

	on_add_frozen_feature_stubs_selected is
			-- On `add_frozen_feature_stubs' selected
		do
			wizard_information.set_add_frozen_feature_stubs_selected (add_frozen_feature_stubs.is_selected)
		end

	check_feature_clause_sub_notes (a_item: EV_TREE_ITEM; a_check: BOOLEAN)
			-- If `a_item' is feature clause, check all sub nodes under it.
		require
			not_void: a_item /= Void
		local
			l_items: like all_items_under
		do
			if {l_feature_clause_data: !FEATURE_CLAUSE_AS} a_item.data then
				-- It's a feature clause, we should select all sub nodes.
				l_items := all_items_under (a_item)
				l_items.do_all (agent (a_tree_item: EV_TREE_ITEM; a_to_check: BOOLEAN)
									do
										if a_to_check then
											feature_tree.check_item (a_tree_item)
										else
											feature_tree.uncheck_item (a_tree_item)
										end
									end (?, a_check))
			end
		end

	expand_all_items is
			-- Expand all feature tree items
		local
			l_items: like all_items_under
		do
			l_items := all_items_under (Void)

			from
				l_items.start
			until
				l_items.after
			loop
				if l_items.item.is_expandable and then not l_items.item.is_expanded then
					l_items.item.expand
				end
				l_items.forth
			end
		end

	all_features_checked: ARRAYED_LIST [E_FEATURE]
			-- All features' tree items checked
		local
			l_items: like all_items_under
		do
			l_items := all_items_under (Void)
			create Result.make (l_items.count)

			from
				l_items.start
			until
				l_items.after
			loop
				if {l_feature: !E_FEATURE} l_items.item.data then
					if feature_tree.is_item_checked (l_items.item) then
						Result.extend (l_feature)
					end
				end
				l_items.forth
			end
		ensure
			not_void: Result /= Void
		end

	all_items_under (a_tree_node: EV_TREE_ITEM): ARRAYED_LIST [EV_TREE_ITEM]
			-- All tree nodes under `a_tree_node'
			-- If `a_tree_node' Void, then Result is all tree nodes in `feature_tree'
		do
			create tmp_all_items.make (feature_tree.count)

			if a_tree_node /= Void then
				a_tree_node.recursive_do_all (agent (a_item: EV_TREE_ITEM)
										do
											tmp_all_items.extend (a_item)
										end)
			else
				feature_tree.recursive_do_all (agent (a_item: EV_TREE_ITEM)
										do
											tmp_all_items.extend (a_item)
										end)
			end

			Result := tmp_all_items
		ensure
			not_void: Result /= Void
		end

	tmp_all_items: ARRAYED_LIST [EV_TREE_ITEM]
			-- All items temporary used by `all_items_under'
			-- It should not called by any other features directly.

	check_all_imp (a_check: BOOLEAN) is
			-- Recursive select all tree items.
		local
			l_all_items: like all_items_under
		do
			l_all_items := all_items_under (Void)
			l_all_items.do_all (agent (a_item: EV_TREE_ITEM; a_select: BOOLEAN)
									do
										if a_select then
											feature_tree.check_item (a_item)
										else
											feature_tree.uncheck_item (a_item)
										end
									end  (?, a_check))
		end

	on_uncheck_all
			-- Deselect all features.
		do
			check_all_imp (False)
		end

	add_frozen_feature_stubs: EV_CHECK_BUTTON
			-- Check button for `add frozen feature stubs'

	add_to_be_implemented_checks: EV_CHECK_BUTTON
			-- Check button for `add "to be implemented" checks'

feature {NONE}	-- Tree manipulation

	build_tree_ui is
			-- Build tree UI
		local
			l_class_name: STRING
			l_list: LIST [CLASS_I]
			l_class_i: EIFFEL_CLASS_I
			l_item: EV_TREE_ITEM
			l_shared: ES_SHARED_FONTS_AND_COLORS
		do
			-- We reset `last_class', so `build_tree' with work
			last_class := Void
			l_class_name := wizard_information.class_under_test
			check not_void: l_class_name /= Void end
			l_list := universe.classes_with_name (l_class_name)
			if l_list.count = 1 then
				l_class_i ?= l_list.first
				check not_void: l_class_i /= Void end

	 			if l_class_i.is_compiled then
	 				build_tree (l_class_i.compiled_class)
	 			else
					create l_item.make_with_text (interface_names.l_compile_first)
					create l_shared
					feature_tree.set_foreground_color (l_shared.colors.high_priority_foreground_color)
					feature_tree.extend (l_item)
	 			end

			else
				check not_implemented: False end
			end

		end

	build_tree (a_class_c: CLASS_C)
			-- Build tree base on `a_class_c'
			-- Modified from {ES_FEATURES_TOOL_PANEL}.on_stone_changed
		require
			not_void: a_class_c /= Void and then a_class_c.already_compiled
		local
			l_container: EV_CONTAINER
			l_tree: like feature_tree
			l_class_ast: CLASS_AS
		do

			if a_class_c /= last_class then
					l_tree := feature_tree
					-- Removes the tree from the parent to perform off-screen drawing.
					l_container := l_tree.parent
					l_container.prune (l_tree)

					l_tree.wipe_out
					if not a_class_c.is_external and then a_class_c.has_ast then

						if a_class_c.is_precompiled then
							l_class_ast := a_class_c.ast
						elseif a_class_c.eiffel_class_c.file_is_readable then
							l_class_ast := a_class_c.eiffel_class_c.parsed_ast (False)
						end

						if l_class_ast /= Void then
							if l_tree.selected_item /= Void then
								l_tree.selected_item.disable_select
							end

							if {l_clauses: !EIFFEL_LIST [FEATURE_CLAUSE_AS]} l_class_ast.features then
									-- Build tree from AST nodes
								build_tree_imp (l_clauses, a_class_c)
							else
									-- No items
								l_tree.extend (create {EV_TREE_ITEM}.make_with_text (warning_messages.w_no_feature_to_display))
							end
						end
					elseif {l_external_classc: !EXTERNAL_CLASS_C} a_class_c then
						-- Special processing for a .NET type since has no 'ast' in the normal
						-- sense.

						if l_tree.selected_item /= Void then
							l_tree.selected_item.disable_select
						end
						l_tree.wipe_out
						build_tree_for_external (l_external_classc)
					end

					-- Add tree back to the container
				l_container.extend (l_tree)

				if not l_tree.is_empty and then l_tree.is_displayed then
					l_tree.ensure_item_visible (l_tree.first)
				end
			end
		end

	build_tree_for_external (a_class: !EXTERNAL_CLASS_C)
			-- Build tree for .Net classes
		do
			-- FIXIT: Don't support .Net classes for the moment
			feature_tree.extend (create {EV_TREE_ITEM}.make_with_text (warning_messages.w_no_feature_to_display))
		end

	build_tree_imp (a_fcl: EIFFEL_LIST [FEATURE_CLAUSE_AS]; a_class: CLASS_C)
			-- Build feature tree
			-- Modified base on {EB_FEATURES_TREE}.build_tree
		require
			not_void: feature_tree /= Void
			not_void: a_fcl /= Void
			not_void: a_class /= Void
		local
			l_tree_item: EV_TREE_ITEM
			l_match_list: LEAF_AS_LIST
			l_features: EIFFEL_LIST [FEATURE_AS]
			l_export_status: EXPORT_I
			l_name: STRING
			l_retried: BOOLEAN
			l_comments: EIFFEL_COMMENTS
		do
			if not l_retried then
				last_class := a_class
				l_match_list := match_list_server.item (a_class.class_id)

				from
					a_fcl.start
				until
					a_fcl.after
				loop
					if a_fcl.item = Void then
						feature_tree.extend (create {EV_TREE_ITEM}.make_with_text (
							Warning_messages.w_short_internal_error ("Void feature clause")))
					else
						l_features := a_fcl.item.features
						l_comments := a_fcl.item.comment (l_match_list)
						if l_comments = Void or else l_comments.is_empty then
							l_name := " "
						else
							l_name := l_comments.first.content
						end
						l_name.right_adjust
					end

					l_tree_item := build_tree_folder (l_name, l_features, a_class)

					l_export_status := export_status_generator.feature_clause_export_status (system, a_class, a_fcl.item)
					if l_export_status.is_none then
						l_tree_item.set_pixmap (pixmaps.icon_pixmaps.folder_features_none_icon)
					elseif l_export_status.is_set then
						l_tree_item.set_pixmap (pixmaps.icon_pixmaps.folder_features_some_icon)
					else
						l_tree_item.set_pixmap (pixmaps.icon_pixmaps.folder_features_all_icon)
					end

					l_tree_item.set_data (a_fcl.item)
					-- l_tree_item.set_configurable_target_menu_mode
					-- l_tree_item.set_configurable_target_menu_handler (agent context_menu_factory.feature_clause_item_menu (?, ?, ?, ?, a_fcl.item))

					feature_tree.extend (l_tree_item)
					a_fcl.forth
				end


				-- Expand tree codes here

				if a_fcl.is_empty then
						-- Display a message not to confuse the user.
					feature_tree.extend (create {EV_TREE_ITEM}.make_with_text (Warning_messages.w_no_feature_to_display))
				end
			else
				feature_tree.extend (create {EV_TREE_ITEM}.make_with_text (
					Warning_messages.w_short_internal_error ("Crash in build_tree")))
			end
		ensure
			set: last_class = a_class
		rescue
			l_retried := True
			retry
		end

	last_class: CLASS_C
			-- Last set class, the tree was built with

feature {NONE} -- Implementation

	pixmap_factory: EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY is
			-- Pixmap factory
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	build_tree_folder (n: STRING; fl: EIFFEL_LIST [FEATURE_AS]; a_class: CLASS_C): EV_TREE_ITEM is
			-- Build the tree node corresponding to feature clause named `n'.
			-- Modified from {EB_FEATURES_TREE}, now the class replaced by {ES}
		require
			fl_not_void: fl /= Void
			a_class_not_void: a_class /= Void
		local
			l_tree_item: EV_TREE_ITEM
			ef: E_FEATURE
			st: FEATURE_STONE
			fa: FEATURE_AS
			f_names: EIFFEL_LIST [FEATURE_NAME]
			f_item_name: STRING
			l_first_item_name: STRING
			l_external: BOOLEAN
		do
			create Result
			l_external := a_class.is_external
			if
				n /= Void and then
				not n.is_equal ("")
			then
				Result.set_text (n)
			else
				Result.set_text (Interface_names.l_no_feature_group_clause)
			end
			from
				fl.start
			until
				fl.after
			loop
				fa := fl.item
				if fa = Void then
					Result.extend (create {EV_TREE_ITEM}.make_with_text (
						warning_messages.w_short_internal_error ("Void feature")))
				else
					l_first_item_name := Void
					from
						f_names := fa.feature_names
						f_names.start
					until
						f_names.after
					loop
						f_item_name := f_names.item.internal_name.name
						if l_first_item_name = Void then
							l_first_item_name := f_item_name
						end
						if a_class.has_feature_table then
							ef := a_class.feature_with_name (f_item_name)
							if ef /= Void and then ef.written_in /= a_class.class_id then
								ef := Void
							end
						end
						create l_tree_item
						if ef = Void then
							l_tree_item.set_text (f_item_name)
							l_tree_item.set_data (f_item_name)
							if {l_feature_name: !STRING_8} l_first_item_name then
								l_tree_item.set_pixmap (pixmap_factory.pixmap_from_feature_ast (l_external, fa, f_names.index))
							end
						else
							l_tree_item.set_data (ef)
							-- if is_clickable then
							-- l_tree_item.pointer_button_press_actions.extend (
							-- agent button_go_to (ef, ?, ?, ?, ?, ?, ?, ?, ?))
							-- l_tree_item.set_configurable_target_menu_mode
							-- l_tree_item.set_configurable_target_menu_handler (agent feature_item_handler (?, ?, ?, ?, True, Void))
							-- end
							l_tree_item.set_text (feature_name (ef))
							l_tree_item.set_pixmap (pixmap_factory.pixmap_from_feature_ast (l_external, fa, f_names.index))
							create st.make (ef)
							l_tree_item.set_pebble (st)
							l_tree_item.set_accept_cursor (st.stone_cursor)
							l_tree_item.set_deny_cursor (st.X_stone_cursor)
						end
						Result.extend (l_tree_item)
						f_names.forth
					end
				end
				fl.forth
			end
		end

	feature_name (a_ef: E_FEATURE): STRING is
			-- Feature name of `a_ef' depending of the signature displayed or not.
		require
			a_ef_not_void: a_ef /= Void
		do
			Result := a_ef.name.twin
		end
indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
