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

	EV_TREE

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

	make (a_features_tool: EB_FEATURES_TOOL; clickable: BOOLEAN) is
			-- Initialization: build the widget and the tree.
		do
			is_clickable := clickable
			features_tool := a_features_tool
			update_states
			default_create

			set_minimum_height (20)
			key_press_actions.extend (agent on_key_pushed)
		end

feature -- Status report

	is_clickable: BOOLEAN
			-- Is the class corresponding to the item loaded in the tool when
			-- the user left-click on it.

feature -- Access

	update_states is
			-- Update command states
		do
			is_signature_enabled := features_tool.is_signature_enabled
			is_alias_enabled := features_tool.is_alias_enabled
			is_assigner_enabled := features_tool.is_assigner_enabled
		end

	update_all is
			-- Update feature tree
		do
			update_states
			recursive_do_all (agent update_node)
		end

	update_node (n: EV_TREE_NODE) is
			-- Update node alias name and signature
		local
			ef: E_FEATURE
		do
			ef ?= n.data
			if ef /= Void then
				n.set_text (feature_name (ef))
			end
		end

	is_signature_enabled: BOOLEAN
			-- Do we display signature of feature ?

	is_alias_enabled: BOOLEAN
			-- Is alias name shown?

	is_assigner_enabled: BOOLEAN
			-- Is assigner command shown?

feature {EB_FEATURES_TOOL} -- Implementation

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

	build_tree (fcl: EIFFEL_LIST [FEATURE_CLAUSE_AS]) is
			-- Build the feature tree corresponding to current class.
		require
			feature_clause_list_not_void: fcl /= Void
		local
			features: EIFFEL_LIST [FEATURE_AS]
			tree_item: EV_TREE_ITEM
			name: STRING
			expand_tree: BOOLEAN
			retried: BOOLEAN
			l_class: CLASS_C
			l_export_status: EXPORT_I
			l_match_list: LEAF_AS_LIST
			l_comments: EIFFEL_COMMENTS
		do
			if not retried then
				expand_tree := preferences.feature_tool_data.expand_feature_tree
				l_class := features_tool.current_compiled_class
				l_match_list := match_list_server.item (l_class.class_id)
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
							name := l_comments.first
						end
						name.right_adjust
					end
					tree_item := build_tree_folder (name, features, l_class)
					l_export_status := export_status_generator.
					feature_clause_export_status (l_class, fcl.item)
					if l_export_status.is_none then
						tree_item.set_pixmap (Pixmaps.Icon_feature_clause_none)
					elseif l_export_status.is_set then
						tree_item.set_pixmap (Pixmaps.Icon_feature_clause_some)
					else
						tree_item.set_pixmap (Pixmaps.Icon_feature_clause_any)
					end
					if is_clickable then
						tree_item.set_data (fcl.item)
						tree_item.pointer_button_press_actions.extend (
							agent button_go_to_clause (fcl.item, ?, ?, ?, ?, ?, ?, ?, ?))
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
			class_text: STRING
			retried: BOOLEAN
			l_dev_win: EB_DEVELOPMENT_WINDOW
			l_clauses: ARRAYED_LIST [DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]]
		do
			if not retried then
				expand_tree := preferences.feature_tool_data.expand_feature_tree
				class_text := features_tool.current_compiled_class.text
				l_dev_win := Window_manager.last_focused_development_window
				if l_dev_win /= Void then
					l_clauses := l_dev_win.get_feature_clauses (a_class.name)
				end
				if l_clauses.is_empty then
					extend (create {EV_TREE_ITEM}.make_with_text (Interface_names.l_compile_first))
				elseif class_text /= Void then
					from
						l_clauses.start
					until
						l_clauses.after
					loop
						name := l_clauses.item.name
						name.right_adjust
						tree_item := build_tree_folder_for_external (name, l_clauses.item)
						if not l_clauses.item.is_exported then
							tree_item.set_pixmap (Pixmaps.Icon_feature_clause_none)
						else
							tree_item.set_pixmap (Pixmaps.Icon_feature_clause_any)
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
				else
					wipe_out
					extend (create {EV_TREE_ITEM}.make_with_text (
						Warning_messages.w_cannot_read_file (
							features_tool.current_compiled_class.file_name)))
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

	on_key_pushed (a_key: EV_KEY) is
			-- If `a_key' is enter, set a stone in the development window.
		require
			a_key_not_void: a_key /= Void
		local
			l_data: ANY
			l_feature: E_FEATURE
			l_clause: FEATURE_CLAUSE_AS
		do
				-- When features tree is created, there is no element and therefore
				-- no selected items.
			if selected_item /= Void then
				l_data := selected_item.data
			end
			if a_key.code = {EV_KEY_CONSTANTS}.Key_enter and then l_data /= Void then
				l_feature ?= l_data
				if l_feature /= Void then
					features_tool.go_to (l_feature)
				else
					l_clause ?= l_data
					if l_clause /= Void then
						features_tool.go_to_clause (l_clause)
					end
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
			if a_button = 1 then
				features_tool.go_to (ef)
			end
		end

	button_go_to_clause (fclause: FEATURE_CLAUSE_AS; a_x: INTEGER; a_y: INTEGER; a_button: INTEGER
						 a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE
						 a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Target `features_tool' to `fclause'.
		require
			fclause_not_void: fclause /= Void
		do
			if a_button = 1 then
				features_tool.go_to_clause (fclause)
			end
		end

	features_tool: EB_FEATURES_TOOL
			-- Associated features tool.

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
		do
			create Result
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
					from
						f_names := fa.feature_names
						f_names.start
					until
						f_names.after
					loop
						f_item_name := f_names.item.internal_name
						if a_class.has_feature_table then
							ef := a_class.feature_with_name (f_item_name)
						end
						create tree_item
						if ef = Void then
							tree_item.set_text (f_item_name)
							tree_item.pointer_button_press_actions.force_extend (
								agent features_tool.go_to_line (fa.start_location.line))
							tree_item.set_pixmap (pixmaps.Icon_feature)
						else
							if is_clickable then
								tree_item.set_data (ef)
								tree_item.pointer_button_press_actions.extend (
									agent button_go_to (ef, ?, ?, ?, ?, ?, ?, ?, ?))
							end

							tree_item.set_text (feature_name (ef))
							tree_item.set_pixmap (pixmap_from_e_feature (ef))
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

	build_tree_folder_for_external (n: STRING; fl: DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]): EV_TREE_ITEM is
			-- Build the tree node corresponding to feature clause named `n'.
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
						if
							features_tool.current_compiled_class /= Void and then
							features_tool.current_compiled_class.has_feature_table
						then
							ef := features_tool.current_compiled_class.feature_with_name (
								fl.item.eiffel_name)
							if ef = Void then
									-- Check for infix feature
								ef := features_tool.current_compiled_class.feature_with_name (
									"infix %"" + fl.item.eiffel_name + "%"")
								if ef = Void then
										-- Check for prefix feature
									ef := features_tool.current_compiled_class.feature_with_name (
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

