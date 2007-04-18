indexing
	description	: "Window manager for tools."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_WINDOW_MANAGER

inherit
	ANY

	EB_SHARED_INTERFACE_TOOLS
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EB_CLUSTER_MANAGER_OBSERVER
			-- Just to have a reference to the cluster manager.
		export
			{NONE} all
		redefine
			on_project_loaded,
			on_project_unloaded
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Make a window manager.
		do
			create managed_windows.make (10)
			create focused_windows.make (5)

			create minimize_all_cmd.make
			minimize_all_cmd.set_pixmap (pixmaps.icon_pixmaps.windows_minimize_all_icon)
			minimize_all_cmd.set_tooltip (Interface_names.e_Minimize_all)
			minimize_all_cmd.set_menu_name (Interface_names.m_Minimize_all)
			minimize_all_cmd.set_tooltext (Interface_names.b_Minimize_all)
			minimize_all_cmd.set_name ("Minimize_all")
			minimize_all_cmd.add_agent (agent minimize_all)
			minimize_all_cmd.enable_sensitive

			create raise_all_cmd.make
			raise_all_cmd.set_pixmap (pixmaps.icon_pixmaps.windows_raise_all_icon)
			raise_all_cmd.set_tooltip (Interface_names.e_Raise_all)
			raise_all_cmd.set_menu_name (Interface_names.m_Raise_all)
			raise_all_cmd.set_tooltext (Interface_names.b_Raise_all)
			raise_all_cmd.set_name ("Raise_all")
			raise_all_cmd.add_agent (agent raise_all)
			raise_all_cmd.enable_sensitive

			create raise_all_unsaved_cmd.make
			raise_all_unsaved_cmd.set_pixmap (pixmaps.icon_pixmaps.windows_raise_all_unsaved_icon)
			raise_all_unsaved_cmd.set_tooltip (Interface_names.e_Raise_all_unsaved)
			raise_all_unsaved_cmd.set_menu_name (Interface_names.m_Raise_all_unsaved)
			raise_all_unsaved_cmd.set_name ("Raise_all_unsaved")
			raise_all_unsaved_cmd.add_agent (agent raise_all_unsaved)
			raise_all_unsaved_cmd.enable_sensitive

			Eiffel_project.manager.load_agents.extend (agent on_project_loaded)
			Eiffel_project.manager.create_agents.extend (agent on_project_created)
			Eiffel_project.manager.close_agents.extend (agent on_project_unloaded)
		end

feature -- Basic operations

	new_menu: EB_WINDOW_MANAGER_MENU is
			-- Menu corresponding to current: This is a menu with
			-- the following entries: New Window, Minimize All and
			-- an entry for each opened window.
			--
			-- When this menu is not anymore needed, call `recycle' on it.
		do
			create Result.make (Current)
		end

	new_widget: EB_WINDOW_MANAGER_LIST is
			-- Widget corresponding to current: This is a list with
			-- all opened windows.
			--
			-- When this list is not anymore needed, call `recycle' on it.
		do
			create Result.make (Current)
		end

	create_window is
			-- Create a new development window and update `last_created_window'.
		local
			l_director: EB_DEVELOPMENT_WINDOW_DIRECTOR
			l_window: EB_DEVELOPMENT_WINDOW
		do
			create l_director.make
			l_director.construct
			l_window := l_director.develop_window
			initialize_window (l_window, True)
		end

	create_window_from_session_data (a_dev_window: EB_DEVELOPMENT_WINDOW; a_session_data: EB_DEVELOPMENT_WINDOW_SESSION_DATA) is
			-- Create a new window using `a_session_data'
		require
			a_session_data_not_void: a_session_data /= Void
		local
			l_window: EB_DEVELOPMENT_WINDOW
			l_director: EB_DEVELOPMENT_WINDOW_DIRECTOR
		do
			create l_director.make
			l_director.construct_with_session_data (a_dev_window, a_session_data)
			l_window := l_director.develop_window
			initialize_window (l_window, False)
		end

	create_editor_window is
			-- Create a new editor window and update `last_created_window'.
		local
			l_window: EB_DEVELOPMENT_WINDOW
			l_director: EB_DEVELOPMENT_WINDOW_DIRECTOR
		do
			create l_director.make
			l_director.construct_as_editor
			l_window := l_director.develop_window
			initialize_window (l_window, True)
		end

	create_context_window is
			-- Create a new context window and update `last_created_window'.
		local
			l_window: EB_DEVELOPMENT_WINDOW
			l_director: EB_DEVELOPMENT_WINDOW_DIRECTOR
		do
			create l_director.make
			l_director.construct_as_context_tool
			l_window := l_director.develop_window
			initialize_window (l_window, True)
		end

	initialize_window (a_window: EB_DEVELOPMENT_WINDOW; a_new_window: BOOLEAN) is
			-- Initialize `a_window'.
			-- If `a_window' is not `a_new_window', we ignore window title.
		require
			a_window_not_void: a_window /= Void
		do
			managed_windows.extend (a_window)
			if a_window.stone = Void and then a_new_window then
					-- Set the title if a stone hasn't already been set by session manager.
				a_window.set_title (new_title)
			end
			if a_new_window then
				notify_observers (a_window, Notify_added_window)
			else
				notify_observers (a_window, Notify_changed_window)
			end
			last_created_window := a_window

				-- Show the window if not already shown
			if not a_window.is_visible then
				a_window.show
			end
			a_window.give_focus
		end

	create_dynamic_lib_window is
			-- Create a new dynamic library window if necessary and display it.
		local
			a_window: EB_DYNAMIC_LIB_WINDOW
		do
			if not dynamic_lib_window_is_valid then
				create a_window.make
				managed_windows.extend (a_window)
				notify_observers (a_window, Notify_added_window)
				set_dynamic_lib_window (a_window)
			end

				-- Show the window
			dynamic_lib_window.show
			dynamic_lib_window.give_focus
		ensure
			valid_dynamic_lib_window: dynamic_lib_window_is_valid
		end

feature -- Access

	development_windows_with_class (cl_name: STRING): LIST [EB_DEVELOPMENT_WINDOW] is
			-- List of all windows with `cl_name' opened.
		require
			cl_name_not_void: cl_name /= Void
		local
			a_dev: EB_DEVELOPMENT_WINDOW
			l_index: INTEGER
		do
			create {ARRAYED_LIST [EB_DEVELOPMENT_WINDOW]} Result.make (managed_windows.count)
			from
				l_index := managed_windows.index
				managed_windows.start
			until
				managed_windows.after
			loop
				a_dev ?= managed_windows.item
				if a_dev /= Void then
					if a_dev.editors_manager.is_class_editing (cl_name) then
						Result.extend (a_dev)
					end
				end
				managed_windows.forth
			end
			managed_windows.go_i_th (l_index)
		ensure
			not_void: Result /= Void
		end

	compile_start_actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions to be performed when Eiffel compilation starts
		do
			if compile_start_actions_internal = Void then
				create compile_start_actions_internal
			end
			Result := compile_start_actions_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	last_created_window: EB_DEVELOPMENT_WINDOW
			-- Window created by the last call to `create_window'.
			-- Void if none.

	development_windows_count: INTEGER is
			-- number of visible development windows
		local
			a_dev: EB_DEVELOPMENT_WINDOW
			l_index: INTEGER
		do
			from
				l_index := managed_windows.index
				managed_windows.start
			until
				managed_windows.after
			loop
				a_dev ?= managed_windows.item
				if a_dev /= Void then
					Result := Result + 1
				end
				managed_windows.forth
			end
			managed_windows.go_i_th (l_index)
		end

	has_active_development_windows: BOOLEAN is
			-- Are there any active development window up?
		do
			Result := (development_windows_count /= 0)
		end

	has_modified_windows: BOOLEAN is
			-- Are there any window having been modified and not yet saved?
		local
			a_dev: EB_DEVELOPMENT_WINDOW
			l_index: INTEGER
		do
			from
				l_index := managed_windows.index
				managed_windows.start
			until
				Result or else managed_windows.after
			loop
				a_dev ?= managed_windows.item
				if a_dev /= Void then
					Result := a_dev.any_editor_changed
				end
				managed_windows.forth
			end
			if not Result then
				Result := (dynamic_lib_window_is_valid and then dynamic_lib_window.changed)
			end
			managed_windows.go_i_th (l_index)
		end

	development_window_from_window (a_window: EV_WINDOW): EB_DEVELOPMENT_WINDOW is
			-- Return the development window whose widget is `a_window'.
		local
			l_index: INTEGER
		do
			from
				l_index := managed_windows.index
				managed_windows.start
			until
				managed_windows.after or else
				Result /= Void
			loop
				if
					managed_windows.item /= Void and then
					managed_windows.item.window = a_window
				then
					Result ?= managed_windows.item
				end
				managed_windows.forth
			end
			managed_windows.go_i_th (l_index)
		end

	last_focused_development_window: EB_DEVELOPMENT_WINDOW is
			-- Return the development window which last had the keyboard focus.
		do
			from
				focused_windows.finish
			until
				Result /= Void or else focused_windows.before
			loop
				Result ?= focused_windows.item
				focused_windows.back
			end
			if Result = Void then
				Result := a_development_window
			end
		end

	last_focused_window: EB_WINDOW is
			-- Return the window which last had the keyboard focus.
			-- Return Void if no window is focused.
		local
			l_list: ARRAYED_LIST [EB_WINDOW]
		do
			if not focused_windows.is_empty then
				Result := focused_windows.last
			elseif not managed_windows.is_empty then
				l_list := managed_windows.twin
				Result := l_list.last
			end
		end

	a_development_window: EB_DEVELOPMENT_WINDOW is
			-- Return a random development window
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
			found: BOOLEAN
			l_index: INTEGER
		do
			from
				l_index := managed_windows.index
				managed_windows.start
			until
				managed_windows.after or found
			loop
				conv_dev ?= managed_windows.item
				found := (conv_dev /= Void)
				managed_windows.forth
			end
			Result := conv_dev
			managed_windows.go_i_th (l_index)
		end

feature -- Actions on a given window

	show_window (a_window: EB_WINDOW)  is
			-- Show the window.
		do
				-- We call `raise' since it takes care of really showing the window
				-- in case it is hidden or minimized.
			a_window.window.raise
			notify_observers (a_window, Notify_shown_window)
		end

	hide_window (a_window: EB_WINDOW) is
			-- Hide the window
		do
			a_window.window.hide
			notify_observers (a_window, Notify_hidden_window)
		end

	destroy_window (a_window: EB_WINDOW) is
			-- Destroy the window.
		do
				-- Remove this window from managed windows.
			managed_windows.prune_all (a_window)
			focused_windows.prune_all (a_window)

			if last_created_window = a_window then
				last_created_window := Void
			end

				-- Notify the observers
			notify_observers (a_window, Notify_removed_window)

				-- Destroy the window.
			a_window.destroy_imp
		end

	record_window_change (a_window: EB_WINDOW) is
			-- Record that `a_window' has changed and notify the observers.
		do
			notify_observers (a_window, Notify_changed_window)
		end

feature -- Actions on all windows

	raise_all_unsaved is
			-- Raise all the editors.
		do
			for_all (agent raise_unsaved_action)
		end

	refresh_all is
			-- Refresh all the windows after a compilation
		do
			for_all (agent refresh_action)
		end

	save_all is
			-- Ask each window to save its content.
		do
			for_all (agent save_action)
		end

	save_all_before_compiling is
			-- Ask each window to save its content.
		do
			for_all (agent save_before_compiling_action)
		end

	backup_all is
			-- Create a backup file (.swp) for all development window.
		do
			not_backuped := 0
			for_all (agent backup_action)
		end

	not_backuped: INTEGER
			-- Number of files that could not be backed up during a back up.

	minimize_all is
			-- Minimize all windows
		do
			for_all (agent minimize_action)
		end

	disable_all is
			-- Disable sensitivity on all windows.
		do
			for_all (agent disable_action)
		end

	enable_all is
			-- Enable sensitivity on all windows.
		do
			for_all (agent enable_action)
		end

	quick_refresh_all_margins is
			-- Redraws the margins of all the editor windows.
		do
			for_all (agent quick_refresh_margin_action)
		end

	quick_refresh_all_editors is
			-- Redraws the editors of all the windows.
		do
			for_all (agent quick_refresh_action)
		end

	raise_all is
			-- Raise all windows.
		do
			for_all (agent show_window)
		end

	close_all is
			-- Close all windows.
		do
			from
				managed_windows.start
			until
				managed_windows.after
			loop
				close_action (managed_windows.item)
				if not managed_windows.after then
						-- Since we delete elements, we might be after.
					managed_windows.forth
				end
			end
		end

	synchronize_all_about_breakpoints is
		do
			quick_refresh_all_margins
			for_all (agent synchronize_breakpoints_action)
		end

	synchronize_all is
			-- A compilation is over. Warn all windows and tools.
		do
				-- Reload the cluster tree in the cluster manager.
			manager.refresh

				-- Get rid of all dead classes in the favorites.
			favorites.refresh

				-- Update the state of some commands.

			if not Eiffel_project.compilation_modes.is_precompiling then
				freeze_project_cmd.enable_sensitive
				precompilation_cmd.disable_sensitive
				Finalize_project_cmd.enable_sensitive
			else
				freeze_project_cmd.disable_sensitive
				precompilation_cmd.enable_sensitive
				Finalize_project_cmd.disable_sensitive
			end
			for_all (agent c_compilation_start_action)
			melt_project_cmd.enable_sensitive
			terminate_c_compilation_cmd.disable_sensitive
			refactoring_manager.enable_sensitive
			override_scan_cmd.enable_sensitive
			discover_melt_cmd.enable_sensitive

			project_cancel_cmd.disable_sensitive
			if process_manager.is_c_compilation_running then
				on_c_compilation_start
			else
				for_all (agent for_all (agent c_compilation_stop_action))
			end
			for_all (agent synchronize_action)
		end

	display_message_and_percentage (m: STRING; a_value: INTEGER) is
			-- Display message `m' and `a_value' percentage in status bars of all development windows.
		require
			one_line_message: m /= Void and then (not m.has ('%N') and not m.has ('%R'))
			a_value_valid: a_value >= 0 and then a_value <= 100
		local
			l_managed_windows: like managed_windows
			cv_dev: EB_DEVELOPMENT_WINDOW
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
		do
			from
					-- Make a twin of the list incase window is destroyed during
					-- indirect call to status bar `process_events_and_idle' which
					-- is needed to update the label and progress bar display.
				l_managed_windows := managed_windows.twin
				l_managed_windows.start
			until
				l_managed_windows.after
			loop
				cv_dev ?= l_managed_windows.item
				if cv_dev /= Void and then not cv_dev.destroyed then
					l_status_bar := cv_dev.status_bar
					l_status_bar.display_message (m)
					l_status_bar.progress_bar.reset
					l_status_bar.progress_bar.set_value (a_value)
				end
				l_managed_windows.forth
			end
		end

	display_message (m: STRING_GENERAL) is
			-- Display a message in status bars of all development windows.
		require
			one_line_message: m /= Void and then (not m.has_code (('%N').natural_32_code) and not m.has_code (('%R').natural_32_code))
		local
			l_managed_windows: like managed_windows
			cv_dev: EB_DEVELOPMENT_WINDOW
		do
			from
					-- Make a twin of the list incase window is destroyed during
					-- indirect call to status bar `process_events_and_idle' which
					-- is needed to update the label and progress bar display.
				l_managed_windows := managed_windows.twin
				l_managed_windows.start
			until
				l_managed_windows.after
			loop
				cv_dev ?= l_managed_windows.item
				if cv_dev /= Void and then not cv_dev.destroyed then
					cv_dev.status_bar.display_message (m)
				end
				l_managed_windows.forth
			end
		end

	display_percentage (a_value: INTEGER) is
			-- Display `a_value' percentage in status bars of all development windows.
		require
			a_value_valid: a_value >= 0 and then a_value <= 100
		local
			l_managed_windows: like managed_windows
			cv_dev: EB_DEVELOPMENT_WINDOW
			pb: EB_PERCENT_PROGRESS_BAR
		do
			from
					-- Make a twin of the list incase window is destroyed during
					-- indirect call to status bar `process_events_and_idle' which
					-- is needed to update the label and progress bar display.
				l_managed_windows := managed_windows.twin
				l_managed_windows.start
			until
				l_managed_windows.after
			loop
				cv_dev ?= l_managed_windows.item
				if cv_dev /= Void and then not cv_dev.destroyed then
					pb := cv_dev.status_bar.progress_bar
					pb.reset
					pb.set_value (a_value)
					pb.refresh_now
				end
				l_managed_windows.forth
			end
		end

	display_c_compilation_progress (mess: STRING_GENERAL) is
			-- Display `mess' in status bars of all development windows.
		require
			mess_not_void: mess /= Void
			mess_not_empty: not mess.is_empty
		local
			l_managed_windows: like managed_windows
			cv_dev: EB_DEVELOPMENT_WINDOW
		do
			from
					-- Make a twin of the list incase window is destroyed during
					-- indirect call to status bar `process_events_and_idle' which
					-- is needed to update the label and progress bar display.
				l_managed_windows := managed_windows.twin
				l_managed_windows.start
			until
				l_managed_windows.after
			loop
				cv_dev ?= l_managed_windows.item
				if cv_dev /= Void and then not cv_dev.destroyed then
					if cv_dev.status_bar.message.is_empty then
						cv_dev.status_bar.display_message (mess)
						state_message_waiting_count := 0
					else
						state_message_waiting_count := state_message_waiting_count + 1
						if state_message_waiting_count > max_waiting_count then
							state_message_waiting_count := 0
							cv_dev.status_bar.display_message (mess)
						end
					end
				end
				l_managed_windows.forth
			end
		end

	for_all_development_windows (p: PROCEDURE [ANY, TUPLE [EB_DEVELOPMENT_WINDOW]]) is
			-- Call `p' on all development windows.
		local
			cv_dev: EB_DEVELOPMENT_WINDOW
			l_index: INTEGER
		do
			from
				l_index := managed_windows.index
				managed_windows.start
			until
				managed_windows.after
			loop
				cv_dev ?= managed_windows.item
				if cv_dev /= Void then
					p.call ([cv_dev])
				end
				managed_windows.forth
			end
			if managed_windows.valid_index (l_index) then
				managed_windows.go_i_th (l_index)
			end
		end

feature {EB_SHORTCUT_MANAGER} -- Actions on all windows

	refresh_commands is
			-- Refresh all windows commands.
		do
			for_all (agent refresh_commands_action)
		end

	refresh_external_commands is
			-- Only refresh external commands
		do
			for_all (agent refresh_external_commands_action)
		end

feature {EB_WINDOW, EB_DEVELOPMENT_WINDOW_BUILDER} -- Events

	set_focused_window (w: EB_WINDOW) is
			-- Tell `Current' `w' has been given the focus.
		do
			focused_windows.prune_all (w)
			focused_windows.extend (w)
		end

	try_to_destroy_window (a_window: EB_WINDOW) is
			-- Destroy the window if it is possible.
			-- The window-level checks should be performed in EB_WINDOW::destroy.
			-- This method only takes into account the cases when closing the
			-- window means exiting the application.
		local
			loc_development_window: EB_DEVELOPMENT_WINDOW
		do
			loc_development_window ?= a_window
			if development_windows_count = 1 and then loc_development_window /= Void then
				confirm_and_quit
			else
				destroy_window (a_window)
			end
		end

feature {NONE} -- Exit implementation

	confirm_and_quit is
			-- If a compilation is under way, do not exit.
		local
			wd: EB_WARNING_DIALOG
			qd: EB_QUESTION_DIALOG
			evcsts: EV_DIALOG_CONSTANTS
		do
			if Eiffel_project.initialized and then Eiffel_project.is_compiling then
				Exit_application_cmd.set_already_confirmed (True)
				create wd.make_with_text (Warning_messages.W_exiting_stops_compilation)
				wd.show_modal_to_window (last_focused_development_window.window)
			elseif has_modified_windows then
				Exit_application_cmd.set_already_confirmed (True)
				create qd.make_with_text (Interface_names.L_exit_warning)
				create evcsts
				qd.button (interface_names.b_yes).select_actions.extend (agent save_and_quit)
				qd.button (interface_names.b_no).select_actions.extend (agent quit)
				qd.show_modal_to_window (last_focused_development_window.window)
			else
				quit
			end

		end

	kill_process_and_confirm_quit is
			-- Kill running c compilation and external command, if any and then quit.
		do
			process_manager.terminate_process
			quit
		end

	save_and_quit is
			-- Save all windows and destroy the last development window.
		do
			save_all
			if has_modified_windows then
					-- Some windows couldn't be saved, do not exit.
			else
				quit
			end
		end

	quit is
			-- Destroy the last development window.
		do
			if process_manager.is_process_running then
				process_manager.confirm_process_termination_for_quiting (agent kill_process_and_confirm_quit, Void, last_focused_development_window.window)
			else
				Exit_application_cmd.ask_confirmation
			end
		end

feature -- Events

	load_favorites is
			-- Try to initialize the favorites with the 'preferences.wb' file.
		local
			fn: FILE_NAME
			pref: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
				create fn.make_from_string (project_location.target_path)
				fn.set_file_name ("preferences.wb")
				create pref.make (fn)
				if pref.exists then
					pref.open_read
					pref.read_stream (pref.count)
					pref.close
					favorites.make_with_string (pref.last_string)
					if favorites.loading_error then
							-- The file is corrupted, delete it.
						pref.delete
					end
				end
			else
				-- Do nothing. Something is wrong (maybe we dont have rights on the favorites file...)
			end
		rescue
			retried := True
			retry
		end

	save_favorites is
			-- Try to save the favorites' state within the 'preferences.wb' file.
		local
			fn: FILE_NAME
			pref: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
				create fn.make_from_string (project_location.target_path)
				fn.set_file_name ("preferences.wb")
				create pref.make (fn)
				if pref.exists then
					pref.open_write
					pref.put_string (favorites.string_representation)
					pref.close
				else
					pref.create_read_write
					pref.put_string (favorites.string_representation)
					pref.close
				end
			end
		rescue
			retried := True
			retry
		end

	load_session is
			-- Try to recreate previous project session, if any.
		local
			i, window_count: INTEGER
			l_raw_file: RAW_FILE
			l_reader: SED_MEDIUM_READER_WRITER
			l_sed_facilities: SED_STORABLE_FACILITIES
			fn: FILE_NAME
			l_session: ES_SESSION
			retried: BOOLEAN
			l_managed_windows: like managed_windows
			l_dl_window: EB_DYNAMIC_LIB_WINDOW
			l_dev_window: EB_DEVELOPMENT_WINDOW
		do
			if not retried then
					-- Attempt to load the 'session.wb' file from the project directory.
					-- If load fails then do nothing.
				create fn.make_from_string (project_location.target_path)
				fn.set_file_name ("session.wb")
				create l_raw_file.make (fn)
				if l_raw_file.exists then
					l_raw_file.open_read
					create l_reader.make (l_raw_file)
					l_reader.set_for_reading
					create l_sed_facilities
					l_session ?= l_sed_facilities.retrieved (l_reader, True)
					l_raw_file.close

						-- Recreate previous session from retrieved session data.
					if l_session /= Void then
							-- Remove any existing managed windows.

						from
							l_managed_windows := managed_windows.twin
							l_managed_windows.start
						until
							l_managed_windows.after
						loop
							if l_managed_windows.item /= Void then
								l_dl_window ?= l_managed_windows
								if l_dl_window /= Void then
									destroy_window (l_dl_window)
								end
							end
							l_managed_windows.forth
						end

						from
							l_managed_windows := managed_windows.twin
							if l_managed_windows.valid_cursor_index (l_session.window_session_data.count + 1) then
								l_managed_windows.go_i_th (l_session.window_session_data.count + 1)
							else
								l_managed_windows.go_i_th (l_managed_windows.index + 1)
							end
							-- Only destroy extra windows
						until
							l_managed_windows.after
						loop
							destroy_window (l_managed_windows.item)
							l_managed_windows.forth
						end

						from
							window_count := l_session.window_session_data.count
							i := 1
							l_managed_windows.start
						until
							i > window_count
						loop
							if not l_managed_windows.after then
								l_dev_window ?= l_managed_windows.item
								check l_dev_window /= Void end
								create_window_from_session_data (l_dev_window, l_session.window_session_data.i_th (i))
								l_managed_windows.forth
							else
								create_window_from_session_data (Void, l_session.window_session_data.i_th (i))
							end

							i := i + 1
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

	save_session is
			-- Try to store current session data.
		local
			l_raw_file: RAW_FILE
			l_writer: SED_MEDIUM_READER_WRITER
			l_sed_facilities: SED_STORABLE_FACILITIES
			fn: FILE_NAME
			l_session: ES_SESSION
			retried: BOOLEAN
		do
			if not retried then
					-- Attempt to save the 'session.wb' file to the current project directory.
					-- If save cannot be made then do nothing.
				create l_session
				for_all_development_windows (agent {EB_DEVELOPMENT_WINDOW}.save_layout_to_session (l_session))
				create fn.make_from_string (project_location.target_path)
				fn.set_file_name ("session.wb")
				create l_raw_file.make_open_write (fn)
				create l_writer.make (l_raw_file)
				l_writer.set_for_writing
				create l_sed_facilities
				l_sed_facilities.independent_store (l_session, l_writer, False)
				l_raw_file.close
			end
		rescue
			retried := True
			retry
		end

	on_compile is
			-- A compilation has been launched.
			-- Update the display accordingly, ie gray out all forbidden commands.
		do
			Melt_project_cmd.disable_sensitive
			Freeze_project_cmd.disable_sensitive
			Finalize_project_cmd.disable_sensitive
			Precompilation_cmd.disable_sensitive
			Project_cancel_cmd.enable_sensitive
			override_scan_cmd.disable_sensitive
			discover_melt_cmd.disable_sensitive
			refactoring_manager.disable_sensitive
			for_all (agent c_compilation_start_action)
			compile_start_actions.call (Void)
		end

	on_refactoring_start is
			-- A refactoring has been started.
		do
			Melt_project_cmd.disable_sensitive
			Freeze_project_cmd.disable_sensitive
			Finalize_project_cmd.disable_sensitive
			Precompilation_cmd.disable_sensitive
			override_scan_cmd.disable_sensitive
			discover_melt_cmd.disable_sensitive
			for_all (agent c_compilation_start_action)
		end

	on_refactoring_end is
			-- A refactoring has finished.
		do
			Melt_project_cmd.enable_sensitive
			Freeze_project_cmd.enable_sensitive
			Finalize_project_cmd.enable_sensitive
			Precompilation_cmd.enable_sensitive
			override_scan_cmd.enable_sensitive
			discover_melt_cmd.enable_sensitive
			for_all (agent c_compilation_stop_action)
		end

	on_c_compilation_start is
			-- Freezing or finalizing has been launched.
			-- Update the display accordingly, ie gray out all forbidden commands.
		do
			Freeze_project_cmd.disable_sensitive
			Finalize_project_cmd.disable_sensitive
			terminate_c_compilation_cmd.enable_sensitive
			for_all (agent c_compilation_start_action)
			run_workbench_cmd.disable_sensitive
			if process_manager.is_finalizing_running then
				run_finalized_cmd.disable_sensitive
			end
		end

	on_c_compilation_stop is
			-- Freezing or finalizing has finished.
			-- Update the display accordingly.
		do
			Freeze_project_cmd.enable_sensitive
			Finalize_project_cmd.enable_sensitive
			terminate_c_compilation_cmd.disable_sensitive
			for_all (agent c_compilation_stop_action)
			run_workbench_cmd.enable_sensitive
			run_finalized_cmd.enable_sensitive
		end

	on_project_created is
			-- A new project has been created. Update the state of some commands.
		do
			Melt_project_cmd.enable_sensitive
			Freeze_project_cmd.enable_sensitive
			Finalize_project_cmd.enable_sensitive
			Precompilation_cmd.enable_sensitive
			System_cmd.enable_sensitive
			override_scan_cmd.enable_sensitive
			discover_melt_cmd.enable_sensitive
			for_all (agent create_project_action)
		end

	on_project_loaded is
			-- A new project has been loaded. Warn all managed windows.
		do
			if Eiffel_project.initialized then
				if Eiffel_project.compilation_modes.is_precompiling then
					Melt_project_cmd.disable_sensitive
					Freeze_project_cmd.disable_sensitive
					Finalize_project_cmd.disable_sensitive
					Precompilation_cmd.enable_sensitive
					Run_project_cmd.disable_sensitive
					Run_workbench_cmd.disable_sensitive
					Run_finalized_cmd.disable_sensitive
					override_scan_cmd.disable_sensitive
					discover_melt_cmd.disable_sensitive
				else
					Melt_project_cmd.enable_sensitive
					Freeze_project_cmd.enable_sensitive
					Finalize_project_cmd.enable_sensitive
					Precompilation_cmd.disable_sensitive
					Run_project_cmd.enable_sensitive
					Run_workbench_cmd.enable_sensitive
					Run_finalized_cmd.enable_sensitive
					override_scan_cmd.enable_sensitive
					discover_melt_cmd.enable_sensitive
				end
				System_cmd.enable_sensitive
				Export_cmd.enable_sensitive
				Document_cmd.enable_sensitive
			else
				Melt_project_cmd.disable_sensitive
				Precompilation_cmd.disable_sensitive
				Freeze_project_cmd.disable_sensitive
				Finalize_project_cmd.disable_sensitive
				System_cmd.disable_sensitive
				Export_cmd.disable_sensitive
				Document_cmd.disable_sensitive
				Run_project_cmd.disable_sensitive
				override_scan_cmd.disable_sensitive
				discover_melt_cmd.disable_sensitive
			end
			load_favorites
				-- Recreate window configuration from last session of project if any.
			load_session
			Manager.on_project_loaded
			for_all (agent load_project_action)
		end

	on_project_unloaded is
			-- Current project has been closed. Warn all managed windows.
		do
			Manager.on_project_unloaded
			save_favorites
				-- Make development window session data persistent for future reloading.
			save_session
			for_all (agent unload_project_action)
			Melt_project_cmd.disable_sensitive
			Freeze_project_cmd.disable_sensitive
			Finalize_project_cmd.disable_sensitive
			Precompilation_cmd.disable_sensitive
			System_cmd.disable_sensitive
			Export_cmd.disable_sensitive
			Document_cmd.disable_sensitive
			Run_project_cmd.disable_sensitive
			Run_workbench_cmd.disable_sensitive
			Run_finalized_cmd.disable_sensitive
			override_scan_cmd.disable_sensitive
			discover_melt_cmd.disable_sensitive
		end

feature {NONE} -- Implementation

	exiting_application: BOOLEAN
			-- Is the application currently in its closing phase?
			--| Used in `destroy_window' to avoid infinite reentrance.

	focused_windows: ARRAYED_LIST [EB_WINDOW]
			-- Focused windows (chronological order).

	close_action (a_window: EB_WINDOW)  is
			-- Action to be performed on `item' in `close_all'.
		do
			destroy_window (a_window)
			notify_observers (a_window, Notify_removed_window)
		end

	minimize_action (a_window: EB_WINDOW) is
			-- Action to be performed on `item' in `minimize_all'.
		do
			a_window.window.minimize
		end

	disable_action (a_window: EB_WINDOW) is
			-- Action to be performed on `item' in `disable_all'.
		do
			a_window.window.disable_sensitive
		end

	enable_action (a_window: EB_WINDOW) is
			-- Action to be performed on `item' in `enable_all'.
		do
			a_window.window.enable_sensitive
		end

	refresh_action (a_window: EB_WINDOW)  is
			-- Action to be performed on `item' in `refresh'.
		do
			a_window.refresh
			notify_observers (a_window, Notify_changed_window)
		end

	refresh_commands_action (a_window: EB_WINDOW)  is
			-- Action to be performed on `item' in `refresh_all_commands'.
		do
			a_window.refresh_all_commands
		end

	refresh_external_commands_action (a_window: EB_WINDOW)  is
			-- Action to be performed on `item' in `refresh_external_commands'.
		do
			a_window.refresh_external_commands
		end

	synchronize_breakpoints_action (a_window: EB_WINDOW) is
			-- Action to synchronize `a_window' regarding the breakpoints data.
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			conv_dev ?= a_window
			if conv_dev /= Void then
				conv_dev.tools.breakpoints_tool.synchronize
			end
		end

	synchronize_action (a_window: EB_WINDOW)  is
			-- Action to be performed on `item' in `refresh'.
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
			conv_dyn: EB_DYNAMIC_LIB_WINDOW
		do
			conv_dev ?= a_window
			if conv_dev /= Void then
				conv_dev.synchronize
			else
				conv_dyn ?= a_window
				if conv_dyn /= Void then
					conv_dyn.synchronize
				else
					a_window.refresh
				end
			end
			notify_observers (a_window, Notify_changed_window)
		end

	backup_action (a_window: EB_WINDOW) is
			-- Create a backup file of the text contained in `a_window'.
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			conv_dev ?= a_window
			if conv_dev /= Void then
				conv_dev.editors_manager.backup_all
				not_backuped := not_backuped + conv_dev.editors_manager.not_backuped
			end
		end

	quick_refresh_action (a_window: EB_WINDOW)  is
			-- Action to be performed on `a_window' in `quich_refresh_all_editors'.
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			conv_dev ?= a_window
			if conv_dev /= Void then
				conv_dev.quick_refresh_editors
			end
		end

	quick_refresh_margin_action (a_window: EB_WINDOW)  is
			-- Action to be performed on `a_window' in `quick_refresh_all_margins'.
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			conv_dev ?= a_window
			if conv_dev /= Void then
				conv_dev.quick_refresh_margins
			end
		end

	raise_unsaved_action (a_window: EB_WINDOW) is
			-- Action to be performed on `item' in `raise_non_saved'.
		local
			a_dev: EB_DEVELOPMENT_WINDOW
		do
			a_dev ?= a_window
			if a_dev /= Void and then a_dev.changed then
				a_window.show
			end
		end

	save_action (a_window: EB_WINDOW) is
			-- Action to be performed on `item' in `save_all'.
		local
			l_dev_window: EB_DEVELOPMENT_WINDOW
			conv_dll: EB_DYNAMIC_LIB_WINDOW
		do
			l_dev_window ?= a_window
			if l_dev_window /= Void and then l_dev_window.any_editor_changed then
				l_dev_window.save_all
			end
			conv_dll ?= a_window
			if conv_dll /= Void and then conv_dll.changed then
				conv_dll.save
			end
		end

	save_before_compiling_action (a_window: EB_WINDOW) is
			-- Action to be performed on `item' in `save_all_before_compiling'.
		local
			a_dev_window: EB_DEVELOPMENT_WINDOW
		do
			a_dev_window ?= a_window
			if a_dev_window /= Void and then
			   	a_dev_window.editors_manager.changed
			then
				a_dev_window.save_before_compiling
			end
		end

	create_project_action (a_window: EB_WINDOW) is
			-- Action to be performed on `a_window' in `create_project'.
		local
			a_dev_window: EB_DEVELOPMENT_WINDOW
		do
			a_dev_window ?= a_window
			if a_dev_window /= Void then
				a_dev_window.agents.on_project_created
			end
		end

	load_project_action (a_window: EB_WINDOW) is
			-- Action to be performed on `a_window' in `load_project'.
		local
			a_dev_window: EB_DEVELOPMENT_WINDOW
		do
			a_dev_window ?= a_window
			if a_dev_window /= Void then
				a_dev_window.agents.on_project_loaded
			end
		end

	unload_project_action (a_window: EB_WINDOW) is
			-- Action to be performed on `a_window' in `unload_project'.
		local
			a_dev_window: EB_DEVELOPMENT_WINDOW
		do
			a_dev_window ?= a_window
			if a_dev_window /= Void then
				a_dev_window.agents.on_project_unloaded
			end
		end

	c_compilation_start_action (a_window: EB_WINDOW) is
			-- Action to be performed on `a_window' when freezing or finalizing starts.
		local
			a_dev_window: EB_DEVELOPMENT_WINDOW
		do
			a_dev_window ?= a_window
			if a_dev_window /= Void then
				a_dev_window.agents.on_c_compilation_starts
			end
		end

	c_compilation_stop_action (a_window: EB_WINDOW) is
			-- Action to be performed on `a_window' when freezing or finalizing stops.
		local
			a_dev_window: EB_DEVELOPMENT_WINDOW
		do
			a_dev_window ?= a_window
			if a_dev_window /= Void then
				a_dev_window.agents.on_c_compilation_stops
			end
		end

	for_all (action: PROCEDURE [ANY, TUPLE]) is
			-- Iterate `action' on every managed window.
		local
			l_index: INTEGER
		do
			l_index := managed_windows.index
			from
				managed_windows.start
			until
				managed_windows.after
			loop
				action.call ([managed_windows.item])
				managed_windows.forth
			end
			if managed_windows.valid_index (l_index) then
				managed_windows.go_i_th (l_index)
			end
		end

feature {EB_WINDOW_MANAGER_OBSERVER, EB_WINDOW, EB_DEVELOPMENT_WINDOW_BUILDER} -- Observer pattern

	add_observer (an_observer: EB_WINDOW_MANAGER_OBSERVER) is
			-- Add `an_observer' to the list of observers for Current.
		require
			valid_observer: an_observer /= Void
		do
			if observers = Void then
				create observers.make (2)
			end
			observers.extend (an_observer)
		end

	remove_observer (an_observer: EB_WINDOW_MANAGER_OBSERVER) is
			-- Remove `an_observer' from the list of observers for Current.
		require
			valid_observer: an_observer /= Void
		do
			if observers /= Void then
				observers.start
				observers.prune_all (an_observer)
			end
		end

	minimize_all_cmd: EB_STANDARD_CMD
			-- Command to minimize all windows.

	raise_all_cmd: EB_STANDARD_CMD
			-- Command to raise all windows.

	raise_all_unsaved_cmd: EB_STANDARD_CMD
			-- Command to raise all unsaved windows.

feature {EB_WINDOW} -- Implementation / Observer pattern

	notify_observers (an_item: EB_WINDOW; item_change: INTEGER) is
			-- Notify all observers about the change of `an_item'.
		require
		--	valid_item_change:
		--		item_change = Notify_removed_window or
		--		item_change = Notify_added_window or
		--		item_change = Notify_changed_window
			valid_item: an_item /= Void
		do
			if observers /= Void then
				from
					observers.start
				until
					observers.after
				loop
					inspect item_change
					when Notify_added_window then
						observers.item.on_item_added (an_item)
					when Notify_changed_window then
						observers.item.on_item_changed (an_item)
					when Notify_removed_window then
						observers.item.on_item_removed (an_item)
					when Notify_shown_window then
						observers.item.on_item_shown (an_item)
					when Notify_hidden_window then
						observers.item.on_item_hidden (an_item)
					end
					observers.forth
				end
			end
		end

	observers: ARRAYED_LIST [EB_WINDOW_MANAGER_OBSERVER]
			-- All observers for Current.

feature {EB_C_COMPILER_LAUNCHER, EB_WINDOW_MANAGER_LIST, EB_WINDOW_MANAGER_MENU, EB_EXEC_FORMAT_CMD, EB_EXTERNAL_COMMANDS_EDITOR} -- Implementation

	managed_windows: ARRAYED_SET [EB_WINDOW]
			-- Managed windows.

feature {EB_DEVELOPMENT_WINDOW} -- Implementation

	new_title: STRING_GENERAL is
			-- Find an empty titled not yet used.
		local
			l_index: INTEGER
			empty_title: STRING_GENERAL
			window_titles: ARRAYED_LIST [STRING_GENERAL]
			i: INTEGER
			l_found: BOOLEAN
			l_str: STRING_GENERAL
		do
				-- Remember the title of all windows.
			create window_titles.make (managed_windows.count)
			window_titles.compare_objects

			l_index :=	managed_windows.index
			from
				managed_windows.start
			until
				managed_windows.after
			loop
				window_titles.extend (managed_windows.item.title)
				managed_windows.forth
			end
			managed_windows.go_i_th (l_index)

				-- Look for a title not yet used.
			empty_title := Interface_names.t_Empty_development_window.twin
			empty_title.append (" #")
			from
				i := 1
			until
				l_found
			loop
				l_str := empty_title.twin
				l_str.append (i.out)
				if not window_titles.has (l_str) then
					l_found := True
				end
				i := i + 1
			end
			Result := l_str
		end

	stop_ev_application is
			-- Stop `application' by killing main event loop of EiffelVision2.
		require
			no_more_development_windows: development_windows_count = 0
		do
			ev_application.destroy
		end

	store_last_focused_window is
			-- Store layout of last focused window so new windows may be initialized
			-- to match.
		local
			a_window: EB_DEVELOPMENT_WINDOW
		do
			a_window := last_focused_development_window
			if a_window /= Void then
				a_window.save_layout
			end
		end

feature {EB_WINDOW} -- Implementation / Private Constants

	Notify_hidden_window: INTEGER is -2
		-- Notification constant for `notify_observers'.

	Notify_removed_window: INTEGER is -1
		-- Notification constant for `notify_observers'.

	Notify_added_window: INTEGER is 1
		-- Notification constant for `notify_observers'.

	Notify_shown_window: INTEGER is 2
		-- Notification constant for `notify_observers'.

	Notify_changed_window: INTEGER is 0
		-- Notification constant for `notify_observers'.

feature{NONE} -- Implementation

	state_message_waiting_count: INTEGER
			-- Times that we have been waiting for displaying a c compilation message.

	max_waiting_count: INTEGER is 30;
			-- Max value of `state_message_waiting_count'

	compile_start_actions_internal: like compile_start_actions;
			-- Implementation of `compile_start_actions'

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

end -- EB_WINDOW_MANAGER
