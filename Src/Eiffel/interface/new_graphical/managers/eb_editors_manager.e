note
	description: "Tabbed editor manager for one window of EiffelStudio"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITORS_MANAGER

inherit
	EB_RECYCLABLE
		redefine
			internal_detach_entities
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EB_SHARED_ID_SOLUTION
		export
			{NONE} all
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EC_ENCODING_UTILITIES
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	SD_ACCESS

create
	make

feature {NONE} -- Initialization

	make (a_dev_win: EB_DEVELOPMENT_WINDOW)
			-- Initialization
		require
			a_dev_win_attached: a_dev_win /= Void
		do
				-- Set editor manager on the window
			a_dev_win.set_editors_manager (Current)

				-- Ensure the editor manager is recycled when the development window is
			a_dev_win.auto_recycle (Current)

			create editors_internal.make (0)
			create fake_editors.make (0)
			create recently_closed_editors.make (0)

				-- Action sequences
			create editor_switched_actions
			create editor_created_actions
			create editor_closed_actions

			editor_switched_actions.extend (agent on_editor_switched)
			editor_closed_actions.extend (agent on_editor_closed)

			create editor_number_factory.make
			build_observer_lists
			development_window := a_dev_win
			docking_manager := a_dev_win.docking_manager
			register_action (docking_manager.tab_drop_actions, agent ((a_dev_win.commands).new_tab_cmd).execute_with_stone_content)

			set_veto_pebble_function (agent veto_pebble_function)
			docking_manager.tab_drop_actions.set_veto_pebble_function (agent (a: ANY; c: SD_CONTENT): BOOLEAN do Result := veto_pebble_function_internal (a) end)

			if veto_pebble_function_internal = Void then
				docking_manager.tab_drop_actions.set_veto_pebble_function (agent (a: ANY; c: SD_CONTENT): BOOLEAN do Result := veto_pebble_function_internal (a) end)
			end
			create_editor
			register_action (docking_manager.main_area_drop_action, agent create_editor_beside_content (?, Void, False))
			if veto_pebble_function_internal = Void then
				docking_manager.main_area_drop_action.set_veto_pebble_function (agent veto_pebble_function)
			end
			docking_manager.zones.place_holder_widget.file_drop_actions.extend (agent on_file_drop)
		ensure
			recently_closed_editors_not_void: recently_closed_editors /= Void
			editors_internal_not_void: editors_internal /= Void
			editors_not_empty: not editors_internal.is_empty
			docking_manager_attached: docking_manager = a_dev_win.docking_manager
			development_window_not_void: development_window = a_dev_win
			history_observer_list_internal_not_void: history_observer_list_internal /= Void
			edition_observer_list_internal_not_void: edition_observer_list_internal /= Void
			cursor_observer_list_internal_not_void: cursor_observer_list_internal /= Void
			selection_observer_list_internal_not_void: selection_observer_list_internal /= Void
			lines_observer_list_internal_not_void: lines_observer_list_internal /= Void
		end

feature -- Access

	unsaved_editors: like editors_internal
			-- Unsaved editors
		local
			l_editors: like editors
		do
			create Result.make (0)
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after
			loop
				if l_editors.item.changed then
					Result.extend (l_editors.item)
				end
				l_editors.forth
			end
		end

	current_editor: detachable EB_SMART_EDITOR
			-- Current editor
		do
			if editors_internal.has (last_focused_editor) then
				Result := last_focused_editor
			elseif not editors_internal.is_empty then
				-- We return a random editor
				if editors_internal.off then
					editors_internal.start
				end
				Result := editors_internal.item
			end
		end

	editor_with_content (a_content: SD_CONTENT): detachable like current_editor
			-- Editor corresponding to `a_content' if exists
		local
			l_editors: like editors
			l_item: like current_editor
		do
			from
				l_editors := editors
				l_editors.start
			until
				l_editors.after or Result /= Void
			loop
				l_item := l_editors.item
				if l_item.docking_content = a_content then
					Result := l_item
				end
				l_editors.forth
			end

			if Result = Void then
				from
					l_editors := fake_editors
					l_editors.start
				until
					l_editors.after or Result /= Void
				loop
					l_item := l_editors.item
					if l_item.docking_content = a_content then
						Result := l_item
					end
					l_editors.forth
				end
			end
		end

	editor_with_stone (a_stone: ANY) : like current_editor
			-- Editor that has `a_stone', or editing the same path file.
		do
			if attached {STONE} a_stone as l_stone then
				Result := editor_with_stone_internal (editors, l_stone)
				if Result = Void and then fake_editors /= Void then
					Result := editor_with_stone_internal (fake_editors, l_stone)
					if attached {EB_FAKE_SMART_EDITOR} Result as l_fake_editor then
						init_editor
						Result := last_created_editor
						change_fake_to_real (Result, l_fake_editor, l_fake_editor.content)
					else
							-- `fake_editors' can only contain instances of EB_FAKE_SMART_EDITOR so
							-- Result is either a fake editor or nothing, i.e. Void.
						check not_found: Result = Void end
					end
				end
			end
		end

	editor_with_class (a_file_name: PATH) : like current_editor
			-- Editor editing a class with `a_file_name'
		require
			a_file_name_attached: a_file_name /= Void
		do
			across
				editors as e
			until
				attached Result
			loop
				if
					attached {CLASSI_STONE} e.item.stone as s and then
					s.file_name.is_equal (a_file_name.name)
				then
					Result := e.item
				end
			end
		end

	editors: like editors_internal
			-- Clone of all editors
		do
			Result := editors_internal.twin
		end

	editor_count: INTEGER
			-- Number of editors under management.
		do
			Result := editors_internal.count
			if fake_editors /= Void then
				Result := Result + fake_editors.count
			end
		end

	development_window: EB_DEVELOPMENT_WINDOW
			-- Associated development window.

	editor_editing (a_class_i: CLASS_I) : like editors_internal
			-- Editors contain `a_class_i'
		require
			a_class_i_attached: a_class_i /= Void
		do
			create Result.make (0)
			across
				editors as e
			loop
				if
					attached {CLASSI_STONE} e.item.stone as s and then
					s.class_i = a_class_i
				then
					Result.extend (e.item)
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	last_focused_editor: like current_editor
			-- Last focused editor

	last_created_editor: like current_editor
			-- Last created editor

	open_classes: HASH_TABLE [STRING, STRING]
			-- Open classes. [ID, title]
		local
			l_editors: like editors
		do
			create Result.make (editors_internal.count)
			l_editors := editors
			from
				l_editors.start
				if l_editors.after then
					l_editors := fake_editors
					l_editors.start
				end
			until
				l_editors.after
			loop
				if attached {CLASSC_STONE} l_editors.item.stone as l_classc_stone then
					check
						class_not_void: l_classc_stone.class_i /= Void
						config_class_not_void: l_classc_stone.class_i.config_class /= Void
					end
					Result.force (id_of_class (l_classc_stone.class_i.config_class),
						l_editors.item.docking_content.unique_title.as_string_8)
				end
				l_editors.forth
					-- Perform a second iteration of the loop, this time using `fake_editors'.
				if l_editors.after and then l_editors /= fake_editors then
					l_editors := fake_editors
					l_editors.start
				end
			end
		ensure
			not_void: Result /= Void
		end

	open_clusters: HASH_TABLE [STRING, STRING]
			-- Open clusters. [ID, title]
		local
			l_editors: like editors
		do
			create Result.make (editors_internal.count)
			l_editors := editors
			from
				l_editors.start
				if l_editors.after then
					l_editors := fake_editors
					l_editors.start
				end
			until
				l_editors.after
			loop
				if attached {CLUSTER_STONE} l_editors.item.stone as l_cluster_stone then
					Result.force (id_of_group (l_cluster_stone.group),
						l_editors.item.docking_content.unique_title.as_string_8)
				end
				l_editors.forth
					-- Perform a second iteration of the loop, this time using `fake_editors'.
				if l_editors.after and then l_editors /= fake_editors then
					l_editors := fake_editors
					l_editors.start
				end
			end
		end

	changed_classes: ARRAYED_LIST [CLASS_I]
			-- All classes with unsaved changes
		require
			changed: changed
		do
			create Result.make (editors_internal.count)
			across
				editors as e
			loop
				if e.item.changed then
					if attached {CLASSC_STONE} e.item.stone as s then
						Result.extend (s.class_i)
					elseif attached {CLASSI_STONE} e.item.stone as s then
						Result.extend (s.class_i)
					end
				end
			end
		ensure
			not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
			editors_unmoved: editors.cursor.is_equal (editors.cursor)
		end

	is_all_editors_valid: BOOLEAN
			-- Check if all editors' statues are valid
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_item: SD_CONTENT
			l_editor_count: INTEGER
			l_all_editors: like editors
		do
			from
				Result := True
				l_contents := docking_manager.query.contents_editors
				l_contents.start
			until
				l_contents.after or not Result
			loop
				l_item := l_contents.item
				check l_item.type = {SD_ENUMERATION}.editor end
				l_editor_count := l_editor_count + 1
				Result := l_item.is_visible
				if Result then
					if attached l_item.user_widget.parent then
						-- Main development window must contain the editor widget
						Result := development_window.window.has_recursive (l_item.user_widget)
					else
						-- `l_item' must exists in SD_NOTEBOOK and not selected
						if attached {SD_TAB_STATE} l_item.state as l_state then
							Result := (l_state.zone.contents.count >= 2) and (not l_state.zone.is_content_selected (l_item))
							if Result then
								-- Main development window must contain the tab zone
								Result := development_window.window.has_recursive (l_state.zone)
							end
						else
							Result := False
						end
					end
				end

				l_contents.forth
			end

			l_all_editors := editors
			if attached fake_editors as l_fake_editors then
				l_all_editors.append (l_fake_editors)
			end

			Result := l_editor_count = l_all_editors.count

			if Result then
				from
					l_all_editors.start
				until
					l_all_editors.after or not Result
				loop
					Result := l_all_editors.item.docking_content.type = {SD_ENUMERATION}.editor
					l_all_editors.forth
				end
			end
		end

	last_recently_closed_editor: detachable EB_SMART_EDITOR
			-- last recently closed editor.

	restore_last_recently_closed_editor
			-- last closed editor.
		local
			l_editor: EB_SMART_EDITOR
		do
			if not recently_closed_editors.is_empty then
				l_editor := recently_closed_editors.last.twin
				last_recently_closed_editor := l_editor
				recently_closed_editors.prune_all (recently_closed_editors.last)
			end
		end


feature {NONE} -- Access

	docking_manager: SD_DOCKING_MANAGER
			-- Docking manager, containing the editors

feature -- Actions

	editor_created_actions: ACTION_SEQUENCE [TUPLE [editor: EB_SMART_EDITOR]]
			-- Actions call when a new editor is created.

	editor_closed_actions: ACTION_SEQUENCE [TUPLE [editor: EB_SMART_EDITOR]]
			-- Actions call when a new editor is created.

	editor_switched_actions: ACTION_SEQUENCE [TUPLE [editor: EB_SMART_EDITOR]]
			-- Actions after editor switched from one document to another

feature {NONE} -- Action handlers

	on_editor_switched (a_editor: EB_SMART_EDITOR)
			-- Editor is switched.
		require
			a_editor_attached: a_editor /= Void
		do
			if
				not a_editor.is_recycled and then
				development_window.editors_manager /= Void
			then
					-- During initialization of Current, the editor manager will be Void for the development window
				development_window.set_stone (a_editor.stone)
			end
		end

	on_editor_closed (a_editor: EB_SMART_EDITOR)
			-- Editor is closed
		require
			a_editor_attached: a_editor /= Void
		do
			recently_closed_editors.force (a_editor.twin)
		end

feature -- Status report

	is_class_editing (a_class: CLASS_I) : BOOLEAN
			-- Editor editing a class with `a_file_name'
		require
			a_class_attached: a_class /= Void
		local
			l_editors: like editors_internal
		do
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after or Result
			loop
				Result := attached {CLASSI_STONE} l_editors.item.stone as l_class_stone and then l_class_stone.class_i = a_class
				l_editors.forth
			end
		end

	changed : BOOLEAN
			-- Any editor is changed?
		local
			l_editors: like editors_internal
		do
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after or Result
			loop
				Result := l_editors.item.changed
				l_editors.forth
			end
		end

	full_loaded: BOOLEAN
			-- Have all editor full loaded?
		local
			l_editors: like editors_internal
		do
			Result := True
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after or not Result
			loop
				Result := l_editors.item.text_is_fully_loaded
				l_editors.forth
			end
		end

	show_formatting_marks: BOOLEAN
			-- Show formating marks?

	not_backuped: INTEGER
			-- Number of editors not backuped last time

	stone_acceptable (a_stone: ANY): BOOLEAN
			-- Is `a_stone' suitable for a new editor?
		do
			if attached veto_pebble_function_internal as l_veto then
				Result := l_veto (a_stone)
			else
				Result := veto_pebble_function (a_stone)
			end
		end

feature -- Editor observer

	add_edition_observer (a_text_observer: TEXT_OBSERVER)
			-- Add observer for all editors.
		require
			a_text_abserver_attached: a_text_observer /= Void
		local
			l_editors: ARRAYED_LIST [like current_editor]
		do
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after
			loop
				if l_editors.item.text_displayed /= Void then
					l_editors.item.text_displayed.add_edition_observer (a_text_observer)
					if a_text_observer /= Void and then not edition_observer_list_internal.has (a_text_observer) then
						edition_observer_list_internal.extend (a_text_observer)
					end
				end
				l_editors.forth
			end
		end

	add_history_observer (history_observer: UNDO_REDO_OBSERVER)
			-- Add history observer for all editors.
		require
			history_observer_attached: history_observer /= Void
		local
			l_editors: ARRAYED_LIST [like current_editor]
		do
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after
			loop
				l_editors.item.text_displayed.history.add_observer (history_observer)
				history_observer_list_internal.extend (history_observer)
				l_editors.forth
			end
		end

	remove_history_observer (history_observer: UNDO_REDO_OBSERVER)
			-- Remove observer for all editors.
		require
			history_observer_attached: history_observer /= Void
		local
			l_editors: ARRAYED_LIST [like current_editor]
		do
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after
			loop
				l_editors.item.text_displayed.history.remove_observer (history_observer)
				history_observer_list_internal.prune_all (history_observer)
				l_editors.forth
			end
		end

	add_cursor_observer (a_cursor_observer: TEXT_OBSERVER)
			-- Add cursor observer for all editors.
		require
			a_cursor_abserver_attached: a_cursor_observer /= Void
		local
			l_editors: ARRAYED_LIST [like current_editor]
		do
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after
			loop
				if not l_editors.item.text_displayed.is_notifying then
					l_editors.item.text_displayed.add_cursor_observer (a_cursor_observer)
					if a_cursor_observer /= Void and then not cursor_observer_list_internal.has (a_cursor_observer) then
						cursor_observer_list_internal.extend (a_cursor_observer)
					end
				end
				l_editors.forth
			end
		end

	remove_cursor_observer (a_cursor_observer: TEXT_OBSERVER)
			-- Remove observer for all editors.
		require
			a_cursor_observer_attached: a_cursor_observer /= Void
		local
			l_editors: ARRAYED_LIST [like current_editor]
		do
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after
			loop
				l_editors.item.text_displayed.remove_observer (a_cursor_observer)
				cursor_observer_list_internal.prune_all (a_cursor_observer)
				l_editors.forth
			end
		end

feature -- Element change

	create_editor
			-- Create a new editor.
		do
			create_editor_beside_content (Void, exist_content, False)
		end

	create_editor_beside_content (a_stone: detachable ANY; a_content: SD_CONTENT; a_force_right_side: BOOLEAN)
			-- Create an editor beside `a_content'. Meanwile set `a_stone' to the editor if `a_stone' is not void.
			-- Set top if the a_content is void.
		local
			l_content: SD_CONTENT
		do
			init_editor
			l_content := create_docking_content (editor_number_factory.new_editor_name, last_created_editor, a_content, a_force_right_side)
			last_created_editor.set_docking_content (l_content)
			if attached {STONE} a_stone as l_stone then
				on_drop (l_stone, last_created_editor)
			end
			check no_duplicated: not has_duplicated_stone end
		end

	close_editor (a_editor: like current_editor)
			-- Close an editor.
		require
			a_editor_attached: a_editor /= Void
		do
			on_close (a_editor)
		end

	close_all_editor
			-- Close all editor
		local
			l_editors: ARRAYED_LIST [like current_editor]
		do
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after
			loop
				close_editor_perform (l_editors.item)
				l_editors.forth
			end
				-- Not sure if this is needed!
			create editors_internal.make (5)
		end

	set_veto_pebble_function (a_func: PREDICATE [ANY])
			-- Set veto pebble_function for all editors.
		require
			a_func_attached: a_func /= Void
		local
			l_editors: ARRAYED_LIST [like current_editor]
		do
			l_editors := editors
			veto_pebble_function_internal := a_func
			from
				l_editors.start
			until
				l_editors.after
			loop
				l_editors.item.drop_actions.set_veto_pebble_function (a_func)
				if l_editors.item.docking_content /= Void then
					l_editors.item.docking_content.drop_actions.set_veto_pebble_function (a_func)
				end
				l_editors.forth
			end
		ensure
			set: veto_pebble_function_internal = a_func
		end

	restore_editors (a_open_classes, a_open_clusters: HASH_TABLE [STRING, STRING]): BOOLEAN
			-- Restore editors.
			-- If really have editors to open, then result is True, otherwise is False
		require
			a_open_classes_attached: a_open_classes /= Void
			a_open_clusters_attached: a_open_clusters /= Void
		local
			l_classi_stone: CLASSI_STONE
			l_classc_stone: CLASSC_STONE
			l_cluster_stone: CLUSTER_STONE
			l_content: SD_CONTENT
			l_editor_numbers: ARRAYED_LIST [INTEGER]
		do
			-- After this operation, the place holder zone will be inserted by docking library
			close_all_editor
			if not a_open_classes.is_empty or not a_open_clusters.is_empty then
				is_opening_editors := True

				create l_editor_numbers.make (a_open_classes.count + a_open_clusters.count)
				fake_editors.wipe_out
					-- Restore open classes.
				from
					a_open_classes.start
				until
					a_open_classes.after
				loop
					if attached class_of_id (a_open_classes.item_for_iteration) as l_conf_class then
						l_content := create_docking_content_fake_one (a_open_classes.key_for_iteration)
						if attached {EB_FAKE_SMART_EDITOR} last_created_editor as l_fake_editor then
							fake_editors.extend (l_fake_editor)
						else
								-- Per postcondition of `create_docking_content_fake_one' we cannot execute this branch.
							check inserted: False end
						end

						l_content.set_long_title (l_conf_class.name)
						l_content.set_short_title (l_conf_class.name)

						if attached {CLASS_I} l_conf_class as l_class_i then
							l_content.set_pixmap (pixmap_from_class_i (l_class_i))
							l_editor_numbers.extend (editor_number_factory.editor_number_from_title (a_open_classes.key_for_iteration))
							if l_class_i.is_compiled then
								create l_classc_stone.make (l_class_i.compiled_class)
								last_created_editor.set_stone (l_classc_stone)
								update_content_description (l_classc_stone, last_created_editor.docking_content)
							else
								create l_classi_stone.make (l_class_i)
								last_created_editor.set_stone (l_classi_stone)
								update_content_description (l_classi_stone, last_created_editor.docking_content)
							end
						end
						Result := True
					end
					a_open_classes.forth
				end
					-- Restore open clusters,
				from
					a_open_clusters.start
				until
					a_open_clusters.after
				loop
					if attached group_of_id (a_open_clusters.item_for_iteration) as l_group then
						create l_cluster_stone.make (l_group)
						l_content := create_docking_content_fake_one (a_open_clusters.key_for_iteration)
						if attached {EB_FAKE_SMART_EDITOR} last_created_editor as l_fake_editor then
							fake_editors.extend (l_fake_editor)
						else
								-- Per postcondition of `create_docking_content_fake_one' we cannot execute this branch.
							check inserted: False end
						end
						l_content.set_long_title (l_group.name)
						l_content.set_short_title (l_group.name)
						l_content.set_pixmap (pixmap_from_group (l_group))
						l_editor_numbers.extend (editor_number_factory.editor_number_from_title (a_open_clusters.key_for_iteration))
						last_created_editor.set_stone (l_cluster_stone)
						update_content_description (l_cluster_stone, last_created_editor.docking_content)
						Result := True
					end
					a_open_clusters.forth
				end
				editor_number_factory.set_editors_numbers (l_editor_numbers)
				is_opening_editors := False
			end
		ensure
			not_opening_editors: not is_opening_editors
		end

	fake_editors: ARRAYED_LIST [EB_FAKE_SMART_EDITOR]
			-- Fake editors which is used for fast opening Eiffel Studio.

	show_editors_possible
			-- Show editors which are possible to show.
		do
			if attached fake_editors as l_fake_editors then
				across
					l_fake_editors.twin as ic  -- FIXME: check if the twin is required now with across loop.
				loop
					if
						attached ic.item as l_snapshot_item and then
						l_snapshot_item.docking_content.user_widget.is_displayed
					then
						on_focus (l_snapshot_item)
					end
				end
			end
			synchronize_with_docking_manager
		end

	update_content_description (a_stone: STONE; a_content: detachable SD_CONTENT)
			-- Update `a_content''s detail and description text which are readed from `a_stone'.
		local
			l_shared: SD_SHARED
			l_name: like {FILED_STONE}.file_name
			s32: STRING_32
		do
			if a_content /= Void then
				if attached {CLASSI_STONE} a_stone as l_class_stone then
					a_content.set_description (interface_names.l_eiffel_class)
					l_name := l_class_stone.file_name
					a_content.set_detail (l_name.as_string_32)
					a_content.set_tab_tooltip (l_name.as_string_32)
				elseif attached {CLUSTER_STONE} a_stone as l_cluster_stone then
					a_content.set_description (interface_names.l_eiffel_cluster)

					if attached l_cluster_stone.group.location.evaluated_path as l_path then
						if attached l_cluster_stone.path as l_cluster_path and then not l_cluster_path.is_empty then
							s32 := l_cluster_stone.path
							from until not s32.starts_with_general ("/") loop
								s32.remove_head (1)
							end
							l_name := l_path.extended (s32).name
						else
							l_name := l_path.name
						end
					end

					if l_name /= Void then
						a_content.set_detail (l_name.as_string_32)
						a_content.set_tab_tooltip (l_name.as_string_32)
					else
						a_content.set_tab_tooltip (Void)
					end
				else
					-- We don't know this kind of stone.
					create l_shared
					a_content.set_description (l_shared.interface_names.zone_navigation_no_description_available)
					a_content.set_detail (l_shared.interface_names.zone_navigation_no_detail_available)
					a_content.set_tab_tooltip (Void)
				end
			end
		end

	synchronize_with_docking_manager
			-- Sometimes editors manager data would not synchronized with docking editor content statues,
			-- synchronized here.
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_item: SD_CONTENT
			l_item_valid: BOOLEAN
			l_editor_count: INTEGER
			l_editors: like editors
			l_editor_item: like current_editor
			l_has, l_found_editor: BOOLEAN
		do
			from
				l_contents := docking_manager.query.contents_editors
				l_contents.start
			until
				l_contents.after
			loop
				l_item := l_contents.item
				l_item_valid := True

				check l_item.type = {SD_ENUMERATION}.editor end
				l_editor_count := l_editor_count + 1

				if not l_contents.item.is_visible then
					l_item_valid := False
				else
					if attached l_item.user_widget.parent then
						-- Main development window must contain the editor widget
						l_item_valid := development_window.window.has_recursive (l_item.user_widget)
					else
						-- `l_item' must exists in SD_NOTEBOOK and not selected
						if attached {SD_TAB_STATE} l_item.state as l_state then
							l_item_valid := (l_state.zone.contents.count >= 2) and (not l_state.zone.is_content_selected (l_item))
							if l_item_valid then
								-- Main development window must contain the tab zone
								l_item_valid := development_window.window.has_recursive (l_state.zone)
							end
						else
							l_item_valid := False
						end
					end
				end

				if not l_item_valid then
					-- This editor not exists in saved docking layout, we should remove it.
					remove_editor_of_content (l_item)

					-- Remove it from docking manager too.
					l_item.close
				end

				l_contents.forth
			end

			l_contents := docking_manager.query.contents_editors
			l_editors := editors
			if attached fake_editors as l_fake_editors then
				l_editors.append (l_fake_editors)
			end

			if l_editors.count /= l_contents.count then

				from
					-- Remove useless editor(s) in `internal_editors'
					l_editors.start
				until
					l_editors.after
				loop
					l_found_editor := False
					l_editor_item := l_editors.item
					from
						l_contents.start
					until
						l_contents.after or l_found_editor
					loop
						l_item := l_contents.item
						l_found_editor := l_item.user_widget ~ l_editor_item.widget
						l_contents.forth
					end
					if not l_found_editor then
						close_editor_perform (l_editor_item)
					end
					l_editors.forth
				end

				from
					-- Remove useless editor(s) in docking manager contents
					l_contents.start
				until
					l_contents.after
				loop
					l_item := l_contents.item
					l_has := False
					from
						l_editors.start
					until
						l_editors.after or l_has
					loop
						l_editor_item := l_editors.item
						l_has := l_item.user_widget ~ l_editor_item.widget
						l_editors.forth
					end
					if not l_has then
						l_item.close
						docking_manager.contents.prune_all (l_item)
					end
					l_contents.forth
				end
			end
		ensure
			valid: is_all_editors_valid
		end

feature -- Basic operations

	select_editor (a_editor: like current_editor; a_force_focus: BOOLEAN)
			-- Give `a_editor' focus.
			-- `a_force_focus' means if force unmaximized other tool to show `a_editor'.
		require
			a_editor_attached: a_editor /= Void
		local
			l_content: SD_CONTENT
			l_area: EV_DRAWING_AREA
		do
			if editors_internal.has (a_editor) then
				l_content := a_editor.docking_content
				if docking_manager.has_content (l_content) then
					if a_force_focus then
						if l_content.is_visible then
							l_content.set_focus
						else
							l_content.show
							l_content.set_focus
						end
					else
						l_content.set_focus_no_maximized (l_content.user_widget)
					end
					l_area := a_editor.editor_drawing_area
					if l_area.is_sensitive and l_area.is_displayed then
						l_area.set_focus
					end
				end
			end
		end

	backup_all
			-- Back up all changed editor.
		local
			l_editors: like editors_internal
		do
			not_backuped := 0
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after
			loop
				back_up_editor (l_editors.item)
				l_editors.forth
			end
		end

	toggle_formatting_marks
			-- Toggle formatting marks.
		local
			l_editors: like editors
		do
			from
				l_editors := editors
				l_editors.start
			until
				l_editors.after
			loop
				check
					show_formatting_marks = l_editors.item.view_invisible_symbols
				end
				l_editors.item.toggle_view_invisible_symbols
				l_editors.forth
			end
			show_formatting_marks := not show_formatting_marks
		end

feature -- Status setting

	load_fully
			-- Wait until all editors finish loading.
		local
			a: like ev_application
		do
			development_window.window.set_pointer_style (default_pixmaps.wait_cursor)
			from
				a := ev_application
			until
				full_loaded
			loop
					-- As editor text is loaded on idle, unless idle_actions are called EiffelStudio
					-- stays in an infinite loop.
				a.process_events
			end
			development_window.window.set_pointer_style (default_pixmaps.standard_cursor)
		ensure
			full_loaded
		end

feature -- Memory management

	internal_recycle
			-- Memory management
		local
			l_editors: like editors
		do
			from
				l_editors := editors_internal
				l_editors.start
			until
				l_editors.after
			loop
				if not l_editors.item.is_recycled then
					l_editors.item.recycle
				end
				l_editors.forth
			end
			l_editors.wipe_out
			if fake_editors /= Void then
				from
					l_editors := fake_editors
					l_editors.start
				until
					l_editors.after
				loop
					if not l_editors.item.is_recycled then
						l_editors.item.recycle
					end
					l_editors.forth
				end
				l_editors.wipe_out
			end
			if recently_closed_editors /= Void then
				from
					l_editors := recently_closed_editors
					l_editors.start
				until
					l_editors.after
				loop
					if not l_editors.item.is_recycled then
						l_editors.item.recycle
					end
					l_editors.forth
				end
				l_editors.wipe_out
			end
			editor_created_actions.wipe_out
			editor_closed_actions.wipe_out
			editor_switched_actions.wipe_out

			cursor_observer_list_internal.wipe_out
			selection_observer_list_internal.wipe_out
			edition_observer_list_internal.wipe_out
			history_observer_list_internal.wipe_out
			lines_observer_list_internal.wipe_out

			docking_manager.tab_drop_actions.set_veto_pebble_function (Void)
		end

	internal_detach_entities
			-- <Precursor>
		do
			development_window := Void
			docking_manager := Void
			fake_editors := Void
			recently_closed_editors := Void
			last_created_editor := Void
			veto_pebble_function_internal := Void
			editor_number_factory := Void
			on_show_imp_agent := Void
			last_focused_editor := Void
			Precursor
		end

feature {NONE} -- Access

	editors_internal: ARRAYED_LIST [like current_editor]
			-- Actual list of editors.

	recently_closed_editors: ARRAYED_LIST [like current_editor]
			-- Actual list of recently closed editors.	

feature {NONE} -- Observer

	history_observer_list_internal:ARRAYED_LIST [UNDO_REDO_OBSERVER]
		-- List of history observers.

	edition_observer_list_internal: ARRAYED_LIST [TEXT_OBSERVER]
		-- List of editor observers.

	cursor_observer_list_internal: ARRAYED_LIST [TEXT_OBSERVER]
		-- List of cursor observers.

	selection_observer_list_internal: ARRAYED_LIST [TEXT_OBSERVER]
		-- List of editor observers.

	lines_observer_list_internal: ARRAYED_LIST [TEXT_OBSERVER]
		-- List of editor observers.

	build_observer_lists
			-- Build all internal observer lists.
		do
			create edition_observer_list_internal.make (0)
			create history_observer_list_internal.make (0)
			create cursor_observer_list_internal.make (0)
			create selection_observer_list_internal.make (0)
			create lines_observer_list_internal.make (0)
		end

	add_observers (a_editor: like current_editor)
			-- Add exsiting observers for a new editor.
		do
			from
				edition_observer_list_internal.start
			until
				edition_observer_list_internal.after
			loop
				a_editor.add_edition_observer (edition_observer_list_internal.item)
				edition_observer_list_internal.forth
			end
			from
				history_observer_list_internal.start
			until
				history_observer_list_internal.after
			loop
				a_editor.add_history_observer (history_observer_list_internal.item)
				history_observer_list_internal.forth
			end
			from
				cursor_observer_list_internal.start
			until
				cursor_observer_list_internal.after
			loop
				a_editor.add_cursor_observer (cursor_observer_list_internal.item)
				cursor_observer_list_internal.forth
			end
			from
				selection_observer_list_internal.start
			until
				selection_observer_list_internal.after
			loop
				a_editor.add_selection_observer (selection_observer_list_internal.item)
				selection_observer_list_internal.forth
			end
			a_editor.drop_actions.set_veto_pebble_function (veto_pebble_function_internal)
		end

feature {NONE} -- Agents

	on_focus (a_editor: like current_editor)
			-- Invoke when `a_editor' is focusing.
		local
			l_editor: EB_SMART_EDITOR
			l_ignore: BOOLEAN
		do
			if not is_opening_editors then
				if attached {EB_FAKE_SMART_EDITOR} a_editor as l_fake_editor then
					-- Maybe called by `on_show_imp' (`on_show_imp' called by `on_show') on same editor more than once.
					l_ignore := has_editor_with_long_title (l_fake_editor.content.long_title)
					if not l_ignore then
						init_editor
						l_editor := last_created_editor
						change_fake_to_real (l_editor, l_fake_editor, l_fake_editor.content)
					end
				else
					l_editor := a_editor
				end

				if not l_ignore then
					if not editors_internal.is_empty and then not editors_internal.off then
						last_focused_editor := a_editor
					else
						last_focused_editor := Void
					end
					validate_editor (l_editor)
					editor_switched_actions.call ([l_editor])
					if l_editor.editor_drawing_area /= Void and then l_editor.editor_drawing_area.is_displayed and l_editor.editor_drawing_area.is_sensitive then
						l_editor.editor_drawing_area.set_focus
					end
				end
			end
		end

	on_editor_focus_in (a_content: SD_CONTENT)
			-- Handle docking content focus in actions
		local
			l_item: EB_FOCUS_PANEL_COMMAND
		do
			across
				development_window.commands.focus_commands as ic
			loop
				l_item := ic.item
				l_item.set_current_focused_content (a_content)
				l_item.enable_sensitive
			end
		end

	on_editor_focus_out (a_content: SD_CONTENT)
			-- Handle docking content focus out actions
		local
			l_item: EB_FOCUS_PANEL_COMMAND
		do
			across
				development_window.commands.focus_commands as ic
			loop
				l_item := ic.item
				l_item.set_current_focused_content (Void)
				l_item.disable_sensitive
			end
		end

	on_fake_focus (a_editor: like current_editor)
			-- Handle `focus_in_actions' of fake editors.
		local
			l_env: EV_ENVIRONMENT
		do
			if on_show_imp_agent /= Void then
				create l_env
				l_env.application.remove_idle_action (on_show_imp_agent)
				on_show_imp_agent := Void
			end

			on_focus (a_editor)
		end

	on_show (a_editor: like current_editor)
			-- Handle `show_actions' of fake editors.
		local
			l_env: EV_ENVIRONMENT
		do
			-- show actions of same editor maybe called more than once.
			if on_show_imp_agent = Void then
				on_show_imp_agent := agent on_show_imp (a_editor)
				create l_env
				l_env.application.do_once_on_idle (on_show_imp_agent)
			end
		ensure
			registed: on_show_imp_agent /= Void
		end

	on_show_imp (a_editor: like current_editor)
			-- Invoke when `a_editor' is shown, and `a_editor' is fake focus editor.
		local
			l_last_focused_editor: like last_focused_editor
		do
			if not is_opening_editors then
				if last_focused_editor /= Void then
					l_last_focused_editor := last_focused_editor
				end
				on_focus (a_editor)
				-- When changing fake editor to real one, we don't want to change `last_focused_editor'.
				if l_last_focused_editor /= Void and a_editor /= Void and then a_editor.docking_content /= l_last_focused_editor.docking_content then
					on_focus (l_last_focused_editor)
				end
			end
			on_show_imp_agent := Void
		ensure
			cleared: on_show_imp_agent = Void
		end

	on_file_drop (a_list: LIST [STRING_32])
			-- OS file drop actions for editor area
			-- Open a new tab for the class which file path are included in `a_list'
		local
			l_stone: CLASSI_STONE
			l_item: CLASS_I
			l_class_name, l_dropped_class_name: STRING_32
			l_splitted_file_path: LIST [STRING_32]
			l_prompt_provider: ES_PROMPT_PROVIDER
		do
			if workbench.universe_defined then
				across
					a_list as file_cursor
				loop
					l_class_name := file_cursor.item
					l_splitted_file_path := l_class_name.split (Operating_environment.directory_separator)
					if l_splitted_file_path.count >= 1 then
							-- FIXME: file name and class name must be same, problem here?
						l_dropped_class_name := l_splitted_file_path.last
						if l_dropped_class_name.ends_with (".e") then
							l_dropped_class_name.remove_tail (2)
							across
								universe.classes_with_name (l_dropped_class_name.as_upper) as class_cursor
							loop
								l_item := class_cursor.item
								if l_item.file_name.name.is_case_insensitive_equal (l_class_name) then
									create l_stone.make (l_item)
									if attached current_editor as l_editor then
											-- There is already an editor, we drop the stone there.
										on_drop (l_stone, l_editor)
									else
											-- No editor is present, we create a new one.
										create_editor_beside_content (l_stone, Void, False)
									end
								end
							end
						elseif l_prompt_provider = Void then
								-- Should tell users only drop ".e" file here, only tell users ONE time.
							create l_prompt_provider
							l_prompt_provider.show_error_prompt (interface_names.l_only_eiffel_class_file_allowed, Void, Void)
						end
					end
				end
				if not attached l_stone then
						-- No suitable eiffel class is found.
					create l_prompt_provider
					l_prompt_provider.show_warning_prompt (interface_names.l_no_suitable_classes_for_files, Void, Void)
				end
			else
				create l_prompt_provider
				l_prompt_provider.show_warning_prompt (interface_names.l_dropping_files_without_project, Void, Void)
			end
		end

	on_drop (a_stone: STONE; a_editor: like current_editor)
			-- Invoke when a stone is dropped on `a_editor'.
		require
			a_editor_attached: a_editor /= Void
		do
			check is_all_editors_valid end
			if a_stone /= Void and then a_stone.is_valid then

				if attached editor_with_stone (a_stone) as l_editor and then l_editor /= a_editor then
						-- There is already an editor with `a_stone'. We simply switch to it if it
						-- is not already our visible editor.
					select_editor (l_editor, False)
				elseif not a_editor.docking_content.has_focus then
					a_editor.docking_content.set_focus
				end

					-- Now we are sure to have a valid editor, let's set the stone.
				development_window.set_dropping_on_editor (True)
				development_window.set_stone (a_stone)
				development_window.set_dropping_on_editor (False)
			end
		end

	on_close (a_editor: like current_editor)
			-- Closing an editor callback
		do
			if a_editor.changed then
				if a_editor /= current_editor then
					-- If `a_editor' changed and not focused, we must focus it, then notify our users whether to save it.
					-- We have to give the focus to the editor (see bug#14247) since when closing an editor
					-- we do a lot of things (see {EB_SAVE_FILE_COMMAND}.execute for details).

					-- In perfect case, we should only switch to the editor if something wrong happen, but
					-- that need to change a lot of codes...
					select_editor (a_editor, False)
				end

				-- Editor changed, we make sure save command is sensitive
				-- Sometimes, `save_cmd' is disabled when saving class file
				-- See bug#13499
				development_window.save_cmd.enable_sensitive

				development_window.save_and (agent close_editor_perform (a_editor))
			else
				close_editor_perform (a_editor)
			end
		end

	on_tab_bar_right_blank_area_double_click (a_content: SD_CONTENT)
			-- When users double clicked on notebook tab bar
		do
			create_editor_beside_content (Void, a_content, True)
			development_window.address_manager.set_focus
		end

feature {NONE} -- Implementation

	is_opening_editors: BOOLEAN
		-- If Current opening more than one editors?

	on_show_imp_agent: PROCEDURE
			-- Agent created by `on_show', cleared by `on_show_imp' or `on_fake_focus'.

	editor_number_factory: EB_EDITOR_NUMBER_FACTORY
			-- Produce editor number and internal names.

	veto_pebble_function_internal: PREDICATE [ANY]
			-- Veto pebble function.

	close_editor_perform (a_editor: like current_editor)
			-- Perform closing editor.
		local
			l_editors: like editors_internal
			l_fake_editors: like fake_editors
			l_found: BOOLEAN
		do
			l_editors := editors_internal
			if l_editors.has (a_editor) then
				l_editors.prune_all (a_editor)
				l_found := True
			elseif attached {EB_FAKE_SMART_EDITOR} a_editor as l_fake_editor then
				l_fake_editors := fake_editors
				if l_fake_editors.has (l_fake_editor) then
					l_fake_editors.prune_all (l_fake_editor)
					l_found := True
				end
			end

			check found: l_found end

			editor_number_factory.remove_editor_name (a_editor.docking_content.unique_title)
			a_editor.docking_content.close
			editor_closed_actions.call ([a_editor])
			a_editor.recycle
			if editors_internal.is_empty then
				last_created_editor := Void
			end
			if last_focused_editor /= Void and then
				editors_internal.has (last_focused_editor) then
				select_editor (last_focused_editor, True)
			else
				if attached previous_clicked_editor as l_previous_clicked_editor then
					select_editor (l_previous_clicked_editor, True)
				end
			end
		end

	previous_clicked_editor: like last_focused_editor
			-- Find previous clicked editor base on docking library
		local
			l_list: ARRAYED_LIST [SD_CONTENT]
			l_editor_content: detachable SD_CONTENT
		do
			l_list := docking_manager.property.contents_by_click_order
			from
				l_list.start
			until
				l_list.after or l_editor_content /= Void
			loop
				if l_list.item.type = {SD_ENUMERATION}.editor then
					l_editor_content := l_list.item
				end

				l_list.forth
			end

			if l_editor_content /= Void then
				Result := editor_with_content (l_editor_content)
			end
		end

	validate_editor (a_editor: like current_editor)
			-- Locate `a_editor' in `editor_internal'. If not exist, start `editor_internal'.
		do
			editors_internal.start
			editors_internal.search (a_editor)
			if editors_internal.exhausted then
				editors_internal.start
			end
		end

	exist_content : SD_CONTENT
			-- A docking content that exists. Void if not.
		do
			if not editors_internal.is_empty then
				Result := current_editor.docking_content
			end
		end

	init_editor
			-- Initial an editor.
		do
			create last_created_editor.make (development_window)
			last_created_editor.set_is_main_editor (True)
			if show_formatting_marks /= last_created_editor.view_invisible_symbols then
				last_created_editor.toggle_view_invisible_symbols
			end
			last_created_editor.widget.set_minimum_size (0, 0)
			add_observers (last_created_editor)
			if veto_pebble_function_internal = Void then
				last_created_editor.drop_actions.set_veto_pebble_function (agent veto_pebble_function)
			end
			register_action (last_created_editor.drop_actions, agent on_drop (?, last_created_editor))
			editors_internal.extend (last_created_editor)
			if editors_internal.off then
				editors_internal.start
			end
			last_created_editor.editor_drawing_area.file_drop_actions.extend (agent on_file_drop)
		ensure
			last_created_editor_not_void: last_created_editor /= Void
			formatting_marks_set: show_formatting_marks = last_created_editor.view_invisible_symbols
		end

	has_editor_with_long_title (a_title: STRING_GENERAL): BOOLEAN
			-- Does `editors_internal' has a editor's content's long title is `a_title'?
		local
			l_editors: like editors_internal
		do
			from
				l_editors := editors_internal.twin
				l_editors.start
			until
				l_editors.after or Result
			loop
				if l_editors.item.docking_content.long_title.is_equal (a_title) then
					Result := True
				end
				l_editors.forth
			end
		end

	create_docking_content (a_unique_title: STRING; a_editor: like current_editor; a_content: SD_CONTENT; a_force_right_side: BOOLEAN): SD_CONTENT
			-- Create a docking content with `a_editor' in it.
			-- This content is set close to a_content if a_content is not void.
		require
			a_unique_title_not_void: a_unique_title /= Void
			a_editor_not_void: a_editor /= Void
		do
			create Result.make_with_widget_title_pixmap (a_editor.widget, Pixmaps.icon_pixmaps.general_document_icon , a_unique_title, docking_manager)

			register_action (Result.drop_actions, agent on_drop (?, a_editor))
			if veto_pebble_function_internal = Void then
				Result.drop_actions.set_veto_pebble_function (agent veto_pebble_function)
			end

			docking_manager.contents.extend (Result)
			register_action (Result.focus_in_actions, agent on_focus (a_editor))
			register_action (Result.focus_in_actions, agent on_editor_focus_in (Result))
			register_action (Result.focus_out_actions, agent on_editor_focus_out (Result))
			register_action (Result.close_request_actions, agent on_close (a_editor))
			register_action (Result.tab_bar_right_blank_area_double_click_actions, agent on_tab_bar_right_blank_area_double_click (Result))
			Result.set_type ({SD_ENUMERATION}.editor)

			if a_content /= Void then
				if a_force_right_side then
					Result.set_tab_with (a_content, False)
				else
					Result.set_tab_with (a_content, development_window.preferences.editor_data.new_tab_at_left)
				end
			else
				Result.set_default_editor_position
			end
		ensure
			create_docking_content_not_void: Result /= Void
		end

	create_docking_content_fake_one (a_unique_title: STRING): SD_CONTENT
			-- Create a fake docking content.
		require
			not_void: a_unique_title /= Void
		do
			create Result.make_with_widget_title_pixmap (create {EV_CELL}, Pixmaps.icon_pixmaps.general_document_icon , a_unique_title, docking_manager)
			create {EB_FAKE_SMART_EDITOR} last_created_editor.make (Result)
			last_created_editor.set_docking_content (Result)

				-- We must register drop actions for fake editors, see bug#14530
				-- Note: the parameter `last_create_editor' for agent is fake editor
			register_action (Result.drop_actions, agent on_drop (?, last_created_editor))
			if veto_pebble_function_internal = Void then
				Result.drop_actions.set_veto_pebble_function (agent veto_pebble_function)
			end

				-- When fake editor first time showing, we change it to a real one.
			register_action (Result.focus_in_actions, agent on_fake_focus (last_created_editor))
			register_action (Result.focus_in_actions, agent on_editor_focus_in (Result))
			register_action (Result.focus_out_actions, agent on_editor_focus_out (Result))
			register_action (Result.show_actions, agent on_show (last_created_editor))
			register_action (Result.tab_bar_right_blank_area_double_click_actions, agent on_tab_bar_right_blank_area_double_click (Result))
			Result.close_request_actions.extend (agent on_close (last_created_editor))

			docking_manager.contents.extend (Result)
			Result.set_type ({SD_ENUMERATION}.editor)
		ensure
			last_created_editor_non_void: attached {EB_FAKE_SMART_EDITOR} last_created_editor
		end

	change_fake_to_real (a_editor: like current_editor; a_fake_editor: EB_FAKE_SMART_EDITOR; a_content: SD_CONTENT)
			-- Change fake editor to real editors.
		require
			not_void: a_editor /= Void
			not_void: a_content /= Void
		do
			a_content.set_user_widget (a_editor.widget)

				-- We wipe out the `drop_actions' which registered in `create_docking_content_fake_one'
			a_content.drop_actions.wipe_out

			register_action (a_content.drop_actions, agent on_drop (?, a_editor))
			if veto_pebble_function_internal = Void then
				a_content.drop_actions.set_veto_pebble_function (agent veto_pebble_function)
			end

			a_content.show_actions.wipe_out

			a_content.focus_in_actions.wipe_out
			register_action (a_content.focus_in_actions, agent on_focus (a_editor))
			register_action (a_content.focus_in_actions, agent on_editor_focus_in (a_content))
			-- There are fake content close request actions which should be removed first.
			a_content.close_request_actions.wipe_out
			register_action (a_content.close_request_actions, agent on_close (a_editor))

			a_editor.set_docking_content (a_content)
			a_editor.set_stone (a_fake_editor.stone)

				-- Remove `a_fake_editor' from `fake_editors'.
			fake_editors.start
			fake_editors.prune (a_fake_editor)
		ensure
			not_has: not fake_editors.has (a_fake_editor)
		end

	build_class_name (a_path: STRING): STRING
			-- Build the class name of the text if exists --not well solved
		local
			l_class_name:STRING
			l_list_string: LIST [STRING]
		do
			l_class_name := a_path
			l_list_string := l_class_name.split (operating_environment.directory_separator)
			l_class_name := l_list_string [l_list_string.count]
			if l_class_name.has ('.') then
				Result := l_class_name.substring (1, l_class_name.last_index_of ('.', l_class_name.count) - 1)
			end
			Result.to_upper
		end

	back_up_editor (a_editor: like current_editor)
			-- Back up `a_editor'.
		require
			a_editor_not_void: a_editor /= Void
		local
			retried: BOOLEAN
			tmp_file: RAW_FILE
		do
			if not retried then
				if
					a_editor.changed and then
					attached a_editor.file_path as tmp_name
				then
					create tmp_file.make_with_path (tmp_name.appended (".swp"))
					if
						not tmp_file.exists and then
						tmp_file.is_creatable
					then
						tmp_file.open_append
						tmp_file.put_string (convert_to_stream (a_editor.wide_text, a_editor.encoding))
						tmp_file.close
					end
				end
			else
				not_backuped := not_backuped + 1
			end
		rescue
			retried := True
			retry
		end

	editor_with_stone_internal (a_editors: ARRAYED_LIST [EB_SMART_EDITOR]; a_stone: STONE): detachable EB_SMART_EDITOR
			-- Editor from `a_editors' having `a_stone'.
		require
			a_stone_set: a_stone /= Void
			editors_not_void: a_editors /= Void
		local
			e: like editor_with_stone_internal
		do
			across
				a_editors as ic
			until
				Result /= Void
			loop
				e := ic.item
				if attached e.stone as l_editor_stone then
					if a_stone.same_as (l_editor_stone) then
						Result := e
					elseif
						attached {FILED_STONE} a_stone as l_file_stone1 and then
						attached {FILED_STONE} l_editor_stone as l_file_stone2 and then
						(l_file_stone1.is_valid and l_file_stone2.is_valid) and then
						l_file_stone1.file_name.is_case_insensitive_equal (l_file_stone2.file_name)
					then
						Result := e
					end
				end
			end
		end

	remove_editor_of_content (a_content: SD_CONTENT)
			-- Remove editor related with `a_content'.
		local
			l_editors: like editors
			l_found: BOOLEAN
		do
			from
				l_editors := editors_internal
				l_editors.start
			until
				l_editors.after or l_found
			loop
				if l_editors.item.docking_content = a_content then
					l_editors.remove
					l_found := True
				else
					l_editors.forth
				end
			end
			if not l_found then
				from
					fake_editors.start
				until
					fake_editors.after or l_found
				loop
					if fake_editors.item.docking_content = a_content then
						fake_editors.remove
						l_found := True
					else
						fake_editors.forth
					end
				end
			end
		end

	veto_pebble_function (a_stone: ANY): BOOLEAN
			-- Default veto function
		do
			Result := attached {FILED_STONE} a_stone or attached {CLUSTER_STONE} a_stone
		end

	has_duplicated_stone: BOOLEAN
			-- Is there duplicated stones in all real and fake editors?
		local
			l_all: ARRAYED_LIST [EB_SMART_EDITOR]
		do
			l_all := editors
			if attached fake_editors as l_fake_editors then
				l_all.merge_right (l_fake_editors.twin)
			end

			Result := has_duplicated_stone_imp (l_all)
		end

	has_duplicated_stone_imp (a_editors: ARRAYED_LIST [EB_SMART_EDITOR]): BOOLEAN
			-- Is `a_editors' contain duplicated stones?
		require
			not_void: a_editors /= Void
		local
			l_current_editor: EB_SMART_EDITOR
			l_copy, l_another: ARRAYED_LIST [EB_SMART_EDITOR]
		do
			from
				l_copy := a_editors.twin
				a_editors.start
			until
				a_editors.after or Result
			loop
				l_current_editor := a_editors.item
				if attached l_current_editor.stone as l_stone then
					l_another := l_copy.twin
					l_another.prune_all (l_current_editor)
					if attached editor_with_stone_internal (l_another, l_stone) then
						Result := True
					end
				end

				a_editors.forth
			end
		end

feature {NONE} -- Implementation

	default_pixmaps: EV_STOCK_PIXMAPS
			-- Default pixmaps and cursors.
		once
			create Result
		end

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
