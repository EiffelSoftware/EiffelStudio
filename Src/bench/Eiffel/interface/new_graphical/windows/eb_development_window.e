indexing
	description	: "Window holding a project tool"
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	EB_DEVELOPMENT_WINDOW

inherit
	EB_TOOL_MANAGER
		redefine
			make,
			init_size_and_position,
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
			destroy
		end

	EB_FILEABLE
		redefine
			set_stone,
			reset,
			stone,
			on_text_saved,
			perform_check_before_save,
			check_passed,
			update_save_symbol
		select
			set_stone
		end

	EB_FILEABLE
		rename
			set_stone as old_set_stone
		export {NONE}
			old_set_stone
		redefine
			reset,
			stone,
			on_text_saved,
			perform_check_before_save,
			check_passed,
			update_save_symbol
		end


		-- Shared tools & contexts
	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

	EB_SHARED_MANAGERS

	EB_SHARED_GRAPHICAL_COMMANDS

		-- Ressources
	EB_RESOURCE_USER

	EB_PROJECT_TOOL_DATA

	EB_GENERAL_DATA

	EV_STOCK_PIXMAPS

	EB_CONFIRM_SAVE_CALLBACK

		-- Errors
	EB_GRAPHICAL_ERROR_MANAGER

	TEXT_OBSERVER
		redefine
			on_text_reset, on_text_edited, 
			on_selection_begun, on_selection_finished,
			on_text_back_to_its_last_saved_state,
			on_text_fully_loaded,
			on_text_loaded
		end

		-- To warn editor commands to refresh their state when the current editor changes.
	TEXT_OBSERVER_MANAGER
		rename
			changed as text_changed,
			remove_observer as text_remove_observer,
			make as text_make
		undefine
			on_block_removed,
			on_text_block_loaded,
			on_line_inserted, on_line_modified, on_line_removed
		redefine
			on_selection_begun, on_selection_finished,
			on_text_back_to_its_last_saved_state,
			on_text_edited, on_text_fully_loaded, on_text_loaded, on_text_reset,
			recycle
		end

	EB_FORMATTER_DATA

	EB_SHARED_EDITOR_DATA
	
	EV_KEY_CONSTANTS
		export
			{NONE} All
		end

creation {EB_WINDOW_MANAGER}
	make,
	make_as_context_tool,
	make_as_editor

feature {NONE} -- Initialization

	make_as_context_tool is
			-- Create a new development window and expand the context tool.
		do
			make
			if not context_tool.shown then
				context_tool.show
			end
			if not unified_stone then
				toggle_stone_cmd.execute
			end
			context_tool.explorer_bar_item.maximize
		end

	make_as_editor is
			-- Create a new development window and expand the editor tool.
		do
			make
			editor_tool.explorer_bar_item.maximize
		end

	make is
			-- Create a new development window.
		do
			text_make
			unified_stone := context_unified_stone
				-- Build the history manager, the address manager, ...
			create history_manager.make (Current)
			create address_manager.make (Current, False)
			build_formatters
			address_manager.set_formatters (managed_main_formatters)

				-- Register to the preferences manager
			register

				-- Init commands, build interface, build menus, ...
			Precursor

			initialized := False -- Reset the flag since initialization is not yet complete.

				-- Update widgets visibilities
			update

				-- Finish initializing the main editor formatters
			end_build_formatters

			initialized := True
			is_destroying := False
		end
	
	init_size_and_position is
			-- Initialize window size.
		local
			default_width, default_height: INTEGER
			screen: EV_SCREEN
		do
			create screen
			default_width := window_preferences.width.min (screen.width)
			default_height := window_preferences.height.min (screen.height)
			window.set_size (default_width, default_height)

				-- Maximize window if needed.
			if window_preferences.is_maximized then
				window.maximize
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
				show_dynamic_lib_tool.set_menu_name (Interface_names.m_New_dynamic_lib)
				show_dynamic_lib_tool.add_agent (~show_dynamic_library_dialog)
			end
			if has_profiler then
				create show_profiler
			end
			if Eiffel_project.manager.is_project_loaded then
				if has_dll_generation then
					show_dynamic_lib_tool.enable_sensitive
				end
				if has_profiler then
					show_profiler.enable_sensitive
				end
			else
				if has_dll_generation then
					show_dynamic_lib_tool.disable_sensitive
				end
				if has_profiler then
					show_profiler.disable_sensitive
				end
			end

				-- Undo/redo, cut, copy, paste.
			create undo_cmd.make (Current)
			toolbarable_commands.extend (undo_cmd)

			create redo_cmd.make (Current)
			toolbarable_commands.extend (redo_cmd)

			create editor_cut_cmd.make (Current)
			toolbarable_commands.extend (editor_cut_cmd)

			create editor_copy_cmd.make (Current)
			toolbarable_commands.extend (editor_copy_cmd)

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

			create toggle_stone_cmd.make (Current)
			toolbarable_commands.extend (toggle_stone_cmd)

			create send_stone_to_context_cmd.make
			send_stone_to_context_cmd.set_pixmaps (Pixmaps.Icon_send_stone_down)
			send_stone_to_context_cmd.set_tooltip (Interface_names.e_Send_stone_to_context)
			send_stone_to_context_cmd.set_menu_name (Interface_names.m_Send_stone_to_context)
			send_stone_to_context_cmd.set_name ("Send_to_context")
			send_stone_to_context_cmd.add_agent (~send_stone_to_context)
			create accel.make_with_key_combination (
				create {EV_KEY}.make_with_code (Kcst.Key_down), False, True, False
			)
			accel.actions.extend (~send_stone_to_context)
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

			from
				toolbarable_commands.start
			until
				toolbarable_commands.after
			loop
				if toolbarable_commands.item.accelerator /= Void then
					window.accelerators.extend (toolbarable_commands.item.accelerator)
				end
				toolbarable_commands.forth
			end

			from
				debugger_manager.toolbarable_commands.start
			until
				debugger_manager.toolbarable_commands.after
			loop
				if
					debugger_manager.toolbarable_commands.item.accelerator /= Void
				then
					window.accelerators.extend (debugger_manager.toolbarable_commands.item.accelerator)
				end
				debugger_manager.toolbarable_commands.forth
			end

				-- This command conflicts with the project toolbar one for accelerators.
			toolbarable_commands.extend (Run_project_cmd)

			window.focus_in_actions.extend(~on_focus)

			new_feature_cmd.disable_sensitive

				-- Disable commands if no project is loaded
			if not Eiffel_project.manager.is_project_loaded then
				disable_commands_on_project_unloaded
			elseif not Eiffel_project.manager.initialized then
			else
				enable_commands_on_project_loaded
			end

			create editors.make (5)
		end

	build_formatters is
			-- Build all formatters used.
		local
			form: EB_CLASS_TEXT_FORMATTER
			accel: EV_ACCELERATOR
		do
			create managed_class_formatters.make (10)
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
			managed_class_formatters.extend (create {EB_DEFERREDS_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_ONCES_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_EXTERNALS_FORMATTER}.make (Current))
			managed_class_formatters.extend (create {EB_EXPORTED_FORMATTER}.make (Current))

			create managed_feature_formatters.make (5)
			managed_feature_formatters.extend (create {EB_BASIC_FEATURE_FORMATTER}.make (Current))
			managed_feature_formatters.extend (create {EB_ROUTINE_FLAT_FORMATTER}.make (Current))
			managed_feature_formatters.extend (Void)
			managed_feature_formatters.extend (create {EB_CALLERS_FORMATTER}.make (Current))
			managed_feature_formatters.extend (create {EB_IMPLEMENTERS_FORMATTER}.make (Current))
			managed_feature_formatters.extend (create {EB_ROUTINE_ANCESTORS_FORMATTER}.make (Current))
			managed_feature_formatters.extend (create {EB_ROUTINE_DESCENDANTS_FORMATTER}.make (Current))
			managed_feature_formatters.extend (create {EB_HOMONYMS_FORMATTER}.make (Current))

			create managed_main_formatters.make (5)
			create {EB_BASIC_TEXT_FORMATTER} form.make (Current)
			create accel.make_with_key_combination (
					create {EV_KEY}.make_with_code (Kcst.Key_t),
					True, False, True)
			accel.actions.extend (form~execute)
			form.set_accelerator (accel)
			managed_main_formatters.extend (form)

			create {EB_CLICKABLE_FORMATTER} form.make (Current)
			create accel.make_with_key_combination (
					create {EV_KEY}.make_with_code (Kcst.Key_c),
					True, False, True)
			accel.actions.extend (form~execute)
			form.set_accelerator (accel)
			managed_main_formatters.extend (form)

			create {EB_FLAT_FORMATTER} form.make (Current)
			create accel.make_with_key_combination (
					create {EV_KEY}.make_with_code (Kcst.Key_f),
					True, False, True)
			accel.actions.extend (form~execute)
			form.set_accelerator (accel)
			managed_main_formatters.extend (form)

			create {EB_SHORT_FORMATTER} form.make (Current)
			create accel.make_with_key_combination (
					create {EV_KEY}.make_with_code (Kcst.Key_o),
					True, False, True)
			accel.actions.extend (form~execute)
			form.set_accelerator (accel)
			managed_main_formatters.extend (form)

			create {EB_FLAT_SHORT_FORMATTER} form.make (Current)
			create accel.make_with_key_combination (
					create {EV_KEY}.make_with_code (Kcst.Key_i),
					True, False, True)
			accel.actions.extend (form~execute)
			form.set_accelerator (accel)
			managed_main_formatters.extend (form)

			from
				managed_class_formatters.start
			until
				managed_class_formatters.after
			loop
				if managed_class_formatters.item /= Void then
					managed_class_formatters.item.enable_breakpoints
				end
				managed_class_formatters.forth
			end
			from
				managed_main_formatters.start
			until
				managed_main_formatters.after
			loop
				managed_main_formatters.item.enable_breakpoints
				managed_main_formatters.forth
			end
		end

	end_build_formatters is
			-- Finish the initialization of formatters (associate them with the editor and select a formatter).
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
			f_ind := default_class_formatter_index
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
			f_ind := default_feature_formatter_index
			if f_ind > 2 then
				f_ind := f_ind + 1
			end
			if f_ind < 1 or f_ind > managed_feature_formatters.count then
				f_ind := 2
			end
			(managed_feature_formatters @ f_ind).enable_select
		end

	build_tools is
			-- Build all tools that can take place in this window and put them
			-- in `left_tools' or `bottom_tools'.
		local
			show_cmd: EB_SHOW_TOOL_COMMAND
		do
				-- Build the features tool
			create features_tool.make (Current, left_panel)
			left_tools.extend (features_tool.explorer_bar_item)
			create show_cmd.make (Current, features_tool.explorer_bar_item)
			show_tool_commands.extend (show_cmd)
			toolbarable_commands.extend (show_cmd)
			add_recyclable (features_tool)

				-- Build the cluster tool
			create cluster_tool.make (Current, left_panel, Current)
			left_tools.extend (cluster_tool.explorer_bar_item)
			create show_cmd.make (Current, cluster_tool.explorer_bar_item)
			show_tool_commands.extend (show_cmd)
			toolbarable_commands.extend (show_cmd)
			add_recyclable (cluster_tool)

				-- Build the favorites tool
			create favorites_tool.make (Current, left_panel, favorites_manager)
			left_tools.extend (favorites_tool.explorer_bar_item)
			create show_cmd.make (Current, favorites_tool.explorer_bar_item)
			show_tool_commands.extend (show_cmd)
			toolbarable_commands.extend (show_cmd)
			add_recyclable (favorites_tool)

				-- Build the windows tool (formerly known as Selector tool)
			create windows_tool.make (Current, left_panel)
			left_tools.extend (windows_tool.explorer_bar_item)
			create show_cmd.make (Current, windows_tool.explorer_bar_item)
			show_tool_commands.extend (show_cmd)
			toolbarable_commands.extend (show_cmd)
			add_recyclable (windows_tool)

				-- Build the search tool
			create search_tool.make (Current, left_panel)
			left_tools.extend (search_tool.explorer_bar_item)
			create show_cmd.make (Current, search_tool.explorer_bar_item)
			show_tool_commands.extend (show_cmd)
			toolbarable_commands.extend (show_cmd)
			add_recyclable (search_tool)

				-- Build the editor tool
			create editor_tool.make (Current, right_panel)
			bottom_tools.extend (editor_tool.explorer_bar_item)
			editor_tool.text_area.add_edition_observer(save_cmd)
			editor_tool.text_area.add_edition_observer(save_as_cmd)
			editor_tool.text_area.add_edition_observer(print_cmd)
			editor_tool.text_area.add_edition_observer(Current)
			editor_tool.text_area.drop_actions.set_veto_pebble_function (~can_drop)
			add_recyclable (editor_tool)

				-- Build the context tool
			create context_tool.make (Current, right_panel)
			bottom_tools.extend (context_tool.explorer_bar_item)
			create show_cmd.make (Current, context_tool.explorer_bar_item)
			show_tool_commands.extend (show_cmd)
			toolbarable_commands.extend (show_cmd)
			add_recyclable (context_tool)

				-- Set the flag "Tools initialized"
			tools_initialized := True
			
				-- Initialize undo / redo accelerators
			create undo_accelerator.make_with_key_combination (create {EV_KEY}.make_with_code (Key_z), True, False, False)
			if has_case then
				undo_accelerator.actions.extend (agent (context_tool.editor.undo_cmd).on_ctrl_z)
			end
			undo_accelerator.actions.extend (agent undo_cmd.accelerator_execute)
			create redo_accelerator.make_with_key_combination (create {EV_KEY}.make_with_code (Key_y), True, False, False)
			if has_case then
				redo_accelerator.actions.extend (agent (context_tool.editor.redo_cmd).on_ctrl_y)
			end
			redo_accelerator.actions.extend (agent redo_cmd.accelerator_execute)
			window.accelerators.extend (undo_accelerator)
			window.accelerators.extend (redo_accelerator)
		end

feature -- Access

	cluster: CLUSTER_I is
			-- Cluster for current class. Void if none.
		local
			classi_stone: CLASSI_STONE
			cluster_stone: CLUSTER_STONE
		do
			classi_stone ?= stone
			if classi_stone /= Void then
				Result := classi_stone.cluster
			end
			cluster_stone ?= stone
			if cluster_stone /= Void then
				Result := cluster_stone.cluster_i
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
			editor_tool.text_area.set_text (a_text)
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

	preference_tool_is_hidden: BOOLEAN
			-- Is the preference tool hidden?

	profile_tool_is_hidden: BOOLEAN
			-- Is the profile tool hidden?

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
		do
			during_synchronization := True
			favorites_manager.refresh
			context_tool.synchronize
			cluster_tool.synchronize
			history_manager.synchronize
			features_tool.synchronize
			if stone /= Void then
				st := stone.synchronized_stone
			end
			editor_tool.text_area.update_click_list (False)
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
			debug_menu := debugger_manager.new_debug_menu
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
			general_customizable_toolbar := window_preferences.retrieve_general_toolbar (toolbarable_commands)
			if window_preferences.show_text_in_general_toolbar then
				general_customizable_toolbar.enable_text_displayed
			end
			create hbox
			hbox.extend (general_customizable_toolbar.widget)
			hbox.disable_item_expand (general_customizable_toolbar.widget)

				-- Generate the toolbar.
			general_customizable_toolbar.update_toolbar

				-- Cell to fill in empty space and receive the right click menu holder.
			create cell
			cell.pointer_button_release_actions.extend (~toolbar_right_click_action)
			hbox.extend (cell)

				-- Create the vertical layout (separator + toolbar)
			create hsep
			general_toolbar.set_padding (2)
			general_toolbar.extend (hsep)
			general_toolbar.disable_item_expand (hsep)
			general_toolbar.extend (hbox)
			general_toolbar.pointer_button_release_actions.extend (~toolbar_right_click_action)

				-- Create the command to show/hide this toolbar.
			create show_general_toolbar_command.make (general_toolbar, Interface_names.m_General_toolbar)
			show_toolbar_commands.extend (show_general_toolbar_command)
			if window_preferences.show_general_toolbar then
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
			tb.extend (history_manager.back_command.new_toolbar_item (False, False))

				-- Forward icon
			tb.extend (history_manager.forth_command.new_toolbar_item (False, False))
			
				-- Set up the accelerators.
			create accel.make_with_key_combination (
				create {EV_KEY}.make_with_code (Kcst.Key_right), False, True, False
			)
			accel.actions.extend (~on_forth)
			window.accelerators.extend (accel)
			
			create accel.make_with_key_combination (
				create {EV_KEY}.make_with_code (Kcst.Key_left), False, True, False
			)
			accel.actions.extend (~on_back)
			window.accelerators.extend (accel)

			------------------------------------------
			-- Address bar (Class name & feature name)
			------------------------------------------
			hbox.extend (address_manager.widget)

				-- Create the command to show/hide this toolbar.
			create show_address_toolbar_command.make (address_toolbar, Interface_names.m_Address_toolbar)
			show_toolbar_commands.extend (show_address_toolbar_command)

			if window_preferences.show_address_toolbar then
				show_address_toolbar_command.enable_visible
			else
				show_address_toolbar_command.disable_visible
			end

				-- Cell to fill in empty space and receive the right click menu holder.
			create cell
			cell.pointer_button_release_actions.extend (~toolbar_right_click_action)
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
			project_customizable_toolbar := debugger_manager.new_toolbar
			hbox.extend (project_customizable_toolbar.widget)
			hbox.disable_item_expand (project_customizable_toolbar.widget)

			project_customizable_toolbar.update_toolbar

				-- Create the command to show/hide this toolbar.
			create show_project_toolbar_command.make (project_toolbar, Interface_names.m_Project_toolbar)
			show_toolbar_commands.extend (show_project_toolbar_command)
			if window_preferences.show_project_toolbar then
				show_project_toolbar_command.enable_visible
			else
				show_project_toolbar_command.disable_visible
			end

				-- Cell to fill in empty space and receive the right click menu holder.
			create cell
			cell.pointer_button_release_actions.extend (~toolbar_right_click_action)
			hbox.extend (cell)
			project_toolbar.extend (hbox)
		end

feature -- Menu Building

	build_file_menu is
			-- Build the file menu.
		local
			new_project_cmd: EB_NEW_PROJECT_COMMAND
			open_project_cmd: EB_OPEN_PROJECT_COMMAND
			send_to_menu: EV_MENU
			menu_item: EV_MENU_ITEM
			command_menu_item: EB_COMMAND_MENU_ITEM
		do
			create file_menu.make_with_text (Interface_names.m_File)

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
			create menu_item.make_with_text (Interface_names.m_Close)
			menu_item.select_actions.extend (~destroy)
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
			create send_to_menu.make_with_text (Interface_names.m_Send_to)
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
			create menu_item.make_with_text (Interface_names.m_New_project)
			menu_item.select_actions.extend (new_project_cmd~execute)
			file_menu.extend (menu_item)

				-- Open Project
			create open_project_cmd.make_with_parent (window)
			create menu_item.make_with_text (Interface_names.m_Open_project)
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
			create Result.make_with_text (Interface_names.m_Class_info)
			i := 1

			create empty_menu.make_with_text (Interface_names.m_Formatter_separators @ i)
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
					create empty_menu.make_with_text (Interface_names.m_Formatter_separators @ i)
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
			create Result.make_with_text (Interface_names.m_Feature_info)
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
		do
			editor := editor_tool.text_area
			create editor_commands.make (10)
			create selection_commands.make (10)

			create edit_menu.make_with_text (Interface_names.m_Edit)

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
			command_menu_item := editor_cut_cmd.new_menu_item
			add_recyclable (command_menu_item)
			edit_menu.extend (command_menu_item)

				-- Copy
			command_menu_item := editor_copy_cmd.new_menu_item
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
			cmd.add_agent (~select_all)
			command_menu_item := cmd.new_menu_item
			add_edition_observer (cmd)
			editor_commands.extend (cmd)
			add_recyclable (command_menu_item)
			edit_menu.extend (command_menu_item)

				-- Separator --------------------------------------
			edit_menu.extend (create {EV_MENU_SEPARATOR})

				-- Search
			create cmd.make
			cmd.set_menu_name (Interface_names.m_Search + "%T" + Editor_preferences.shorcut_name_for_action (3))
			cmd.add_agent (editor~search)
			command_menu_item := cmd.new_menu_item
			add_edition_observer (cmd)
			editor_commands.extend (cmd)
			add_recyclable (command_menu_item)
			edit_menu.extend (command_menu_item)

				-- Replace
			create cmd.make
			cmd.set_menu_name (Interface_names.m_Replace + "%T" + Editor_preferences.shorcut_name_for_action (4))
			cmd.add_agent (editor~replace)
			cmd.set_needs_editable (True)
			command_menu_item := cmd.new_menu_item
			add_edition_observer (cmd)
			editor_commands.extend (cmd)
			add_recyclable (command_menu_item)
			edit_menu.extend (command_menu_item)

				-- Find sub menu

			create sub_menu.make_with_text (Interface_names.m_Find)

				-- Find next
			create cmd.make
			cmd.set_menu_name (Interface_names.m_Find_next + "%T" + Editor_preferences.shorcut_name_for_action (6))
			cmd.add_agent (editor~find_next)
			command_menu_item := cmd.new_menu_item
			add_edition_observer (cmd)
			editor_commands.extend (cmd)
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

				-- Find previous
			create cmd.make
			cmd.set_menu_name (Interface_names.m_Find_previous + "%T" + Editor_preferences.shorcut_name_for_action (7))
			cmd.add_agent (editor~find_previous)
			command_menu_item := cmd.new_menu_item
			add_edition_observer(cmd)
			editor_commands.extend (cmd)
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

				-- Find selection
			create os_cmd.make (Current)
			os_cmd.set_menu_name (Interface_names.m_Find_selection + "%T" + Editor_preferences.shorcut_name_for_action (5))
			os_cmd.add_agent (editor~find_selection)
			command_menu_item := os_cmd.new_menu_item
			add_selection_observer(os_cmd)
			selection_commands.extend (os_cmd)
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

			edit_menu.extend (sub_menu)


				-- Separator --------------------------------------
			edit_menu.extend (create {EV_MENU_SEPARATOR})

			create sub_menu.make_with_text (Interface_names.m_Advanced)

			create os_cmd.make (Current)
			os_cmd.set_needs_editable (True)
			add_selection_observer (os_cmd)
			selection_commands.extend (os_cmd)
			os_cmd.set_menu_name (Interface_names.m_Indent)
			os_cmd.add_agent (editor~indent_selection)
			command_menu_item := os_cmd.new_menu_item
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

			create os_cmd.make (Current)
			os_cmd.set_needs_editable (True)
			add_selection_observer (os_cmd)
			selection_commands.extend (os_cmd)
			os_cmd.set_menu_name (Interface_names.m_Unindent)
			os_cmd.add_agent (editor~unindent_selection)
			command_menu_item := os_cmd.new_menu_item
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

			create os_cmd.make (Current)
			os_cmd.set_needs_editable (True)
			add_selection_observer(os_cmd)
			selection_commands.extend (os_cmd)
			os_cmd.set_menu_name (Interface_names.m_To_lower)
			os_cmd.add_agent (editor~set_selection_case (True))
			command_menu_item := os_cmd.new_menu_item
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

			create os_cmd.make (Current)
			os_cmd.set_needs_editable (True)
			add_selection_observer(os_cmd)
			selection_commands.extend (os_cmd)
			os_cmd.set_menu_name (Interface_names.m_To_upper)
			os_cmd.add_agent (editor~set_selection_case (False))
			command_menu_item := os_cmd.new_menu_item
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

			create cmd.make
			cmd.set_needs_editable (True)
			cmd.set_menu_name (Interface_names.m_Comment)
			cmd.add_agent (editor~comment_selection)
			command_menu_item := cmd.new_menu_item
			add_edition_observer(cmd)
			editor_commands.extend (cmd)
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

			create cmd.make
			cmd.set_needs_editable (True)
			cmd.set_menu_name (Interface_names.m_Uncomment)
			cmd.add_agent (editor~uncomment_selection)
			command_menu_item := cmd.new_menu_item
			add_edition_observer(cmd)
			editor_commands.extend (cmd)
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

				-- Separator --------------------------------------
			sub_menu.extend (create {EV_MENU_SEPARATOR})

				-- Insert if block
			create cmd.make
			cmd.set_needs_editable (True)
			cmd.set_menu_name (Interface_names.m_If_block)
			cmd.add_agent (editor~embed_in_block("if  then", 3))
			command_menu_item := cmd.new_menu_item
			add_edition_observer(cmd)
			editor_commands.extend (cmd)
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

				-- Insert debug block
			create cmd.make
			cmd.set_needs_editable (True)
			cmd.set_menu_name (Interface_names.m_debug_block)
			cmd.add_agent (editor~embed_in_block("debug", 5))
			command_menu_item := cmd.new_menu_item
			add_edition_observer(cmd)
			editor_commands.extend (cmd)
			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)


				-- Separator --------------------------------------
			sub_menu.extend (create {EV_MENU_SEPARATOR})

				-- Complete word
			create cmd.make
			cmd.set_needs_editable (True)
			cmd.set_menu_name (Interface_names.m_Complete_word + "%T" + Editor_preferences.shorcut_name_for_action (1))
			command_menu_item := cmd.new_menu_item
			add_edition_observer(cmd)
			editor_commands.extend (cmd)
			cmd.add_agent (editor~complete_feature_name)

			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

				-- Complete class name
			create cmd.make
			cmd.set_needs_editable (True)
			cmd.set_menu_name (Interface_names.m_Complete_class_name + "%T" + Editor_preferences.shorcut_name_for_action (2))
			command_menu_item := cmd.new_menu_item
			add_edition_observer(cmd)
			editor_commands.extend (cmd)
			cmd.add_agent (editor~complete_class_name)

			add_recyclable (command_menu_item)
			sub_menu.extend (command_menu_item)

			sub_menu.extend (create {EV_MENU_SEPARATOR})

				-- show/hide formatting marks.
			create cmd.make
			if editor_tool.text_area.view_invisible_symbols then
				cmd.set_menu_name (Interface_names.m_Hide_formatting_marks)
			else
				cmd.set_menu_name (Interface_names.m_Show_formatting_marks)
			end
			formatting_marks_command_menu_item := cmd.new_menu_item
			add_edition_observer(cmd)
			editor_commands.extend (cmd)
			cmd.add_agent (~toggle_formatting_marks)

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
				new_basic_item.select_actions.put_front (form~invalidate)
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
			show_favorites_menu_item.select_actions.extend (~execute_show_favorites)
			
			favorites_menu.start
			favorites_menu.put_right (show_favorites_menu_item)
			favorites_menu.select_actions.extend (~update_show_favorites_menu_item)
		end
	
	build_project_menu is
			-- Build the project menu.
		local
			command_menu_item: EB_COMMAND_MENU_ITEM
		do
			create project_menu.make_with_text (Interface_names.m_Project)

				-- Melt
			command_menu_item := Melt_project_cmd.new_menu_item
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

	build_tools_menu is
			-- Create and build `tools_menu'
		local
			command_menu_item: EB_COMMAND_MENU_ITEM
			menu_item: EV_MENU_ITEM
		do
			create tools_menu.make_with_text (Interface_names.m_Tools)


			if has_metrics then
					-- Metric tool
				create metric_menu.make_with_text (interface_names.l_Tab_metrics)
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

			if debugger_manager.display_dotnet_cmd then
					-- Import .Net Assembly
				command_menu_item := dotnet_import_cmd.new_menu_item
				add_recyclable (command_menu_item)
				tools_menu.extend (command_menu_item)
			end

				-- Separator -------------------------------------------------
			tools_menu.extend (create {EV_MENU_SEPARATOR})

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

					-- Preferences
			command_menu_item := Show_preferences_cmd.new_menu_item
			add_recyclable (command_menu_item)
			tools_menu.extend (command_menu_item)
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
			-- Display text associated with `a_stone', if any and if possible
		local
			feature_stone: FEATURE_STONE
			old_class_stone: CLASSI_STONE
			test_stone: CLASSI_STONE
			same_class: BOOLEAN
			conv_ferrst: FEATURE_ERROR_STONE
		do
			old_class_stone ?= stone
			feature_stone ?= a_stone
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
							editor_tool.text_area.find_feature_named (feature_stone.feature_name)
							feature_stone_already_processed := editor_tool.text_area.found_feature
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
				save_and (~set_stone_after_check (a_stone))
				if text_saved and then not syntax_is_correct then
					text_saved := False
					during_synchronization := True
					set_stone_after_check (stone)
					during_synchronization := False
					address_manager.refresh
				end
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
			txt: STRING
			pos, end_pos: INTEGER
		do
			set_default_format
			e_class := s.e_feature.written_class
			if e_class.lace_class.hide_implementation then
				set_stone (s)
			else
				create cl_stone.make (e_class)
				set_stone (cl_stone)
				editor_tool.text_area.deselect_all
				pos := s.error_position
				txt := text
				if txt.count > pos then
					if txt.item (pos) = '%N' then	
						end_pos := txt.index_of ('%N', pos + 1)
					else
						end_pos := txt.index_of ('%N', pos)
					end
					if pos /= 0 then
						editor_tool.text_area.highlight_selected (pos, end_pos)
					end
				end
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
			editor_tool.text_area.highlight_when_ready (s.start_position + 1, s.end_position + 1)
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

	quick_refresh is
			-- Redraw the main editor's drawing area.
		do
			editor_tool.text_area.refresh
			context_tool.quick_refresh
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

feature -- Resource Update

	update is
			-- Update Current with the registered resources.
		do
				-- Show/hide general toolbar
			if window_preferences.show_general_toolbar then
				show_general_toolbar_command.enable_visible
			else
				show_general_toolbar_command.disable_visible
			end

				-- Show/hide address toolbar
			if window_preferences.show_address_toolbar then
				show_address_toolbar_command.enable_visible
			else
				show_address_toolbar_command.disable_visible
			end

				-- Show/hide project toolbar
			if window_preferences.show_project_toolbar then
				show_project_toolbar_command.enable_visible
			else
				show_project_toolbar_command.disable_visible
			end

			left_panel.load_from_resource (window_preferences.left_panel_layout)
			right_panel.load_from_resource (window_preferences.right_panel_layout)
		end

	update_splitters is
			-- Refresh the position of the splitter on screen according to 
			-- our internal values.
		do
				-- Set the interior layout
			if panel.full then
				panel.set_split_position (splitter_position.max (panel.minimum_split_position).min (panel.maximum_split_position))
			end
			left_panel.refresh_splitter
			right_panel.refresh_splitter
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
			address_manager.on_project_created
			context_tool.on_project_created
		end

	on_project_loaded is
			-- Inform tools that the current project has been loaded or re-loaded.
		do
--			cluster_manager.on_project_loaded
			enable_commands_on_project_loaded
			cluster_tool.on_project_loaded
			context_tool.on_project_loaded
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
		end

	save_before_compiling is
			-- save the text but do not update clickable positions
		do
			save_only := True
			save_text
		end

	perform_check_before_save is
		local
			dial: EV_CONFIRMATION_DIALOG
		do
			debug ("EDITOR")
				if editor_tool.text_area.current_text /= Void and then changed then
					io.error.putstring ("%N Warning: Attempting to save a non editable format%N")
				end
			end
			if editor_tool.text_area.open_backup then
				create dial.make_with_text(Warning_messages.w_Save_backup)
				dial.set_buttons_and_actions(<<"Continue", "Cancel">>, <<~continue_save, ~cancel_save>>)
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
		do
			save_canceled := False
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
			str := clone (title)
			if str @ 1 = '*' then
				str.tail (str.count - 2)
				set_title (str)
			end
			update_formatters
		end

	save_and (an_action: PROCEDURE [ANY, TUPLE []]) is
		local
			save_dialog: EB_CONFIRM_SAVE_DIALOG
		do
			save_canceled := True
			text_saved := False
			create save_dialog.make_and_launch (Current,Current)
			if not save_canceled and then syntax_is_correct then
				an_action.call([])
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

feature -- Tools & Controls

	editor_tool: EB_EDITOR_TOOL

	favorites_tool: EB_FAVORITES_TOOL

	cluster_tool: EB_CLUSTER_TOOL

	search_tool: EB_SEARCH_TOOL

	features_tool: EB_FEATURES_TOOL

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
				current_editor.remove_observer (Current)
				current_editor_index := new_index
				current_editor.add_edition_observer (Current)
				current_editor.add_selection_observer (Current)
				from
					editors.start
				until
					editors.after
				loop
					if editors.index /= current_editor_index and then editors.item.has_selection then
						editors.item.disable_selection
					end
					editors.forth
				end
				update_paste_cmd
					-- Since the current editor has changed,
					-- it may be in a different state than the current state,
					-- and we have to update the state and send events accordingly....*sigh*
				if text_state = 0 then
					if current_editor.text_is_fully_loaded then
						on_text_loaded
						on_text_fully_loaded
					end
				elseif text_state = 1 then
					if current_editor.text_is_fully_loaded then
						on_text_fully_loaded
					elseif current_editor.is_empty then
						on_text_reset
					end
				else
						-- State was fully loaded.
					if current_editor.is_empty then
						on_text_reset
					end
				end
				if selection_state = 0 then
					if current_editor.has_selection then
						on_selection_begun
					end
				else
						-- Selection state is there is a selection.
					if not current_editor.has_selection then
						on_selection_finished
					end
				end
				if edition_state = 0 then
					if current_editor.changed then
							--| True is safer for the diagram.
						on_text_edited (True)
					end
				else
					if not current_editor.changed then
						on_text_back_to_its_last_saved_state
					end
				end
				
					-- Now for the "editability" of the editor...
				if current_editor.is_editable then
					from
						editor_commands.start
					until
						editor_commands.after
					loop
						editor_commands.item.on_editable
						editor_commands.forth
					end
					from
						selection_commands.start
					until
						selection_commands.after
					loop
						selection_commands.item.on_editable
						selection_commands.forth
					end
				else
					from
						editor_commands.start
					until
						editor_commands.after
					loop
						editor_commands.item.on_not_editable
						editor_commands.forth
					end
					from
						selection_commands.start
					until
						selection_commands.after
					loop
						selection_commands.item.on_not_editable
						selection_commands.forth
					end
				end

					-- Last thing, update the menu entry for the formatting marks.
				if current_editor.view_invisible_symbols then
					formatting_marks_command_menu_item.set_text (Interface_names.m_Hide_formatting_marks)
				else
					formatting_marks_command_menu_item.set_text(Interface_names.m_Show_formatting_marks)
				end
			end
		end

	update_paste_cmd is
			-- Update `editor_paste_cmd'. To be performed when an editor grabs the focus.
		local
			txt: STRING
		do
			txt := current_editor.clipboard.text
			if
				not current_editor.is_empty and then
				current_editor.is_editable and then
				txt /= Void and then
				not txt.is_empty
			then
				editor_paste_cmd.enable_sensitive
			else
				editor_paste_cmd.disable_sensitive
			end
		end
				
feature {NONE} -- Implementation (Multiple editors)

	text_state: INTEGER
			-- Can be 0 if the current editor is empty, 1 if loaded, 2 if fully loaded.

	edition_state: INTEGER
			-- Can be 0 if the text has not been edited, 1 if it has been.

	selection_state: INTEGER
			-- Can be 0 if there is no selection,
			-- 1 if selection began,
			-- 2 if selection ended.

	on_selection_begun is
			-- Update `editor_copy_cmd' and `editor_cut_command'
			-- (to be performed when selection starts in one of the editors)
		do
				-- FIXME XR: Some day we'll have to merge clipboard commands with other editor commands.
			editor_copy_cmd.enable_sensitive
			if current_editor.is_editable then
				editor_cut_cmd.enable_sensitive
			end
			Precursor {TEXT_OBSERVER_MANAGER}
			selection_state := 1
		end
	
	on_selection_finished is
			-- Update `editor_copy_cmd' and `editor_cut_command'
			-- (to be performed when selection stops in one fo the editors)
		do
			if not current_editor.has_selection then
				editor_copy_cmd.disable_sensitive
				editor_cut_cmd.disable_sensitive
			end
			Precursor {TEXT_OBSERVER_MANAGER}
			if current_editor.has_selection then
				selection_state := 2
			else
				selection_state := 0
			end
		end

feature {NONE} -- Multiple editor management

	editors: ARRAYED_LIST [EB_EDITOR]
			-- editor contained in `Current'

	current_editor_index: INTEGER


feature {EB_WINDOW_MANAGER} -- Window management / Implementation

	destroy_imp is
			-- Destroy window.
		do
				-- To avoid reentrance
			if not is_destroying then
				is_destroying := True
				window_preferences.save_left_panel_layout (left_panel.save_to_resource)
				window_preferences.save_right_panel_layout (right_panel.save_to_resource)
				window_preferences.save_search_tool_options (search_tool)
				hide

					-- Commit saves
				window_preferences.save_resources

					-- If a launched application is still running, kill it.
				if
					Application.is_running and then
					debugger_manager.debugging_window = Current
				then
					Application.kill
				end
				toolbars_area.wipe_out
				address_manager.recycle
				project_customizable_toolbar.recycle
				Precursor {EB_TOOL_MANAGER}

					-- These components are automatically recycled through `add_recyclable'.
	--			cluster_tool.recycle
	--			context_tool.recycle
	--			editor_tool.recycle
	--			favorites_tool.recycle
	--			features_tool.recycle
	--			search_tool.recycle
	--			windows_tool.recycle

				-- The compile menu is never created !!!
	--			compile_menu.destroy
	--			debug_menu.destroy
	--			project_menu.destroy

				managed_class_formatters.wipe_out
				managed_feature_formatters.wipe_out
				managed_main_formatters.wipe_out
				toolbarable_commands.wipe_out
				editors.wipe_out
				stone := Void
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
			feature_stone: FEATURE_STONE
			conv_ferrst: FEATURE_ERROR_STONE
			tmp_structured_text: STRUCTURED_TEXT
			conv_errst: ERROR_STONE
			class_file: RAW_FILE
			class_text_exists: BOOLEAN
			same_class: BOOLEAN
			test_stone: CLASSI_STONE
			conv_ace: ACE_SYNTAX_STONE
			str: STRING
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
			if conv_brkstone /= Void then
				if Application.is_breakpoint_enabled (conv_brkstone.routine, conv_brkstone.index) then
					Application.remove_breakpoint (conv_brkstone.routine, conv_brkstone.index)
				else
					Application.set_breakpoint (conv_brkstone.routine, conv_brkstone.index)
				end
				output_manager.display_stop_points
				window_manager.quick_refresh_all
			elseif conv_errst /= Void then
				display_error_help_cmd.execute_with_stone (conv_errst)
			elseif conv_ace /= Void then
				--| FIXME XR: What should we do?!
			else
				
					-- Remember previous stone.
				old_stone := stone
				old_class_stone ?= stone
		
					-- New stone properties
				new_class_stone ?= a_stone

					-- Set the stone.
				old_set_stone (a_stone)
				cluster_st ?= a_stone
				
				new_feature_cmd.disable_sensitive
					-- We update the state of the `Add to Favorites' command.
				if new_class_stone /= Void then
					favorites_menu.first.enable_sensitive
				else
					favorites_menu.first.disable_sensitive
				end

					-- Update the history.
				if
					new_class_stone /= Void
				then
					history_manager.extend (new_class_stone)
				elseif
					cluster_st /= Void
				then
					history_manager.extend (cluster_st)
				end
					-- Update the address manager if needed.
				address_manager.refresh
				if
					new_class_stone /= Void
				then
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
						if 
							same_class and then text_saved						
						then
								-- nothing changed in the editor
								-- we only have to update click_list
							if editor_tool.text_area.is_editable then
								editor_tool.text_area.update_click_list (False)
							end
						else
							if changed then
									-- user has already chosen not to save the file
									-- do not ask again
								editor_tool.text_area.no_save_before_next_load
							end
						end
					end

					conv_classc ?= new_class_stone
					if conv_classc = Void or else feature_stone /= Void and not feature_stone_already_processed then
							-- If a classi_stone or a feature_stone has been dropped,
							-- display the basic text formatter.
						if class_text_exists then
							managed_main_formatters.first.set_stone (new_class_stone)
							managed_main_formatters.first.execute
						else
							editor_tool.text_area.clear_window
							editor_tool.text_area.display_message (Warning_messages.w_file_not_exist (new_class_stone.class_i.file_name))
						end
					end
					if conv_classc = Void then
							--| The dropped class is not compiled.
							--| Display only the textual formatter.
						address_manager.disable_formatters
					else
							--| We have a compiled class.
						if
							class_text_exists and then
							Eiffel_project.Workbench.last_reached_degree <= 2
						then
							new_feature_cmd.enable_sensitive
						end

						address_manager.enable_formatters
						if not class_text_exists then
								--| Disable the textual formatter.
							managed_main_formatters.first.disable_sensitive
							from
								managed_main_formatters.start
								managed_main_formatters.forth
							until
								managed_main_formatters.after
							loop
								managed_main_formatters.item.set_stone (new_class_stone)
								managed_main_formatters.forth
							end
							managed_main_formatters.i_th (2).execute
						else
							if not changed then
									--| Enable all formatters.
								if not feature_stone_already_processed then
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
								address_manager.disable_formatters
								managed_main_formatters.first.set_stone (new_class_stone)
							end
						end
					end
				else
						-- not a class text : cannot be edited
					editor_tool.text_area.disable_editable
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
						create tmp_structured_text.make
						tmp_structured_text.add_string ("Cluster: " + cluster_st.cluster_i.cluster_name)
						tmp_structured_text.add_new_line
						tmp_structured_text.add_string ("Cluster path: " + cluster_st.cluster_i.path)
						editor_tool.text_area.process_text (tmp_structured_text)
--| END FIXME
					end
				end
				if feature_stone /= Void and class_text_exists and not feature_stone_already_processed then
					conv_ferrst ?= feature_stone
					if conv_ferrst /= Void then
							-- Scroll to the line of the error.
						editor_tool.text_area.display_line_when_ready (conv_ferrst.line_number, True)
					else
							-- if a feature_stone has been dropped
							-- scroll to the corresponding feature in the basic text format
						if feature_stone.e_feature.ast /= Void and not during_synchronization then
							scroll_to_feature (feature_stone.e_feature.ast, new_class_stone.class_i)
						end
					end
				end
					-- Update the title of the window
				if a_stone /= Void then
					if changed then
						str := clone (a_stone.header)
						str.prepend ("* ")
						set_title (str)
					else
						set_title (a_stone.header)
					end
				else
					set_title (Interface_names.t_Empty_development_window)
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

	scroll_to_feature (feat_as: FEATURE_AS; displayed_class: CLASS_I) is
			-- highlight the feature correspnding to `feat_as' in the class represented by `displayed_class'
		require
			class_is_not_void: displayed_class /= Void
			feat_as_is_not_void: feat_as /= Void
		local
			begin_index, offset: INTEGER
			tmp_text: STRING
		do
			begin_index := feat_as.start_position
			if platform_constants.is_windows then
				tmp_text := displayed_class.text.substring (1, begin_index)
				offset := tmp_text.occurrences('%R')
			end
			editor_tool.text_area.scroll_to_when_ready (begin_index - offset)
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
			{EB_FILEABLE} Precursor
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

	update_formatters is
			-- Give a correct sensitivity to formatters.
		local
			cst: CLASSC_STONE
			file: RAW_FILE
		do
			cst ?= stone
			if cst /= Void then
				if changed then
					address_manager.disable_formatters
				else
					address_manager.enable_formatters
					create file.make (cst.e_class.lace_class.file_name)
					if not file.exists then
						managed_main_formatters.first.disable_sensitive
					end
				end
			else
				address_manager.disable_formatters
			end
		end

	on_text_reset is
			-- The main editor has just been wiped out
			-- before loading a new file.
		local
			str: STRING
		do
			str := clone (title)
			if str @ 1 = '*' then
				str.tail (str.count - 2)
				set_title (str)
			end
			address_manager.disable_formatters
			update_paste_cmd
			Precursor {TEXT_OBSERVER_MANAGER}
			text_state := 0
		end

	on_text_loaded is
			-- Update editor commands.
		do
			Precursor {TEXT_OBSERVER_MANAGER}
			text_state := 1
		end
					
	on_text_fully_loaded is
			-- The main editor has just been reloaded.
		do
			update_paste_cmd
			Precursor {TEXT_OBSERVER_MANAGER}
			text_state := 2
			if current_editor.is_editable then
				from
					editor_commands.start
				until
					editor_commands.after
				loop
					editor_commands.item.on_editable
					editor_commands.forth
				end
				from
					selection_commands.start
				until
					selection_commands.after
				loop
					selection_commands.item.on_editable
					selection_commands.forth
				end
			else
				from
					editor_commands.start
				until
					editor_commands.after
				loop
					editor_commands.item.on_not_editable
					editor_commands.forth
				end
				from
					selection_commands.start
				until
					selection_commands.after
				loop
					selection_commands.item.on_not_editable
					selection_commands.forth
				end
			end
			update_formatters
		end

	on_text_back_to_its_last_saved_state is
		local
			str: STRING
		do
			str := clone (title)
			if str @ 1 = '*' then
				str.tail (str.count - 2)
				set_title (str)
			end
			update_formatters
			Precursor {TEXT_OBSERVER_MANAGER}
			edition_state := 0
		end			
		

	on_text_edited (unused: BOOLEAN) is
			-- The text in the editor is modified, add the '*' in the title.
			-- Gray out the formatters.
		local
			str: STRING
		do
			str := clone (title)
			if str @ 1 /= '*' then
				str.prepend ("* ")
				set_title (str)
			end
			address_manager.disable_formatters
			Precursor {TEXT_OBSERVER_MANAGER} (unused)
			edition_state := 1
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

	quick_refresh_on_class_drop (unused: CLASSI_STONE) is
			-- Quick refresh all windows.
		do
			window_manager.quick_refresh_all
		end

	quick_refresh_on_brk_drop (unused: BREAKABLE_STONE) is
			-- Quick refresh all windows.
		do
			window_manager.quick_refresh_all
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
			dialog_w: EB_WARNING_DIALOG
		do
			if editor_tool /= Void and then editor_tool.text_area /= Void and then changed and then not confirmed then
				Exit_application_cmd.set_already_save_confirmed (True)
				create dialog_w.make_with_text (Interface_names.l_Close_warning)
				dialog_w.set_buttons_and_actions (<<"Yes", "No", "Cancel">>, <<~save_and_destroy, ~force_destroy, Exit_application_cmd~set_already_save_confirmed (False)>>)
				dialog_w.set_default_push_button (dialog_w.button("Yes"))
				dialog_w.set_default_cancel_button (dialog_w.button("Cancel"))
				dialog_w.show_modal_to_window (window)
			else
				Precursor {EB_TOOL_MANAGER}
				Exit_application_cmd.set_already_save_confirmed (False)
			end
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

	recycle is
			-- Call the precursors.
		do
			{EB_TOOL_MANAGER} Precursor
			{TEXT_OBSERVER_MANAGER} Precursor
		end

feature {NONE} -- Implementation: Editor commands

	select_all is
			-- Select the whole text in the focused editor.
		do
			current_editor.select_all
		end

	toggle_formatting_marks is
			-- Show/Hide formatting marks in the editor and update related menu item.
		do
			current_editor.toggle_view_invisible_symbols
			if current_editor.view_invisible_symbols then
				formatting_marks_command_menu_item.set_text (Interface_names.m_Hide_formatting_marks)
			else
				formatting_marks_command_menu_item.set_text(Interface_names.m_Show_formatting_marks)
			end
		end

feature {NONE} -- Implementation / Menus

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

	editor_cut_cmd: EB_EDITOR_CUT_COMMAND
			-- Command to cut text in the editor.
	
	editor_copy_cmd: EB_EDITOR_COPY_COMMAND
			-- Command to copy text in the editor.
	
	editor_paste_cmd: EB_EDITOR_PASTE_COMMAND
			-- Command to paste text in the editor.

	melt_cmd: EB_MELT_PROJECT_COMMAND
			-- Command to start compilation.

	freeze_cmd: EB_FREEZE_PROJECT_COMMAND
			-- Command to Freeze the project.

	finalize_cmd: EB_FINALIZE_PROJECT_COMMAND
			-- Command to Finalize the project.

	c_workbench_compilation_cmd: EB_C_COMPILATION_COMMAND
			-- Command to compile the workbench C code.

	c_finalized_compilation_cmd: EB_C_COMPILATION_COMMAND
			-- Command to compile the finalized C code.

	new_cluster_cmd: EB_NEW_CLUSTER_COMMAND
			-- Command to create a new cluster.

	new_class_cmd: EB_NEW_CLASS_COMMAND
			-- Command to create a new class.

	new_feature_cmd: EB_NEW_FEATURE_COMMAND
			-- Command to execute the feature wizard.

	toggle_stone_cmd: EB_UNIFY_STONE_CMD
			-- Command to toggle between the stone management modes.

	delete_class_cluster_cmd: EB_DELETE_CLASS_CLUSTER_COMMAND
			-- Command to remove a class or a cluster from the system
			-- (permanent deletion).

	show_profiler: EB_SHOW_PROFILE_TOOL
			-- What allows us to display the profiler window.

	toolbarable_commands: ARRAYED_LIST [EB_TOOLBARABLE_COMMAND]
			-- All commands that can be put in a toolbar.
	
	editor_commands: ARRAYED_LIST [EB_EDITOR_COMMAND]
			-- Commands relative to the main editor.
	
	selection_commands: ARRAYED_LIST [EB_ON_SELECTION_COMMAND]
			-- Commands relative to the main editor.
	
	save_as_cmd: EB_SAVE_FILE_AS_COMMAND
			-- Command to save a class with a different file name.

	system_info_cmd: EB_STANDARD_CMD is
			-- Command to display information about the system (root class,...)
		do
			Result := debugger_manager.system_info_cmd
		end

	display_error_help_cmd: EB_ERROR_INFORMATION_CMD is
			-- Command to pop up a dialog giving help on compilation errors.
		do
			Result := debugger_manager.display_error_help_cmd
		end

	send_stone_to_context_cmd: EB_STANDARD_CMD
			-- Command to send the current stone to the context tool.

	print_cmd: EB_PRINT_COMMAND
			-- Command to print the content of editor with focus

	dotnet_import_cmd: EB_DOTNET_IMPORT_CMD is
			-- Manage .Net assemblies.
		do
			Result := debugger_manager.dotnet_import_cmd
		end

	show_favorites_menu_item: EV_MENU_ITEM
			-- Show/Hide favorites menu item.
	
	update_show_favorites_menu_item is
			-- Update `show_favorites_menu_item' menu label.
		do
			if favorites_tool.shown then
				show_favorites_menu_item.set_text (Interface_names.m_Hide_favorites)
			else
				show_favorites_menu_item.set_text (Interface_names.m_Show_favorites)
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

feature {NONE} -- external edition handling

	on_focus is
			-- check if the text has not been modified by an external editor
		local
			dialog: EV_INFORMATION_DIALOG
			button_labels: ARRAY [STRING]
			actions: ARRAY [PROCEDURE [ANY, TUPLE]]
		do
			debug ("DEBUGGER_INTERFACE")
				io.putstring ("Took focus!%N")
			end
			if not editor_tool.edited_file_is_up_to_date then
				if not editor_tool.file_date_already_checked then
					if not editor_tool.changed and Editor_preferences.automatic_update
					then
						editor_tool.reload
					else
						create dialog.make_with_text (warning_messages.w_file_modified_by_another_editor)
						create button_labels.make (1, 2)
						create actions.make (1, 2)
						button_labels.put (interface_names.b_Reload, 1)
						actions.put (editor_tool~reload, 1)
						button_labels.put (interface_names.b_Continue_anyway, 2)
						actions.put (editor_tool~set_changed (True), 2)
						dialog.set_buttons_and_actions (button_labels,actions)
						dialog.set_default_push_button (dialog.button (button_labels @ 1))
						dialog.set_default_cancel_button (dialog.button (button_labels @ 2))
						dialog.set_title (interface_names.t_External_edition)
						dialog.show_modal_to_window (window)
					end
				end
			end
		end

feature {NONE} -- Execution

	Kcst: EV_KEY_CONSTANTS is
			-- A way to access key constants.
		once
			create Result
		end

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
		end

end -- class EB_DEVELOPMENT_WINDOW

