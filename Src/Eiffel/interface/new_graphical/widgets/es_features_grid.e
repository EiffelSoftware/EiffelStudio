indexing
	description: "Tree enabled Grid representing the features of the class currently opened"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_FEATURES_GRID

inherit
	ES_GRID

	EB_EDITOR_TOKEN_GRID_SUPPORT
		rename
			on_pick_start_from_grid_pickable_item as evs_on_pebble_function
		undefine
			default_create, is_equal, copy
		redefine
			evs_on_pebble_function
		end

	CHARACTER_ROUTINES
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

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

			enable_single_row_selection
			enable_tree
			enable_last_column_use_all_width
			enable_vertical_scrolling_per_item
			hide_tree_node_connectors
			hide_header

			set_item_pebble_function (agent on_pebble_function)
			set_item_accept_cursor_function (agent on_item_accept_cursor_function)
			set_item_deny_cursor_function (agent on_item_deny_cursor_function)
			pointer_button_release_item_actions.extend (agent on_item_right_clicked)

			set_minimum_height (20)
			key_press_actions.extend (agent on_key_pushed)
			enable_default_tree_navigation_behavior (False, False, False, True)

			make_with_grid (Current)

			set_configurable_target_menu_mode
			set_configurable_target_menu_handler (agent on_menu_handler (?, ?, ?, ?))
		end

feature -- Status report

	is_clickable: BOOLEAN
			-- Is the class corresponding to the item loaded in the tool when
			-- the user left-click on it.

	is_empty: BOOLEAN is
			-- Is current empty ?
		do
			Result := row_count = 0
		end

feature {NONE} -- Access

	features_tool: ES_FEATURES_TOOL_PANEL
			-- Associated features tool.

	last_class: CLASS_I
			-- Last set class, the tree was built with

feature {NONE} -- Status report

	is_signature_enabled: BOOLEAN
			-- Do we display signature of feature ?

	is_alias_enabled: BOOLEAN
			-- Is alias name shown?

	is_assigner_enabled: BOOLEAN
			-- Is assigner command shown?

	is_editor_token_enabled: BOOLEAN
			-- Is Editor token grid item enabled ?

	grid_item_pnd_support_enabled: BOOLEAN
			-- Is grid_item_pnd_support enabled ?

feature {NONE} -- Status setting

	update_states
			-- Update command states
		do
			is_signature_enabled := features_tool.is_showing_signatures
			is_alias_enabled := features_tool.is_showing_alias
			is_assigner_enabled := features_tool.is_showing_assigners
			is_editor_token_enabled := is_clickable and is_signature_enabled
										and not is_alias_enabled
										and not is_assigner_enabled
			if is_editor_token_enabled then
				if not grid_item_pnd_support_enabled then
					enable_grid_item_pnd_support
					grid_item_pnd_support_enabled := True
				end
			else
				if grid_item_pnd_support_enabled then
					disable_grid_item_pnd_support
					grid_item_pnd_support_enabled := False
				end
			end
		end

feature -- Basic operations

	update_all
			-- Updates all feature tree nodes
		do
			update_states
			recursive_do_all (agent update_row)
		end

	recursive_do_all (ag: PROCEDURE [ANY, TUPLE [EV_GRID_ROW]]) is
			-- Recursively call `ag' on each row
		local
			r,n: INTEGER
		do
			from
				r := 1
				n := row_count
			until
				r > n
			loop
				ag.call ([row (r)])
				r := r + 1
			end
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
			l_window.set_feature_locating (True)
			l_window.set_stone (create {!FEATURE_STONE}.make (a_feature))
			l_window.set_feature_locating (False)
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
				if {l_class: !CLASS_I} last_class then
					l_text := l_class.text
				end
				if l_text = Void then
					l_text := l_editor.text
				end

				if l_text /= Void and then {l_formatter: !EB_BASIC_TEXT_FORMATTER} l_window.pos_container then
						-- Ensure we are in edit mode in the editor.

						-- Fetch line number
					l_pos := a_clause.start_position
					if l_pos <= l_text.count then
						l_text := l_text.substring (1, l_pos)
					end
					l_line := l_text.occurrences ('%N')

					if not a_focus then
						l_editor.display_line_at_top_when_ready  (l_line, 0)
					else
						l_editor.docking_content.set_focus
						l_editor.set_focus
						l_editor.scroll_to_start_of_line_when_ready_if_top (l_line, 0, False, True)
					end
				end
			else
				check False end
			end
		end

feature {NONE} -- Basic operations

	update_row (a_row: EV_GRID_ROW) is
			-- Update node alias name and signature
		require
			a_row_attached: a_row /= Void
		do
			if a_row.count > 0 then
				if {l_ef: !E_FEATURE} data_from_row (a_row) then
					update_tree_item_for_e_feature (a_row, l_ef)
				end
			end
		end

	data_from_row (a_row: EV_GRID_ROW): ANY is
			-- Data related to `a_row'
		do
			if a_row /= Void and then a_row.count > 0 then
				Result := data_from_item (a_row.item (1))
			end
			if Result = Void then
				Result := a_row.data
			end
		end

	data_from_item (a_item: EV_GRID_ITEM): ANY is
			-- Data related to `a_item'
		do
			if a_item /= Void then
				Result := a_item.data
			end
		end

feature -- Tree construction

	ensure_first_row_visible is
			-- Ensure first row is visible (if any)
		do
			if row_count > 0 then
				row (1).ensure_visible
			end
		end

	retrieve_row_recursively_by_data (a_data: ANY; a_compare_object: BOOLEAN): EV_GRID_ROW is
		require
			a_data_not_void: a_data /= Void
		local
			r,n: INTEGER
			d: ANY
		do
			from
				r := 1
				n := row_count
			until
				r > n or Result /= Void
			loop
				Result := row (r)
				d := data_from_row (Result)
				if a_compare_object then
					if d = Void or else not (d.same_type (a_data) and then d.is_equal (a_data)) then
						Result := Void
					end
				elseif d /= a_data then
					Result := Void
				end
				r := r + 1
			end
		end

	selected_row: EV_GRID_ROW is
			-- Selected row
		local
			lst: like  selected_rows
		do
			lst := selected_rows
			if not lst.is_empty then
				Result := selected_rows.first
			end
		end

	extend_item (a_grid_item: EV_GRID_ITEM) is
			-- Extend `a_grid_item' to Current grid
			-- (in new row)
		do
			extended_new_row.set_item (1, a_grid_item)
		end

	extend_message_item (a_mesg: STRING_GENERAL) is
			-- Extend message `a_mesg' to Current grid
			-- (in new row)
		require
			a_mesg_not_void: a_mesg /= Void
		do
			extend_item (create {EV_GRID_LABEL_ITEM}.make_with_text (a_mesg))
		end

	extend_sub_item	(a_row: EV_GRID_ROW; a_grid_item: EV_GRID_ITEM) is
			-- Extend `a_grid_item' in subrow of `a_row'
		do
			extended_new_subrow (a_row).set_item (1, a_grid_item)
		end

	build_tree (fcl: EIFFEL_LIST [FEATURE_CLAUSE_AS]; a_class: CLASS_C) is
			-- Build the feature tree corresponding to current class.
		require
			feature_clause_list_not_void: fcl /= Void
			a_class_attached: a_class /= Void
		local
			l_row: EV_GRID_ROW
			cname: STRING
			name: STRING_GENERAL
			expand_tree: BOOLEAN
			retried: BOOLEAN
			l_match_list: LEAF_AS_LIST
			l_comments: EIFFEL_COMMENTS
		do
			if not retried then
				last_class := a_class.lace_class

				update_states

				expand_tree := preferences.feature_tool_data.expand_feature_tree
				l_match_list := match_list_server.item (a_class.class_id)
					--| Features
				from
					fcl.start
				until
					fcl.after
				loop
					if fcl.item = Void then
						extend_message_item (Warning_messages.w_short_internal_error ("Void feature clause"))
					else
						l_comments := fcl.item.comment (l_match_list)
						if l_comments /= Void and then not l_comments.is_empty then
							cname := l_comments.first.content.twin
							cname.right_adjust
							name := cname
						end
						if name = Void or else name.is_empty then
							name := Interface_names.l_no_feature_group_clause
						end
						l_row := extended_folder_row (fcl.item, name, a_class)
						if
							expand_tree and then
							l_row.is_expandable
						then
							l_row.expand
						end
					end
					fcl.forth
				end
				if fcl.is_empty then
						-- Display a message not to confuse the user.
					extend_message_item (Warning_messages.w_no_feature_to_display)
				end
			else
				extend_message_item (Warning_messages.w_short_internal_error ("Crash in build_tree"))
			end
		ensure
			last_class_set: last_class = a_class.lace_class
		rescue
			retried := True
			retry
		end

	build_tree_for_external (a_class: CLASS_C) is
			-- Build the feature tree corresponding to current .NET class 'a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			l_row: EV_GRID_ROW
			cname: STRING
			name: STRING_GENERAL
			expand_tree: BOOLEAN
			retried: BOOLEAN
			l_dev_win: EB_DEVELOPMENT_WINDOW
			l_clauses: ARRAYED_LIST [DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]]
		do
			if not retried then
				last_class := a_class.lace_class

				update_states

				expand_tree := preferences.feature_tool_data.expand_feature_tree
				l_dev_win := Window_manager.last_focused_development_window
				if l_dev_win /= Void then
					l_clauses := l_dev_win.get_feature_clauses (a_class.name)
				end
				if l_clauses.is_empty then
					extend_message_item (Interface_names.l_compile_first)
				else
					from
						l_clauses.start
					until
						l_clauses.after
					loop
						cname := l_clauses.item.name
						if cname /= Void then
							cname := cname.twin
							cname.right_adjust
							name := cname
						end
						if name = Void or else name.is_empty then
							name := Interface_names.l_no_feature_group_clause
						end
						l_row := extended_folder_row_for_external (name, l_clauses.item, a_class)
						if
							expand_tree and then
							l_row.is_expandable
						then
							l_row.expand
						end
						l_clauses.forth
					end
					if l_clauses.is_empty then
							-- Display a message not to confuse the user.
						extend_message_item (Warning_messages.w_no_feature_to_display)
					end
				end
			else
				wipe_out
				extend_message_item (Interface_names.l_compile_first)
			end
		ensure
			last_class_set: last_class = a_class.lace_class
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

	on_menu_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA];
					a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Context menu handler for a feature
		local
			l_factory: EB_CONTEXT_MENU_FACTORY
		do
			if is_clickable then
				l_factory := features_tool.develop_window.menus.context_menu_factory
				if {fst: !FEATURE_STONE} a_pebble then
					if {fe: !E_FEATURE} fst.e_feature and then fe.is_compiled then
						l_factory.standard_compiler_item_menu (a_menu, a_target_list, a_source, a_pebble)
					else
						l_factory.uncompiled_feature_item_menu (a_menu, a_target_list, a_source, a_pebble, fst.feature_name)
					end
				elseif {fc: !FEATURE_CLAUSE_AS} (data_from_row (selected_row)) then
					l_factory.feature_clause_item_menu (a_menu, a_target_list, a_source, a_pebble, fc)
				end
			end
		end

feature {NONE} -- Event handler

	on_item_right_clicked (ax,ay, ab: INTEGER; a_item: EV_GRID_ITEM) is
			-- Action to process when Ctrl+Right click in raise
		local
			st: FEATURE_STONE
		do
			if ab = {EV_POINTER_CONSTANTS}.right and ev_application.ctrl_pressed then
				if a_item /= Void and then {fe: !E_FEATURE} data_from_item (a_item) then
					create st.make (fe)
					if st.is_valid then
						(create {EB_CONTROL_PICK_HANDLER}).launch_stone (st)
					end
				end
			end
		end

	evs_on_pebble_function (a_item: EV_GRID_ITEM; a_grid_support: EB_EDITOR_TOKEN_GRID_SUPPORT) is
		local
			l_pebble: ANY
		do
			l_pebble := on_pebble_function (a_item)
			if l_pebble = Void then
				Precursor {EB_EDITOR_TOKEN_GRID_SUPPORT} (a_item, a_grid_support)
			end
		end

	on_pebble_function (a_item: EV_GRID_ITEM): ANY is
			-- Pebble associated with `a_item'
		local
			d: like data_from_item
		do
			if {gf: !EB_GRID_EDITOR_TOKEN_ITEM} a_item then
			else
				d := data_from_item (a_item)
				if {ef: !E_FEATURE} d  then
					create {FEATURE_STONE} Result.make (ef)
				end
			end
		end

	on_item_accept_cursor_function (a_item: EV_GRID_ITEM): EV_POINTER_STYLE is
			-- Accept cursor computing
		do
			if {st: !STONE} on_pebble_function (a_item) then
				Result := st.stone_cursor
			end
		end

	on_item_deny_cursor_function (a_item: EV_GRID_ITEM): EV_POINTER_STYLE is
			-- Deny cursor computing
		do
			if {st: !STONE} on_pebble_function (a_item) then
				Result := st.X_stone_cursor
			end
		end

	on_key_pushed (a_key: EV_KEY) is
			-- If `a_key' is enter, set a stone in the development window.
		require
			a_key_not_void: a_key /= Void
		local
			l_data: ANY
		do
				-- When features grid is created, there is no element and therefore
				-- no selected items.
			if {l_row: !EV_GRID_ROW} selected_row then
				l_data := data_from_row (l_row)
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

	extended_folder_row (fc: FEATURE_CLAUSE_AS; n: STRING_GENERAL; a_class: CLASS_C): EV_GRID_ROW is
			-- Build the grid row corresponding to feature clause named `n'.
		require
			fc_not_void: fc /= Void
			a_class_not_void: a_class /= Void
			n_not_empty: n /= Void and then not n.is_empty
		local
			fl: EIFFEL_LIST [FEATURE_AS]
			l_row: EV_GRID_ROW
			ef: E_FEATURE
			fa: FEATURE_AS
			f_names: EIFFEL_LIST [FEATURE_NAME]
			f_item_name: STRING
			l_first_item_name: STRING
			l_external: BOOLEAN
			l_export_status: EXPORT_I
			pix: EV_PIXMAP
		do
			Result := extended_new_row

			l_export_status := export_status_generator.feature_clause_export_status (system, a_class, fc)
			if l_export_status.is_none then
				pix := pixmaps.icon_pixmaps.folder_features_none_icon
			elseif l_export_status.is_set then
				pix := pixmaps.icon_pixmaps.folder_features_some_icon
			else
				pix := pixmaps.icon_pixmaps.folder_features_all_icon
			end
			add_tree_item_for_feature_clause (Result, fc, n, pix)

			fl := fc.features
			l_external := a_class.is_external
			from
				fl.start
			until
				fl.after
			loop
				fa := fl.item
				if fa = Void then
					l_row := extended_new_subrow (Result)
					add_tree_item_for_text (l_row, warning_messages.w_short_internal_error ("Void feature"))
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

						l_row := extended_new_subrow (Result)
						if ef = Void then
							add_tree_item_for_feature_name (l_row, l_first_item_name, f_item_name, pixmap_from_feature_ast (l_external, fa, f_names.index))
						else
							add_tree_item_for_e_feature (l_row, ef, pixmap_from_feature_ast (l_external, fa, f_names.index))
						end
						f_names.forth
					end
				end
				fl.forth
			end
		end

	extended_folder_row_for_external (n: STRING_GENERAL; fl: DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]; a_class: CLASS_C): EV_GRID_ROW is
			-- Build the tree node corresponding to feature clause named `n'.
		require
			fl_not_void: fl /= Void
			n_not_empty: n /= Void and then not n.is_empty
			a_class_attached: a_class /= Void
		local
			ef: E_FEATURE
			l_row: EV_GRID_ROW
			pix: EV_PIXMAP
		do
			Result := extended_new_row

			if not fl.is_exported then
				pix := pixmaps.icon_pixmaps.folder_features_none_icon
			else
				pix := pixmaps.icon_pixmaps.folder_features_all_icon
			end
			add_tree_item_for_dotnet_feature_clause (Result, fl, n, pix)

			from
				fl.start
			until
				fl.after
			loop
				if fl.item = Void then
					l_row := extended_new_subrow (Result)
					add_tree_item_for_text (l_row, warning_messages.w_short_internal_error ("Void feature"))
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
					l_row := extended_new_subrow (Result)
					if ef = Void then
						--| FIXME jfiat [2008/02/26] : if not is_clickable, there is Void ef...
						if is_clickable then
							add_tree_item_for_text (l_row, warning_messages.w_short_internal_error ("Void feature"))
						else
							add_tree_item_for_text (l_row, fl.item.eiffel_name)
						end
					else
						add_tree_item_for_e_feature (l_row, ef, pixmap_from_e_feature (ef))
					end
				end
				fl.forth
			end
		end

feature {NONE} -- Tree item factory

	Grid_feature_style: EB_FEATURE_EDITOR_TOKEN_STYLE is
			-- Feature style to generate editor token informaton of feature
		once
			create Result
			Result.enable_argument
			Result.disable_comment
			Result.disable_class
			Result.enable_return_type
			Result.disable_value_for_constant
			Result.disable_use_overload_name
		ensure
			result_attached: Result /= Void
		end

	add_tree_item_for_text (a_row: EV_GRID_ROW; a_text: STRING_GENERAL) is
		local
			lab: EV_GRID_LABEL_ITEM
		do
			create lab.make_with_text (a_text)
			a_row.set_item (1, lab)
		end

	update_tree_item_for_e_feature (a_row: EV_GRID_ROW; ef: E_FEATURE) is
			--
		local
			lab: EV_GRID_LABEL_ITEM
			gf: EB_GRID_EDITOR_TOKEN_ITEM
		do
			if a_row.count > 0 then
				gf ?= a_row.item (1)
				lab ?= a_row.item (1)
				if is_editor_token_enabled then
					if gf = Void then
						check lab /= Void end
						a_row.clear
						add_tree_item_for_e_feature (a_row, ef, lab.pixmap)
					else
						-- nothing to change
					end
				else
					if lab /= Void then
						lab.set_text (feature_name (ef))
					else
						check gf /= Void end
						a_row.clear
						add_tree_item_for_e_feature (a_row, ef, gf.pixmap)
					end
				end
			end
		end

	editor_token_font_info: TUPLE [f: SPECIAL [EV_FONT]; h: INTEGER] is
			-- Info for Editor tokens
		local
			esw: EB_SHARED_WRITER
		once
			create esw
			Result := [esw.label_font_table, esw.label_font_height]
		end

	add_tree_item_for_e_feature (a_row: EV_GRID_ROW; ef: E_FEATURE; pix: EV_PIXMAP) is
		local
			lab: EV_GRID_LABEL_ITEM
			l_text: STRING_GENERAL
			i: EV_GRID_ITEM
			gf: EB_GRID_EDITOR_TOKEN_ITEM
			f: EV_FONT
		do
			a_row.set_data (ef)
			l_text := feature_name (ef)

			if is_editor_token_enabled then
				create gf.make_with_text (l_text.as_string_8)
				gf.set_pixmap (pix)
				gf.set_data (ef)

				create f
				gf.set_overriden_fonts (editor_token_font_info.f, editor_token_font_info.h)
				Grid_feature_style.set_e_feature (ef)
				gf.set_text_with_tokens (Grid_feature_style.text)

				i := gf
			else
				create lab.make_with_text (l_text)
				lab.set_pixmap (pix)
				lab.set_data (ef)
				i := lab
			end
			if is_clickable then
				i.pointer_button_press_actions.extend (agent button_go_to (ef, ?, ?, ?, ?, ?, ?, ?, ?))
			end
			a_row.set_item (1, i)
		end

	add_tree_item_for_feature_name (a_row: EV_GRID_ROW; ffn: STRING; a_text: STRING_GENERAL; pix: EV_PIXMAP) is
		local
			lab: EV_GRID_LABEL_ITEM
		do
			create lab.make_with_text (a_text)
			lab.set_pixmap (pix)
			lab.set_data (a_text)
			if is_clickable then
				if {l_feature_name: !STRING_8} ffn then
					lab.pointer_button_press_actions.force_extend (agent nagivate_to_feature_by_name (l_feature_name))
				end
			end
			a_row.set_item (1, lab)
		end

	add_tree_item_for_feature_clause (a_row: EV_GRID_ROW; fc: FEATURE_CLAUSE_AS; a_text: STRING_GENERAL; pix: EV_PIXMAP) is
		local
			lab: EV_GRID_LABEL_ITEM
		do
			create lab.make_with_text (a_text)
			lab.set_pixmap (pix)
			lab.set_data (fc)
			if is_clickable then
				lab.pointer_button_press_actions.extend (agent button_go_to_clause (fc, ?, ?, ?, ?, ?, ?, ?, ?))
			end
			a_row.set_data (fc)
			a_row.set_item (1, lab)
		end

	add_tree_item_for_dotnet_feature_clause (a_row: EV_GRID_ROW; fd: DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]; a_text: STRING_GENERAL; pix: EV_PIXMAP) is
		local
			lab: EV_GRID_LABEL_ITEM
		do
			create lab.make_with_text (a_text)
			lab.set_pixmap (pix)
			lab.set_data (fd)
			if is_clickable then
				--| To implemente ... maybe
			end
			a_row.set_data (fd)
			a_row.set_item (1, lab)
		end

;indexing
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

end -- class ES_FEATURES_GRID


