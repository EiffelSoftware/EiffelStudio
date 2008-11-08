indexing
	description: "Summary description for {ES_TEST_WIZARD_ROUTINE_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_WIZARD_ROUTINE_WINDOW

inherit
	ES_TEST_WIZARD_FINAL_WINDOW
		redefine
			clean_screen,
			cancel
		end

	SHARED_ERROR_HANDLER
		export
			{NONE}
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make_window

feature {NONE} -- Initialization

	build
			-- <Precursor>
		local
			l_parent: EV_BOX
			l_sep: EV_HORIZONTAL_SEPARATOR
		do
			first_window.set_final_state (local_formatter.translation (b_create))

			l_parent := initialize_container (choice_box)

			build_test_name (l_parent)
			create l_sep
			l_parent.extend (l_sep)
			l_parent.disable_item_expand (l_sep)

			build_class_feature_tree (l_parent)
			create l_sep
			l_parent.extend (l_sep)
			l_parent.disable_item_expand (l_sep)

			build_tag_list (l_parent)
			on_after_initialize
		end

	build_test_name (a_parent: EV_BOX) is
			-- Initialize `class_name'.
		local
			l_label: EV_LABEL
			l_hb: EV_HORIZONTAL_BOX
			l_text_field: EV_TEXT_FIELD
		do
			create l_hb
			create l_label.make_with_text (local_formatter.translation (l_test_name))
			l_hb.extend (l_label)
			l_hb.disable_item_expand (l_label)

			create l_text_field
			create test_name.make (l_text_field, agent on_validate_test_name)
			test_name.valid_state_changed_event.subscribe (agent on_valid_state_changed)
			l_hb.extend (test_name)

			a_parent.extend (l_hb)
			a_parent.disable_item_expand (l_hb)
		end

	build_class_feature_tree (a_parent: EV_BOX) is
			-- Initizialize `class_tree' and `feature_tree'.
		local
			l_layouts: EV_LAYOUT_CONSTANTS
			l_label: EV_LABEL
			l_hb: EV_HORIZONTAL_BOX
		do
			create l_label.make_with_text (local_formatter.translation (l_cover))
			l_label.align_text_left
			a_parent.extend (l_label)
			a_parent.disable_item_expand (l_label)

			create l_hb
			create l_layouts
			create class_tree.make_with_options (development_window.menus.context_menu_factory, False, True)
			class_tree.select_actions.extend (agent on_select_class)
			l_hb.extend (class_tree)
			class_tree.refresh

			create feature_tree
			feature_tree.select_actions.extend (agent on_select_feature)
			l_hb.extend (feature_tree)

			a_parent.extend (l_hb)
		end

	build_tag_list (a_parent: EV_BOX)
			-- Initialize `tag_list'.
		local
			l_vb: EV_VERTICAL_BOX
			l_label: EV_LABEL
			l_text_field: EV_TEXT_FIELD
		do
			create l_vb

			create l_label.make_with_text (local_formatter.translation (l_tag_list))
			l_label.align_text_left
			l_vb.extend (l_label)
			l_vb.disable_item_expand (l_label)

			create l_text_field
			create tag_list.make (l_text_field, agent on_validate_tag_list)
			tag_list.valid_state_changed_event.subscribe (agent on_valid_state_changed)
			l_vb.extend (tag_list)
			l_vb.disable_item_expand (tag_list)

			a_parent.extend (l_vb)
			a_parent.disable_item_expand (l_vb)
		end

	on_after_initialize
			-- Called after all widgets have been initialized.
		local
			l_tags: DS_BILINEAR_CURSOR [!STRING]
			l_text: !STRING_32
			l_feat: E_FEATURE
		do
			if {l_name: !STRING} wizard_information.name_cache then
				if {l_name32: !STRING_32} l_name.to_string_32 then
					test_name.set_text (l_name32)
				end
			end
			test_name.validate

			if {l_class: !CLASS_I} wizard_information.class_covered then
				l_feat := wizard_information.feature_covered
				class_tree.show_class (l_class)
				if l_feat /= Void then
					select_feature (l_feat)
				end
			end

			from
				create l_text.make (100)
				l_tags := wizard_information.tag_list.new_cursor
				l_tags.start
			until
				l_tags.after
			loop
				l_text.append_string_general (l_tags.item)
				if not l_tags.is_last then
					l_text.append (", ")
				end
				l_tags.forth
			end
			tag_list.set_text (l_text)
			tag_list.validate

			update_next_button_status
		end

feature {NONE} -- Access

	factory_type: !TYPE [TEST_CREATOR_I]
			-- <Precursor>
		do
			Result := manual_factory_type
		end

	feature_name_validator: ES_FEATURE_NAME_VALIDATOR
			-- Validator for `test_name'
		once
			create Result
		end

feature {NONE} -- Access: widgets

	test_name: ES_VALIDATION_TEXT_FIELD
			-- Text field for new test class name

	class_tree: ?EB_CLASSES_TREE
			-- Tree showing all classes in the system
			--
			-- Note: must be detachable for recycling

	feature_tree: EV_TREE
			-- Tree displaying features of the selected class in `class_tree'

	tag_list: ES_VALIDATION_TEXT_FIELD
			-- Text field containing additional tags for new test

feature {NONE} -- Access: tag utilities

	tag_utilities: TAG_UTILITIES
			-- Tag utilities
		once
			create Result
		end

	splitter: ST_SPLITTER
			-- Splitter for retrieving input
		once
			create Result.make_with_separators (", ")
		end

feature {NONE} -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			if test_name.is_valid then
				Result := tag_list.is_valid
			end
		end

feature {NONE} -- Status setting

	select_feature (a_feature: E_FEATURE)
			-- Select feature in `feature_tree'.
			--
			-- `a_feature': Feature to be selected in `feature_tree'.
		local
			l_res: BOOLEAN
		do
			l_res := select_feature_recursive (a_feature, feature_tree)
		end

	select_feature_recursive (a_feature: E_FEATURE; a_list: EV_TREE_NODE_LIST): BOOLEAN is
			-- Select corresponding feature in list of tree items recursively.
			--
			-- `a_feature': Feature to be selected.
			-- `a_list': List of tree items where an item corresponds to the feature if its data field
			--           points to the feature.
			-- `Result': True if feature was found in `a_list', False otherwise.
		local
			l_item: EV_TREE_NODE
		do
			from
				a_list.start
			until
				Result or a_list.after
			loop
				l_item := a_list.item_for_iteration
				if {l_feature: E_FEATURE} l_item.data then
					if a_feature.feature_id = l_feature.feature_id then
						Result := True
						l_item.enable_select
					end
				end
				if not Result then
					Result := select_feature_recursive (a_feature, l_item)
				end
				a_list.forth
			end
		end

feature {NONE} -- Events

	on_validate_test_name (a_name: !STRING_32): !TUPLE [BOOLEAN, ?STRING_32]
			-- Called when `class_name' content needs to be validated
		local
			l_valid: BOOLEAN
			l_msg: STRING_32
		do
			if {l_name: !STRING} a_name.to_string_8 then
				wizard_information.name_cache := l_name
				if not wizard_information.is_new_class and then {l_class: !CLASS_I} wizard_information.test_class then
					feature_name_validator.validate_new_feature_name (l_name, l_class)
				else
					feature_name_validator.validate_feature_name (l_name)
				end
				l_valid := feature_name_validator.is_valid
				l_msg := feature_name_validator.last_error_message
				if l_valid then
					if l_name.is_equal ("setup") or l_name.is_equal ("tear_down") then
						l_valid := False
						l_msg := local_formatter.translation (e_bad_test_name)
					end
				end
			end
			Result := [l_valid, l_msg]
		end

	on_select_class
			-- Called when item is selected in `class_tree'
		local
			l_classi: CLASS_I
			l_tree_item: EV_TREE_ITEM
		do
			feature_tree.wipe_out
			wizard_information.set_class_covered (Void)
			wizard_information.set_feature_covered (Void)
			if {l_item: !EB_CLASSES_TREE_CLASS_ITEM} class_tree.selected_item then
				l_classi := l_item.data
				if wizard_information.class_covered /= l_classi then
					wizard_information.set_class_covered (l_classi)
				end
				if l_classi.is_compiled then
					build_tree (l_classi.compiled_class)
				else
					create l_tree_item.make_with_text ("Class not compiled...")
					feature_tree.extend (l_tree_item)
				end
			end
		end

	on_select_feature
			-- Called when item is selected in `feature_tree'.
		do
			wizard_information.set_feature_covered (Void)
			if feature_tree.selected_item /= Void then
				if {l_feat: !E_FEATURE} feature_tree.selected_item.data then
					wizard_information.set_feature_covered (l_feat)
				end
			end
		end

	on_validate_tag_list (a_list: !STRING_32): !TUPLE [BOOLEAN, ?STRING_32] is
			-- Called when `tag_list' content needs to be validated
		local
			l_list: STRING
			l_tags: DS_LINEAR [!STRING]
			l_valid: BOOLEAN
			l_invalid: STRING
			l_error: STRING_32
		do
			wizard_information.tag_list.wipe_out
			l_list := a_list.to_string_8
			l_tags ?= splitter.split (l_list)
			from
				l_tags.start
				l_valid := True
			until
				l_tags.after
			loop
				if not tag_utilities.is_valid_tag (l_tags.item_for_iteration) then
					l_valid := False
					if l_invalid = Void then
						create l_invalid.make_from_string (l_tags.item_for_iteration)
					end
				end
				wizard_information.tag_list.force_last (l_tags.item_for_iteration)
				l_tags.forth
			end
			if not l_valid then
				create l_error.make (100)
				l_error.append (l_invalid)
				l_error.append (local_formatter.translation (e_invalid_tag1))
				l_error.append (local_formatter.translation (e_invalid_tag2))
				l_error.append ("token1")
				l_error.append_character (tag_utilities.split_char)
				l_error.append ("token2")
				l_error.append_character (tag_utilities.split_char)
				l_error.append ("token3")
				l_error.append (local_formatter.translation (e_invalid_tag3))
				l_error.append (tag_utilities.valid_token_chars)
				Result := [False, l_error]
			else
				Result := [True, Void]
			end
		end

feature {NONE} -- Basic operations

	clean_screen
			-- <Precursor>
		do
			Precursor
			if class_tree /= Void then
				class_tree.recycle
			end
		end

	cancel
			-- <Precursor>
		do
			Precursor
			class_tree.recycle
		end

feature {NONE} -- Implementation: feature tree

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
						-- Clear error handler, as per-note in parsed_ast
					error_handler.wipe_out
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
					if l_tree_item.is_expandable then
						l_tree_item.expand
					end
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
		rescue
			l_retried := True
			retry
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

feature {NONE} -- Implementation: creation


feature {NONE} -- Constants

	t_title: STRING = "Test routine"
	t_subtitle: STRING = "Define properties of new test routine"

	b_create: STRING = "Create"

	l_test_name: STRING = "Test name: "
	l_cover: STRING = "Choose a class and a feature to be associated with the new test"
	l_tag_list: STRING = "Additional tags for test routine (comma separated)"

	e_bad_test_name: STRING = "`setup' or `tear_down' can not be used as test routine names."
	e_invalid_tag1: STRING = " is not a valid tag%N%N"
	e_invalid_tag2: STRING = "Tags must have the form%N%N"
	e_invalid_tag3: STRING = "%N%Nwhere tokens can contain letters, numbers or any of "

end
