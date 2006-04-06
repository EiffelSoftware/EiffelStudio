indexing
	description	: "Window holding a project tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "$Author$"

class
	EB_DEVELOPMENT_WINDOW

inherit
	EB_TOOL_MANAGER
		redefine
			make,
			init_size_and_position,
			window_displayed,
			init_commands,
			build_menu_bar,
			build_menus,
			build_file_menu,
			build_edit_menu,
			build_view_menu,
			build_tools_menu,
			build_favorites_menu,
			refresh,
			recycle,
			destroy_imp,
			destroy,
			position,
			pos_container
		end

	EB_FILEABLE
		export {NONE}
			set_position,
			set_pos_container
		redefine
			set_stone,
			reset,
			stone,
			on_text_saved,
			perform_check_before_save,
			check_passed,
			update_save_symbol,
			position,
			pos_container
		select
			set_stone
		end

	EB_FILEABLE
		rename
			set_stone as old_set_stone
		export {NONE}
			old_set_stone,
			set_position,
			set_pos_container
		redefine
			reset,
			stone,
			on_text_saved,
			perform_check_before_save,
			check_passed,
			update_save_symbol,
			position,
			pos_container
		end


		-- Shared tools & contexts

	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

	EB_SHARED_MANAGERS

	EB_SHARED_GRAPHICAL_COMMANDS

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EV_STOCK_PIXMAPS

	EB_CONFIRM_SAVE_CALLBACK

		-- Errors
	EB_GRAPHICAL_ERROR_MANAGER

	TEXT_OBSERVER
		redefine
			on_text_reset, on_text_edited,
			on_text_back_to_its_last_saved_state,
			on_text_fully_loaded, on_cursor_moved
		end

	EV_KEY_CONSTANTS
		export
			{NONE} All
		end

	EIFFEL_ENV
		export
			{NONE} All
		end

	SHARED_TEXT_ITEMS
		export
			{NONE} All
		end

create {EB_WINDOW_MANAGER}
	make,
	make_with_session_data,
	make_as_context_tool,
	make_as_editor

feature {NONE} -- Initialization

	make_as_context_tool is
			-- Create a new development window and expand the context tool.
		do
			make
				-- Perform window setting from `show_actions', as the
				-- resizing executed as a result only works correctly
				-- while the window is displayed.
			window.show_actions.extend (agent set_context_mode)
		end

	set_context_mode is
			-- Set `current' into context mode, that is the context tool
			-- maximized, and the non editor panel is hidden.
		do
			if not context_tool.shown then
				context_tool.show
			end
			if not unified_stone then
				toggle_stone_cmd.execute
			end
			context_tool.explorer_bar_item.maximize
			close_all_bars_except (right_panel)
		end

	make_as_editor is
			-- Create a new development window and expand the editor tool.
		do
			make
				-- Perform window setting from `show_actions', as the resizing executed
				-- must be performed after `current' is displayed.
			window.show_actions.extend (agent (editor_tool.explorer_bar_item).maximize)
			window.show_actions.extend (agent close_all_bars_except (right_panel))
		end

	make_with_session_data (a_session_data: EB_DEVELOPMENT_WINDOW_SESSION_DATA) is
			-- Recreate a previously existing development window using `a_session_data'.
		local
			l_class_i: CLASS_I
			l_class_c_stone: CLASSC_STONE
			l_cluster_string, l_class_string, l_feature_string: STRING
		do
			internal_development_window_data := a_session_data
			make
				-- Attempt to reload last edited class of `Current'.
			if a_session_data.file_name /= Void then
				conf_todo
--				l_class_i := eiffel_universe.class_with_file_name (a_session_data.file_name)
				if l_class_i /= Void and then l_class_i.compiled then
						-- Create compiled class stone and target `Current' to it.
					create l_class_c_stone.make (l_class_i.compiled_class)
					set_stone_after_check (l_class_c_stone)
					if a_session_data.editor_position > 0 then
						editor_tool.text_area.display_line_when_ready (a_session_data.editor_position, False)
					end
				end
			end
			if context_tool /= Void then
					-- Presumption is made that if the strings are not void then they represent
					-- valid entities in the project.
				l_cluster_string := a_session_data.context_cluster_string
				l_class_string := a_session_data.context_class_string
				l_feature_string := a_session_data.context_feature_string
				if l_feature_string /= Void then
					context_tool.address_manager.feature_address.set_text (l_feature_string)
					context_tool.address_manager.class_address.set_text (l_class_string)
					context_tool.address_manager.execute_with_feature
				elseif l_class_string /= Void then
					context_tool.address_manager.class_address.set_text (l_class_string)
					context_tool.address_manager.execute_with_class
				elseif l_cluster_string /= Void then
					context_tool.address_manager.cluster_address.set_text (l_cluster_string)
					context_tool.address_manager.execute_with_cluster
				end
					-- Set the appropriate notebook tab
				context_tool.notebook.select_item (context_tool.notebook.i_th (a_session_data.context_tab_index))
			end
		end

	make is
			-- Create a new development window.
		do
			unified_stone := preferences.development_window_data.context_unified_stone
				-- Build the history manager, the address manager, ...
			create history_manager.make (Current)
			create address_manager.make (Current, False)
			build_formatters
			address_manager.set_formatters (managed_main_formatters)

				-- Init commands, build interface, build menus, ...
			Precursor

			initialized := False -- Reset the flag since initialization is not yet complete.
			set_up_accelerators

			window.focus_in_actions.extend(agent on_focus)

				-- Create the toolbars.
			build_toolbars_area
			container.put_front (toolbars_area)
			container.disable_item_expand (toolbars_area)

				-- Update widgets visibilities
			window.show_actions.extend (agent update)
			status_bar.remove_cursor_position
			address_manager.set_output_line (status_bar.label)

				-- Finish initializing the main editor formatters
			end_build_formatters

			address_manager.disable_formatters
			if Eiffel_project.manager.is_project_loaded then
				on_project_created
				on_project_loaded
			elseif Eiffel_project.manager.is_created then
				on_project_unloaded
				on_project_created
			else
				on_project_unloaded
			end

				-- Create feature position table
			create feature_positions.make (1)
			feature_positions.compare_objects

			window.move_actions.force_extend (agent window_moved)

			initialized := True
			is_destroying := False
		end

	init_size_and_position is
			-- Initialize window size.
		local
			screen: EB_STUDIO_SCREEN
			l_x, l_y: INTEGER
		do
			create screen
			window.set_size (
				development_window_data.width.min (screen.width),
				development_window_data.height.min (screen.height))
			l_x := development_window_data.x_position
			if l_x < screen.virtual_left or l_x > screen.virtual_right then
					-- Somehow screens have changed, reset it to 0
				l_x := 0
			end
			l_y := development_window_data.y_position
			if l_y < screen.virtual_top or l_y > screen.virtual_bottom then
					-- Somehow screens have changed, reset it to 0
				l_y := 0
			end
			window.set_position (l_x, l_y)
		end

	window_displayed is
			-- `Current' has been displayed on screen.
		do
				-- Minimize or Maximize window if needed.
			if development_window_data.is_maximized then
				window.maximize
			elseif development_window_data.is_minimized then
				window.minimize
			end
		end

	init_commands is
			-- Initialize commands.
		local
			accel: EV_ACCELERATOR
		do
			Precursor
			create toolbarable_commands.make (15)

				-- Open, save, ...
			toolbarable_commands.extend (new_editor_cmd)

			toolbarable_commands.extend (new_context_tool_cmd)

			create open_cmd.make (Current)
			toolbarable_commands.extend (open_cmd)

			create save_cmd.make (Current)
			toolbarable_commands.extend (save_cmd)

			create save_as_cmd.make (Current)
			if editor_tool = Void or else editor_tool.text_area.is_empty then
				save_as_cmd.disable_sensitive
			else
				save_as_cmd.enable_sensitive
			end

			create shell_cmd.make (Current)
			toolbarable_commands.extend (shell_cmd)

			create print_cmd.make (Current)
			if is_empty then
				print_cmd.disable_sensitive
			else
				print_cmd.enable_sensitive
			end
			toolbarable_commands.extend (print_cmd)

				-- Compilation
			create c_workbench_compilation_cmd.make_workbench (Current)
			create c_finalized_compilation_cmd.make_finalized (Current)
			if has_dll_generation then
				create show_dynamic_lib_tool.make
				show_dynamic_lib_tool.set_menu_name (Interface_names.m_new_dynamic_lib)
				show_dynamic_lib_tool.add_agent (agent show_dynamic_library_dialog)
			end
			if has_profiler then
				create show_profiler
			end

				-- Undo/redo, cut, copy, paste.
			create undo_cmd.make (Current)
			toolbarable_commands.extend (undo_cmd)

			create redo_cmd.make (Current)
			toolbarable_commands.extend (redo_cmd)

			create editor_paste_cmd.make (Current)
			toolbarable_commands.extend (editor_paste_cmd)

			create new_cluster_cmd.make (Current)
			toolbarable_commands.extend (new_cluster_cmd)

			create new_class_cmd.make (Current)
			toolbarable_commands.extend (new_class_cmd)

			create delete_class_cluster_cmd.make (Current)
			toolbarable_commands.extend (delete_class_cluster_cmd)

			create new_feature_cmd.make (Current)
			toolbarable_commands.extend (new_feature_cmd)

			create toggle_feature_alias_cmd.make (Current)
			toolbarable_commands.extend (toggle_feature_alias_cmd)

			create toggle_feature_signature_cmd.make (Current)
			toolbarable_commands.extend (toggle_feature_signature_cmd)

			create toggle_feature_assigner_cmd.make (Current)
			toolbarable_commands.extend (toggle_feature_assigner_cmd)

			create toggle_stone_cmd.make (Current)
			toolbarable_commands.extend (toggle_stone_cmd)

			create send_stone_to_context_cmd.make
			send_stone_to_context_cmd.set_pixmap (Pixmaps.Icon_send_stone_down)
			send_stone_to_context_cmd.set_tooltip (Interface_names.e_send_stone_to_context)
			send_stone_to_context_cmd.set_menu_name (Interface_names.m_send_stone_to_context)
			send_stone_to_context_cmd.set_name ("Send_to_context")
			send_stone_to_context_cmd.set_tooltext (Interface_names.b_send_stone_to_context)
			send_stone_to_context_cmd.add_agent (agent send_stone_to_context)
			create accel.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_down), False, True, False
			)
			accel.actions.extend (agent send_stone_to_context)
			send_stone_to_context_cmd.set_accelerator (accel)
			send_stone_to_context_cmd.disable_sensitive
			toolbarable_commands.extend (send_stone_to_context_cmd)

			toolbarable_commands.extend (window_manager.minimize_all_cmd)
			window_manager.minimize_all_cmd.enable_sensitive
			toolbarable_commands.extend (window_manager.raise_all_cmd)
			window_manager.raise_all_cmd.enable_sensitive

			toolbarable_commands.extend (New_development_window_cmd)
				-- Show tool/toolbar commands (will be filled when tools will
				-- be created)
			create show_tool_commands.make (7)
			create show_toolbar_commands.make (3)

			new_feature_cmd.disable_sensitive
			toggle_feature_alias_cmd.disable_sensitive
			toggle_feature_signature_cmd.disable_sensitive
			toggle_feature_assigner_cmd.disable_sensitive

			create editors.make (5)
			estudio_debug_cmd.set_main_window (window)
		end

	set_up_accelerators is
			-- Fill the accelerator of `window' with the accelerators of the `toolbarable_commands'.
		local
			cmds: ARRAYED_LIST [EB_TOOLBARABLE_COMMAND]
		do
				--| Accelerators related to toolbarable_commands
			from
				cmds := toolbarable_commands
				cmds.start
			until
				cmds.after
			loop
				if cmds.item.accelerator /= Void then
					window.accelerators.extend (cmds.item.accelerator)
				end
				cmds.forth
			end

				--| Accelerators related to debugging toolbarable_commands
			from
				cmds := Eb_debugger_manager.toolbarable_commands
				cmds.start
			until
				cmds.after
			loop
				if
					cmds.item.accelerator /= Void
				then
					window.accelerators.extend (cmds.item.accelerator)
				end
				cmds.forth
			end
		end

	build_formatters is
			-- Build all formatters used.
		local
			form: EB_CLASS_TEXT_FORMATTER
			accel: EV_ACCELERATOR
		do
			create managed_class_formatters.make (17)
			managed_class_formatters.extend (create {EB_CLICKABLE_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_FLAT_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_SHORT_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_FLAT_SHORT_FORMATTER}.make (Current))
			managed_class_formatters.extend (Void)
			managed_class_formatters.extend (create {EB_ANCESTORS_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_DESCENDANTS_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_CLIENTS_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_SUPPLIERS_FORMATTER}.make (Current))
			managed_class_formatters.extend (Void)
			managed_class_formatters.extend (create {EB_ATTRIBUTES_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_ROUTINES_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_INVARIANTS_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_CREATORS_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_DEFERREDS_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_ONCES_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_EXTERNALS_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_EXPORTED_FORMATTER}.make (Current))

			create managed_feature_formatters.make (12)
			managed_feature_formatters.extend (create {EB_BASIC_FEATURE_FORMATTER}.make (Current))
			managed_feature_formatters.extend (create {EB_ROUTINE_FLAT_FORMATTER}.make (Current))
			managed_feature_formatters.extend (Void)
			managed_feature_formatters.extend (create {EB_CALLERS_FORMATTER}.make (Current, 0))
			managed_feature_formatters.extend (create {EB_CALLERS_FORMATTER}.make (Current,
				{DEPEND_UNIT}.is_in_assignment_flag))
			managed_feature_formatters.extend (create {EB_CALLERS_FORMATTER}.make (Current,
				{DEPEND_UNIT}.is_in_creation_flag))
			managed_feature_formatters.extend (Void)
			managed_feature_formatters.extend (create {EB_IMPLEMENTERS_FORMATTER}.make (Current))
			managed_feature_formatters.extend (create {EB_ROUTINE_ANCESTORS_FORMATTER}.make (Current))
			managed_feature_formatters.extend (create {EB_ROUTINE_DESCENDANTS_FORMATTER}.make (Current))
			managed_feature_formatters.extend (Void)
			managed_feature_formatters.extend (create {EB_HOMONYMS_FORMATTER}.make (Current))


			create managed_main_formatters.make (6)

			create {EB_BASIC_TEXT_FORMATTER} form.make (Current)
			create accel.make_with_key_combination (
					create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_t),
					True, False, True)
			accel.actions.extend (agent form.execute)
			form.set_accelerator (accel)
			managed_main_formatters.extend (form)

			create {EB_CLICKABLE_FORMATTER} form.make (Current)
			create accel.make_with_key_combination (
					create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_c),
					True, False, True)
			accel.actions.extend (agent form.execute)
			form.set_accelerator (accel)
			managed_main_formatters.extend (form)

			create {EB_FLAT_FORMATTER} form.make (Current)
			create accel.make_with_key_combination (
					create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_f),
					True, False, True)
			accel.actions.extend (agent form.execute)
			form.set_accelerator (accel)
			managed_main_formatters.extend (form)

			create {EB_SHORT_FORMATTER} form.make (Current)
			create accel.make_with_key_combination (
					create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_o),
					True, False, True)
			accel.actions.extend (agent form.execute)
			form.set_accelerator (accel)
			managed_main_formatters.extend (form)

			create {EB_FLAT_SHORT_FORMATTER} form.make (Current)
			create accel.make_with_key_combination (
					create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_i),
					True, False, True)
			accel.actions.extend (agent form.execute)
			form.set_accelerator (accel)
			managed_main_formatters.extend (form)
		end

	end_build_formatters is
			-- Finish initialization of formatters (associate them with editor
			-- and select a formatter).
		local
			f_ind: INTEGER
		do
			from
				managed_class_formatters.start
			until
				managed_class_formatters.after
			loop
				if managed_class_formatters.item /= Void then
					managed_class_formatters.item.set_manager (context_tool)
				end
				managed_class_formatters.forth
			end
			from
				managed_feature_formatters.start
			until
				managed_feature_formatters.after
			loop
				if managed_feature_formatters.item /= Void then
					managed_feature_formatters.item.set_manager (context_tool)
				end
				managed_feature_formatters.forth
			end
			from
				managed_main_formatters.start
			until
				managed_main_formatters.after
			loop
				managed_main_formatters.item.set_editor (editor_tool.text_area)
				managed_main_formatters.item.on_shown
				if managed_main_formatters.item.accelerator /= Void then
					window.accelerators.extend (managed_main_formatters.item.accelerator)
				end
				managed_main_formatters.forth
			end

			(managed_main_formatters @ 1).enable_select;

				-- We now select the correct class formatter.
			f_ind := preferences.context_tool_data.default_class_formatter_index
				--| This takes the formatter separators in consideration.
			if f_ind > 4 then
				f_ind := f_ind + 1
			end
			if f_ind > 8 then
				f_ind := f_ind + 1
			end
			if f_ind < 1 or f_ind > managed_class_formatters.count then
				f_ind := 6
			end
			(managed_class_formatters @ f_ind).enable_select;
				-- We now select the correct feature formatter.
			f_ind := preferences.context_tool_data.default_feature_formatter_index
			if f_ind > 2 then
				f_ind := f_ind + 1
			end
			if f_ind < 1 or f_ind > managed_feature_formatters.count then
				f_ind := 2
			end
			managed_class_formatters.i_th (f_ind).enable_select
		end

	build_tools is
			-- Build all tools that can take place in this window and put them
			-- in `left_tools' or `bottom_tools'.
		local
			show_cmd: EB_SHOW_TOOL_COMMAND
			l_accel: EV_ACCELERATOR
			l_shortcut_preference: SHORTCUT_PREFERENCE
		do
			lock_update
				-- Build the features tool
			create features_tool.make (Current)
			features_tool.attach_to_explorer_bar (left_panel)
			left_tools.extend (features_tool.explorer_bar_item)
			create show_cmd.make (Current, features_tool.explorer_bar_item)
			show_tool_commands.extend (show_cmd)
			toolbarable_commands.extend (show_cmd)
			add_recyclable (features_tool)

				-- Build the breakpoints tool
			create breakpoints_tool.make (Current)
			breakpoints_tool.attach_to_explorer_bar (left_panel)
			left_tools.extend (breakpoints_tool.explorer_bar_item)
			create show_cmd.make (Current, breakpoints_tool.explorer_bar_item)
			show_tool_commands.extend (show_cmd)
			toolbarable_commands.extend (show_cmd)
			add_recyclable (breakpoints_tool)

				-- Build the cluster tool
			create cluster_tool.make (Current, Current)
			cluster_tool.attach_to_explorer_bar (left_panel)
			left_tools.extend (cluster_tool.explorer_bar_item)
			create show_cmd.make (Current, cluster_tool.explorer_bar_item)
			show_tool_commands.extend (show_cmd)
			toolbarable_commands.extend (show_cmd)
			add_recyclable (cluster_tool)

				-- Build the favorites tool
			create favorites_tool.make (Current, favorites_manager)
			favorites_tool.attach_to_explorer_bar (left_panel)
			left_tools.extend (favorites_tool.explorer_bar_item)
			create show_cmd.make (Current, favorites_tool.explorer_bar_item)
			show_tool_commands.extend (show_cmd)
			toolbarable_commands.extend (show_cmd)
			add_recyclable (favorites_tool)

				-- Build the windows tool (formerly known as Selector tool)
			create windows_tool.make (Current)
			windows_tool.attach_to_explorer_bar (left_panel)
			left_tools.extend (windows_tool.explorer_bar_item)
			create show_cmd.make (Current, windows_tool.explorer_bar_item)
			show_tool_commands.extend (show_cmd)
			toolbarable_commands.extend (show_cmd)
			add_recyclable (windows_tool)

				-- Build the search tool
			create search_tool.make (Current)
			search_tool.attach_to_explorer_bar (right_panel)
			bottom_tools.extend (search_tool.explorer_bar_item)
			create show_cmd.make (Current, search_tool.explorer_bar_item)
			l_shortcut_preference := preferences.editor_data.shortcuts.item ("show_search_panel")
			create l_accel.make_with_key_combination (l_shortcut_preference.key, l_shortcut_preference.is_ctrl, l_shortcut_preference.is_alt, l_shortcut_preference.is_shift)
			l_accel.actions.extend (agent search_tool.prepare_search)
			show_cmd.set_accelerator (l_accel)
			show_tool_commands.extend (show_cmd)
			toolbarable_commands.extend (show_cmd)
			add_recyclable (search_tool)

				-- Build the editor tool
			create editor_tool.make (Current)
			editor_tool.attach_to_explorer_bar (right_panel)
			bottom_tools.extend (editor_tool.explorer_bar_item)
			editor_tool.text_area.add_edition_observer(save_cmd)
			editor_tool.text_area.add_edition_observer(save_as_cmd)
			editor_tool.text_area.add_edition_observer(print_cmd)
			editor_tool.text_area.add_edition_observer(Current)
			editor_tool.text_area.add_edition_observer(search_tool)
			editor_tool.text_area.drop_actions.set_veto_pebble_function (agent can_drop)
			editor_tool.text_area.add_cursor_observer (Current)
			create show_cmd.make(Current, editor_tool.explorer_bar_item)
			show_tool_commands.extend (show_cmd)
			toolbarable_commands.extend (show_cmd)

				-- The minimim height masks a bug on windows to do with the sizing of the editors
				-- scroll bars, which were affecting the resizing although they should not have done so.
				-- Having a default minimum height on the editor is perfectly reasonable.
			editor_tool.widget.set_minimum_height (20)
			add_recyclable (editor_tool)

				-- Build the context tool
			create context_tool.make (Current)
			context_tool.attach_to_explorer_bar (right_panel)
			bottom_tools.extend (context_tool.explorer_bar_item)
			create show_cmd.make (Current, context_tool.explorer_bar_item)
			show_tool_commands.extend (show_cmd)
			toolbarable_commands.extend (show_cmd)
			add_recyclable (context_tool)

				-- Build the refactoring tools
			toolbarable_commands.extend (refactoring_manager.pull_command)
			toolbarable_commands.extend (refactoring_manager.rename_command)
			toolbarable_commands.extend (refactoring_manager.undo_command)
			toolbarable_commands.extend (refactoring_manager.redo_command)

				-- Set the flag "Tools initialized"
			tools_initialized := True

				-- Initialize undo / redo accelerators
			create undo_accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (Key_z), True, False, False)
			if has_case then
				undo_accelerator.actions.extend (agent (context_tool.editor.undo_cmd).on_ctrl_z)
			end
			undo_accelerator.actions.extend (agent undo_cmd.accelerator_execute)
			create redo_accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (Key_y), True, False, False)
			if has_case then
				redo_accelerator.actions.extend (agent (context_tool.editor.redo_cmd).on_ctrl_y)
			end
			redo_accelerator.actions.extend (agent redo_cmd.accelerator_execute)
			window.accelerators.extend (undo_accelerator)
			window.accelerators.extend (redo_accelerator)
			unlock_update
		end

feature -- Access

	cluster: CLUSTER_I is
			-- Cluster for current class. Void if none.
		do
			conf_todo_msg ("Update callers to use `group' instead.")
			Result ?= group
		end

	group: CONF_GROUP is
			-- Group of current class. Void if none.
		local
			classi_stone: CLASSI_STONE
			cluster_stone: CLUSTER_STONE
		do
			classi_stone ?= stone
			if classi_stone /= Void then
				Result := classi_stone.group
			end
			cluster_stone ?= stone
			if cluster_stone /= Void then
				Result := cluster_stone.group
			end
		end

	class_name: STRING is
			-- Name of the current class, Void if none.
		local
			class_stone: CLASSI_STONE
		do
			class_stone ?= stone
			if class_stone /= Void then
				Result := class_stone.class_name
			end
		end

	feature_name: STRING is
			-- Name of the current feature, Void if none.
		local
			feature_stone: FEATURE_STONE
		do
			feature_stone ?= stone
			if feature_stone /= Void then
				Result := feature_stone.feature_name
			end
		end

feature -- Status setting

	disable_sensitive is
			-- Disable sensitivity of all widgets.
		do
			window.disable_sensitive
		end

	enable_sensitive is
			-- Enable sensitivity of all widgets.
		do
			window.enable_sensitive
		end

feature -- Window Settings

	set_initialized is
			-- Set `initialized' to True.
		do
			initialized := True
		end

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			a_text_not_void: a_text /= Void
		do
			editor_tool.text_area.set_editor_text (a_text)
		ensure
			--| FIXME This needs to work: text_assigned: text.is_equal (a_text)
			--| FIXME changed_flag_set: changed
		end

feature -- Window Properties

	changed: BOOLEAN is
			-- Has something been changed and not yet been saved?
		do
			Result := editor_tool.changed
		end

	is_empty: BOOLEAN is
			-- Does `Current's text is empty?
		do
			Result := editor_tool = Void or else editor_tool.text_area.is_empty
		end

	text: STRING is
			-- Text representing Current
		do
			Result := editor_tool.text_area.text
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing Current window.
		do
			Result := Pixmaps.Icon_development_window
		end

feature -- Pulldown Menus

	metric_menu: EV_MENU
			-- Menu for entries of metric tool.

	format_menu: EV_MENU
			-- ID Menu for formats.
			-- Only used during debugging

	compile_menu: EV_MENU
			-- Compile ID menu.

	debug_menu: EV_MENU
			-- Debug ID menu.

	debugging_tools_menu: EV_MENU
			-- Debugging tools menu item

	active_menus (erase: BOOLEAN) is
			-- Enable all the menus and if `erase' clean
			-- the content of the Project tool.
		do
			compile_menu.enable_sensitive
			if erase then
				output_manager.clear
			end
		end

	disable_menus is
			-- Disable all the menus.
		do
			compile_menu.disable_sensitive
		end

	update_debug_menu is
			-- Update debug menu
		do
			Eb_debugger_manager.update_debugging_tools_menu_from (Current)
		end

feature -- Modifiable menus

	melt_menu_item: EV_MENU_ITEM
			-- Melt menu entry

	freeze_menu_item: EV_MENU_ITEM
			-- Freeze menu entry

	finalize_menu_item: EV_MENU_ITEM
			-- Finalize menu entry

feature -- Update

	synchronize is
			-- Synchronize stones.
		local
			st: STONE
			l_text_area: EB_SMART_EDITOR
		do
			during_synchronization := True
			favorites_manager.refresh
			context_tool.synchronize
			cluster_tool.synchronize
			history_manager.synchronize
			features_tool.synchronize
			breakpoints_tool.synchronize
				-- Update main views
			managed_main_formatters.i_th (2).invalidate
			managed_main_formatters.i_th (3).invalidate
			managed_main_formatters.i_th (4).invalidate
			managed_main_formatters.i_th (5).invalidate
			if stone /= Void then
				st := stone.synchronized_stone
			end
			l_text_area := editor_tool.text_area
			l_text_area.update_click_list (False)
			if l_text_area.file_loaded then
				editor_tool.text_area.check_document_modifications_and_reload
			end
			set_stone (st)
			update_save_symbol
			address_manager.refresh
			during_synchronization := False
		end

	synchronize_routine_tool_to_default is
			-- Synchronize the editor tool to the debug format.
		do
			--| FIXME ARNAUD: To be implemented
		end

	clear_object_tool is
			-- Clear the contents of the object tool if shown.
		do
			--| FIXME ARNAUD: To be implemented
		end

	build_menus is
			-- Build all menus displayed in the development window.
		do
				-- Build each menu
			build_file_menu
			build_edit_menu
			build_view_menu
			build_favorites_menu
			build_project_menu
			build_debug_menu
			build_tools_menu
			build_window_menu
			build_help_menu
				-- Build the menu bar.
			build_menu_bar
		end

	build_debug_menu is
			-- Build the `Debug' menu through the debugger_manager.
		local
			conv_mit: EB_COMMAND_MENU_ITEM
		do
			debug_menu := Eb_debugger_manager.new_debug_menu
			from
				debug_menu.start
			until
				debug_menu.after
			loop
				conv_mit ?= debug_menu.item
				if conv_mit /= Void then
					add_recyclable (conv_mit)
				end
				debug_menu.forth
			end
				--| Debugging tools menu
			debugging_tools_menu := Eb_debugger_manager.new_debugging_tools_menu
			debug_menu.extend (create {EV_MENU_SEPARATOR})
			debug_menu.extend (debugging_tools_menu)
			update_debug_menu
		end

	build_menu_bar is
			-- Build the menu bar
		local
			mb: EV_MENU_BAR
		do
			check
				window.menu_bar /= Void implies not window.menu_bar.is_empty
				-- If a menu bar was already present, it shouldn't be empty.
			end
			if window.menu_bar /= Void then
				mb := window.menu_bar
				from
					mb.start
					mb.forth
				until
					mb.after
				loop
					mb.remove
				end
			else
				create mb
				window.set_menu_bar (mb)
				mb.extend (file_menu)
			end

			if Eiffel_project.manager.is_created then
				mb.extend (edit_menu)
				mb.extend (view_menu)
				mb.extend (favorites_menu)
				mb.extend (project_menu)
				mb.extend (debug_menu)
			else
				mb.extend (view_menu)
			end
			mb.extend (tools_menu)
			mb.extend (window_menu)
			mb.extend (help_menu)
			estudio_debug_cmd.build_menu_bar
		end

feature -- Graphical Interface

	build_general_toolbar is
			-- Set up the general toolbar (New, Save, Search, Shell, Undo, Redo, ...)
		local
			cell: EV_CELL
			hsep: EV_HORIZONTAL_SEPARATOR
			hbox: EV_HORIZONTAL_BOX
		do
				-- Create the toolbar.
			create general_toolbar
			general_customizable_toolbar := development_window_data.retrieve_general_toolbar (toolbarable_commands)
			if development_window_data.show_text_in_general_toolbar then
				general_customizable_toolbar.enable_important_text
			elseif development_window_data.show_all_text_in_general_toolbar then
				general_customizable_toolbar.enable_text_displayed
			end

			create hbox
			hbox.extend (general_customizable_toolbar.widget)
			hbox.disable_item_expand (general_customizable_toolbar.widget)

				-- Generate the toolbar.
			general_customizable_toolbar.update_toolbar

				-- Cell to fill in empty space and receive the right click menu holder.
			create cell
			cell.pointer_button_release_actions.extend (agent toolbar_right_click_action)
			hbox.extend (cell)

				-- Create the vertical layout (separator + toolbar)
			create hsep
			general_toolbar.set_padding (2)
			general_toolbar.extend (hsep)
			general_toolbar.disable_item_expand (hsep)
			general_toolbar.extend (hbox)

				-- Create the command to show/hide this toolbar.
			create show_general_toolbar_command.make (general_toolbar, Interface_names.m_general_toolbar)
			show_toolbar_commands.extend (show_general_toolbar_command)
			if development_window_data.show_general_toolbar then
				show_general_toolbar_command.enable_visible
			else
				show_general_toolbar_command.disable_visible
			end

		end

	build_address_toolbar is
			-- Set up the address toolbar (Back, Forward, Current, Class name, feature name, ...)
		local
			tb: EV_TOOL_BAR
--			address_bar: EV_HORIZONTAL_BOX -- Contains "Class" + Combobox + "Feature" + Combobox + "Format" + Combobox
			hsep: EV_HORIZONTAL_SEPARATOR
			hbox: EV_HORIZONTAL_BOX -- Contains HistoryToolbar (back, forth, current) + `address_bar'
			cell: EV_CELL
			accel: EV_ACCELERATOR
		do
				-- Create the toolbar
			create address_toolbar
			create hsep
			create hbox
--			create address_bar
			create tb
			address_toolbar.set_padding (2)
			address_toolbar.extend (hsep)
			address_toolbar.disable_item_expand (hsep)
			address_toolbar.extend (hbox)

			hbox.extend (tb)
			hbox.disable_item_expand (tb)
--			hbox.extend (address_bar)
--			hbox.disable_item_expand (address_bar)

				-- Back icon
			tb.extend (history_manager.back_command.new_toolbar_item (False))

				-- Forward icon
			tb.extend (history_manager.forth_command.new_toolbar_item (False))

				-- Set up the accelerators.
			create accel.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_right), False, True, False
			)
			accel.actions.extend (agent on_forth)
			window.accelerators.extend (accel)

			create accel.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_left), False, True, False
			)
			accel.actions.extend (agent on_back)
			window.accelerators.extend (accel)

			------------------------------------------
			-- Address bar (Class name & feature name)
			------------------------------------------
			hbox.extend (address_manager.widget)
--			editor_tool.text_area.add_cursor_observer (address_manager)

				-- Create the command to show/hide this toolbar.
			create show_address_toolbar_command.make (address_toolbar, Interface_names.m_address_toolbar)
			show_toolbar_commands.extend (show_address_toolbar_command)

			if development_window_data.show_address_toolbar then
				show_address_toolbar_command.enable_visible
			else
				show_address_toolbar_command.disable_visible
			end

				-- Cell to fill in empty space and receive the right click menu holder.
			create cell
			cell.pointer_button_release_actions.extend (agent toolbar_right_click_action)
			hbox.extend (cell)
		end

	build_project_toolbar is
			-- Build toolbar corresponding to the project options bar
		local
			cell: EV_CELL
			hsep: EV_HORIZONTAL_SEPARATOR
			hbox: EV_HORIZONTAL_BOX
		do
			create project_toolbar
			create hsep
			project_toolbar.extend (hsep)
			project_toolbar.disable_item_expand (hsep)

				-- Generate the toolbar.
			create hbox
			project_customizable_toolbar := Eb_debugger_manager.new_toolbar
			hbox.extend (project_customizable_toolbar.widget)
			hbox.disable_item_expand (project_customizable_toolbar.widget)

			project_customizable_toolbar.update_toolbar

				-- Create the command to show/hide this toolbar.
			create show_project_toolbar_command.make (project_toolbar, Interface_names.m_project_toolbar)
			show_toolbar_commands.extend (show_project_toolbar_command)
			if development_window_data.show_project_toolbar then
				show_project_toolbar_command.enable_visible
			else
				show_project_toolbar_command.disable_visible
			end

				-- Cell to fill in empty space and receive the right click menu holder.
			create cell
			cell.pointer_button_release_actions.extend (agent toolbar_right_click_action)
			hbox.extend (cell)
			project_toolbar.extend (hbox)
		end

	build_refactoring_toolbar is
			-- Build refactoring toolbar.
		local
			cell: EV_CELL
			hsep: EV_HORIZONTAL_SEPARATOR
			hbox: EV_HORIZONTAL_BOX
		do
				-- Create the toolbar.
			create refactoring_toolbar
			refactoring_customizable_toolbar := development_window_data.retrieve_refactoring_toolbar (toolbarable_commands)
			if development_window_data.show_text_in_refactoring_toolbar then
				refactoring_customizable_toolbar.enable_important_text
			elseif development_window_data.show_all_text_in_refactoring_toolbar then
				refactoring_customizable_toolbar.enable_text_displayed
			end

			create hbox
			hbox.extend (refactoring_customizable_toolbar.widget)
			hbox.disable_item_expand (refactoring_customizable_toolbar.widget)

				-- Generate the toolbar.
			refactoring_customizable_toolbar.update_toolbar

				-- Cell to fill in empty space and receive the right click menu holder.
			create cell
			cell.pointer_button_release_actions.extend (agent toolbar_right_click_action)
			hbox.extend (cell)

				-- Create the vertical layout (separator + toolbar)
			create hsep
			refactoring_toolbar.set_padding (2)
			refactoring_toolbar.extend (hsep)
			refactoring_toolbar.disable_item_expand (hsep)
			refactoring_toolbar.extend (hbox)

				-- Create the command to show/hide this toolbar.
			create show_refactoring_toolbar_command.make (refactoring_toolbar, Interface_names.m_refactoring_toolbar)
			show_toolbar_commands.extend (show_refactoring_toolbar_command)
			if development_window_data.show_refactoring_toolbar then
				show_refactoring_toolbar_command.enable_visible
			else
				show_refactoring_toolbar_command.disable_visible
			end
		end


feature {NONE} -- Menu Building

	build_file_menu is
			-- Build the file menu.
		local
			new_project_cmd: EB_NEW_PROJECT_COMMAND
			open_project_cmd: EB_OPEN_PROJECT_COMMAND
			send_to_menu: EV_MENU
			menu_item: EV_MENU_ITEM
			command_menu_item: EB_COMMAND_MENU_ITEM
		do
			create file_menu.make_with_text (Interface_names.m_file)

				-- New
			command_menu_item := New_development_window_cmd.new_menu_item
			add_recyclable (command_menu_item)
			file_menu.extend (command_menu_item)

				-- New editor
			command_menu_item := New_editor_cmd.new_menu_item
			add_recyclable (command_menu_item)
			file_menu.extend (command_menu_item)

				-- New context tool
			command_menu_item := New_context_tool_cmd.new_menu_item
			add_recyclable (command_menu_item)
			file_menu.extend (command_menu_item)

				-- Open
			command_menu_item := open_cmd.new_menu_item
			add_recyclable (command_menu_item)
			file_menu.extend (command_menu_item)

				-- Close
			create menu_item.make_with_text (Interface_names.m_close)
			menu_item.select_actions.extend (agent destroy)
			file_menu.extend (menu_item)

				-- Separator --------------------------------------
			file_menu.extend (create {EV_MENU_SEPARATOR})

				-- Save
			command_menu_item := save_cmd.new_menu_item
			add_recyclable (command_menu_item)
			file_menu.extend (command_menu_item)

				-- Save as
			command_menu_item := save_as_cmd.new_menu_item
			add_recyclable (command_menu_item)
			file_menu.extend (command_menu_item)

				-- Sent to
			create send_to_menu.make_with_text (Interface_names.m_send_to)
					-- External editor
				command_menu_item := shell_cmd.new_menu_item
				add_recyclable (command_menu_item)
				send_to_menu.extend (command_menu_item)
			file_menu.extend (send_to_menu)

				-- Separator --------------------------------------
			file_menu.extend (create {EV_MENU_SEPARATOR})
			command_menu_item := print_cmd.new_menu_item
			add_recyclable (command_menu_item)
			file_menu.extend (command_menu_item)

				-- Separator --------------------------------------
			file_menu.extend (create {EV_MENU_SEPARATOR})

				-- New Project
			create new_project_cmd.make_with_parent (window)
			create menu_item.make_with_text (Interface_names.m_new_project)
			menu_item.select_actions.extend (agent new_project_cmd.execute)
			file_menu.extend (menu_item)

				-- Open Project
			create open_project_cmd.make_with_parent (window)
			create menu_item.make_with_text (Interface_names.m_open_project)
			menu_item.select_actions.extend (agent open_project_cmd.execute)
			file_menu.extend (menu_item)

				-- Recent Projects
			recent_projects_menu := recent_projects_manager.new_menu
			add_recyclable (recent_projects_menu)
			file_menu.extend (recent_projects_menu)

				-- Separator --------------------------------------
			file_menu.extend (create {EV_MENU_SEPARATOR})

				-- Exit
			command_menu_item := Exit_application_cmd.new_menu_item
			add_recyclable (Command_menu_item)
			file_menu.extend (command_menu_item)
		end

	build_class_info_menu: EV_MENU is
			-- Build the class format sub-menu.
		local
			form: EB_CLASS_INFO_FORMATTER
			empty_menu: EV_MENU_ITEM
			i: INTEGER
		do
			create Result.make_with_text (Interface_names.m_class_info)
			i := 1

			create empty_menu.make_with_text (Interface_names.m_formatter_separators @ i)
			i := i + 1
			empty_menu.disable_sensitive
			Result.extend (empty_menu)
			from
				managed_class_formatters.start
			until
				managed_class_formatters.after
			loop
				form := managed_class_formatters.item
				if form /= Void then
					Result.extend (form.new_menu_item)
				else
					create empty_menu.make_with_text (Interface_names.m_formatter_separators @ i)
					i := i + 1
					empty_menu.disable_sensitive
					Result.extend (empty_menu)
				end
				managed_class_formatters.forth
			end
		end

	build_feature_info_menu: EV_MENU is
			-- Build the feature format sub-menu.
		local
			form: EB_FEATURE_INFO_FORMATTER
		do
			create Result.make_with_text (Interface_names.m_feature_info)
			from
				managed_feature_formatters.start
			until
				managed_feature_formatters.after
			loop
				form := managed_feature_formatters.item
				if form /= Void then
					Result.extend (form.new_menu_item)
				end
				managed_feature_formatters.forth
			end
		end

	build_edit_menu is
			-- Create and build `edit_menu'
		local
			command_menu_item: EB_COMMAND_MENU_ITEM
			sub_menu: EV_MENU
			cmd: EB_EDITOR_COMMAND
			os_cmd: EB_ON_SELECTION_COMMAND
			editor: EB_SMART_EDITOR
			ln_cmd: EB_TOGGLE_LINE_NUMBERS_COMMAND
		do
			editor := editor_tool.text_area
			create command_controller.make

			create edit_menu.make_with_text (Interface_names.m_edit)

				-- Undo
			command_menu_item := undo_cmd.new_menu_item
			add_recyclable (command_menu_item)
			edit_menu.extend (command_menu_item)

				-- Redo
			command_menu_item := redo_cmd.new_menu_item
			add_recyclable (command_menu_item)
			edit_menu.extend (command_menu_item)

				-- Separator --------------------------------------
			edit_menu.extend (create {EV_MENU_SEPARATOR})

				-- Cut
			create os_cmd.make (Current)
			os_cmd.set_menu_name (Interface_names.M_cut)
			os_cmd.set_pixmap (pixmaps.icon_cut)
			os_cmd.set_name ("Editor_cut")
			os_cmd.set_tooltip (interface_names.f_cut)
			os_cmd.add_agent (agent cut_selection)
			os_cmd.set_tooltext (Interface_names.b_cut)
			toolbarable_commands.extend (os_cmd)
			os_cmd.set_needs_editable (True)
			command_controller.add_selection_command (os_cmd)
			command_menu_item := os_cmd.new_menu_item
			add_recyclable (command_menu_item)
			edit_menu.extend (command_menu_item)

				-- Copy
			create os_cmd.make (Current)
			os_cmd.set_menu_name (Interface_names.M_copy)
			os_cmd.set_pixmap (pixmaps.icon_copy)
			os_cmd.set_name ("Editor_copy")
			os_cmd.set_tooltip (interface_names.f_copy)
			os_cmd.set_tooltext (Interface_names.b_copy)
			os_cmd.add_agent (agent copy_selection)
			toolbarable_commands.extend (os_cmd)
			os_cmd.set_needs_editable (False)
			command_controller.add_selection_command (os_cmd)
			command_menu_item := os_cmd.new_menu_item
			add_recyclable (command_menu_item)
			edit_menu.extend (command_menu_item)

				-- Paste
			command_menu_item := editor_paste_cmd.new_menu_item
			add_recyclable (command_menu_item)
			edit_menu.extend (command_menu_item)

				-- Separator --------------------------------------
			edit_menu.extend (create {EV_MENU_SEPARATOR})

				-- Select all
			create cmd.make
			cmd.set_menu_name (Interface_names.m_select_all)
			cmd.add_agent (agent select_all)
			command_menu_item := cmd.new_menu_item
			command_controller.add_edition_command (cmd)
			add_recyclable (command_menu_item)
			edit_menu.extend (command_menu_item)

				-- Separator --------------------------------------
			edit_menu.extend (create {EV_MENU_SEPARATOR})

				-- Line numbers
			create ln_cmd.make
			command_menu_item := ln_cmd.new_menu_item
			add_recyclable (command_menu_item)
			edit_menu.extend (command_menu_item)
			window.accelerators.extend (ln_cmd.accelerator)


				-- Separator --------------------------------------
			edit_menu.extend (create {EV_MENU_SEPARATOR})

				-- Search
			create cmd.make
			cmd.set_menu_name (Interface_names.m_search + "%T" + preferences.editor_data.shortcuts.item ("show_search_panel").display_string)
			cmd.add_agent (agent search)
			command_menu_item := cmd.new_menu_item
			command_controller.add_edition_command (cmd)
			add_recyclable (command_menu_item)
			edit_menu.extend (command_menu_item)

				-- Go to
			create cmd.make
			cmd.set_menu_name (Interface_names.m_go_to)
			cmd.add_agent (agent goto)
			cmd.set_needs_editable (True)
			command_menu_item := cmd.new_menu_item
			command_controller.add_edition_command (cmd)
			add_recyclable (command_menu_item)
			edit_menu.extend (command_menu_item)

				-- Replace
			create cmd.make
			cmd.set_menu_name (Interface_names.m_replace + "%T" + preferences.editor_data.shortcuts.item ("show_search_and_replace_panel").display_string)
			cmd.add_agent (agent editor.replace)
			cmd.set_needs_editable (True)
			command_menu_item := cmd.new_menu_item
			command_controller.add_edition_command (cmd)
			add_recyclable (command_menu_item)
			edit_menu.extend (command_menu_item)

				-- Find sub menu

			create sub_menu.make_with_text (Interface_names.m_find)

				-- Find next
			create cmd.make
			cmd.set_menu_name (Interface_names.m_find_next + "%T" + preferences.editor_data.shortcuts.item ("search_last").display_string)
			cmd.add_agent (agent find_next)
			command_menu_item := cmd.new_menu_item
			command_controller.add_edition_command (cmd)
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

				-- Find previous
			create cmd.make
			cmd.set_menu_name (Interface_names.m_find_previous + "%T" + preferences.editor_data.shortcuts.item ("search_backward").display_string)
			cmd.add_agent (agent find_previous)
			command_menu_item := cmd.new_menu_item
			command_controller.add_edition_command (cmd)
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

				-- Find selection
			create os_cmd.make (Current)
			os_cmd.set_menu_name (Interface_names.m_find_selection + "%T" + preferences.editor_data.shortcuts.item ("search_selection").display_string)
			os_cmd.add_agent (agent find_selection)
			command_menu_item := os_cmd.new_menu_item
			command_controller.add_selection_command (os_cmd)
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

			edit_menu.extend (sub_menu)


				-- Separator --------------------------------------
			edit_menu.extend (create {EV_MENU_SEPARATOR})

			create sub_menu.make_with_text (Interface_names.m_advanced)

			create os_cmd.make (Current)
			os_cmd.set_needs_editable (True)
			command_controller.add_selection_command (os_cmd)
			os_cmd.set_menu_name (Interface_names.m_indent)
			os_cmd.add_agent (agent editor.indent_selection)
			command_menu_item := os_cmd.new_menu_item
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

			create os_cmd.make (Current)
			os_cmd.set_needs_editable (True)
			command_controller.add_selection_command (os_cmd)
			os_cmd.set_menu_name (Interface_names.m_unindent)
			os_cmd.add_agent (agent editor.unindent_selection)
			command_menu_item := os_cmd.new_menu_item
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

			create os_cmd.make (Current)
			os_cmd.set_needs_editable (True)
			command_controller.add_selection_command (os_cmd)
			os_cmd.set_menu_name (Interface_names.m_to_lower)
			os_cmd.add_agent (agent editor.set_selection_case (True))
			command_menu_item := os_cmd.new_menu_item
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

			create os_cmd.make (Current)
			os_cmd.set_needs_editable (True)
			command_controller.add_selection_command (os_cmd)
			os_cmd.set_menu_name (Interface_names.m_to_upper)
			os_cmd.add_agent (agent editor.set_selection_case (False))
			command_menu_item := os_cmd.new_menu_item
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

			create cmd.make
			cmd.set_needs_editable (True)
			cmd.set_menu_name (Interface_names.m_comment)
			cmd.add_agent (agent editor.comment_selection)
			command_menu_item := cmd.new_menu_item
			command_controller.add_edition_command (cmd)
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

			create cmd.make
			cmd.set_needs_editable (True)
			cmd.set_menu_name (Interface_names.m_uncomment)
			cmd.add_agent (agent editor.uncomment_selection)
			command_menu_item := cmd.new_menu_item
			command_controller.add_edition_command (cmd)
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

				-- Separator --------------------------------------
			sub_menu.extend (create {EV_MENU_SEPARATOR})

				-- Insert if block
			create cmd.make
			cmd.set_needs_editable (True)
			cmd.set_menu_name (Interface_names.m_if_block)
			cmd.add_agent (agent editor.embed_in_block("if  then", 3))
			command_menu_item := cmd.new_menu_item
			command_controller.add_edition_command (cmd)
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

				-- Insert debug block
			create cmd.make
			cmd.set_needs_editable (True)
			cmd.set_menu_name (Interface_names.m_debug_block)
			cmd.add_agent (agent editor.embed_in_block("debug", 5))
			command_menu_item := cmd.new_menu_item
			command_controller.add_edition_command (cmd)
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)


				-- Separator --------------------------------------
			sub_menu.extend (create {EV_MENU_SEPARATOR})

				-- Complete word
			create cmd.make
			cmd.set_needs_editable (True)
			cmd.set_menu_name (Interface_names.m_complete_word + "%T" + preferences.editor_data.shortcuts.item ("autocomplete").display_string)
			command_menu_item := cmd.new_menu_item
			command_controller.add_edition_command (cmd)
			cmd.add_agent (agent editor.complete_feature_name)

			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

				-- Complete class name
			create cmd.make
			cmd.set_needs_editable (True)
			cmd.set_menu_name (Interface_names.m_complete_class_name + "%T" + preferences.editor_data.shortcuts.item ("class_autocomplete").display_string)
			command_menu_item := cmd.new_menu_item
			command_controller.add_edition_command (cmd)
			cmd.add_agent (agent editor.complete_class_name)

			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

			sub_menu.extend (create {EV_MENU_SEPARATOR})

				-- show/hide formatting marks.
			create cmd.make
			if editor_tool.text_area.view_invisible_symbols then
				cmd.set_menu_name (Interface_names.m_hide_formatting_marks)
			else
				cmd.set_menu_name (Interface_names.m_show_formatting_marks)
			end
			formatting_marks_command_menu_item := cmd.new_menu_item
			command_controller.add_edition_command (cmd)
			cmd.add_agent (agent toggle_formatting_marks)

			add_recyclable (formatting_marks_command_menu_item)
			sub_menu.extend (formatting_marks_command_menu_item)

			edit_menu.extend (sub_menu)
		end

	build_view_menu is
			-- Build the view menu.
		local
			form: EB_CLASS_INFO_FORMATTER
			new_menu_item: EB_COMMAND_MENU_ITEM
			new_basic_item: EV_MENU_ITEM
		do
			Precursor

			new_menu_item := toggle_stone_cmd.new_menu_item
			view_menu.extend (new_menu_item)
			add_recyclable (new_menu_item)

			new_menu_item := send_stone_to_context_cmd.new_menu_item
			view_menu.extend (new_menu_item)
			add_recyclable (new_menu_item)
				-- Go to menu
			new_basic_item := history_manager.new_menu
			view_menu.extend (new_basic_item)

				-- Separator --------------------------------------
			view_menu.extend (create {EV_MENU_SEPARATOR})
			view_menu.extend (build_class_info_menu)
			view_menu.extend (build_feature_info_menu)

				-- Separator --------------------------------------
			view_menu.extend (create {EV_MENU_SEPARATOR})

			from
				managed_main_formatters.start
			until
				managed_main_formatters.after
			loop
				form := managed_main_formatters.item
				new_basic_item := form.new_menu_item
				new_basic_item.select_actions.put_front (agent form.invalidate)
				view_menu.extend (new_basic_item)
				--add_recyclable (new_basic_item)
				managed_main_formatters.forth
			end
		end

	build_favorites_menu is
			-- Build the favorites menu
		do
			Precursor {EB_TOOL_MANAGER}

			create show_favorites_menu_item
			update_show_favorites_menu_item
			show_favorites_menu_item.select_actions.extend (agent execute_show_favorites)

			favorites_menu.start
			favorites_menu.put_right (show_favorites_menu_item)
			favorites_menu.select_actions.extend (agent update_show_favorites_menu_item)
		end

	-- Jason Wei modified the following on Aug 31 2005
	build_project_menu is
			-- Build the project menu.
		local
			command_menu_item: EB_COMMAND_MENU_ITEM
		do
			create project_menu.make_with_text (Interface_names.m_project)

				-- Melt
			command_menu_item := Melt_project_cmd.new_menu_item
			add_recyclable (command_menu_item)
			project_menu.extend (command_menu_item)

				-- Quick melt
			command_menu_item := Quick_melt_project_cmd.new_menu_item
			add_recyclable (command_menu_item)
			project_menu.extend (command_menu_item)

				-- Freeze
			command_menu_item := Freeze_project_cmd.new_menu_item
			add_recyclable (command_menu_item)
			project_menu.extend (command_menu_item)

				-- Finalize
			command_menu_item := Finalize_project_cmd.new_menu_item
			add_recyclable (command_menu_item)
			project_menu.extend (command_menu_item)

				-- Precompile
			command_menu_item := precompilation_cmd.new_menu_item
			add_recyclable (command_menu_item)
			project_menu.extend (command_menu_item)

				-- Cancel
			command_menu_item := project_cancel_cmd.new_menu_item
			add_recyclable (command_menu_item)
			project_menu.extend (command_menu_item)

				-- Separator -------------------------------------------------
			project_menu.extend (create {EV_MENU_SEPARATOR})

				-- Compile Workbench C code
			command_menu_item := c_workbench_compilation_cmd.new_menu_item
			add_recyclable (command_menu_item)
			project_menu.extend (command_menu_item)

				-- Compile Finalized C code
			command_menu_item := c_finalized_compilation_cmd.new_menu_item
			add_recyclable (command_menu_item)
			project_menu.extend (command_menu_item)

			-- Jason Wei
				-- Terminate C compilation
			command_menu_item := Terminate_c_compilation_cmd.new_menu_item
			add_recyclable (command_menu_item)
			project_menu.extend (command_menu_item)
			-- Jason Wei

				-- Execute Finalized code
			command_menu_item := run_finalized_cmd.new_menu_item
			add_recyclable (command_menu_item)
			project_menu.extend (command_menu_item)

				-- Separator -------------------------------------------------
			project_menu.extend (create {EV_MENU_SEPARATOR})

				-- System Tool window
			command_menu_item := system_cmd.new_menu_item
			add_recyclable (command_menu_item)
			project_menu.extend (command_menu_item)

				-- System information
			command_menu_item := system_info_cmd.new_menu_item
			add_recyclable (command_menu_item)
			project_menu.extend (command_menu_item)

				-- Error information
			command_menu_item := display_error_help_cmd.new_menu_item
			add_recyclable (command_menu_item)
			project_menu.extend (command_menu_item)

			if has_documentation_generation or has_xmi_generation then
					-- Separator -------------------------------------------------
				project_menu.extend (create {EV_MENU_SEPARATOR})
			end

			if has_documentation_generation then
					-- Generate Documentation
				command_menu_item := document_cmd.new_menu_item
				add_recyclable (command_menu_item)
				project_menu.extend (command_menu_item)
			end

			if has_xmi_generation then
					-- Export XMI
				command_menu_item := export_cmd.new_menu_item
				add_recyclable (command_menu_item)
				project_menu.extend (command_menu_item)
			end
		end

------- This is the original version
--	build_project_menu is
--			-- Build the project menu.
--		local
--			command_menu_item: EB_COMMAND_MENU_ITEM
--		do
--			create project_menu.make_with_text (Interface_names.m_project)
--
--				-- Melt
--			command_menu_item := Melt_project_cmd.new_menu_item
--			add_recyclable (command_menu_item)
--			project_menu.extend (command_menu_item)
--
--				-- Quick melt
--			command_menu_item := Quick_melt_project_cmd.new_menu_item
--			add_recyclable (command_menu_item)
--			project_menu.extend (command_menu_item)
--
--				-- Freeze
--			command_menu_item := Freeze_project_cmd.new_menu_item
--			add_recyclable (command_menu_item)
--			project_menu.extend (command_menu_item)
--
--				-- Finalize
--			command_menu_item := Finalize_project_cmd.new_menu_item
--			add_recyclable (command_menu_item)
--			project_menu.extend (command_menu_item)
--
--				-- Precompile
--			command_menu_item := precompilation_cmd.new_menu_item
--			add_recyclable (command_menu_item)
--			project_menu.extend (command_menu_item)
--
--				-- Separator -------------------------------------------------
--			project_menu.extend (create {EV_MENU_SEPARATOR})
--
--				-- Compile Workbench C code
--			command_menu_item := c_workbench_compilation_cmd.new_menu_item
--			add_recyclable (command_menu_item)
--			project_menu.extend (command_menu_item)
--
--				-- Compile Finalized C code
--			command_menu_item := c_finalized_compilation_cmd.new_menu_item
--			add_recyclable (command_menu_item)
--			project_menu.extend (command_menu_item)
--
--				-- Execute Finalized code
--			command_menu_item := run_finalized_cmd.new_menu_item
--			add_recyclable (command_menu_item)
--			project_menu.extend (command_menu_item)
--
--				-- Separator -------------------------------------------------
--			project_menu.extend (create {EV_MENU_SEPARATOR})
--
--				-- System Tool window
--			command_menu_item := system_cmd.new_menu_item
--			add_recyclable (command_menu_item)
--			project_menu.extend (command_menu_item)
--
--				-- System information
--			command_menu_item := system_info_cmd.new_menu_item
--			add_recyclable (command_menu_item)
--			project_menu.extend (command_menu_item)
--
--				-- Error information
--			command_menu_item := display_error_help_cmd.new_menu_item
--			add_recyclable (command_menu_item)
--			project_menu.extend (command_menu_item)
--
--			if has_documentation_generation or has_xmi_generation then
--					-- Separator -------------------------------------------------
--				project_menu.extend (create {EV_MENU_SEPARATOR})
--			end
--
--			if has_documentation_generation then
--					-- Generate Documentation
--				command_menu_item := document_cmd.new_menu_item
--				add_recyclable (command_menu_item)
--				project_menu.extend (command_menu_item)
--			end
--
--			if has_xmi_generation then
--					-- Export XMI
--				command_menu_item := export_cmd.new_menu_item
--				add_recyclable (command_menu_item)
--				project_menu.extend (command_menu_item)
--			end
--		end
	-- Jason Wei modified the above on Aug 31 2005

	build_tools_menu is
			-- Create and build `tools_menu'
		local
			command_menu_item: EB_COMMAND_MENU_ITEM
			menu_item: EV_MENU_ITEM
		do
			create tools_menu.make_with_text (Interface_names.m_tools)

				-- New Cluster command.
			command_menu_item := new_cluster_cmd.new_menu_item
			add_recyclable (command_menu_item)
			tools_menu.extend (command_menu_item)

				-- New Class command.
			command_menu_item := new_class_cmd.new_menu_item
			add_recyclable (command_menu_item)
			tools_menu.extend (command_menu_item)

				-- New Feature command.
			command_menu_item := new_feature_cmd.new_menu_item
			add_recyclable (command_menu_item)
			tools_menu.extend (command_menu_item)

				-- Delete class/cluster command.
			command_menu_item := delete_class_cluster_cmd.new_menu_item
			add_recyclable (command_menu_item)
			tools_menu.extend (command_menu_item)

				-- Separator --------------------------------------
			tools_menu.extend (create {EV_MENU_SEPARATOR})


			if has_metrics then
					-- Metric tool
				create metric_menu.make_with_text (interface_names.metric_metrics)
					create menu_item.make_with_text (interface_names.metric_calculate)
					metric_menu.extend (menu_item)
					create menu_item.make_with_text (interface_names.metric_add)
					metric_menu.extend (menu_item)
					create menu_item.make_with_text (interface_names.metric_delete)
					metric_menu.extend (menu_item)
					create menu_item.make_with_text (interface_names.metric_details)
					metric_menu.extend (menu_item)
					create menu_item.make_with_text (interface_names.metric_new_metrics)
					metric_menu.extend (menu_item)
					create menu_item.make_with_text (interface_names.metric_management)
					metric_menu.extend (menu_item)
					create menu_item.make_with_text (interface_names.metric_archive)
					metric_menu.extend (menu_item)
				metric_menu.disable_sensitive
				tools_menu.extend (metric_menu)
			end

			if has_profiler then
					-- Profiler Window
				command_menu_item := show_profiler.new_menu_item
				add_recyclable (command_menu_item)
				tools_menu.extend (command_menu_item)
			end

				-- Precompile Wizard
			command_menu_item := wizard_precompile_cmd.new_menu_item
			add_recyclable (command_menu_item)
			tools_menu.extend (command_menu_item)

			if has_dll_generation then
					-- Dynamic Library Window
				command_menu_item := show_dynamic_lib_tool.new_menu_item
				add_recyclable (command_menu_item)
				tools_menu.extend (command_menu_item)
			end

				-- Separator -------------------------------------------------
			tools_menu.extend (create {EV_MENU_SEPARATOR})

					-- Preferences
			command_menu_item := Show_preferences_cmd.new_menu_item
			add_recyclable (command_menu_item)
			tools_menu.extend (command_menu_item)

					-- External commands editor
			command_menu_item := Edit_external_commands_cmd.new_menu_item
			add_recyclable (command_menu_item)
			tools_menu.extend (command_menu_item)

			rebuild_tools_menu
		end

feature -- Stone process

	stone: STONE
			-- Current stone

	toggle_unified_stone is
			-- Change the stone management mode.
		do
			unified_stone := not unified_stone
			if unified_stone then
				send_stone_to_context
				send_stone_to_context_cmd.disable_sensitive
				context_tool.link_to_development_window
			else
				if stone /= Void then
					send_stone_to_context_cmd.enable_sensitive
				end
				context_tool.cut_from_development_window
			end
		end

	set_stone (a_stone: STONE) is
			-- Change the currently focused stone.
		local
			cd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
			cv_cst: CLASSI_STONE
			ef_stone: EXTERNAL_FILE_STONE
			l: LIST [EB_DEVELOPMENT_WINDOW]
			l_filename: STRING
		do
			cv_cst ?= a_stone
			if cv_cst /= Void then
				l_filename := cv_cst.class_i.name
			else
				ef_stone ?= a_stone
				if ef_stone /= Void then
					l_filename := ef_stone.file_name.string
				end
			end

			if cv_cst /= Void or ef_stone /= Void then
				l := Window_manager.development_windows_with_class (l_filename)
				if l.is_empty or else l.has (Current) then
						-- We're not editing the class in another window.
					set_stone_after_first_check (a_stone)
				else
					create cd.make_initialized (2,
						preferences.dialog_data.already_editing_class_string,
						warning_messages.w_class_already_edited,
						Interface_names.l_do_not_show_again,
						preferences.preferences)
					cd.set_ok_action (agent set_stone_after_first_check (a_stone))
					cd.show_modal_to_window (window)
				end
			else
				set_stone_after_first_check (a_stone)
			end
		end

	set_stone_after_first_check (a_stone: STONE) is
			-- Display text associated with `a_stone', if any and if possible
		local
			feature_stone: FEATURE_STONE
			old_class_stone: CLASSI_STONE
			test_stone: CLASSI_STONE
			same_class: BOOLEAN
			conv_ferrst: FEATURE_ERROR_STONE
			ef_stone: EXTERNAL_FILE_STONE
			cluster_st: CLUSTER_STONE
			new_class_stone: CLASSI_STONE
			conv_ace: ACE_SYNTAX_STONE
			conv_errst: ERROR_STONE
			conv_brkstone: BREAKABLE_STONE
		do
			old_class_stone ?= stone
			feature_stone ?= a_stone
			ef_stone ?= a_stone
			new_class_stone ?= a_stone
			cluster_st ?= a_stone

				-- Update the history.
			conv_brkstone ?= a_stone
			conv_errst ?= a_stone
			conv_ace ?= a_stone
			if
				conv_brkstone = Void and
				conv_errst = Void and
				conv_ace = Void and
				ef_stone = Void
			then
				if
					new_class_stone /= Void
				then
					history_manager.extend (new_class_stone)
				elseif
					cluster_st /= Void
				then
					history_manager.extend (cluster_st)
				end
			end

			if old_class_stone /= Void then
				create test_stone.make (old_class_stone.class_i)
				same_class := test_stone.same_as (a_stone)
					-- We need to compare classes. If `old_class_stone' is a FEATURE_STONE
					-- `same_as' will compare features. Therefore, we need `test_stone' to be sure
					-- we have a CLASSI_STONE.
				if same_class and then feature_stone /= Void then
					same_class := False
						-- if the stone corresponding to a feature of currently opened class is dropped
						-- we attempt to scroll to the feature without asking to save the file
						-- except if it is during a resynchronization, in which case we do not scroll at all.
					if editor_tool.text_area.text_is_fully_loaded then
						if not during_synchronization then
							scroll_to_feature (feature_stone.e_feature, new_class_stone.class_i)
							feature_stone_already_processed := True
						else
							feature_stone_already_processed := True
						end
						conv_ferrst ?= feature_stone
						if feature_stone_already_processed and conv_ferrst /= Void then
								-- Scroll to the line of the error.
							if not during_synchronization then
								editor_tool.text_area.display_line_when_ready (conv_ferrst.line_number, True)
							end
						end
					end
				end
			elseif ef_stone /= Void then
			end

				-- first, let's check if there is already something in this window
				-- if there's nothing, there's no need to save anything...
			if stone = Void or else not changed or else feature_stone_already_processed or else same_class then
				set_stone_after_check (a_stone)
				feature_stone_already_processed := False
			else
					-- there is something to be saved
					-- if user chooses to save, current file will be parsed
					-- if there is a syntax_error, new file is not loaded
				save_and (agent set_stone_after_check (a_stone))
				if text_saved and then not syntax_is_correct then
					text_saved := False
					during_synchronization := True
					set_stone_after_check (stone)
					during_synchronization := False
					address_manager.refresh
				end
			end
			if not editor_tool.text_area.has_focus then
				ev_application.idle_actions.extend_kamikaze (agent editor_tool.set_focus)
			end
		end

	force_stone (s: STONE) is
			-- make `s' the new value of `stone', and
			-- change the display accordingly. Try to
			-- extract a class from `s' whenever possible.
		do
			if s.is_storable then
				set_stone (s)
				if not unified_stone then
					context_tool.advanced_set_stone (s)
				end
			end
		end

	process_class (s: CLASSI_STONE) is
			-- Process class stone
		do
			set_stone (s)
		end

	process_feature_error (s: FEATURE_ERROR_STONE) is
			-- Process feature error stone.
		local
			cl_stone: CLASSC_STONE
			e_class: CLASS_C
		do
			set_default_format
			e_class := s.e_feature.written_class
			create cl_stone.make (e_class)
			set_stone (cl_stone)
			editor_tool.text_area.deselect_all
			if s.line_number > 0 then
				editor_tool.text_area.highlight_selected (s.line_number, s.line_number)
			end
		end


	process_class_syntax (s: CL_SYNTAX_STONE) is
			-- Process class syntax.
		local
			cl_stone: CLASSC_STONE
		do
				-- call set_stone to ensure the proper class is displayed
			create cl_stone.make (s.e_class)
			set_stone (cl_stone)
			editor_tool.text_area.deselect_all
			editor_tool.text_area.highlight_when_ready (s.line, s.line)
		end

	refresh is
			-- Synchronize clickable elements with text, if possible.
		do
	--| FIXME ARNAUD
	--			synchronise_stone
	--| END FIXME
	--| FIXME XR: Refresh current display in the editor.
			editor_tool.text_area.update_click_list (False)
			update_save_symbol
			address_manager.refresh
				-- The cluster manager should already be refreshed by the window manager.
	--			cluster_manager.refresh
	--			context_tool.refresh
		end

	quick_refresh_editors is
			-- Redraw editors' drawing area.
		do
			editor_tool.text_area.refresh
			context_tool.quick_refresh_editors
		end

	quick_refresh_margins is
			-- Redraw the main editor's drawing area.
		do
			editor_tool.text_area.margin.refresh
			context_tool.quick_refresh_margins
		end

	set_default_format is
			-- Default format of windows.
	--| FIXME ARNAUD: To be implemented.
	--		local
	--			f: EB_FORMATTER
		do
	--			if stone /= Void then
	--				if stone.class_i.hide_implementation then
	--					f := format_list.precompiled_default_format
	--				else
	--					f := format_list.default_format
	--				end
	--			else
	--				f := format_list.default_format
	--			end
	--			set_last_format (f)
	--| END FIXME
		end

feature -- Position provider

	position: like position_internal is
			-- Currently shown text position in the editor
		do
			Result := editor_tool.text_area.first_line_displayed
		end

	pos_container: like pos_container_internal is
			-- Current selected formatter
		local
			l_end : BOOLEAN
			l_formatter: like managed_main_formatters
		do
			l_formatter := managed_main_formatters.twin
			from
				l_formatter.start
			until
				l_formatter.after or l_end
			loop
				if l_formatter.item.selected then
					l_end := true
					Result := l_formatter.item
				end
				l_formatter.forth
			end
		end

feature -- Resource Update

	update is
			-- Update Current with the registered resources.
		do
			lock_update
				-- Show/hide general toolbar
			if development_window_data.show_general_toolbar then
				show_general_toolbar_command.enable_visible
			else
				show_general_toolbar_command.disable_visible
			end

				-- Show/hide address toolbar
			if development_window_data.show_address_toolbar then
				show_address_toolbar_command.enable_visible
			else
				show_address_toolbar_command.disable_visible
			end

				-- Show/hide project toolbar
			if development_window_data.show_project_toolbar then
				show_project_toolbar_command.enable_visible
			else
				show_project_toolbar_command.disable_visible
			end

				-- Show/hide refactoring toolbar
			if development_window_data.show_refactoring_toolbar then
				show_refactoring_toolbar_command.enable_visible
			else
				show_refactoring_toolbar_command.disable_visible
			end

			left_panel.load_from_resource (development_window_data.left_panel_layout)
			right_panel.load_from_resource (development_window_data.right_panel_layout)
			splitter_position := development_window_data.left_panel_width
			update_splitters
			unlock_update
		end

	update_splitters is
			-- Refresh the position of the splitter on screen according to
			-- our internal values.
		do
				-- Set the interior layout
			if panel.full then
				panel.set_split_position (splitter_position.max (panel.minimum_split_position))
			end
		end

	register is
			-- Register to preferences we want notification of.
		do
		end

	unregister is
			-- unregister to preferences we want notification of.
		do
		end

	reset is
			-- Reset the window contents
		do
			Precursor
			address_manager.reset

	--| FIXME ARNAUD, multiformat not yet implemented.
	--			format_list.enable_imp_formats_sensitive
	--| END FIXME
		end

	rebuild_tools_menu is
			-- Refresh the list of external commands.
		local
			ms: LIST [EB_COMMAND_MENU_ITEM]
			l_sep: EV_MENU_SEPARATOR
		do
				-- Remove all the external commands, which are at the end of the menu.
			from
				tools_menu.go_i_th (tools_menu.count + 1 - number_of_displayed_external_commands)
			until
				tools_menu.after
			loop
				tools_menu.remove
			end
			ms := Edit_external_commands_cmd.menus
			number_of_displayed_external_commands := ms.count

			if not ms.is_empty and not tools_menu.is_empty then
				l_sep ?= tools_menu.last
				if l_sep = Void then
					create l_sep
					tools_menu.extend (l_sep)
					number_of_displayed_external_commands := number_of_displayed_external_commands + 1
				end
			end

			from
				ms.start
			until
				ms.after
			loop
				tools_menu.extend (ms.item)
				add_recyclable (ms.item)
				ms.forth
			end
		end

	syntax_is_correct: BOOLEAN is
			-- file was successfully parsed.
		do
			Result := editor_tool.text_area.syntax_is_correct
		end

	on_project_created is
			-- Inform tools that the current project has been loaded or re-loaded.
		do
			build_menu_bar
			enable_commands_on_project_created
			context_tool.on_project_created
			address_manager.on_project_created
			if has_dll_generation then
				show_dynamic_lib_tool.enable_sensitive
			end
			if has_profiler then
				show_profiler.enable_sensitive
			end
		end

	on_project_loaded is
			-- Inform tools that the current project has been loaded or re-loaded.
		do
--			cluster_manager.on_project_loaded
			enable_commands_on_project_loaded
			cluster_tool.on_project_loaded
			context_tool.on_project_loaded
			breakpoints_tool.on_project_loaded
		end

	on_project_unloaded is
			-- Inform tools that the current project will soon been unloaded.
		do
--			cluster_manager.on_project_unloaded
			disable_commands_on_project_unloaded
			cluster_tool.on_project_unloaded
			context_tool.on_project_unloaded
			address_manager.on_project_unloaded
			build_menu_bar
			if has_dll_generation then
				show_dynamic_lib_tool.disable_sensitive
			end
			if has_profiler then
				show_profiler.disable_sensitive
			end
		end

	on_c_compilation_starts is
			-- Enable commands when freezing or finalizing starts.
		do
			c_workbench_compilation_cmd.disable_sensitive
			c_finalized_compilation_cmd.disable_sensitive
		end

	on_c_compilation_stops is
			-- Disable commands when freezing or finalizing stops.
		do
			c_workbench_compilation_cmd.enable_sensitive
			c_finalized_compilation_cmd.enable_sensitive
		end

	save_before_compiling is
			-- save the text but do not update clickable positions
		do
			save_only := True
			save_text
		end

	perform_check_before_save is
			-- Perform any pre-save operations/checks
		local
			dial: EV_CONFIRMATION_DIALOG
		do
				-- Remove trailing blanks.
			if preferences.editor_data.auto_remove_trailing_blank_when_saving then
				editor_tool.text_area.text_displayed.remove_trailing_blanks
			else
				editor_tool.text_area.text_displayed.remove_trailing_fake_blanks
			end
			editor_tool.text_area.refresh_now

			if editor_tool.text_area.open_backup then
				create dial.make_with_text(Warning_messages.w_save_backup)
				dial.set_buttons_and_actions(<<"Continue", "Cancel">>, <<agent continue_save, agent cancel_save>>)
				dial.set_default_push_button(dial.button("Continue"))
				dial.set_default_cancel_button(dial.button("Cancel"))
				dial.set_title ("Save Backup")
				dial.show_modal_to_window (window)
			else
				check_passed := True
			end
		end

	continue_save is
			-- continue saving
		do
			check_passed := True
		end

	cancel_save is
			-- cancel saving
		do
			check_passed := False
		end

	process is
			-- process the user entry in the address bar
		local
			l_class_stone: CLASSI_STONE
			l_multi_search_tool: EB_MULTI_SEARCH_TOOL
		do
			save_canceled := False
			l_class_stone ?= stone
			if l_class_stone /= Void then
				l_multi_search_tool ?= search_tool
				if l_multi_search_tool /= Void then
					l_multi_search_tool.class_changed (l_class_stone.class_i)
				end
			end
		end

	on_text_saved is
			-- Notify the editor that the text has been saved
		local
			str: STRING
		do
			Precursor
			editor_tool.on_text_saved
			text_saved := True
			if not save_only then
				editor_tool.text_area.update_click_list (True)
			end
			save_only := False
			str := title.twin
			if str @ 1 = '*' then
				str.keep_tail (str.count - 2)
				set_title (str)
			end
			update_formatters
			if editor_tool.text_area.syntax_is_correct then
				status_bar.display_message ("")
			else
				status_bar.display_message (Interface_names.L_syntax_error)
			end
			text_edited := False
		end

	on_focus is
			-- Focus gained
		local
			editor: TEXT_PANEL
		do
			editor ?= editor_tool.text_area
			if editor /= Void then
				editor.on_focus
			end
		end

	save_and (an_action: PROCEDURE [ANY, TUPLE]) is
		local
			save_dialog: EB_CONFIRM_SAVE_DIALOG
		do
			save_canceled := True
			text_saved := False
			create save_dialog.make_and_launch (Current,Current)
			if not save_canceled and then syntax_is_correct then
				an_action.call(Void)
			end
		end

feature -- Window management

	show_window is
			-- Show the window
		do
			show
		end

	raise_window is
			-- Show the window and set the focus to it.
		do
			show
			--| FIXME, set the focus.
		end

	hide_window is
			-- Hide the window
		do
			hide
		end

	destroy_window is
			-- Destroy the window.
		do
			destroy
		end

	give_focus is
			-- Give the focus to the address manager.
		do
			address_manager.set_focus
		end

	save_layout is
			-- Store layout of `current'.
		do
			save_layout_to_window_data (development_window_data)
				-- Commit saves
			preferences.preferences.save_preferences
		end

	save_layout_to_session (a_session: ES_SESSION) is
			-- Save session data of `Current' to session object `a_session'.
		local
			a_window_data: EB_DEVELOPMENT_WINDOW_SESSION_DATA
			a_class_i: CLASSI_STONE
		do
			create a_window_data.make_from_window_data (preferences.development_window_data)

			a_class_i ?= stone
			if a_class_i /= Void then
				a_window_data.save_filename (a_class_i.file_name)
				a_window_data.save_editor_position (editor_tool.text_area.current_cursor_position)
			end

			if context_tool /= Void then
				a_window_data.save_context_data (
					context_tool.address_manager.cluster_label_text,
					context_tool.address_manager.class_label_text,
					context_tool.address_manager.feature_label_text,
					context_tool.notebook.selected_item_index
				)
			end

			save_layout_to_window_data (a_window_data)

				-- Add the session data of `Current' to the session object.
			a_session.window_session_data.extend (a_window_data)
		end

	save_layout_to_window_data (a_window_data: EB_DEVELOPMENT_WINDOW_DATA) is
			-- Store window data of `Current' in `a_window_data'.
		require
			a_window_data_not_void: a_window_data /= Void
		do
				-- Now save the windows's layout, but only if the
				-- debugger is not displayed in `Current'. By saving the layout,
				-- we ensure that future windows may use exactly the same layout.
				-- If the debugger is displayed, the previous layout is already saved,
				-- and this is the one that must be used, as only one debugger is ever displayed.
			if
				(Eb_debugger_manager.application_is_executing and Eb_debugger_manager.debugging_window /= Current)
				or not Eb_debugger_manager.application_is_executing
			then
				a_window_data.save_left_panel_layout (left_panel.save_to_resource)
				a_window_data.save_right_panel_layout (right_panel.save_to_resource)
				a_window_data.save_left_panel_width (panel.split_position)
					-- Save width & height.
				a_window_data.save_size (window.width, window.height)
				a_window_data.save_window_state (window.is_minimized, window.is_maximized)
				a_window_data.save_position (window.x_position, window.y_position)
			end
			a_window_data.save_show_search_options (search_tool.options_shown)
		end


feature -- Tools & Controls

	editor_tool: EB_EDITOR_TOOL

	favorites_tool: EB_FAVORITES_TOOL

	cluster_tool: EB_CLUSTER_TOOL

	search_tool: EB_MULTI_SEARCH_TOOL

	features_tool: EB_FEATURES_TOOL

	breakpoints_tool: ES_BREAKPOINTS_TOOL

	windows_tool: EB_WINDOWS_TOOL

	context_tool: EB_CONTEXT_TOOL
			-- Context explorer for current class and system.

	address_manager: EB_ADDRESS_MANAGER
			-- Text field in the toolbar
			-- Allow user to enter the name
			-- of the class he wants to edit.

	project_manager: EB_PROJECT_MANAGER is
			-- Project manager associated to the project the user is working on.
		do
			Result := Eiffel_project.manager
		end

	managed_class_formatters: ARRAYED_LIST [EB_CLASS_INFO_FORMATTER]
			-- All formatters that operate on a class.

	managed_feature_formatters: ARRAYED_LIST [EB_FEATURE_INFO_FORMATTER]
			-- All formatters that operate on a class.

	managed_main_formatters: ARRAYED_LIST [EB_CLASS_TEXT_FORMATTER]
			-- All formatters that can be displayed in the main editor frame.

	unified_stone: BOOLEAN
			-- Is the stone common with the context tool or not?

	arguments_dialog: EB_ARGUMENT_DIALOG
			-- The arguments dialog for current, if any

	goto_dialog: EB_GOTO_DIALOG
			-- The goto dialog for line number access

feature -- Multiple editor management

	add_editor_to_list (an_editor: EB_EDITOR) is
			-- adds `an_editor' to `editors'
		do
			editors.extend (an_editor)
		end

	current_editor: EB_EDITOR is
			-- current editor, if none, main editor
		do
			if current_editor_index /= 0 then
				Result := editors @ current_editor_index
			else
				Result := editors.first
			end
		end

	set_current_editor (an_editor: EB_EDITOR) is
			-- set `an_editor' as main editor
		local
			old_index: INTEGER
			new_index: INTEGER
		do
			old_index := current_editor_index
			new_index := editors.index_of (an_editor, 1)
			if
				editors.valid_index (new_index) and
				old_index /= new_index
			then
				current_editor_index := new_index
				update_paste_cmd
					-- Last thing, update the menu entry for the formatting marks.
				if current_editor.view_invisible_symbols then
					formatting_marks_command_menu_item.set_text (Interface_names.m_hide_formatting_marks)
				else
					formatting_marks_command_menu_item.set_text(Interface_names.m_show_formatting_marks)
				end
				command_controller.set_current_editor (an_editor)
			end
		end

	update_paste_cmd is
			-- Update `editor_paste_cmd'. To be performed when an editor grabs the focus.
		do
			if
				not current_editor.is_empty and then
				current_editor.is_editable and then
				current_editor.clipboard.has_text
			then
				editor_paste_cmd.enable_sensitive
			else
				editor_paste_cmd.disable_sensitive
			end
		end

feature {NONE} -- Multiple editor management

	editors: ARRAYED_LIST [EB_EDITOR]
			-- editor contained in `Current'

	current_editor_index: INTEGER
			-- Index in `editors' of the editor that has the focus.

feature {EB_FEATURES_TOOL, EB_FEATURES_TREE, DOTNET_CLASS_AS, DOTNET_CLASS_CONTEXT} -- Feature Clauses

	set_feature_clauses (a_features: ARRAYED_LIST [DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]]; a_type: STRING) is
			-- Set 'features' to 'a_features' and store in hash table with key 'a_type' denoting name of consumed
			-- type pertinent to 'a_features'.
		require
			a_features_not_void: a_features /= Void
		do
			if feature_clauses = Void then
				create feature_clauses.make (5)
			end
			feature_clauses.put (a_features, a_type)
		end

	set_feature_locating (a_locating: BOOLEAN) is
			-- Set `feature_locating' with `a_locating'.
		do
			feature_locating := a_locating
		end

	get_feature_clauses (a_type: STRING): ARRAYED_LIST [DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]] is
			-- Get list of feature clauses relevant to .NET type with name 'a_type'.
		require
			a_type_not_void: a_type /= Void
			has_type_clauses: feature_clauses.has (a_type)
		do
			Result := feature_clauses.item (a_type)
		ensure
			result_not_void: Result /= Void
		end

	feature_clauses: HASH_TABLE [ARRAYED_LIST [DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]], STRING]
			-- List of features clauses for Current window hashed by the .NET name of the consumed_type.

	feature_positions: HASH_TABLE [INTEGER, E_FEATURE]
			-- Features indexed by line position in class text (for .NET features).

	feature_locating: BOOLEAN
			-- Is feature tool locating a feature?

feature {EB_WINDOW_MANAGER} -- Window management / Implementation

	destroy_imp is
			-- Destroy window.
		do
				-- To avoid reentrance
			if not is_destroying then
				is_destroying := True
					-- If a launched application is still running, kill it.
				if
					Eb_debugger_manager.application_is_executing
					and then Eb_debugger_manager.debugging_window = Current
				then
					Eb_debugger_manager.Application.kill
				else
					development_window_data.save_left_panel_layout (left_panel.save_to_resource)
					development_window_data.save_right_panel_layout (right_panel.save_to_resource)
				end
				development_window_data.save_left_panel_width (panel.split_position)
					-- Save width & height.
				development_window_data.save_size (window.width, window.height)
				development_window_data.save_window_state (window.is_minimized, window.is_maximized)
				development_window_data.save_position (window.x_position, window.y_position)
				left_panel.wipe_out
				right_panel.wipe_out
				development_window_data.save_show_search_options (search_tool.options_shown)
				hide

					-- Commit saves
				preferences.preferences.save_preferences

				toolbars_area.wipe_out
				address_manager.recycle
				project_customizable_toolbar.recycle
				refactoring_customizable_toolbar.recycle
				Precursor {EB_TOOL_MANAGER}

				managed_class_formatters.wipe_out
				managed_feature_formatters.wipe_out
				managed_main_formatters.wipe_out
				toolbarable_commands.wipe_out
				editors.wipe_out
				stone := Void
			end
		end

feature -- C output pixmap management

	start_c_output_pixmap_timer is
			-- Start timer to draw c output pixmap.
		do
			if context_tool /= Void then
				context_tool.start_c_output_pixmap_timer
			end
		end

	stop_c_output_pixmap_timer is
			-- Stop timer to draw c output pixmap.
		do
			if context_tool /= Void then
				context_tool.stop_c_output_pixmap_timer
			end
		end

feature {NONE} -- Implementation

	set_stone_after_check (a_stone: STONE) is
		local
			old_stone: STONE
			new_class_stone: CLASSI_STONE
			old_class_stone: CLASSI_STONE
			conv_classc: CLASSC_STONE
			conv_brkstone: BREAKABLE_STONE
			cluster_st: CLUSTER_STONE
			old_cluster_st: CLUSTER_STONE
			feature_stone: FEATURE_STONE
			conv_ferrst: FEATURE_ERROR_STONE

			ef_stone: EXTERNAL_FILE_STONE
			f: FILE

			conv_errst: ERROR_STONE
			cl_syntax_stone: CL_SYNTAX_STONE
			error_line: INTEGER
			class_file: RAW_FILE
			class_text_exists: BOOLEAN
			same_class: BOOLEAN
			test_stone: CLASSI_STONE
			conv_ace: ACE_SYNTAX_STONE
			externali: EXTERNAL_CLASS_I
			external_cons: CONSUMED_TYPE
			str: STRING
			dotnet_class: BOOLEAN
			l_short_formatter: EB_SHORT_FORMATTER
			l_flat_formatter: EB_FLAT_SHORT_FORMATTER
			l_main_formatter: EB_CLASS_TEXT_FORMATTER
			app_exec: APPLICATION_EXECUTION
		do
				-- the text does not change if the text was saved with syntax errors
			cur_wid := window
			if cur_wid = Void then
				--| Do nothing.
			else
				if old_cur = Void then
					old_cur := cur_wid.pointer_style
				end
	--				cur_wid.enable_capture
				cur_wid.set_pointer_style (Wait_cursor)
			end

			conv_brkstone ?= a_stone
			conv_errst ?= a_stone
			conv_ace ?= a_stone
			ef_stone ?= a_stone
			if conv_brkstone /= Void then
				app_exec := Debugger_manager.application
				if app_exec.is_breakpoint_enabled (conv_brkstone.routine, conv_brkstone.index) then
					app_exec.remove_breakpoint (conv_brkstone.routine, conv_brkstone.index)
				else
					app_exec.set_breakpoint (conv_brkstone.routine, conv_brkstone.index)
				end
				Debugger_manager.notify_breakpoints_changes
			elseif conv_errst /= Void then
				display_error_help_cmd.execute_with_stone (conv_errst)
			elseif conv_ace /= Void then
				--| FIXME XR: What should we do?!
			elseif ef_stone /= Void then
				f := ef_stone.file
				f.make_open_read (f.name)
				f.read_stream (f.count)
				f.close
				editor_tool.text_area.load_text (f.last_string)
			else
					-- Remember previous stone.
				old_stone := stone
				old_class_stone ?= stone
				old_cluster_st ?= stone

					-- New stone properties
				new_class_stone ?= a_stone

					-- Set the stone.
				old_set_stone (a_stone)
				cluster_st ?= a_stone

				new_feature_cmd.disable_sensitive
				toggle_feature_alias_cmd.disable_sensitive
				toggle_feature_signature_cmd.disable_sensitive
				toggle_feature_assigner_cmd.disable_sensitive

					-- We update the state of the `Add to Favorites' command.
				if new_class_stone /= Void then
					favorites_menu.first.enable_sensitive
				else
					favorites_menu.first.disable_sensitive
				end

					-- Update the address manager if needed.
				address_manager.refresh
				if new_class_stone /= Void then
						-- Text is now editable.
					editor_tool.text_area.set_read_only (False)

						-- class stone was dropped
					create class_file.make (new_class_stone.class_i.file_name)
					class_text_exists := class_file.exists
					feature_stone ?= a_stone
						--| We have to create a classi_stone to check whether the stones are really similar.
						--| Otherwise a redefinition of same_as may be called.
					create test_stone.make (new_class_stone.class_i)
					if test_stone.same_as (old_class_stone) then
						same_class := True
					end
					if not feature_stone_already_processed then
						if same_class and then text_saved then
								-- nothing changed in the editor
								-- we only have to update click_list
							if editor_tool.text_area.is_editable then
								editor_tool.text_area.update_click_list (False)
							end
						else
							if changed then
									-- user has already chosen not to save the file
									-- do not ask again
								Feature_positions.wipe_out
								editor_tool.text_area.no_save_before_next_load
							end
						end
					end

					conv_classc ?= new_class_stone

						-- First choose possible formatter
					l_main_formatter ?= new_class_stone.pos_container
					if l_main_formatter /= Void and not during_synchronization then
						if
							not (conv_classc /= Void and class_text_exists and (not changed or not same_class))
						then
							l_main_formatter.enable_select
						elseif feature_stone = Void then
							if l_main_formatter /= pos_container then
								l_main_formatter.enable_select
							end
							if new_class_stone.position > 0 then
								editor_tool.text_area.display_line_at_top_when_ready (new_class_stone.position)
							end
						end
					end

					if conv_classc = Void or else
						conv_classc.e_class.is_external or else
						feature_stone /= Void and not
						feature_stone_already_processed and not
						(same_class and context_tool.sending_stone) then
							-- If a classi_stone or a feature_stone or a external call
							-- has been dropped, check to see if a .NET class.
						if class_text_exists then
							if new_class_stone.class_i.is_external_class then
								externali ?= new_class_stone.class_i
								check
									externali_not_void: externali /= Void
								end
								external_cons := externali.external_consumed_type
								if external_cons /= Void then
									-- A .NET class.
									dotnet_class := True
									l_short_formatter ?= managed_main_formatters.i_th (4)
									l_flat_formatter ?= managed_main_formatters.i_th (5)
									if l_short_formatter /= Void then
										l_short_formatter.set_dotnet_mode (True)
									end
									if l_flat_formatter /= Void then
										l_flat_formatter.set_dotnet_mode (True)
									end
								end
							elseif feature_stone /= Void then
								from
									managed_main_formatters.start
								until
									managed_main_formatters.after
								loop
									managed_main_formatters.item.set_stone (new_class_stone)
									managed_main_formatters.forth
								end
							else
								managed_main_formatters.first.set_stone (new_class_stone)
								managed_main_formatters.first.execute
							end
						else
							editor_tool.text_area.clear_window
							editor_tool.text_area.display_message (
								Warning_messages.w_file_not_exist (
									new_class_stone.class_i.file_name))
						end
					end
					if conv_classc = Void then
							--| The dropped class is not compiled.
							--| Display only the textual formatter.
						if dotnet_class then
							managed_main_formatters.i_th (4).set_stone (new_class_stone)
							managed_main_formatters.i_th (5).set_stone (new_class_stone)
							managed_main_formatters.i_th (4).execute
						end
						address_manager.disable_formatters
					else
							--| We have a compiled class.
						if
							class_text_exists and then
							Eiffel_project.Workbench.last_reached_degree <= 2
						then
							new_feature_cmd.enable_sensitive
							toggle_feature_alias_cmd.enable_sensitive
							toggle_feature_signature_cmd.enable_sensitive
							toggle_feature_assigner_cmd.enable_sensitive
						end

						--address_manager.enable_formatters
						update_formatters
						if not class_text_exists then
								--| Disable the textual formatter.
							managed_main_formatters.first.disable_sensitive
							from
								managed_main_formatters.start
							until
								managed_main_formatters.after
							loop
								managed_main_formatters.item.set_stone (new_class_stone)
								managed_main_formatters.forth
							end
							if not is_stone_external then
								managed_main_formatters.i_th (2).execute
							end
						else
							if not changed or not same_class then
									--| Enable all formatters.
								if
									(not feature_stone_already_processed or
									not managed_main_formatters.first.selected) and
									feature_stone = Void
								then
									from
										managed_main_formatters.start
									until
										managed_main_formatters.after
									loop
										managed_main_formatters.item.set_stone (new_class_stone)
										managed_main_formatters.forth
									end
								end
							else
								if not feature_stone_already_processed then
									address_manager.disable_formatters
									from
										managed_main_formatters.start
									until
										managed_main_formatters.after
									loop
										managed_main_formatters.item.set_stone (new_class_stone)
										managed_main_formatters.forth
									end
								end
							end
						end
					end
					if not managed_main_formatters.first.selected then
						editor_tool.text_area.set_read_only (true)
					end
				else
						-- not a class text : cannot be edited
					editor_tool.text_area.set_read_only (True)
					address_manager.disable_formatters

						--| Disable all formatters.
					from
						managed_main_formatters.start
					until
						managed_main_formatters.after
					loop
						managed_main_formatters.item.set_stone (Void)
						managed_main_formatters.forth
					end
					if cluster_st /= Void then
	--| FIXME XR: Really manage cluster display in the main editor
						formatted_context_for_cluster (cluster_st.cluster_i)
						if cluster_st.position > 0 then
							editor_tool.text_area.display_line_at_top_when_ready (cluster_st.position)
						end
	--| END FIXME
					end
				end
				if class_text_exists then
					if feature_stone /= Void and not feature_stone_already_processed and not (same_class and context_tool.sending_stone) then
						conv_ferrst ?= feature_stone
						if conv_ferrst /= Void then
							error_line := conv_ferrst.line_number
						else
								-- if a feature_stone has been dropped
								-- scroll to the corresponding feature in the basic text format
							if not during_synchronization then
								scroll_to_feature (feature_stone.e_feature, new_class_stone.class_i)
							end
						end
					else
						cl_syntax_stone ?= a_stone
						if cl_syntax_stone /= Void then
							error_line := cl_syntax_stone.line
						end
					end
					if error_line > 0 then
							-- Scroll to the line of the error.
						editor_tool.text_area.display_line_when_ready (error_line, True)
					end
				end
					-- Update the title of the window
				if a_stone /= Void then
					if changed then
						str := a_stone.header.twin
						str.prepend ("* ")
						set_title (str)
					else
						set_title (a_stone.header)
					end
				else
					set_title (Interface_names.t_empty_development_window)
				end

					-- Refresh the tools.
				features_tool.set_stone (a_stone)
				cluster_tool.set_stone (a_stone)
					-- Update the context tool.
				if unified_stone then
					context_tool.set_stone (a_stone)
				end

			end
			if
				stone /= Void and then
				not unified_stone
			then
				send_stone_to_context_cmd.enable_sensitive
			else
				send_stone_to_context_cmd.disable_sensitive
			end
			if cur_wid = Void then
				--| Do nothing.
			else
				cur_wid.set_pointer_style (old_cur)
				old_cur := Void
	--					cur_wid.disable_capture
				cur_wid := Void
			end
		end

	formatted_context_for_cluster (a_cluster: CLUSTER_I) is
			-- Formatted context representing the list of classes inside `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			l_assembly: ASSEMBLY_I
			l_sorted_cluster: EB_SORTED_CLUSTER
			l_indexes: INDEXING_CLAUSE_AS
			l_classes: DS_LIST [CLASS_I]
			l_subclu: DS_LIST [EB_SORTED_CLUSTER]
			l_cl_i: CLASS_I
			l_list_cl_i: DS_LIST [CLASS_I]
			l_cluster: CLUSTER_I
			l_assert_level: ASSERTION_I
			l_format_context: TEXT_FORMATTER_DECORATOR
		do

			create l_format_context.make_for_case (editor_tool.text_area.text_displayed)
			editor_tool.text_area.handle_before_processing (false)
			l_format_context.process_keyword_text (ti_indexing_keyword, Void)
			l_format_context.put_new_line
			l_format_context.indent
			if a_cluster.is_assembly then
				l_assembly ?= a_cluster
				check l_assembly /= Void end
				l_format_context.process_indexing_tag_text ("assembly_name")
				l_format_context.set_without_tabs
				l_format_context.process_symbol_text (ti_colon)
				l_format_context.put_space
				l_format_context.put_quoted_string_item (l_assembly.assembly_name)
				l_format_context.put_new_line
				l_format_context.process_indexing_tag_text ("assembly_path")
				l_format_context.set_without_tabs
				l_format_context.process_symbol_text (ti_colon)
				l_format_context.put_space
				conf_todo
--				l_format_context.put_quoted_string_item (l_assembly.assembly_path)
				l_format_context.put_new_line

			end
			l_format_context.process_indexing_tag_text ("cluster")
			l_format_context.set_without_tabs
			l_format_context.process_symbol_text (ti_colon)
			l_format_context.put_space
			l_format_context.put_quoted_string_item (a_cluster.cluster_name)

			l_format_context.put_new_line
			l_format_context.process_indexing_tag_text ("cluster_path")
			l_format_context.set_without_tabs
			l_format_context.process_symbol_text (ti_colon)
			l_format_context.put_space
			l_format_context.put_quoted_string_item (a_cluster.path)
			l_format_context.put_new_line
			conf_todo
--			l_indexes := a_cluster.indexes
			if l_indexes /= Void then
				l_format_context.format_indexing_with_no_keyword (l_indexes)
				l_format_context.put_new_line
			end

			if a_cluster.parent_cluster /= Void then
				l_format_context.process_indexing_tag_text ("parent cluster")
				l_format_context.set_without_tabs
				l_format_context.process_symbol_text (ti_colon)
				l_format_context.put_new_line
				l_format_context.indent
				l_format_context.put_manifest_string (" - ")

				conf_todo
--				l_format_context.add_cluster (a_cluster.parent_cluster, a_cluster.parent_cluster.cluster_name)
				l_format_context.put_new_line
				l_format_context.exdent
			end

			create l_sorted_cluster.make (a_cluster)
			l_sorted_cluster.initialize

			if not l_sorted_cluster.clusters.is_empty then
				l_format_context.process_indexing_tag_text ("sub cluster(s)")
				l_format_context.set_without_tabs
				l_format_context.process_symbol_text (ti_colon)
				l_format_context.put_new_line
				l_format_context.indent
				from
					l_subclu := l_sorted_cluster.clusters
					l_subclu.start
				until
					l_subclu.after
				loop
					conf_todo
--					l_cluster := l_subclu.item.actual_cluster
--					l_format_context.put_manifest_string (" - ")
--					l_format_context.add_cluster (l_cluster, l_cluster.cluster_name)
--					l_format_context.put_space
--					l_format_context.set_without_tabs
--					l_format_context.process_symbol_text (ti_L_parenthesis)
--					l_format_context.process_comment_text (l_cluster.classes.count.out, Void)
--					l_format_context.set_without_tabs
--					l_format_context.process_symbol_text (ti_R_parenthesis)
--					l_format_context.put_new_line
					l_subclu.forth
				end
				l_format_context.exdent
			end

			if not l_sorted_cluster.classes.is_empty then
				l_format_context.process_indexing_tag_text ("class(es)")
				l_format_context.set_without_tabs
				l_format_context.process_symbol_text (ti_colon)
				l_format_context.put_new_line
				l_format_context.indent
				from
					l_classes := l_sorted_cluster.classes
					l_classes.start
				until
					l_classes.after
				loop
					l_cl_i := l_classes.item_for_iteration
					l_assert_level := l_cl_i.assertion_level
					l_format_context.put_manifest_string (" - ")
					l_format_context.put_classi (l_cl_i)
					l_format_context.set_without_tabs
					l_format_context.process_symbol_text (ti_colon)
					if l_cl_i.compiled then
						if l_assert_level.check_all then
							l_format_context.put_space
							l_format_context.set_without_tabs
							l_format_context.process_keyword_text (ti_All_keyword, Void)
						elseif l_assert_level.level = 0  then
							l_format_context.put_space
							l_format_context.process_comment_text (once "None", Void)
						else
							if l_assert_level.check_precond then
								l_format_context.put_space
								l_format_context.set_without_tabs
								l_format_context.process_keyword_text (ti_Require_keyword, Void)
							end
							if l_assert_level.check_postcond then
								l_format_context.put_space
								l_format_context.set_without_tabs
								l_format_context.process_keyword_text (ti_Ensure_keyword, Void)
							end
							if l_assert_level.check_check then
								l_format_context.put_space
								l_format_context.set_without_tabs
								l_format_context.process_keyword_text (ti_Check_keyword, Void)
							end
							if l_assert_level.check_loop then
								l_format_context.put_space
								l_format_context.set_without_tabs
								l_format_context.process_keyword_text (ti_Loop_keyword, Void)
							end
							if l_assert_level.check_invariant then
								l_format_context.put_space
								l_format_context.set_without_tabs
								l_format_context.process_keyword_text (ti_Invariant_keyword, Void)
							end
						end
					else
						l_format_context.process_comment_text (" Not in system.", Void)
					end
					l_format_context.put_new_line
					l_classes.forth
				end
				l_format_context.exdent
			end

			conf_todo
--			if not a_cluster.overriden_classes.is_empty then
--				l_format_context.process_indexing_tag_text ("overriden class(es)")
--				l_format_context.set_without_tabs
--				l_format_context.process_symbol_text (ti_colon)
--				l_format_context.put_new_line
--				l_format_context.indent
--				from
--					l_classes := a_cluster.overriden_classes.linear_representation
--					l_classes.start
--				until
--					l_classes.after
--				loop
--					l_cl_i := l_classes.item
--					l_format_context.put_manifest_string (" - ")
--					l_format_context.put_classi (l_cl_i)
--					l_list_cl_i := eiffel_universe.classes_with_name (l_cl_i.name)
--					if l_list_cl_i /= Void and then not l_list_cl_i.is_empty then
--						l_format_context.set_without_tabs
--						l_format_context.process_symbol_text (ti_colon)
--						l_format_context.process_comment_text (" overriden by", Void)
--						from
--							l_list_cl_i.start
--						until
--							l_list_cl_i.after
--						loop
--							l_cluster := l_list_cl_i.item.cluster
--							if l_cluster /= a_cluster then
--								l_format_context.put_space
--								l_format_context.set_without_tabs
--								l_format_context.process_symbol_text (ti_double_quote)
--								l_format_context.add_cluster (l_list_cl_i.item.cluster, l_list_cl_i.item.cluster.cluster_name)
--								l_format_context.set_without_tabs
--								l_format_context.process_symbol_text (ti_double_quote)
--							end
--							l_list_cl_i.forth
--						end
--					end
--					l_format_context.put_new_line
--					l_classes.forth
--				end
--				l_format_context.exdent
--				l_format_context.put_new_line
--			end

			l_format_context.exdent
			l_format_context.put_new_line
			editor_tool.text_area.handle_after_processing
		end

	scroll_to_feature (feat_as: E_FEATURE; displayed_class: CLASS_I) is
			-- highlight the feature correspnding to `feat_as' in the class represented by `displayed_class'
		require
			class_is_not_void: displayed_class /= Void
			feat_as_is_not_void: feat_as /= Void
		local
			begin_index, offset: INTEGER
			tmp_text: STRING
		do
			if not feat_as.is_il_external then
				if not managed_main_formatters.first.selected then
					if feat_as.ast /= Void then
						editor_tool.text_area.find_feature_named (feat_as.name)
					end
				else
					if feat_as.ast /= Void then
						begin_index := feat_as.ast.start_position
						tmp_text := displayed_class.text.substring (1, begin_index)
						offset := tmp_text.occurrences('%R')
						editor_tool.text_area.scroll_to_when_ready (begin_index.item - offset)
					end
				end
			else
				if not managed_main_formatters.first.selected then
					managed_main_formatters.first.execute
				end
					-- FIXME NC: Doesn't work properly for .NET features
					-- .NET formatted feature.
				begin_index := feature_positions.item (feat_as)
				if platform_constants.is_windows then
					tmp_text := displayed_class.text.substring (1, begin_index)
					offset := tmp_text.occurrences('%N')
				end
				editor_tool.text_area.scroll_to_when_ready (begin_index // 2) -- - offset)
			end
		end

	check_passed: BOOLEAN

	save_canceled: BOOLEAN
		-- did user cancel save ?

	save_only: BOOLEAN
		-- skip parse and update after save ?

	text_saved: BOOLEAN
			-- has the user chosen to save the file

	is_destroying: BOOLEAN
			-- Is `current' being currently destroyed?

	feature_stone_already_processed: BOOLEAN
			-- Is the processed stone a feature stone and has it
			-- been already processed by the editor ?

feature {NONE} -- Implementation

	update_save_symbol is
		do
			Precursor {EB_FILEABLE}
			if changed then
				save_cmd.enable_sensitive
				address_manager.disable_formatters
			else
				save_cmd.disable_sensitive
				update_formatters
			end
			if is_empty then
				print_cmd.disable_sensitive
				save_as_cmd.disable_sensitive
			else
				print_cmd.enable_sensitive
				save_as_cmd.enable_sensitive
			end
		end

	is_stone_external: BOOLEAN
			-- Does 'stone' contain a .NET consumed type?

	update_formatters is
			-- Give a correct sensitivity to formatters.
		local
			cist: CLASSI_STONE
			cst: CLASSC_STONE
			type_changed: BOOLEAN
		do
			cst ?= stone
			cist ?= stone
			-- Check to if formatting context has changed.
			if cst /= Void then
				type_changed := (cst.e_class.is_true_external and not is_stone_external) or
					(not cst.e_class.is_true_external and is_stone_external)
			elseif cist /= Void then
				type_changed := (cist.class_i.is_external_class and not is_stone_external) or
					(not cist.class_i.is_external_class and is_stone_external)
			end

			if type_changed then
					-- Toggle stone flag.
				is_stone_external := not is_stone_external
			end

			if cst /= Void then
				address_manager.enable_formatters
				if is_stone_external then
						-- Change formatters to .NET sensitivity (from normal).
					enable_dotnet_formatters
					if type_changed then
						managed_main_formatters.i_th (4).enable_select
					end
				else
					if changed then
						address_manager.disable_formatters
					else
						--managed_main_formatters.first.disable_sensitive
					end
				end
			elseif cist /= Void and is_stone_external then
					-- Change formatters to .NET sensitivity (from normal).
				enable_dotnet_formatters
				if type_changed then
					managed_main_formatters.i_th (4).enable_select
				end
			else
				address_manager.disable_formatters
				if cist /= stone then
					managed_main_formatters.first.execute
				end
			end
		end

	enable_dotnet_formatters is
			-- Enable only the .NET class text formatters.
		local
			l_formatters: like managed_main_formatters
		do
			l_formatters := managed_main_formatters.twin
			from
				l_formatters.start
			until
				l_formatters.after
			loop
				if l_formatters.item.is_dotnet_formatter then
					l_formatters.item.enable_sensitive
				else
					l_formatters.item.disable_sensitive
				end
				l_formatters.forth
			end
		end

	on_text_reset is
			-- The main editor has just been wiped out
			-- before loading a new file.
		local
			str: STRING
		do
			str := title.twin
			if str @ 1 = '*' then
				str.keep_tail (str.count - 2)
				set_title (str)
			end
			address_manager.disable_formatters
			status_bar.reset
			status_bar.remove_cursor_position
			text_edited := False
		end

	on_cursor_moved is
			-- The cursor has moved, reflect the change in the status bar.
			-- And reflect location editing in the text in features tool and address bar.
		do
			refresh_cursor_position
			if context_refreshing_timer = Void then
				create context_refreshing_timer.make_with_interval (100)
				context_refreshing_timer.actions.extend (agent refresh_context_info)
			end
			if feature_locating then
				context_refreshing_timer.set_interval (0)
			else
				context_refreshing_timer.set_interval (100)
			end

		end

	on_text_fully_loaded is
			-- The main editor has just been reloaded.
		do
			update_paste_cmd
			update_formatters
			if editor_tool.text_area.syntax_is_correct then
				status_bar.reset
			else
				status_bar.display_message (Interface_names.L_syntax_error)
			end
			refresh_cursor_position
			text_edited := False
		end

	on_text_back_to_its_last_saved_state is
		local
			str: STRING
		do
			str := title.twin
			if str @ 1 = '*' then
				str.keep_tail (str.count - 2)
				set_title (str)
			end
			update_formatters
			text_edited := False
		end

	text_edited: BOOLEAN
			-- Do we know that the text was edited?
			-- If so, no need to update the display each time it is edited.

	on_text_edited (unused: BOOLEAN) is
			-- The text in the editor is modified, add the '*' in the title.
			-- Gray out the formatters.
		local
			str: STRING
			cst: CLASSI_STONE
		do
			if not text_edited then
				str := title.twin
				if str @ 1 /= '*' then
					str.prepend ("* ")
					set_title (str)
				end
				address_manager.disable_formatters
				cst ?= stone
				if cst /= Void then
					Eiffel_project.Manager.class_is_edited (cst.class_i)
				end
				text_edited := True
			end
			if not status_bar.message.is_equal (interface_names.e_c_compilation_running) then
					-- We don't want the "Background C compilation in progress" message flash every time
					-- user presses a key.
				status_bar.display_message ("")
			end
		end

	on_back is
			-- User pressed Alt+left.
			-- Go back in the history (or the context history).
		do
			if context_tool_has_focus then
				if context_tool.history_manager.is_back_possible then
					context_tool.history_manager.back_command.execute
				end
			elseif history_manager.is_back_possible then
				history_manager.back_command.execute
			end
		end

	on_forth is
			-- User pressed Alt+right.
			-- Go forth in the history (or the context history).
		do
			if context_tool_has_focus then
				if context_tool.history_manager.is_forth_possible then
					context_tool.history_manager.forth_command.execute
				end
			elseif history_manager.is_forth_possible then
				history_manager.forth_command.execute
			end
		end

	context_tool_has_focus: BOOLEAN is
			-- Does the context tool or one of its children has the focus?
		local
			fw: EV_WIDGET
			cont: EV_CONTAINER
			wid: EV_WIDGET
		do
			fw := (create {EV_ENVIRONMENT}).application.focused_widget
			wid := context_tool.explorer_bar_item.widget
			if wid = fw then
				Result := True
			elseif fw = Void then
				Result := False
			else
				from
					cont := fw.parent
				until
					cont = wid or cont = Void
				loop
					cont := cont.parent
				end
				if cont = wid then
					Result := True
				end
			end
		end

	saved_cursor: CURSOR
			-- Saved cursor position for displaying the stack.

	can_drop (st: ANY): BOOLEAN is
			-- Can the user drop the stone `st'?
		local
			conv_ace: ACE_SYNTAX_STONE
		do
			conv_ace ?= st
			Result := conv_ace = Void
		end

	send_stone_to_context is
			-- Send current stone to the context tool.
			-- Used by `send_stone_to_context_cmd'.
		do
			if stone /= Void then
				context_tool.set_stone (stone)
			end
		end

	destroy is
			-- check if current text has been saved and destroy
		local
			dialog_w: EV_WARNING_DIALOG
		do
			if Window_manager.development_windows_count > 1 and then process_manager.is_external_command_running and then Current = external_output_manager.target_development_window then
				process_manager.confirm_external_command_termination (agent terminate_external_command_and_destroy, agent do_nothing, window)
			else
				if editor_tool /= Void and then editor_tool.text_area /= Void and then changed and then not confirmed then
					if Window_manager.development_windows_count > 1 then
						create dialog_w.make_with_text (Warning_messages.w_save_before_closing)
						dialog_w.set_buttons_and_actions (<<"Yes", "No", "Cancel">>, <<agent save_and_destroy, agent force_destroy, agent do_nothing>>)
						dialog_w.set_default_push_button (dialog_w.button("Yes"))
						dialog_w.set_default_cancel_button (dialog_w.button("Cancel"))
						dialog_w.show_modal_to_window (window)
					else
							-- We let the window manager handle the saving, along with other windows
							-- (not development windows)
						force_destroy
					end
				else
					Precursor {EB_TOOL_MANAGER}
					if context_refreshing_timer /= Void then
						context_refreshing_timer.destroy
						context_refreshing_timer := Void
					end
				end
			end
		end

	terminate_external_command_and_destroy is
			-- Terminate running external command and destroy.
		do
			process_manager.terminate_external_command
			destroy
		ensure
			external_command_not_running: not process_manager.is_external_command_running
		end

	save_and_destroy is
		do
			save_text
			destroy
		end

	force_destroy is
			-- Destroy without asking.
		do
			confirmed := True
			destroy
			confirmed := False
		end

	confirmed: BOOLEAN
			-- Did the user say he wanted to exit?

	show_dynamic_library_dialog is
			-- Create a new dynamic library window and display it.
		do
			Window_manager.create_dynamic_lib_window
		end

	context_refreshing_timer: EV_TIMEOUT

	recycle is
			-- Call the precursors.
		do
			Precursor {EB_TOOL_MANAGER}
			command_controller.recycle
			if refactoring_manager /= Void then
				refactoring_manager.destroy
			end
		end

feature {NONE} -- Implementation: Editor commands

	refresh_cursor_position is
			-- Display the current cursor position in the status bar.
		require
			text_loaded: not is_empty
		local
			l, c, v: INTEGER
		do
			l := editor_tool.text_area.cursor_y_position
			c := editor_tool.text_area.cursor_x_position
			v := editor_tool.text_area.cursor_visible_x_position
			status_bar.set_cursor_position (l, c, v)
		end

	refresh_context_info is
			-- Refresh address bar and features tool to relect
			-- where in the code the cursor is located.
		local
			l_feature: FEATURE_AS
			l_classc_stone: CLASSC_STONE
		do
			context_refreshing_timer.set_interval (0)
			l_classc_stone ?= stone
			if l_classc_stone /= Void then
				l_feature := editor_tool.text_area.text_displayed.current_feature_containing
				if l_feature /= Void then
					set_editing_location_by_feature (l_feature)
				else
					set_editing_location_by_feature (Void)
				end
			end
		end

	set_editing_location_by_feature (a_feature: FEATURE_AS) is
			-- Set editing location, feature tool and combo box changes according to `a_feature'.
		local
			l_efeature: E_FEATURE
			l_class_i: CLASS_I
			l_classc: CLASS_C
		do
			if a_feature /= Void then
				address_manager.set_feature_text_simply (a_feature.feature_names.first.internal_name)
				l_class_i := eiffel_universe.class_named (class_name, group)
				if l_class_i /= Void and then l_class_i.is_compiled then
					l_classc := l_class_i.compiled_class
					if l_classc.has_feature_table then
						l_efeature := l_classc.feature_with_name (a_feature.feature_names.first.internal_name)
					end
				end
			else
				address_manager.set_feature_text_simply (once "")
			end
			seek_item_in_feature_tool (l_efeature)
		end

	seek_item_in_feature_tool (a_feature: E_FEATURE) is
			-- Seek and select item contains data of `a_feature' in features tool.
			-- If `a_feature' is void, deselect item in features tool.
		do
			features_tool.seek_item_in_feature_tool (a_feature)
		end

	select_all is
			-- Select the whole text in the focused editor.
		do
			current_editor.select_all
		end

	search is
			-- Search some text in the focused editor.
		local
			cv_ced: EB_CLICKABLE_EDITOR
		do
			cv_ced ?= current_editor
			if cv_ced /= Void then
				cv_ced.search
			end
		end

	goto is
			-- Display a dialog to select a line to go to in the editor.
		local
			ed: EB_EDITOR
		do
			ed ?= current_editor
			if ed /= Void then
				create goto_dialog.make (ed)
				goto_dialog.show_modal_to_window (Current.window)
			end
		end

	toggle_line_number_display is
			-- Toggle line number display on/off in editor
		do
			preferences.editor_data.show_line_numbers_preference.set_value (not preferences.editor_data.show_line_numbers)
		end

	find_next is
			-- Find the next occurrence of the search text.
		local
			cv_ced: EB_CLICKABLE_EDITOR
		do
			if search_tool.currently_searched /= Void then
				cv_ced ?= current_editor
				if cv_ced /= Void then
					cv_ced.find_next
				end
			else
				search_tool.show_and_set_focus
			end
		end

	find_previous is
			-- Find the previous occurrence of the search text.
		local
			cv_ced: EB_CLICKABLE_EDITOR
		do
			if search_tool.currently_searched /= Void then
				cv_ced ?= current_editor
				if cv_ced /= Void then
					cv_ced.find_previous
				end
			else
				search_tool.show_and_set_focus
			end
		end

	find_selection is
			-- Find the next occurrence of the selection.
		local
			cv_ced: EB_CLICKABLE_EDITOR
		do
			cv_ced ?= current_editor
			if cv_ced /= Void then
				cv_ced.find_selection
			end
		end

	cut_selection is
			-- Cut the selection in the current editor.
		do
			current_editor.cut_selection
		end

	copy_selection is
			-- Cut the selection in the current editor.
		do
			current_editor.copy_selection
		end

	toggle_formatting_marks is
			-- Show/Hide formatting marks in the editor and update related menu item.
		do
			current_editor.toggle_view_invisible_symbols
			if current_editor.view_invisible_symbols then
				formatting_marks_command_menu_item.set_text (Interface_names.m_hide_formatting_marks)
			else
				formatting_marks_command_menu_item.set_text(Interface_names.m_show_formatting_marks)
			end
		end

feature {NONE} -- Implementation / Menus

	number_of_displayed_external_commands: INTEGER
			-- Number of external commands in the tools menu.

	old_cur: EV_CURSOR
			-- Cursor saved while displaying the hourglass cursor.

	cur_wid: EV_WIDGET
			-- Widget on which the hourglass cursor was set.

	project_menu: EV_MENU
			-- Menu for entries relative to the Project.

	recent_projects_menu: EB_RECENT_PROJECTS_MANAGER_MENU
			-- SubMenu for recent projects.

	during_synchronization: BOOLEAN
			-- Are we during a resynchronization?

	formatting_marks_command_menu_item: EB_COMMAND_MENU_ITEM
			-- Menu item used to shw/hide formatting marks.

	undo_accelerator: EV_ACCELERATOR
			-- Accelerator for Ctrl+Z

	redo_accelerator: EV_ACCELERATOR
			-- Accelerator for Ctrl+Y

feature {EB_TOOL} -- Implementation / Commands

	shell_cmd: EB_OPEN_SHELL_COMMAND
			-- Command to use an external editor.

	undo_cmd: EB_UNDO_COMMAND
			-- Command to undo in the editor.

	redo_cmd: EB_REDO_COMMAND
			-- Command to redo in the editor.

	editor_cut_cmd: EB_ON_SELECTION_COMMAND
			-- Command to cut text in the editor.

	editor_copy_cmd: EB_ON_SELECTION_COMMAND
			-- Command to copy text in the editor.

	editor_paste_cmd: EB_EDITOR_PASTE_COMMAND
			-- Command to paste text in the editor.

	melt_cmd: EB_MELT_PROJECT_COMMAND
			-- Command to start compilation.

feature{EB_TOOL, EB_C_COMPILER_LAUNCHER}

	c_workbench_compilation_cmd: EB_C_COMPILATION_COMMAND
			-- Command to compile the workbench C code.

	c_finalized_compilation_cmd: EB_C_COMPILATION_COMMAND
			-- Command to compile the finalized C code.

feature{EB_TOOL}

	new_cluster_cmd: EB_NEW_CLUSTER_COMMAND
			-- Command to create a new cluster.

	new_class_cmd: EB_NEW_CLASS_COMMAND
			-- Command to create a new class.

	new_feature_cmd: EB_NEW_FEATURE_COMMAND
			-- Command to execute the feature wizard.

	toggle_feature_alias_cmd: EB_TOGGLE_FEATURE_ALIAS_COMMAND
			-- Show/Hide alias name of feature node in eb_feature_tool

	toggle_feature_signature_cmd: EB_TOGGLE_FEATURE_SIGNATURE_COMMAND
			-- Show/Hide signature of feature node in eb_feature_tool

	toggle_feature_assigner_cmd: EB_TOGGLE_FEATURE_ASSIGNER_COMMAND
			-- Show/Hide assigner name of feature node in eb_feature_tool

	toggle_stone_cmd: EB_UNIFY_STONE_CMD
			-- Command to toggle between the stone management modes.

	delete_class_cluster_cmd: EB_DELETE_CLASS_CLUSTER_COMMAND
			-- Command to remove a class or a cluster from the system
			-- (permanent deletion).

	show_profiler: EB_SHOW_PROFILE_TOOL
			-- What allows us to display the profiler window.

	toolbarable_commands: ARRAYED_LIST [EB_TOOLBARABLE_COMMAND]
			-- All commands that can be put in a toolbar.

	command_controller: EB_EDITOR_COMMAND_CONTROLLER
			-- Object that takes care of updating the sensitivity of all editor commands.

	save_as_cmd: EB_SAVE_FILE_AS_COMMAND
			-- Command to save a class with a different file name.

feature{EB_TOOL, EB_EXTERNAL_OUTPUT_TOOL}

	Edit_external_commands_cmd: EB_EXTERNAL_COMMANDS_EDITOR is
			-- Command that lets the user add new external commands to the tools menu.
		once
			create Result.make
			Result.enable_sensitive
		end

feature{EB_TOOL}

	system_info_cmd: EB_STANDARD_CMD is
			-- Command to display information about the system (root class,...)
		do
			Result := Eb_debugger_manager.system_info_cmd
		end

	display_error_help_cmd: EB_ERROR_INFORMATION_CMD is
			-- Command to pop up a dialog giving help on compilation errors.
		do
			Result := Eb_debugger_manager.display_error_help_cmd
		end

	send_stone_to_context_cmd: EB_STANDARD_CMD
			-- Command to send the current stone to the context tool.

	print_cmd: EB_PRINT_COMMAND
			-- Command to print the content of editor with focus

	eac_browser_cmd: EB_OPEN_EAC_BROWSER_CMD is
			-- Command to display the eac browser
		do
			Result := Eb_debugger_manager.eac_browser_cmd
		end

	show_favorites_menu_item: EV_MENU_ITEM
			-- Show/Hide favorites menu item.

	update_show_favorites_menu_item is
			-- Update `show_favorites_menu_item' menu label.
		do
			if favorites_tool.shown then
				show_favorites_menu_item.set_text (Interface_names.m_hide_favorites)
			else
				show_favorites_menu_item.set_text (Interface_names.m_show_favorites)
			end
		end

	execute_show_favorites is
			-- Show `favorites_tool' if it is closed, close
			-- it in the opposite case.
		do
			update_show_favorites_menu_item
			if favorites_tool.shown then
				favorites_tool.close
			else
				favorites_tool.show
			end
		end

feature {EB_TOOL_WINDOW, EB_EXPLORER_BAR, EB_DEBUGGER_MANAGER} -- Floating tool handling

	all_tool_windows: ARRAYED_LIST [EB_TOOL_WINDOW]
		-- All tool windows under the control of `Current'.

	add_tool_window (a_tool_window: EB_TOOL_WINDOW) is
			-- Add `a_tool_window' to `all_tool_windows', ensuring it is
			-- then under the control of `Current'.
		require
			a_tool_window_not_void: a_tool_window /= Void
		do
			if all_tool_windows = Void then
				create all_tool_windows.make (2)
			end
			all_tool_windows.extend (a_tool_window)
		ensure
			extended: all_tool_windows.has (a_tool_window)
		end

	remove_tool_window (a_widget: EV_WIDGET) is
			-- Remove tool window associate with `a_widget'.
		require
			a_widget_not_void: a_widget /= Void
		do
			if all_tool_windows /= Void then
				from
					all_tool_windows.start
				until
					all_tool_windows.off
				loop
					if all_tool_windows.item.tool = a_widget then
						all_tool_windows.remove
						all_tool_windows.finish
					end
					all_tool_windows.forth
				end
			end
		end

	remove_all_tool_windows is
			-- Ensure `all_tool_windows' is empty if non Void.
		do
			if all_tool_windows /= Void then
				all_tool_windows.wipe_out
			end
		ensure
			tool_windows_empty: all_tool_windows /= Void implies all_tool_windows.is_empty
		end

	window_moved (x_pos, y_pos: INTEGER) is
			-- `Current' has been moved, so move all associated tool windows within `all_tool_windows'.
		local
			tool_window: EB_TOOL_WINDOW
		do
			if all_tool_windows /= Void then
				from
					all_tool_windows.start
				until
					all_tool_windows.off
				loop
					tool_window := all_tool_windows.item
					check
						not_destroyed: not tool_window.window.is_destroyed
					end
					if preferences.development_window_data.dock_tracking then
						tool_window.window.move_actions.block
						tool_window.window.set_x_position (x_pos + tool_window.x_position)
						tool_window.window.set_y_position (y_pos + tool_window.y_position)
						tool_window.window.move_actions.resume
					else
							-- If we are not performing dock tracking, we must update the relative position
							-- of the tool window, so that if dock tracking is enabled, the relative
							-- positions are correct.
						tool_window.set_x_position ( tool_window.window.screen_x - x_pos)
						tool_window.set_y_position ( tool_window.window.screen_y - y_pos)
					end
					all_tool_windows.forth
				end
			end
		end

feature {NONE} -- Execution

	toolbar_right_click_action (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Action called when the user right-click in the toolbar.
			-- Display a popup menu to show/hide toolbars and customize the general toolbar.
		local
			popup_menu: EV_MENU
		do
			if a_button = 3 then
				popup_menu := build_toolbar_menu
				popup_menu.show
			end
		end

	enable_commands_on_project_created is
			-- Enable commands when a new project has been created (not yet compiled)
		do
			system_info_cmd.enable_sensitive
			if
				stone /= Void and then
				not unified_stone
			then
				send_stone_to_context_cmd.enable_sensitive
			end
		end

	enable_commands_on_project_loaded is
			-- Enable commands when a new project has been created and compiled
		do
			if has_profiler then
				show_profiler.enable_sensitive
			end
			if has_dll_generation then
				show_dynamic_lib_tool.enable_sensitive
			end
			open_cmd.enable_sensitive
			new_class_cmd.enable_sensitive
			new_cluster_cmd.enable_sensitive
			system_info_cmd.enable_sensitive
			if unified_stone then
				send_stone_to_context_cmd.disable_sensitive
			elseif stone /= Void then
				send_stone_to_context_cmd.enable_sensitive
			end
			new_class_cmd.enable_sensitive
			new_cluster_cmd.enable_sensitive
			delete_class_cluster_cmd.enable_sensitive
			c_workbench_compilation_cmd.enable_sensitive
			c_finalized_compilation_cmd.enable_sensitive
			refactoring_manager.enable_sensitive
		end

	disable_commands_on_project_unloaded is
			-- Enable commands when a project has been closed.
		do
			if has_dll_generation then
				show_dynamic_lib_tool.disable_sensitive
			end
			if has_profiler then
				show_profiler.disable_sensitive
			end
			open_cmd.disable_sensitive
			new_class_cmd.disable_sensitive
			new_cluster_cmd.disable_sensitive
			if not project_manager.is_created then
				system_info_cmd.disable_sensitive
				send_stone_to_context_cmd.disable_sensitive
			end
			delete_class_cluster_cmd.disable_sensitive
			c_workbench_compilation_cmd.disable_sensitive
			c_finalized_compilation_cmd.disable_sensitive
			refactoring_manager.disable_sensitive
			refactoring_manager.forget_undo_redo
		end

feature {NONE} -- Access

	development_window_data: EB_DEVELOPMENT_WINDOW_DATA is
			-- Meta data describing `Current'.
		do
			if internal_development_window_data /= Void then
				Result := internal_development_window_data
			else
				Result := preferences.development_window_data
			end
		end

	internal_development_window_data: EB_DEVELOPMENT_WINDOW_SESSION_DATA;
		-- Internal custom meta data for `Current'.

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

end -- class EB_DEVELOPMENT_WINDOW
