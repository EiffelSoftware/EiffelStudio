indexing
	description: "Tree representing the features of the class currently opened"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURES_TREE

inherit

	CHARACTER_ROUTINES
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	ES_TREE

	EB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

	SHARED_WORKBENCH
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	PREFIX_INFIX_NAMES
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	SHARED_SERVER
		undefine
			default_create, is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_features_tool: like features_tool; clickable: BOOLEAN) is
			-- Initialization: build the widget and the tree.
		do
			is_clickable := clickable
			features_tool := a_features_tool
			update_states
			default_create

			set_minimum_height (20)
			key_press_actions.extend (agent on_key_pushed)
			enable_default_tree_navigation_behavior (False, False, False, True)
		end

feature -- Status report

	is_clickable: BOOLEAN
			-- Is the class corresponding to the item loaded in the tool when
			-- the user left-click on it.

feature {NONE} -- Acess

	features_tool: ES_FEATURES_TOOL_PANEL
			-- Associated features tool.

feature {NONE} -- Status report

	is_signature_enabled: BOOLEAN
			-- Do we display signature of feature ?

	is_alias_enabled: BOOLEAN
			-- Is alias name shown?

	is_assigner_enabled: BOOLEAN
			-- Is assigner command shown?

feature {NONE} -- Status setting

	update_states
			-- Update command states
		do
			is_signature_enabled := features_tool.is_showing_signatures
			is_alias_enabled := features_tool.is_showing_alias
			is_assigner_enabled := features_tool.is_showing_assigners
		end

feature -- Basic operations

	update_all
			-- Updates all feature tree nodes
		do
			update_states
			recursive_do_all (agent update_node)
		end

feature -- Basic operations

	nagivate_to_feature (a_feature: !E_FEATURE)
			-- Navigates to a feature in using a default view.
			--
			-- `a_feature': A feature to navigate to.
		local
			l_window: EB_DEVELOPMENT_WINDOW
		do
			l_window := features_tool.develop_window
			l_window.set_feature_locating (true)
			l_window.set_stone (create {!FEATURE_STONE}.make (a_feature))
			l_window.set_feature_locating (false)
		end

	nagivate_to_feature_by_name (a_feature: !STRING) is
			-- Navigates to a feature in using a default view.
			--
			-- `a_feature': A feature name used to navigate to a feature.
		require
			not_a_feature_is_empty: not a_feature.is_empty
		local
			l_window: EB_DEVELOPMENT_WINDOW
		do
			l_window := features_tool.develop_window
			if {l_editor: !EB_SMART_EDITOR} l_window.editors_manager.current_editor then
				if {l_formatter: !EB_BASIC_TEXT_FORMATTER} l_window.pos_container then
					l_window.managed_main_formatters.first.execute
				end
				l_editor.find_feature_named (a_feature)
			end
		end

	nagivate_to_feature_clause (a_clause: !FEATURE_CLAUSE_AS; a_focus: BOOLEAN)
			-- Navigates to a feature clause in the default view.
			--
			-- `a_clause': The feature clause to navigate too.
			-- `a_focus': True to set focus, False otherwise.
		local
			l_text: STRING_8
			l_line, l_pos: INTEGER
			l_window: EB_DEVELOPMENT_WINDOW
		do
			check
				a_clause_is_valid: a_clause.start_position > 0
			end
			l_window := features_tool.develop_window
			if {l_editor: !EB_SMART_EDITOR} l_window.editors_manager.current_editor then
				l_text := "class"
				if l_text = Void then
					l_text := l_editor.text
				end
				check
					l_text_attached: l_text /= Void
				end

				if {l_formatter: !EB_BASIC_TEXT_FORMATTER} l_window.pos_container then
						-- Ensure we are in edit mode in the editor.

						-- Fetch line number
					l_pos := a_clause.start_position
					if l_pos <= l_text.count then
						l_line := l_text.substring (1, l_pos).occurrences ('%N')
					else
						l_line := l_text.occurrences ('%N')
					end

					if not a_focus then
						l_editor.display_line_at_top_when_ready  (l_line, 0)
					else
						l_editor.docking_content.set_focus
						l_editor.set_focus
						l_editor.scroll_to_start_of_line_when_ready_if_top (l_line, 0, False, True)
					end
				end
			end
		end

feature {NONE} -- Basic operations

	update_node (a_node: EV_TREE_NODE) is
			-- Update node alias name and signature
		require
			a_node_attached: a_node /= Void
		do
			if {l_ef: !E_FEATURE} a_node.data then
				a_node.set_text (feature_name (l_ef))
			end
		end

feature -- Tree construction

	build_tree (fcl: EIFFEL_LIST [FEATURE_CLAUSE_AS]; a_class: CLASS_C) is
			-- Build the feature tree corresponding to current class.
		require
			feature_clause_list_not_void: fcl /= Void
			a_class_attached: a_class /= Void
		local
			features: EIFFEL_LIST [FEATURE_AS]
			tree_item: EV_TREE_ITEM
			name: STRING
			expand_tree: BOOLEAN
			retried: BOOLEAN
			l_export_status: EXPORT_I
			l_match_list: LEAF_AS_LIST
			l_comments: EIFFEL_COMMENTS
		do
			if not retried then
				expand_tree := preferences.feature_tool_data.expand_feature_tree
				l_match_list := match_list_server.item (a_class.class_id)
					--| Features
				from
					fcl.start
				until
					fcl.after
				loop
					if fcl.item = Void then
						extend (create {EV_TREE_ITEM}.make_with_text (
							Warning_messages.w_short_internal_error ("Void feature clause")))
					else
						features := fcl.item.features
						l_comments := fcl.item.comment (l_match_list)
						if l_comments = Void or else l_comments.is_empty then
							name := " "
						else
							name := l_comments.first.content
						end
						name.right_adjust
					end
					tree_item := build_tree_folder (name, features, a_class)
					l_export_status := export_status_generator.
						feature_clause_export_status (system, a_class, fcl.item)
					if l_export_status.is_none then
						tree_item.set_pixmap (pixmaps.icon_pixmaps.folder_features_none_icon)
					elseif l_export_status.is_set then
						tree_item.set_pixmap (pixmaps.icon_pixmaps.folder_features_some_icon)
					else
						tree_item.set_pixmap (pixmaps.icon_pixmaps.folder_features_all_icon)
					end
					if is_clickable then
						tree_item.set_data (fcl.item)
						tree_item.pointer_button_press_actions.extend (
							agent button_go_to_clause (fcl.item, ?, ?, ?, ?, ?, ?, ?, ?))
						tree_item.set_configurable_target_menu_mode
						tree_item.set_configurable_target_menu_handler (agent feature_clause_item_handler (?, ?, ?, ?, fcl.item))
					end
					extend (tree_item)
					if
						expand_tree and then
						tree_item.is_expandable
					then
						tree_item.expand
					end
					fcl.forth
				end
				if fcl.is_empty then
						-- Display a message not to confuse the user.
					extend (create {EV_TREE_ITEM}.make_with_text (
					Warning_messages.w_no_feature_to_display))
				end
			else
				extend (create {EV_TREE_ITEM}.make_with_text (
					Warning_messages.w_short_internal_error ("Crash in build_tree")))
			end
		rescue
			retried := True
			retry
		end

	build_tree_for_external (a_class: CLASS_C) is
			-- Build the feature tree corresponding to current .NET class 'a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			tree_item: EV_TREE_ITEM
			name: STRING
			expand_tree: BOOLEAN
			retried: BOOLEAN
			l_dev_win: EB_DEVELOPMENT_WINDOW
			l_clauses: ARRAYED_LIST [DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]]
		do
			if not retried then
				expand_tree := preferences.feature_tool_data.expand_feature_tree
				l_dev_win := Window_manager.last_focused_development_window
				if l_dev_win /= Void then
					l_clauses := l_dev_win.get_feature_clauses (a_class.name)
				end
				if l_clauses.is_empty then
					extend (create {EV_TREE_ITEM}.make_with_text (Interface_names.l_compile_first))
				else
					from
						l_clauses.start
					until
						l_clauses.after
					loop
						name := l_clauses.item.name
						name.right_adjust
						tree_item := build_tree_folder_for_external (name, l_clauses.item, a_class)
						if not l_clauses.item.is_exported then
							tree_item.set_pixmap (pixmaps.icon_pixmaps.folder_features_none_icon)
						else
							tree_item.set_pixmap (pixmaps.icon_pixmaps.folder_features_all_icon)
						end
						if is_clickable then
							--FIXME: NC
							-- tree_item.set_data (l_clauses.item)
							-- tree_item.pointer_button_press_actions.extend (
							--	agent button_go_to_clause (l_clauses.item, ?, ?, ?, ?, ?, ?, ?, ?))
						end
						extend (tree_item)
						if
							expand_tree and then
							tree_item.is_expandable
						then
							tree_item.expand
						end
						l_clauses.forth
					end
					if l_clauses.is_empty then
							-- Display a message not to confuse the user.
						extend (create {EV_TREE_ITEM}.make_with_text (
							Warning_messages.w_no_feature_to_display))
					end
				end
			else
				wipe_out
				extend (create {EV_TREE_ITEM}.make_with_text (Interface_names.l_compile_first))
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	feature_name (a_ef: E_FEATURE): STRING is
			-- Feature name of `a_ef' depending of the signature displayed or not.
		require
			a_ef_not_void: a_ef /= Void
		local
			alias_name: STRING
			assigner_name: STRING
		do
			Result := a_ef.name.twin
			if is_alias_enabled and then not a_ef.is_prefix and then not a_ef.is_infix then
				alias_name := a_ef.alias_name
				if alias_name /= Void then
					Result.append_string (" alias %"")
					Result.append_string (eiffel_string (extract_alias_name (alias_name)))
					Result.append_character ('%"')
				end
			end
			if is_signature_enabled then
				a_ef.append_arguments_to (Result)
				if a_ef.type /= Void then
					Result.append (": " + a_ef.type.dump)
				end
			end
			if is_assigner_enabled then
				assigner_name := a_ef.assigner_name
				if assigner_name /= Void then
					Result.append_string (" assign ")
					Result.append_string (assigner_name)
				end
			end
		end

feature {NONE} -- Context menu handler

	feature_item_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_compiled: BOOLEAN; a_name: STRING) is
			-- Context menu handler for a feature
		require
			not_compiled_implies_name_not_void: not a_compiled implies a_name /= Void
		local
			l_factory: EB_CONTEXT_MENU_FACTORY
		do
			l_factory := features_tool.develop_window.menus.context_menu_factory
			if a_compiled then
				l_factory.standard_compiler_item_menu (a_menu, a_target_list, a_source, a_pebble)
			else
				l_factory.uncompiled_feature_item_menu (a_menu, a_target_list, a_source, a_pebble, a_name)
			end
		end

	feature_clause_item_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; fclause: FEATURE_CLAUSE_AS) is
			-- Context menu handler for a feature
		local
			l_factory: EB_CONTEXT_MENU_FACTORY
		do
			l_factory := features_tool.develop_window.menus.context_menu_factory
			l_factory.feature_clause_item_menu (a_menu, a_target_list, a_source, a_pebble, fclause)
		end

feature {NONE} -- Implementation

	on_key_pushed (a_key: EV_KEY) is
			-- If `a_key' is enter, set a stone in the development window.
		require
			a_key_not_void: a_key /= Void
		local
			l_data: ANY
		do
				-- When features tree is created, there is no element and therefore
				-- no selected items.
			if selected_item /= Void then
				l_data := selected_item.data
			end
			if a_key.code = {EV_KEY_CONSTANTS}.Key_enter and then l_data /= Void then
				if {l_feature: !E_FEATURE} l_data then
					nagivate_to_feature (l_feature)
				elseif {l_clause: !FEATURE_CLAUSE_AS} l_data then
					nagivate_to_feature_clause (l_clause, True)
				end
			end
		end

	button_go_to (ef: E_FEATURE; a_x: INTEGER; a_y: INTEGER; a_button: INTEGER
						 a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE
						 a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Target `features_tool' to `ef'.
		require
			ef_not_void: ef /= Void
		do
			if a_button = 1 and then {l_ef: !E_FEATURE} ef then
				nagivate_to_feature (l_ef)
			end
		end

	button_go_to_clause (fclause: FEATURE_CLAUSE_AS; a_x: INTEGER; a_y: INTEGER; a_button: INTEGER
						 a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE
						 a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Target `features_tool' to `fclause'.
		require
			fclause_not_void: fclause /= Void
		do
			if a_button = 1 and {l_clause: !FEATURE_CLAUSE_AS} fclause then
				nagivate_to_feature_clause (l_clause, False)
			end
		end

	build_tree_folder (n: STRING; fl: EIFFEL_LIST [FEATURE_AS]; a_class: CLASS_C): EV_TREE_ITEM is
			-- Build the tree node corresponding to feature clause named `n'.
		require
			fl_not_void: fl /= Void
			a_class_not_void: a_class /= Void
		local
			tree_item: EV_TREE_ITEM
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
						create tree_item
						if ef = Void then
							tree_item.set_text (f_item_name)
							tree_item.set_data (f_item_name)
							if is_clickable then
								if {l_feature_name: !STRING_8} l_first_item_name then
									tree_item.pointer_button_press_actions.force_extend (
										agent nagivate_to_feature_by_name (l_feature_name))
									tree_item.set_pixmap (pixmap_from_feature_ast (l_external, fa, f_names.index))
									tree_item.set_configurable_target_menu_mode
									tree_item.set_configurable_target_menu_handler (agent feature_item_handler (?, ?, ?, ?, False, l_feature_name))
								end
							end
						else
							tree_item.set_data (ef)
							if is_clickable then
								tree_item.pointer_button_press_actions.extend (
									agent button_go_to (ef, ?, ?, ?, ?, ?, ?, ?, ?))
									tree_item.set_configurable_target_menu_mode
									tree_item.set_configurable_target_menu_handler (agent feature_item_handler (?, ?, ?, ?, True, Void))
							end
							tree_item.set_text (feature_name (ef))
							tree_item.set_pixmap (pixmap_from_feature_ast (l_external, fa, f_names.index))
							create st.make (ef)
							tree_item.set_pebble (st)
							tree_item.set_accept_cursor (st.stone_cursor)
							tree_item.set_deny_cursor (st.X_stone_cursor)
						end
						Result.extend (tree_item)
						f_names.forth
					end
				end
				fl.forth
			end
		end

	build_tree_folder_for_external (n: STRING; fl: DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]; a_class: CLASS_C): EV_TREE_ITEM is
			-- Build the tree node corresponding to feature clause named `n'.
		require
			a_class_attached: a_class /= Void
		local
			tree_item: EV_TREE_ITEM
			ef: E_FEATURE
			st: FEATURE_STONE
		do
			create Result
			if n /= Void and then not n.is_empty then
				Result.set_text (n)
			else
				Result.set_text (Interface_names.l_no_feature_group_clause)
			end
			from
				fl.start
			until
				fl.after
			loop
				if fl.item = Void then
					Result.extend (create {EV_TREE_ITEM}.make_with_text (
						warning_messages.w_short_internal_error ("Void feature")))
				else
					if is_clickable then
						if a_class.has_feature_table then
							ef := a_class.feature_with_name (
								fl.item.eiffel_name)
							if ef = Void then
									-- Check for infix feature
								ef := a_class.feature_with_name (
									"infix %"" + fl.item.eiffel_name + "%"")
								if ef = Void then
										-- Check for prefix feature
									ef := a_class.feature_with_name (
										"prefix %"" + fl.item.eiffel_name + "%"")
								end
							end
						end
					end
					if ef = Void then
						Result.extend (create {EV_TREE_ITEM}.make_with_text (
							warning_messages.w_short_internal_error ("Void feature")))
					else
						create tree_item
						tree_item.set_data (ef)
						tree_item.pointer_button_press_actions.extend (
						agent button_go_to (ef, ?, ?, ?, ?, ?, ?, ?, ?))
						tree_item.set_configurable_target_menu_mode
						tree_item.set_configurable_target_menu_handler (agent feature_item_handler (?, ?, ?, ?, True, Void))
						tree_item.set_text (feature_name (ef))
						tree_item.set_pixmap (pixmap_from_e_feature (ef))

						create st.make (ef)
						tree_item.set_pebble (st)
						tree_item.set_accept_cursor (st.stone_cursor)
						tree_item.set_deny_cursor (st.X_stone_cursor)
						Result.extend (tree_item)
					end
				end
				fl.forth
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_FEATURES_TREE


