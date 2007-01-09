indexing
	description: "Tabbed editor manager for one window of EiffelStudio"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_EDITORS_MANAGER

inherit
	EB_CONSTANTS

	EB_RECYCLABLE

	SHARED_EIFFEL_PROJECT

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY

create
	make

feature -- Initialization

	make (a_dev_win: EB_DEVELOPMENT_WINDOW) is
			-- Initialization
		require
			a_dev_win_attached: a_dev_win /= Void
		do
			create editors_internal.make (0)
			create editor_switched_actions

			editor_switched_actions.extend (agent on_editor_switched)

			create editor_number_factory.make
			build_observer_lists
			development_window := a_dev_win
			docking_manager := a_dev_win.docking_manager
			docking_manager.tab_drop_actions.extend (agent create_editor_beside_content)
			create_editor
		ensure
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

	unsaved_editors: like editors_internal is
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

	docking_manager: SD_DOCKING_MANAGER
			-- Docking manager

	current_editor: EB_SMART_EDITOR is
			-- Current editor
		do
			if editors_internal.is_empty then
			else
				if editors_internal.off then
					editors_internal.start
				end
				Result := editors_internal.item
			end
		end

	editor_with_stone (a_stone: STONE) : like current_editor is
			-- Editor that has `a_stone', or editing the same path file.
		local
			l_editors: ARRAYED_LIST [like current_editor]
			l_file_stone1, l_file_stone2: FILED_STONE
		do
			if a_stone /= Void then
				l_editors := editors
				from
					l_editors.start
				until
					l_editors.after or Result /= Void
				loop
					if l_editors.item.stone /= Void and then a_stone.is_equal (l_editors.item.stone) then
						Result := l_editors.item
					else
						l_file_stone1 ?= a_stone
						l_file_stone2 ?= l_editors.item.stone
						if l_file_stone1 /= Void and l_file_stone2 /= Void then
							if l_file_stone1.file_name.is_equal (l_file_stone2.file_name) then
								Result := l_editors.item
							end
						end
					end
					l_editors.forth
				end
			end
		end

	editor_with_class (a_file_name: FILE_NAME) : like current_editor is
			-- Editor editing a class with `a_file_name'
		require
			a_file_name_attached: a_file_name /= Void
		local
			l_editors: ARRAYED_LIST [like current_editor]
			l_classi_stone: CLASSI_STONE
			l_external_file_stone: EXTERNAL_FILE_STONE
		do
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after or Result /= Void
			loop
				l_classi_stone ?= l_editors.item.stone
				l_external_file_stone ?= l_editors.item.stone
				if l_classi_stone /= Void then
					if l_classi_stone.file_name.is_equal (a_file_name) then
						Result := l_editors.item
					end
				elseif l_external_file_stone /= Void then
					if l_external_file_stone.file_name.is_equal (a_file_name) then
						Result := l_editors.item
					end
				end
				l_editors.forth
			end
		end

	editors: like editors_internal is
			-- Clone of all editors
		do
			Result := editors_internal.twin
		end

	editor_count: INTEGER is
			-- Number of editors under management.
		do
			Result := editors_internal.count
		end

	development_window: EB_DEVELOPMENT_WINDOW
			-- Associated development window.

	editor_editing (a_class_i: CLASS_I) : like editors_internal  is
			-- Editors contain `a_class_i'
		require
			a_class_i_attached: a_class_i /= Void
		local
			l_stone: CLASSI_STONE
			l_editors: like editors
		do
			create Result.make (0)
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after
			loop
				l_stone ?= l_editors.item.stone
				if l_stone /= Void and then l_stone.class_i /= Void and then a_class_i = l_stone.class_i then
					Result.extend (l_editors.item)
				end
				l_editors.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	last_focused_editor: like current_editor
			-- Last focused editor

	last_created_editor: like current_editor
			-- Last created editor

	open_classes: HASH_TABLE [FILE_NAME, STRING] is
			-- Open classes.
		local
			l_classc_stone: CLASSC_STONE
			l_editors: like editors
		do
			create Result.make (editors_internal.count)
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after
			loop
				l_classc_stone ?= l_editors.item.stone
				if l_classc_stone /= Void then
					Result.put (l_classc_stone.file_name, l_editors.item.docking_content.unique_title.as_string_8)
				end
				l_editors.forth
			end
		ensure
			not_void: Result /= Void
		end

	open_fake_classes: HASH_TABLE [FILE_NAME, STRING] is
			-- Opened classes that in fake editors.
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_fake_editor: EB_FAKE_SMART_EDITOR_CELL
			l_classc_stone: CLASSC_STONE
		do
			create Result.make (1)
			from
				l_contents := docking_manager.contents.twin
				l_contents.start
			until
				l_contents.after
			loop
				if l_contents.item.type = {SD_ENUMERATION}.editor then
					l_fake_editor ?= l_contents.item.user_widget
					if l_fake_editor /= Void then
						l_classc_stone ?= l_fake_editor.stone
						check only_class_editor_can_fake: l_classc_stone /= Void end
						Result.put (l_classc_stone.file_name, l_contents.item.unique_title.as_string_8)
					end
				end
				l_contents.forth
			end
		ensure
			not_void: Result /= Void
		end

	open_clusters: HASH_TABLE [STRING, STRING] is
			-- Open clusters.
		local
			l_cluster_stone: CLUSTER_STONE
			l_editors: like editors
		do
			create Result.make (editors_internal.count)
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after
			loop
				l_cluster_stone ?= l_editors.item.stone
				if l_cluster_stone /= Void then
					Result.put (l_cluster_stone.cluster_i.cluster_name.as_string_8, l_editors.item.docking_content.unique_title.as_string_8)
				end
				l_editors.forth
			end
		end

feature -- Access actions

	editor_switched_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions after editor switched

	editor_closed_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions invoked when an editor is closed
		do
			if editor_closed_actions_internal = Void then
				create editor_closed_actions_internal
			end
			Result := editor_closed_actions_internal
		ensure
			result_not_void: Result /= Void
		end

	editor_created_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions invoked when an editor is created
		do
			if editor_created_actions_internal = Void then
				create editor_created_actions_internal
			end
			Result := editor_created_actions_internal
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_class_editing (a_file_name: STRING) : BOOLEAN is
			-- Editor editing a class with `a_file_name'
		require
			a_file_name_attached: a_file_name /= Void
		local
			l_editors: like editors_internal
			l_classi_stone: CLASSI_STONE
			l_external_file_stone: EXTERNAL_FILE_STONE
		do
			l_editors := editors
			from
				l_editors.start
			until
				l_editors.after or Result
			loop
				l_classi_stone ?= l_editors.item.stone
				l_external_file_stone ?= l_editors.item.stone
				if l_classi_stone /= Void then
					if l_classi_stone.file_name.string.is_equal (a_file_name) then
						Result := true
					end
				elseif l_external_file_stone /= Void then
					if l_external_file_stone.file_name.string.is_equal (a_file_name) then
						Result := true
					end
				end
				l_editors.forth
			end
		end

	changed : BOOLEAN is
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

	full_loaded: BOOLEAN is
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

	not_backuped: INTEGER
			-- Number of editors not backuped last time

feature -- Editor observer

	add_edition_observer (a_text_observer: TEXT_OBSERVER) is
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

	add_history_observer (history_observer: UNDO_REDO_OBSERVER) is
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

	remove_history_observer (history_observer: UNDO_REDO_OBSERVER) is
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

	add_cursor_observer (a_cursor_observer: TEXT_OBSERVER) is
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

feature -- Element change

	create_editor is
			-- Create a new editor.
		do
			create_editor_beside_content (Void, exist_content)
		end

	create_editor_beside_content (a_stone: STONE; a_content: SD_CONTENT) is
			-- Create an editor beside `a_content'. Meanwile set `a_stone' to the editor if `a_stone' is not void.
			-- Set top if the a_content is void.
		local
			l_content: SD_CONTENT
		do
			if editor_with_stone (a_stone) = Void then
				init_editor
				l_content := create_docking_content (editor_number_factory.new_editor_name, last_created_editor, a_content)
				last_created_editor.set_docking_content (l_content)
			end

			if a_stone /= Void then
				on_drop (a_stone, last_created_editor)
			end
		end

	close_editor (a_editor: like current_editor) is
			-- Close an editor.
		require
			a_editor_attached: a_editor /= Void
		do
			on_close (a_editor)
		end

	close_all_editor is
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
				l_editors.item.docking_content.close
				l_editors.forth
			end
			create editors_internal.make (5)
			editor_closed_actions.call ([])
		end

	set_veto_pebble_function (a_func: FUNCTION [ANY, TUPLE [ANY], BOOLEAN]) is
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
				l_editors.forth
			end
		end

	restore_editors (a_open_classes: HASH_TABLE [FILE_NAME, STRING]; a_open_clusters: HASH_TABLE [STRING, STRING]): BOOLEAN is
			-- Restore editors.
			-- If really have editors to open, then result is True, otherwise is False
		require
			a_open_classes_attached: a_open_classes /= Void
			a_open_clusters_attached: a_open_clusters /= Void
		local
			l_classi_stone: CLASSI_STONE
			l_classc_stone: CLASSC_STONE
			l_cluster_stone: CLUSTER_STONE
			l_classi: CLASS_I
			l_cluster: CLUSTER_I
			l_content: SD_CONTENT
			l_editor_numbers: ARRAYED_LIST [INTEGER]
			l_classes: LIST [CLASS_I]
		do
			-- After this operation, the place holder zone will be inserted by docking library
			close_all_editor
			if not a_open_classes.is_empty or not a_open_clusters.is_empty then
				is_opening_editors := True


				create l_editor_numbers.make (a_open_classes.count + a_open_clusters.count)

				create fake_editors.make (5)
					-- Restore open classese.
				from
					a_open_classes.start
				until
					a_open_classes.after
				loop
					-- FIXIT: maybe same name class here
					l_classes := eiffel_universe.classes_with_name (build_class_name (a_open_classes.item_for_iteration))
					if not l_classes.is_empty then
						l_classi ?= l_classes.first
					end
					if l_classi /= Void then
						l_content := create_docking_content_fake_one (a_open_classes.key_for_iteration, l_content)

						fake_editors.extend (last_created_editor)

						l_content.set_long_title (l_classi.name)
						l_content.set_short_title (l_classi.name)
						l_content.set_pixmap (pixmap_from_class_i (l_classi))
						l_editor_numbers.extend (editor_number_factory.editor_number_from_title (a_open_classes.key_for_iteration))
						if l_classi.is_compiled then
							create l_classc_stone.make (l_classi.compiled_class)
							last_created_editor.set_stone (l_classc_stone)
						else
							create l_classi_stone.make (l_classi)
							last_created_editor.set_stone (l_classi_stone)
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
					l_cluster := eiffel_universe.cluster_of_name (a_open_clusters.item_for_iteration)
					if l_cluster /= Void then
						create l_cluster_stone.make (l_cluster)
						init_editor
						l_content := create_docking_content (a_open_clusters.key_for_iteration, last_created_editor, exist_content)

						l_editor_numbers.extend (editor_number_factory.editor_number_from_title (a_open_clusters.key_for_iteration))
						last_created_editor.set_docking_content (l_content)
						l_content.set_focus
						development_window.set_stone (l_cluster_stone)
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

	fake_editors: ARRAYED_LIST [EB_SMART_EDITOR]
			-- Fake editors which is for fast opening Eiffel Studio.
			-- It should be cleaned by call `show_editors_possible'.

	show_editors_possible is
			-- Show editors which are possible to show.
		local
			l_snapshot: like fake_editors
		do
			if fake_editors /= Void then
				from
					l_snapshot := fake_editors
					l_snapshot.start
					fake_editors := Void -- Then on_focus can execute.
				until
					l_snapshot.after
				loop
					if l_snapshot.item.docking_content.user_widget.is_displayed then
						on_focus (l_snapshot.item)
					end
					l_snapshot.forth
				end
			end
		ensure
			cleaned: fake_editors = Void
		end

feature -- Basic operations

	select_editor (a_editor: like current_editor) is
			-- Give `a_editor' focus.
		require
			a_editor_attached: a_editor /= Void
		do
			if editors_internal.has (a_editor) then
				if docking_manager.has_content (a_editor.docking_content) then
					a_editor.docking_content.set_focus
					if a_editor.editor_drawing_area.is_sensitive and a_editor.editor_drawing_area.is_displayed then
						a_editor.editor_drawing_area.set_focus
					end
				end
			end
		end

	backup_all is
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

feature -- Memory management

	internal_recycle is
			-- Memory management
		do
		end

feature {NONE} -- Access

	editor_closed_actions_internal: like editor_closed_actions
			-- Actions invoked when an editor is closed

	editor_created_actions_internal: like editor_created_actions
			-- Actions invoked when an editor is created

	editors_internal: ARRAYED_LIST [like current_editor]
			-- Actual list of editors.

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

	build_observer_lists is
			-- Build all internal observer lists.
		do
			create edition_observer_list_internal.make (0)
			create history_observer_list_internal.make (0)
			create cursor_observer_list_internal.make (0)
			create selection_observer_list_internal.make (0)
			create lines_observer_list_internal.make (0)
		end

	add_observers (a_editor: like current_editor) is
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

feature {NONE}-- Implementation

	is_opening_editors: BOOLEAN
		-- If Current opening more than one editors?

	editor_number_factory: EB_EDITOR_NUMBER_FACTORY
			-- Produce editor number and internal names.

	veto_pebble_function_internal: FUNCTION [ANY, TUPLE [ANY], BOOLEAN]
			-- Veto pebble function.

	on_focus (a_editor: like current_editor) is
			-- Invoke when `a_editor' is focusing.
		local
			l_fake_editor: EB_FAKE_SMART_EDITOR
			l_editor: EB_SMART_EDITOR
		do
			if not is_opening_editors and fake_editors = Void then
				l_fake_editor ?= a_editor
				if l_fake_editor /= Void then
					check not_has: not has_editor_with_long_title (l_fake_editor.content.long_title) end
					init_editor
					change_fake_to_real (last_created_editor, l_fake_editor, l_fake_editor.content)
					l_editor := last_created_editor
				else
					l_editor := a_editor
				end

				if not editors_internal.is_empty and then not editors_internal.off then
					if last_focused_editor /= editors_internal.item then
						last_focused_editor := current_editor
					end
				else
					last_focused_editor := Void
				end
				validate_editor (l_editor)
				editor_switched_actions.call ([l_editor])
				if l_editor.editor_drawing_area.is_displayed and l_editor.editor_drawing_area.is_sensitive then
					l_editor.editor_drawing_area.set_focus
				end
			end
		end

	on_drop (a_stone: STONE; a_editor: like current_editor) is
			-- Invoke when a stone is dropped on `a_editor'.
		local
			l_editor : like current_editor
		do
			development_window.set_dropping_on_editor (true)
			l_editor := editor_with_stone (a_stone)
			if l_editor /= Void then
				l_editor.docking_content.set_focus
				if l_editor.editor_drawing_area.is_displayed then
					l_editor.editor_drawing_area.set_focus
				end
			else
				a_editor.docking_content.set_focus
				a_editor.editor_drawing_area.set_focus
			end
			development_window.set_stone (a_stone)
			development_window.set_dropping_on_editor (false)
		end

	on_close (a_editor: like current_editor) is
			-- Closing an editor callback.
		do
			if a_editor.changed then
				development_window.save_and (agent close_editor_perform (a_editor))
			else
				close_editor_perform (a_editor)
			end
		end

	close_editor_perform (a_editor: like current_editor) is
			-- Perform closing editor.
		do
			editors_internal.prune_all (a_editor)
			editor_number_factory.remove_editor_name (a_editor.docking_content.unique_title)
			a_editor.docking_content.close
			editor_closed_actions.call ([])
			a_editor.recycle
			if editors_internal.is_empty then
				last_created_editor := Void
			end
			if last_focused_editor /= Void then
				select_editor (last_focused_editor)
			end
		end

	validate_editor (a_editor: like current_editor) is
			-- Locate `a_editor' in `editor_internal'. If not exist, start `editor_internal'.
		do
			editors_internal.start
			editors_internal.search (a_editor)
			if editors_internal.exhausted then
				editors_internal.start
			end
		end

	exist_content : SD_CONTENT is
			-- A docking content that exists. Void if not.
		do
			if not editors_internal.is_empty then
				Result := current_editor.docking_content
			end
		end

	init_editor is
			-- Initial an editor.
		do
			create last_created_editor.make (development_window)
			last_created_editor.widget.set_minimum_size (0, 0)
			add_observers (last_created_editor)
			last_created_editor.drop_actions.extend (agent on_drop (?, last_created_editor))
			editors_internal.extend (last_created_editor)
			if editors_internal.off then
				editors_internal.start
			end
		end

	has_editor_with_long_title (a_title: STRING_GENERAL): BOOLEAN is
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

	create_docking_content (a_unique_title: STRING; a_editor: like current_editor; a_content: SD_CONTENT): SD_CONTENT is
			-- Create a docking content with `a_editor' in it.
			-- This content is set close to a_content if a_content is not void.
		require
			a_unique_title_not_void: a_unique_title /= Void
			a_editor_not_void: a_editor /= Void
		do
			create Result.make_with_widget_title_pixmap (a_editor.widget, Pixmaps.icon_pixmaps.general_document_icon , a_unique_title)

			Result.drop_actions.extend (agent on_drop (?, a_editor))

			docking_manager.contents.extend (Result)
			Result.focus_in_actions.extend (agent on_focus (a_editor))
			Result.close_request_actions.extend (agent on_close (a_editor))
			Result.set_type ({SD_ENUMERATION}.editor)
			if a_content /= Void then
				Result.set_tab_with (a_content, development_window.preferences.editor_data.new_tab_at_left)
			else
				Result.set_default_editor_position
			end
		ensure
			create_docking_content_not_void: Result /= Void
		end

	create_docking_content_fake_one (a_unique_title: STRING; a_content: SD_CONTENT): SD_CONTENT is
			-- Create a fake docking content.
		require
			not_void: a_unique_title /= Void
		do
			create Result.make_with_widget_title_pixmap (create {EB_FAKE_SMART_EDITOR_CELL}, Pixmaps.icon_pixmaps.general_document_icon , a_unique_title)
			create {EB_FAKE_SMART_EDITOR} last_created_editor.make (Result)
			last_created_editor.set_docking_content (Result)

			Result.focus_in_actions.extend (agent on_focus (last_created_editor))

			Result.close_request_actions.extend (agent Result.close)
			docking_manager.contents.extend (Result)

			Result.set_type ({SD_ENUMERATION}.editor)
		end

	change_fake_to_real (a_editor, a_fake_editor: like current_editor; a_content: SD_CONTENT) is
			-- Change fake editor to real editors.
		require
			not_void: a_editor /= Void
			not_void: a_content /= Void
		do
			a_content.set_user_widget (a_editor.widget)
			a_content.drop_actions.extend (agent on_drop (?, a_editor))

			a_content.focus_in_actions.wipe_out
			a_content.focus_in_actions.extend (agent on_focus (a_editor))
			-- There are fake content close request actions which should be removed first.
			a_content.close_request_actions.wipe_out
			a_content.close_request_actions.extend (agent on_close (a_editor))

			a_editor.set_docking_content (a_content)
			a_editor.set_stone (a_fake_editor.stone)
		end

	build_class_name (a_path: STRING): STRING is
			-- Build the class name of the text if exists --not well solved
		local
			l_class_name:STRING
			l_list_string: LIST [STRING]
		do
			l_class_name := a_path
			l_list_string := l_class_name.split (operating_environment.directory_separator)
			l_class_name := l_list_string [l_list_string.count]
			if l_class_name.has ('.') then
				Result := l_class_name.substring (1,
														l_class_name.last_index_of ('.', l_class_name.count) - 1)
			end
			Result.to_upper
		end

	on_editor_switched (a_editor: EB_SMART_EDITOR) is
			-- Editor is switched.
		do
			-- When making Current, development_window.editors_manager is void.
			if development_window.editors_manager /= Void then
				development_window.set_stone (a_editor.stone)
			end
		end

	back_up_editor (a_editor: like current_editor) is
			-- Back up `a_editor'.
		require
			a_editor_not_void: a_editor /= Void
		local
			retried: BOOLEAN
			tmp_name: FILE_NAME
			tmp_file: RAW_FILE
		do
			if not retried then
				if a_editor.changed then
					tmp_name := a_editor.file_name
					if tmp_name /= Void then
						tmp_name := tmp_name.twin
						tmp_name.add_extension ("swp")
						create tmp_file.make (tmp_name)
						if
							not tmp_file.exists and then
							tmp_file.is_creatable
						then
							tmp_file.open_append
							tmp_file.put_string (a_editor.text)
							tmp_file.close
						end
					end
				end
			else
				not_backuped := not_backuped + 1
			end
		rescue
			retried := True
			retry
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

end
