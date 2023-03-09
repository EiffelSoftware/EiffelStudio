note
	description: "Tree enabled Grid representing the features of the class currently opened"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_FEATURES_GRID

inherit
	ES_IDE_GRID
		redefine
			internal_recycle,
			on_zoom
		end

	EB_EDITOR_TOKEN_GRID_SUPPORT
		rename
			on_pick_start_from_grid_pickable_item as evs_on_pebble_function
		undefine
			default_create, is_equal, copy
		redefine
			evs_on_pebble_function,
			internal_recycle
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

	EB_SHARED_FORMAT_TABLES
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_WRITER
		undefine
			default_create, is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_features_tool: like features_tool; clickable: BOOLEAN)
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

feature {NONE} -- Implementation		

	internal_recycle
		do
			Precursor {EB_EDITOR_TOKEN_GRID_SUPPORT}
			Precursor {ES_IDE_GRID}
		end

feature -- Status report

	is_clickable: BOOLEAN
			-- Is the class corresponding to the item loaded in the tool when
			-- the user left-click on it.

	is_empty: BOOLEAN
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

	recursive_do_all (ag: PROCEDURE [EV_GRID_ROW])
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

	navigate_to_feature (a_feature: E_FEATURE)
			-- Navigates to a feature in using a default view.
			--
			-- `a_feature': A feature to navigate to.
		require
			a_feature_attached: a_feature /= Void
		local
			l_window: EB_DEVELOPMENT_WINDOW
		do
			l_window := features_tool.develop_window
			l_window.set_feature_locating (True)
			l_window.set_stone (create {FEATURE_STONE}.make (a_feature))
			l_window.set_feature_locating (False)
		end

	navigate_to_feature_by_name (a_feature: STRING_32)
			-- Navigates to a feature in using a default view.
			--
			-- `a_feature': A feature name used to navigate to a feature.
		require
			a_feature_attached: a_feature /= Void
			not_a_feature_is_empty: not a_feature.is_empty
		local
			l_window: EB_DEVELOPMENT_WINDOW
		do
			l_window := features_tool.develop_window
			if attached l_window.editors_manager.current_editor as l_editor then
				if attached {EB_BASIC_TEXT_FORMATTER} l_window.pos_container as l_formatter then
					l_window.managed_main_formatters.first.execute
				end
				l_editor.find_feature_named (a_feature)
			end
		end

	navigate_to_feature_clause (a_clause: FEATURE_CLAUSE_AS; a_focus: BOOLEAN)
			-- Navigates to a feature clause in the default view.
			--
			-- `a_clause': The feature clause to navigate too.
			-- `a_focus': True to set focus, False otherwise.
		require
			a_clause_attached: a_clause /= Void
		do
			navigate_to_ast (a_clause, a_focus)
		end

	navigate_to_ast (a_ast: AST_EIFFEL; a_focus: BOOLEAN)
			-- Navigates to a inherit clause in the default view.
			--
			-- `a_ast': The inherit clause to navigate too.
			-- `a_focus': True to set focus, False otherwise.
		require
			a_ast_attached: a_ast /= Void
		local
			l_line: INTEGER
			l_window: EB_DEVELOPMENT_WINDOW
		do
			check
				a_ast_is_valid: a_ast.start_position > 0
			end
			l_window := features_tool.develop_window
			if attached l_window.editors_manager.current_editor as l_editor then
				if attached {EB_BASIC_TEXT_FORMATTER} l_window.pos_container as l_formatter then
						-- Ensure we are in edit mode in the editor.

						-- Fetch line number
					l_line := a_ast.start_location.line

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

	update_row (a_row: EV_GRID_ROW)
			-- Update node alias name and signature
		require
			a_row_attached: a_row /= Void
		do
			if
				a_row.count > 0 and then
				attached {E_FEATURE} data_from_row (a_row) as l_ef
			then
				update_tree_item_for_e_feature (a_row, l_ef)
			end
		end

	data_from_row (a_row: EV_GRID_ROW): ANY
			-- Data related to `a_row'
		do
			if a_row /= Void then
				if a_row.count > 0 then
					Result := data_from_item (a_row.item (1))
				end
				if Result = Void then
					Result := a_row.data
				end
			end
		end

	data_from_item (a_item: EV_GRID_ITEM): ANY
			-- Data related to `a_item'
		do
			if a_item /= Void then
				Result := a_item.data
			end
		end

feature -- Tree construction

	ensure_first_row_visible
			-- Ensure first row is visible (if any)
		do
			if
				row_count > 0 and then
				attached row (1) as l_first and then
				l_first.is_displayed
			then
				l_first.ensure_visible
			end
		end

	retrieve_row_recursively_by_data (a_data: ANY; a_compare_object: BOOLEAN): EV_GRID_ROW
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

	selected_row: detachable EV_GRID_ROW
			-- Selected row
		do
			if has_selected_row then
				Result := selected_rows.first
			end
		end

	extend_item (a_grid_item: EV_GRID_ITEM)
			-- Extend `a_grid_item' to Current grid
			-- (in new row)
		do
			extended_new_row.set_item (1, a_grid_item)
		end

	extend_message_item (a_mesg: STRING_GENERAL)
			-- Extend message `a_mesg' to Current grid
			-- (in new row)
		require
			a_mesg_not_void: a_mesg /= Void
		do
			extend_item (new_grid_label_item (a_mesg))
		end

	extend_sub_item	(a_row: EV_GRID_ROW; a_grid_item: EV_GRID_ITEM)
			-- Extend `a_grid_item' in subrow of `a_row'
		do
			extended_new_subrow (a_row).set_item (1, a_grid_item)
		end

	build_tree (fcl: EIFFEL_LIST [FEATURE_CLAUSE_AS]; a_class: CLASS_C; a_class_ast: CLASS_AS)
			-- Build the feature tree corresponding to current class.
		require
			feature_clause_list_not_void: fcl /= Void
			a_class_attached: a_class /= Void
		local
			l_row: EV_GRID_ROW
			cname: STRING_32
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

				if attached a_class_ast.conforming_parents as l_conforming_parents then
					l_row := extended_parent_list_row (l_conforming_parents, "Inherit", a_class, l_match_list, expand_tree)
					if expand_tree and l_row.is_expandable then
						l_row.collapse
					end
				end
				if attached a_class_ast.non_conforming_parents as l_non_conforming_parents then
					l_row := extended_parent_list_row (l_non_conforming_parents, "Inherit {NONE}", a_class, l_match_list, expand_tree)
					if expand_tree and l_row.is_expandable then
						l_row.collapse
					end
				end

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
							cname := l_comments.first.content_32
							if cname.is_valid_as_string_8 then
								cname.right_adjust
							end
							name := cname
						else
								-- There is no feature clause comment.
							name := Void
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

	build_tree_for_external (a_class: CLASS_C)
			-- Build the feature tree corresponding to current .NET class 'a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			l_row: EV_GRID_ROW
			cname: STRING_32
			name: STRING_32
			expand_tree: BOOLEAN
			retried: BOOLEAN
			l_dev_win: EB_DEVELOPMENT_WINDOW
			l_clauses: ARRAYED_LIST [DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]]
			l_class: DOTNET_CLASS_AS
		do
			if not retried then
				last_class := a_class.lace_class

				update_states

				expand_tree := preferences.feature_tool_data.expand_feature_tree
				l_dev_win := Window_manager.last_focused_development_window
				if
					l_dev_win /= Void and then
					consumed_types.has (last_class.name)
				then
					create l_class.make (consumed_types.item (last_class.name), True, last_class)
					l_clauses := l_class.features
				end
				if l_clauses = Void then
					extend_message_item (Interface_names.l_compile_first)
				else
					from
						l_clauses.start
					until
						l_clauses.after
					loop
						cname := l_clauses.item.name_32
						if cname /= Void then
							cname := cname.twin
							string_general_left_adjust (cname)
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

	feature_name (a_ef: E_FEATURE): STRING_32
			-- Feature name of `a_ef' depending of the signature displayed or not.
		require
			a_ef_not_void: a_ef /= Void
		local
			assigner_name: STRING_32
		do
			Result := a_ef.name_32.twin
			if is_alias_enabled then
				if attached a_ef.aliases as lst then
					across
						lst as ic
					loop
						Result.append_string (" alias %"")
						Result.append_string (eiffel_string_32 (extract_alias_name_32 (ic.item.alias_name_32)))
						Result.append_character ('%"')
					end
				end
			end
			if is_signature_enabled then
				a_ef.append_arguments_to (Result)
				if a_ef.type /= Void then
					Result.append (": " + a_ef.type.dump)
				end
			end
			if is_assigner_enabled then
				assigner_name := a_ef.assigner_name_32
				if assigner_name /= Void then
					Result.append_string (" assign ")
					Result.append_string (assigner_name)
				end
			end
		end

feature {NONE} -- Context menu handler

	on_menu_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA];
					a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY)
			-- Context menu handler for a feature
		local
			l_factory: EB_CONTEXT_MENU_FACTORY
		do
			if is_clickable then
				l_factory := features_tool.develop_window.menus.context_menu_factory
				if attached {FEATURE_STONE} a_pebble as fst then
					if attached fst.e_feature as fe and then fe.is_compiled then
						l_factory.standard_compiler_item_menu (a_menu, a_target_list, a_source, a_pebble)
					else
						l_factory.uncompiled_feature_item_menu (a_menu, a_target_list, a_source, a_pebble, fst.feature_name)
					end
				elseif attached {FEATURE_CLAUSE_AS} data_from_row (selected_row) as fc then
					l_factory.feature_clause_item_menu (a_menu, a_target_list, a_source, a_pebble, fc)
				end
			end
		end

feature {NONE} -- Event handler

	on_item_right_clicked (ax,ay, ab: INTEGER; a_item: EV_GRID_ITEM)
			-- Action to process when Ctrl+Right click in raise
		local
			st: FEATURE_STONE
		do
			if
				ab = {EV_POINTER_CONSTANTS}.right and
				ev_application.ctrl_pressed and then
				a_item /= Void and then
				attached {E_FEATURE} data_from_item (a_item) as fe
			then
				create st.make (fe)
				if st.is_valid then
					(create {EB_CONTROL_PICK_HANDLER}).launch_stone (st)
				end
			end
		end

	evs_on_pebble_function (a_item: EV_GRID_ITEM; a_orignal_pointer_position: EV_COORDINATE; a_grid_support: EB_EDITOR_TOKEN_GRID_SUPPORT)
		local
			l_pebble: ANY
		do
			l_pebble := on_pebble_function (a_item)
			if l_pebble = Void then
				Precursor {EB_EDITOR_TOKEN_GRID_SUPPORT} (a_item, a_orignal_pointer_position, a_grid_support)
			end
		end

	on_pebble_function (a_item: EV_GRID_ITEM): detachable ANY
			-- Pebble associated with `a_item'
		local
			d: like data_from_item
		do
			if
				not ev_application.ctrl_pressed and then
				not attached {EB_GRID_EDITOR_TOKEN_ITEM} a_item
			then
				d := data_from_item (a_item)
				if attached {E_FEATURE} d as ef  then
					create {FEATURE_STONE} Result.make (ef)
				elseif attached {CLASS_I} d as ci then
					if ci.is_compiled then
						create {CLASSC_STONE} Result.make (ci.compiled_class)
					else
						create {CLASSI_STONE} Result.make (ci)
					end
				elseif attached {CLASS_C} d as cl then
					create {CLASSC_STONE} Result.make (cl)
				end
			end
		end

	on_item_accept_cursor_function (a_item: EV_GRID_ITEM): EV_POINTER_STYLE
			-- Accept cursor computing
		do
			if attached {STONE} on_pebble_function (a_item) as st then
				Result := st.stone_cursor
			end
		end

	on_item_deny_cursor_function (a_item: EV_GRID_ITEM): EV_POINTER_STYLE
			-- Deny cursor computing
		do
			if attached {STONE} on_pebble_function (a_item) as st then
				Result := st.X_stone_cursor
			end
		end

	on_key_pushed (a_key: EV_KEY)
			-- If `a_key' is enter, set a stone in the development window.
		require
			a_key_not_void: a_key /= Void
		local
			l_data: ANY
		do
				-- When features grid is created, there is no element and therefore
				-- no selected items.
			if attached selected_row as l_row then
				l_data := data_from_row (l_row)
			end
			if a_key.code = {EV_KEY_CONSTANTS}.Key_enter and then l_data /= Void then
				if attached {E_FEATURE} l_data as l_feature then
					navigate_to_feature (l_feature)
				elseif attached {FEATURE_CLAUSE_AS} l_data as l_clause then
					navigate_to_feature_clause (l_clause, True)
				end
			end
		end

	button_go_to (ef: E_FEATURE; a_x: INTEGER; a_y: INTEGER; a_button: INTEGER;
						 a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE;
						 a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Target `features_tool' to `ef'.
		require
			ef_not_void: ef /= Void
		local
			l_stone: FEATURE_STONE
		do
			if ef /= Void then
				if a_button = 1 then
					navigate_to_feature (ef)
				elseif a_button = 3 then
					if ev_application.ctrl_pressed then
						create l_stone.make (ef)
						if l_stone /= Void and then l_stone.is_valid then
							(create {EB_CONTROL_PICK_HANDLER}).launch_stone (l_stone)
						end
					end
				end
			end
		end

	button_go_to_clause (fclause: FEATURE_CLAUSE_AS; a_x: INTEGER; a_y: INTEGER; a_button: INTEGER;
						 a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE;
						 a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Target `features_tool' to `fclause'.
		do
			if a_button = 1 and fclause /= Void then
				navigate_to_feature_clause (fclause, False)
			end
		end

	button_go_to_ast (a_ast: AST_EIFFEL; a_x: INTEGER; a_y: INTEGER; a_button: INTEGER;
						 a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE;
						 a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Target `features_tool' to `fclause'.
		require
			a_ast_attached: a_ast /= Void
		do
			if a_button = 1 and a_ast /= Void then
				navigate_to_ast (a_ast, False)
			end
		end

	extended_parent_list_row (a_parent_list: PARENT_LIST_AS; s: STRING; a_class: CLASS_C; a_match_list: LEAF_AS_LIST; a_expanded: BOOLEAN): EV_GRID_ROW
			-- Build the grid row corresponding to inherit clause
		require
			a_parent_list_attached: a_parent_list /= Void
			a_class_attached: a_class /= Void
			a_match_list_attached: a_match_list /= Void
		local
			pix: EV_PIXMAP
			l_parent: PARENT_AS
			l_parent_text: STRING_32
			l_parent_class_i: detachable CLASS_I
			l_row: like extended_new_row
		do
			Result := extended_new_row
			pix := pixmaps.icon_pixmaps.class_ancestors_icon
			add_tree_item_for_parent_list (Result, a_parent_list, s, pix)

			from
				a_parent_list.start
			until
				a_parent_list.after
			loop
				l_parent := a_parent_list.item
				l_parent_text := l_parent.type.text_32 (a_match_list)
				l_parent_class_i := Void
				if
					attached l_parent.type.class_name.text_32 (a_match_list) as l_parent_cname32 and then
					l_parent_cname32.is_valid_as_string_8
				then
					if Workbench.universe_defined then
						l_parent_class_i := universe.class_named (l_parent_cname32.to_string_8, a_class.group)
					end
				end

				l_row := extended_parent_item_subrow (Result, l_parent, l_parent_class_i, l_parent_text, a_class)
				if a_expanded and l_row.is_expandable then
					l_row.expand
				end
				a_parent_list.forth
			end
		ensure
			result_attached: Result /= Void
		end

	extended_parent_item_subrow (a_row: EV_GRID_ROW; a_parent: PARENT_AS; a_parent_class_i: detachable CLASS_I; s: STRING_GENERAL; a_class: CLASS_C): EV_GRID_ROW
			-- Build the grid row corresponding to inherit clause
		require
			a_parent_attached: a_parent /= Void
			a_class_attached: a_class /= Void
		local
			pix: EV_PIXMAP
		do
			Result := extended_new_subrow (a_row)
			if a_parent_class_i /= Void then
				pix := pixmap_from_class_i (a_parent_class_i)
			end
			add_tree_item_for_parent (Result, a_parent, a_parent_class_i, s, pix)
		ensure
			result_attached: Result /= Void
		end


	extended_folder_row (fc: FEATURE_CLAUSE_AS; n: STRING_GENERAL; a_class: CLASS_C): EV_GRID_ROW
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
			f_item_name: STRING_32
			l_first_item_name: STRING_32
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
						f_item_name := f_names.item.feature_name.name_32
						if l_first_item_name = Void then
							l_first_item_name := f_item_name
						end
						if a_class.has_feature_table then
							ef := a_class.feature_with_name_id (f_names.item.feature_name.name_id)
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

	extended_folder_row_for_external (n: STRING_GENERAL; fl: DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]; a_class: CLASS_C): EV_GRID_ROW
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
					if
						is_clickable and then
						a_class.has_feature_table
					then
						ef := a_class.feature_with_name_32 (
							fl.item.eiffel_name)
						if ef = Void then
								-- Check for infix feature
							ef := a_class.feature_with_name_32 (
								"infix %"" + fl.item.eiffel_name + "%"")
							if ef = Void then
									-- Check for prefix feature
								ef := a_class.feature_with_name_32 (
									"prefix %"" + fl.item.eiffel_name + "%"")
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

	Grid_feature_style: EB_FEATURE_EDITOR_TOKEN_STYLE
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

	add_tree_item_for_text (a_row: EV_GRID_ROW; a_text: STRING_GENERAL)
		do
			a_row.set_item (1, new_grid_label_item (a_text))
		end

	update_tree_item_for_e_feature (a_row: EV_GRID_ROW; ef: E_FEATURE)
		do
			if a_row.count > 0 then
				if is_editor_token_enabled then
					if not attached {EB_GRID_EDITOR_TOKEN_ITEM} a_row.item (1) then
						if attached {EV_GRID_LABEL_ITEM} a_row.item (1) as lab then
							a_row.clear
							add_tree_item_for_e_feature (a_row, ef, lab.pixmap)
						else
							check is_label_item: False end
						end
					else
						-- nothing to change
					end
				else
					if attached {EV_GRID_LABEL_ITEM} a_row.item (1) as lab then
						lab.set_text (feature_name (ef))
					else
						if attached {EB_GRID_EDITOR_TOKEN_ITEM} a_row.item (1) as gf then
							a_row.clear
							add_tree_item_for_e_feature (a_row, ef, gf.pixmap)
						else
							check is_editor_item: False end
						end
					end
				end
			end
		end

	on_zoom (a_zoom_factor: INTEGER)
		do
			Precursor (a_zoom_factor)
			update_editor_token_font_info
		end

	update_editor_token_font_info
		do
			editor_token_font_info.f := label_font_table
			editor_token_font_info.h := label_font_height
		end

	editor_token_font_info: TUPLE [f: SPECIAL [EV_FONT]; h: INTEGER]
			-- Info for Editor tokens
		once
			Result := [label_font_table, label_font_height]
		end

	add_tree_item_for_parent_list (a_row: EV_GRID_ROW; a_parent_list: PARENT_LIST_AS; a_text: STRING_GENERAL; pix: EV_PIXMAP)
		local
			lab: EV_GRID_LABEL_ITEM
		do
			lab := new_grid_label_item (a_text)
			lab.set_pixmap (pix)
			lab.set_data (a_parent_list)
			if is_clickable then
				lab.pointer_button_press_actions.extend (agent button_go_to_ast (a_parent_list, ?, ?, ?, ?, ?, ?, ?, ?))
			end
			a_row.set_data (a_parent_list)
			a_row.set_item (1, lab)
		end

	add_tree_item_for_parent (a_row: EV_GRID_ROW; a_parent: PARENT_AS; a_parent_class_i: detachable CLASS_I; a_text: STRING_GENERAL; pix: detachable EV_PIXMAP)
		local
			lab: EV_GRID_LABEL_ITEM
		do
			lab := new_grid_label_item (a_text)
			if pix /= Void then
				lab.set_pixmap (pix)
			end

			if is_clickable then
				lab.pointer_button_press_actions.extend (agent button_go_to_ast (a_parent, ?, ?, ?, ?, ?, ?, ?, ?))
			end
			if a_parent_class_i /= Void then
				lab.set_data (a_parent_class_i)
			else
				lab.set_data (a_parent)
			end
			a_row.set_data (lab.data)
			a_row.set_item (1, lab)
		end

	add_tree_item_for_e_feature (a_row: EV_GRID_ROW; ef: E_FEATURE; pix: EV_PIXMAP)
		local
			lab: EV_GRID_LABEL_ITEM
			l_text: STRING_GENERAL
			i: EV_GRID_ITEM
			gf: EB_GRID_EDITOR_TOKEN_ITEM
		do
			a_row.set_data (ef)
			l_text := feature_name (ef)

			if is_editor_token_enabled then
				gf := new_grid_editor_token_item (l_text.to_string_8)
				gf.set_pixmap (pix)
				gf.set_data (ef)

				gf.set_overriden_fonts (editor_token_font_info.f, editor_token_font_info.h)
				Grid_feature_style.set_e_feature (ef)
				gf.set_text_with_tokens (Grid_feature_style.text)

				i := gf
			else
				lab := new_grid_label_item (l_text)
				lab.set_pixmap (pix)
				lab.set_data (ef)
				i := lab
			end
			if is_clickable then
				i.pointer_button_press_actions.extend (agent button_go_to (ef, ?, ?, ?, ?, ?, ?, ?, ?))
			end
			a_row.set_item (1, i)
		end

	add_tree_item_for_feature_name (a_row: EV_GRID_ROW; ffn: STRING_32; a_text: STRING_GENERAL; pix: EV_PIXMAP)
		local
			lab: EV_GRID_LABEL_ITEM
		do
			lab := new_grid_label_item (a_text)
			lab.set_pixmap (pix)
			lab.set_data (a_text)
			if is_clickable and ffn /= Void then
				lab.pointer_button_press_actions.extend (agent (i_ffn: STRING_32; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
						do
							navigate_to_feature_by_name (i_ffn)
						end (ffn, ?,?,?,?,?,?,?,?)
					)
			end
			a_row.set_item (1, lab)
		end

	add_tree_item_for_feature_clause (a_row: EV_GRID_ROW; fc: FEATURE_CLAUSE_AS; a_text: STRING_GENERAL; pix: EV_PIXMAP)
		local
			lab: EV_GRID_LABEL_ITEM
		do
			lab := new_grid_label_item (a_text)
			lab.set_pixmap (pix)
			lab.set_data (fc)
			if is_clickable then
				lab.pointer_button_press_actions.extend (agent button_go_to_clause (fc, ?, ?, ?, ?, ?, ?, ?, ?))
			end
			a_row.set_data (fc)
			a_row.set_item (1, lab)
		end

	add_tree_item_for_dotnet_feature_clause (a_row: EV_GRID_ROW; fd: DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]; a_text: STRING_GENERAL; pix: EV_PIXMAP)
		local
			lab: EV_GRID_LABEL_ITEM
		do
			lab := new_grid_label_item (a_text)
			lab.set_pixmap (pix)
			lab.set_data (fd)
			a_row.set_data (fd)
			a_row.set_item (1, lab)
		end

feature -- Grid item factory

	new_grid_editor_token_item (a_text: detachable READABLE_STRING_8): EB_GRID_EDITOR_TOKEN_ITEM
		do
			if a_text = Void then
				create Result
			else
				create Result.make_with_text (a_text)
			end
--			setup_grid_label_item (Result)
		end

;note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
