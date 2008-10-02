indexing
	description: "Summary description for {ES_EIFFEL_TEST_WIZARD_CLASS_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_WIZARD_CLASS_WINDOW

inherit
	EB_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			wizard_information,
			clean_screen,
			cancel
		end

	ES_EIFFEL_TEST_WIZARD_WINDOW
		redefine
			wizard_information,
			clean_screen,
			cancel
		end

create
	make_window

feature {NONE}

	build
			-- <Precursor>
		local
			l_parent: EV_BOX
			l_sep: EV_HORIZONTAL_SEPARATOR
		do
			l_parent := initialize_container (choice_box)

			build_class_tree (l_parent)
			create l_sep
			l_parent.extend (l_sep)
			l_parent.disable_item_expand (l_sep)
			build_feature_clause_selection (l_parent)

			on_after_initialize
		end

	build_class_tree (a_parent: EV_BOX) is
			-- Initialize `class_tree'
		local
			l_layouts: EV_LAYOUT_CONSTANTS
			l_label: EV_LABEL
		do
			create l_label.make_with_text (l_select_test_class)
			l_label.align_text_left
			a_parent.extend (l_label)
			a_parent.disable_item_expand (l_label)

			create l_layouts
			create class_tree.make_with_options (development_window.menus.context_menu_factory, False, True)
			class_tree.select_actions.extend (agent on_select_tree_item)
			class_tree.set_minimum_width (l_layouts.dialog_unit_to_pixels(350))
			class_tree.set_minimum_height (l_layouts.dialog_unit_to_pixels(200))
			class_tree.refresh
			a_parent.extend (class_tree)
		end

	build_feature_clause_selection (a_parent: EV_BOX) is
			-- Initialize feature clause selection.
		local
			l_vb: EV_VERTICAL_BOX
			l_hb: EV_HORIZONTAL_BOX
			l_cell: EV_CELL
			l_text_field: EV_TEXT_FIELD
		do
			create l_vb

			create reuse_feature_clause_button
			reuse_feature_clause_button.set_text (b_existing_feature_clause)
			reuse_feature_clause_button.select_actions.extend (agent on_select_feature_clause_button)
			l_vb.extend (reuse_feature_clause_button)
			l_vb.disable_item_expand (reuse_feature_clause_button)

			create l_hb
			create l_cell
			l_cell.set_minimum_width (indentation)
			l_hb.extend (l_cell)
			l_hb.disable_item_expand (l_cell)
			create feature_clause_box
			feature_clause_box.disable_edit
			feature_clause_box.select_actions.extend (agent on_feature_clause_select)
			l_hb.extend (feature_clause_box)
			l_vb.extend (l_hb)
			l_vb.disable_item_expand (l_hb)

			create new_feature_clause_button
			new_feature_clause_button.set_text (b_new_feature_clause)
			new_feature_clause_button.select_actions.extend (agent on_select_feature_clause_button)
			l_vb.extend (new_feature_clause_button)
			l_vb.disable_item_expand (new_feature_clause_button)

			create l_hb
			create l_cell
			l_cell.set_minimum_width (indentation)
			l_hb.extend (l_cell)
			l_hb.disable_item_expand (l_cell)
			create l_text_field
			create new_feature_clause_name.make (l_text_field, agent on_validate_feature_clause_name)
			l_hb.extend (new_feature_clause_name)
			l_vb.extend (l_hb)
			l_vb.disable_item_expand (l_hb)

			a_parent.extend (l_vb)
			a_parent.disable_item_expand (l_vb)
		end

	on_after_initialize
			-- Called after all widgets have been initialized.
		local
			l_featc: FEATURE_CLAUSE_AS
			l_reuse: BOOLEAN
		do
			l_featc := wizard_information.feature_clause
			l_reuse := not wizard_information.is_feature_clause_new
			if wizard_information.test_class /= Void then
				class_tree.show_class (wizard_information.test_class)
			end
			if selected_class = Void then
				update_feature_clause_status
			end
			if reuse_feature_clause_button.is_sensitive then
				if l_featc /= Void  then
					select_feature_clause (l_featc)
				end
				if l_reuse then
					reuse_feature_clause_button.enable_select
				else
					new_feature_clause_button.enable_select
				end
			end
			if wizard_information.feature_clause_name /= Void then
				if {l_s32: !STRING_32} wizard_information.feature_clause_name.to_string_32 then
					new_feature_clause_name.set_text (l_s32)
				end
			end
			new_feature_clause_name.validate

			update_next_button_status
		end

feature {NONE} -- Access

	wizard_information: ES_EIFFEL_TEST_WIZARD_INFORMATION
			-- Information user has provided to the wizard

	selected_class: ?EIFFEL_CLASS_I
			-- Class currently selected in `tree_view'

feature {NONE} -- Access: widgets

	class_tree: ?ES_EIFFEL_TEST_WIZARD_CLASS_TREE
			-- Tree displaying clusters and existing test classes
			--
			-- Note: must be detachable for recycling

	reuse_feature_clause_button: EV_RADIO_BUTTON
			-- Button for choosing an existing feature clause

	new_feature_clause_button: EV_RADIO_BUTTON
			-- Button for creating a new feature clause

	feature_clause_box: EV_COMBO_BOX
			-- Drop down box for selecting existing feature clause

	new_feature_clause_name: ES_VALIDATION_TEXT_FIELD
			-- Text field for new feature clause name

feature {NONE} -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			if wizard_information.test_class /= Void then
				if wizard_information.is_feature_clause_new then
					Result := wizard_information.feature_clause_name /= Void and then
					          not wizard_information.feature_clause_name.is_empty
				else
					Result := wizard_information.feature_clause /= Void
				end
			end
		end

feature {NONE} -- Status setting

	select_feature_clause (a_clause: FEATURE_CLAUSE_AS)
			-- Select specific feature clause in `feature_clause_box'.
		local
			l_item: EV_LIST_ITEM
		do
			from
				feature_clause_box.start
			until
				feature_clause_box.after
			loop
				l_item := feature_clause_box.item_for_iteration
				if l_item.data = a_clause then
					l_item.enable_select
				end
				feature_clause_box.forth
			end
		end

feature {NONE} -- Events

	on_select_tree_item
			-- Called when item in `class_tree' is selected.
		do
			selected_class := Void
			if class_tree.selected_item /= Void then
				selected_class ?= class_tree.selected_item.data
				if {l_eclass: !like selected_class} class_tree.selected_item.data then
					selected_class := l_eclass
				else
					selected_class := Void
				end
			end
			wizard_information.set_test_class (selected_class)
			update_feature_clause_status
			update_next_button_status
		end

	on_select_feature_clause_button
			-- Called when feature clause radion button is selected.
		do
			if reuse_feature_clause_button.is_selected then
				feature_clause_box.enable_sensitive
				new_feature_clause_name.text_field.disable_sensitive
			else
				feature_clause_box.disable_sensitive
				new_feature_clause_name.text_field.enable_sensitive
			end
			wizard_information.set_is_feature_clause_new (new_feature_clause_button.is_selected)
			new_feature_clause_name.validate
			update_next_button_status
		end

	on_feature_clause_select
			-- Called when item in `feature_clause_box' is selected.
		do
			wizard_information.set_feature_clause (Void)
			if feature_clause_box.selected_item /= Void then
				if {l_fc: FEATURE_CLAUSE_AS} feature_clause_box.selected_item.data then
					wizard_information.set_feature_clause (l_fc)
				end
			end
			update_next_button_status
		end

	on_validate_feature_clause_name (a_name: !STRING_32): !TUPLE [BOOLEAN, ?STRING_32]
			-- Called when `new_feature_clause_name' contents need to be validated.
		local
			l_name: STRING
		do
			l_name := a_name.to_string_8
			wizard_information.set_feature_clause_name (l_name)
			if new_feature_clause_name.text_field.is_sensitive and l_name.is_empty then
				Result := [False, local_formatter.translation (e_new_feature_clause_name_empty)]
			else
				Result := [True, Void]
			end
			update_next_button_status
		end

feature {NONE} -- Basic operations

	proceed_with_current_info
			-- <Precursor>
		do
			proceed_with_new_state(create {ES_EIFFEL_TEST_WIZARD_ROUTINE_WINDOW}.make_window (development_window, wizard_information))
		end

	display_state_text
			-- <Precursor>
		do
			title.set_text (local_formatter.translation (t_title))
			subtitle.set_text (local_formatter.translation (t_subtitle))
		end

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

feature {NONE} -- Implementation

	update_feature_clause_status
			-- Update widgets according to `new_class_button' and `existing_class_button' selection.
		local
			l_eclass: CLASS_C
			l_ast: CLASS_AS
			l_list: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			l_fc: FEATURE_CLAUSE_AS
			l_export_status: EXPORT_I
			l_comments: EIFFEL_COMMENTS
			l_match_list: LEAF_AS_LIST
			l_fcname: STRING
			l_item: EV_LIST_ITEM
		do
			feature_clause_box.wipe_out
			wizard_information.set_feature_clause (Void)
			if selected_class /= Void and then selected_class.is_compiled then
				l_eclass := selected_class.compiled_class
				if l_eclass.has_ast then
					l_ast := l_eclass.ast
					l_list := l_ast.features
				end
			end

			if l_list /= Void and then not l_list.is_empty then
				l_match_list := match_list_server.item (l_eclass.class_id)
				from
					l_list.start
				until
					l_list.after
				loop
					if l_list.item_for_iteration /= Void then
						l_fc := l_list.item_for_iteration
						l_export_status := export_status_generator.feature_clause_export_status (system, l_eclass, l_fc)
						if l_export_status.is_all then
							l_comments := l_fc.comment (l_match_list)
							if l_comments /= Void and then not l_comments.is_empty then
								l_fcname := l_comments.first.content.twin
								l_fcname.right_adjust
							else
								create l_fcname.make (20)
							end
							if l_fcname.is_empty then
								l_fcname.append (local_formatter.translation (l_no_feature_clause_name))
							end
							create l_item.make_with_text (l_fcname)
							l_item.set_data (l_fc)
							if l_export_status.is_set then
								l_item.set_pixmap (pixmaps.icon_pixmaps.folder_features_some_icon)
							else
								l_item.set_pixmap (pixmaps.icon_pixmaps.folder_features_all_icon)
							end
							feature_clause_box.extend (l_item)
						end
					end
					l_list.forth
				end
			end

			if feature_clause_box.is_empty then
				reuse_feature_clause_button.disable_sensitive
				feature_clause_box.disable_sensitive
				if selected_class = Void then
					new_feature_clause_button.disable_sensitive
					new_feature_clause_name.text_field.disable_sensitive
					new_feature_clause_name.validate
				else
					if not new_feature_clause_button.is_sensitive then
						new_feature_clause_button.enable_sensitive
					end
					if not new_feature_clause_button.is_selected then
						new_feature_clause_button.enable_select
					else
						new_feature_clause_name.text_field.enable_sensitive
					end
				end
			else
				check
					selected_class /= Void
				end
				reuse_feature_clause_button.enable_sensitive
				new_feature_clause_button.enable_sensitive
				feature_clause_box.enable_sensitive
				feature_clause_box.first.enable_select
				if new_feature_clause_button.is_selected then
					new_feature_clause_name.text_field.enable_sensitive
					new_feature_clause_name.validate
					feature_clause_box.disable_sensitive
				end
			end
		end

feature {NONE} -- Constants

	indentation: INTEGER = 20

	t_title: STRING = "Test class properties"
	t_subtitle: STRING = "Define where new test routine will be created"

	b_existing_feature_clause: STRING = "Add to end of existing feature clause:"
	b_new_feature_clause: STRING = "Create new feature clause"

	l_select_test_class: STRING = "Select class in which new test routine will be created"
	l_no_feature_clause_name: STRING = "[Unnamed feature clause]"

	e_new_feature_clause_name_empty: STRING = "Feature clause name can not be empty."

end
