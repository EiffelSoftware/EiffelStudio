note
	description: "Builder which build all EB_DEVELOPMENT_WINDOW menus."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_MENU_BUILDER

inherit
	EB_DEVELOPMENT_WINDOW_BUILDER
	EB_SHARED_MENU_EXTENDER
	EB_SHARED_PREFERENCES
	SHARED_ES_CLOUD_SERVICE

create
	make

feature -- Command

	build_menus
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
			build_refactoring_menu
			build_window_menu
			build_help_menu

				-- Build the menu bar.
			build_menu_bar
		end

	build_debug_menu
			-- Build the `Debug' menu through the debugger_manager.
		local
			l_debug_menu: EV_MENU
		do
			develop_window.menus.set_debug_menu (develop_window.Eb_debugger_manager.new_debug_menu (develop_window))
			l_debug_menu := develop_window.menus.debug_menu
			from
				l_debug_menu.start
			until
				l_debug_menu.after
			loop
				if attached {EB_COMMAND_MENU_ITEM} l_debug_menu.item as l_conv_mit then
					auto_recycle (l_conv_mit)
				end
				l_debug_menu.forth
			end

				--| Debugging tools menu
			develop_window.menus.set_debugging_tools_menu (develop_window.Eb_debugger_manager.new_debugging_tools_menu)
			l_debug_menu.put_front (develop_window.menus.debugging_tools_menu)

				-- Comment because menu will be updated by `develop_window.refresh_all_commands'
			-- develop_window.menus.update_debug_menu
		end

	build_refactoring_menu
			-- Create and build `refactoring_menu'.
		local
			l_command_menu_item: EB_COMMAND_MENU_ITEM
			l_refactoring_menu: EV_MENU
		do
			create l_refactoring_menu.make_with_text (develop_window.Interface_names.m_refactoring)
			develop_window.menus.set_refactoring_menu (l_refactoring_menu)

				-- Pull up command.
			l_command_menu_item := develop_window.refactoring_manager.pull_command.new_menu_item
			auto_recycle (l_command_menu_item)
			l_refactoring_menu.extend (l_command_menu_item)

				-- Rename command.
			l_command_menu_item := develop_window.refactoring_manager.rename_command.new_menu_item
			auto_recycle (l_command_menu_item)
			l_refactoring_menu.extend (l_command_menu_item)

				-- Separator -------------------------------------------------
			l_refactoring_menu.extend (create {EV_MENU_SEPARATOR})

				-- Undo command.
			l_command_menu_item := develop_window.refactoring_manager.undo_command.new_menu_item
			auto_recycle (l_command_menu_item)
			l_refactoring_menu.extend (l_command_menu_item)

				-- Redo command.
			l_command_menu_item := develop_window.refactoring_manager.redo_command.new_menu_item
			auto_recycle (l_command_menu_item)
			l_refactoring_menu.extend (l_command_menu_item)
		ensure
			refactoring_menu_created: develop_window.menus.refactoring_menu /= Void
		end

	build_menu_bar
			-- Build the menu bar
		local
			l_mb: EV_MENU_BAR
		do
			check
				develop_window.window.menu_bar /= Void implies not develop_window.window.menu_bar.is_empty
				-- If a menu bar was already present, it shouldn't be empty.
			end
			if develop_window.window.menu_bar /= Void then
				l_mb := develop_window.window.menu_bar
				from
					l_mb.start
					l_mb.forth
				until
					l_mb.after
				loop
					l_mb.remove
				end
			else
				create l_mb
				develop_window.window.set_menu_bar (l_mb)
				l_mb.extend (develop_window.menus.file_menu)
			end

			if develop_window.Eiffel_project.manager.is_created then
				l_mb.extend (develop_window.menus.edit_menu)
				l_mb.extend (develop_window.menus.view_menu)
				l_mb.extend (develop_window.menus.favorites_menu)
				l_mb.extend (develop_window.menus.project_menu)
				l_mb.extend (develop_window.menus.debug_menu)
				l_mb.extend (develop_window.menus.refactoring_menu)
			else
				l_mb.extend (develop_window.menus.view_menu)
			end
			l_mb.extend (develop_window.menus.tools_menu)
			l_mb.extend (develop_window.menus.window_menu)
			l_mb.extend (develop_window.menus.help_menu)

			develop_window.estudio_debug_cmd.attach_window (develop_window.window)
		end

	build_toolbar_menu: EV_MENU
			-- Create and build a sub menu `toolbar_menu'.
		local
			command_menu_item: EB_COMMAND_CHECK_MENU_ITEM
			l_show_tool_bar_commands: ARRAYED_LIST [EB_SHOW_TOOLBAR_COMMAND]
		do
			create Result.make_with_text (develop_window.Interface_names.m_Toolbars)

				-- Available toolbars
			from
				l_show_tool_bar_commands := develop_window.commands.show_toolbar_commands.linear_representation
				l_show_tool_bar_commands.start
			until
				l_show_tool_bar_commands.after
			loop
				command_menu_item := l_show_tool_bar_commands.item.new_menu_item
				-- This is done by docking manager now.
				auto_recycle (command_menu_item)
				Result.extend (command_menu_item)

				l_show_tool_bar_commands.forth
			end
		end

feature {EB_EXTERNAL_COMMANDS_EDITOR} -- Menu Building

	build_file_menu
			-- Build the file menu.
		local
			l_file_menu: EV_MENU
			l_new_project_cmd: EB_NEW_PROJECT_COMMAND
			l_open_project_cmd: EB_OPEN_PROJECT_COMMAND
			l_menu_item: EV_MENU_ITEM
			l_command_menu_item: EB_COMMAND_MENU_ITEM
			l_shortcut: MANAGED_SHORTCUT
		do
			create l_file_menu.make_with_text (develop_window.Interface_names.m_file)
			develop_window.menus.set_file_menu (l_file_menu)

				-- New editor tab
			l_command_menu_item := develop_window.commands.new_tab_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.file_menu.extend (l_command_menu_item)

				-- New
			l_command_menu_item := develop_window.New_development_window_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.file_menu.extend (l_command_menu_item)

				-- Close
			l_shortcut := preferences.misc_shortcut_data.close_window_shortcut
			create l_menu_item.make_with_text (develop_window.Interface_names.m_close + "%T" + l_shortcut.display_string)
			register_action (l_menu_item.select_actions, agent develop_window.destroy)
			develop_window.menus.file_menu.extend (l_menu_item)

				-- Separator --------------------------------------
			develop_window.menus.file_menu.extend (create {EV_MENU_SEPARATOR})

				-- Save
			l_command_menu_item := develop_window.save_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.file_menu.extend (l_command_menu_item)

				-- Save all	
			l_command_menu_item := develop_window.save_all_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.file_menu.extend (l_command_menu_item)

				-- Save as
			l_command_menu_item := develop_window.commands.save_as_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.file_menu.extend (l_command_menu_item)

				-- External editor
			l_command_menu_item := develop_window.commands.shell_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.file_menu.extend (l_command_menu_item)

				-- Separator --------------------------------------
			develop_window.menus.file_menu.extend (create {EV_MENU_SEPARATOR})
			l_command_menu_item := develop_window.commands.print_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.file_menu.extend (l_command_menu_item)

				-- Separator --------------------------------------
			develop_window.menus.file_menu.extend (create {EV_MENU_SEPARATOR})

				-- New Project
			create l_new_project_cmd.make_with_parent (develop_window.window)
			create l_menu_item.make_with_text (develop_window.Interface_names.m_new_project)
			l_menu_item.select_actions.extend (agent l_new_project_cmd.execute)
			develop_window.menus.file_menu.extend (l_menu_item)

				-- Open Project
			create l_open_project_cmd.make_with_parent (develop_window.window)
			create l_menu_item.make_with_text (develop_window.Interface_names.m_open_project)
			l_menu_item.select_actions.extend (agent l_open_project_cmd.execute)
			develop_window.menus.file_menu.extend (l_menu_item)

				-- Recent Projects
			develop_window.menus.set_recent_projects_menu (develop_window.recent_projects_manager.new_menu)
			auto_recycle (develop_window.menus.recent_projects_menu)
			develop_window.menus.file_menu.extend (develop_window.menus.recent_projects_menu)

				-- Separator --------------------------------------
			develop_window.menus.file_menu.extend (create {EV_MENU_SEPARATOR})

				-- Exit
			l_command_menu_item := develop_window.Exit_application_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.file_menu.extend (l_command_menu_item)
		end

	build_class_info_menu: EV_MENU
			-- Build the class format sub-menu.
		local
			l_form: EB_CLASS_INFO_FORMATTER
			l_empty_menu: EV_MENU_ITEM
			l_i: INTEGER
			l_managed_class_formatters: ARRAYED_LIST [EB_CLASS_INFO_FORMATTER]
		do
			create Result.make_with_text (develop_window.Interface_names.m_class_info)
			l_i := 1

			create l_empty_menu.make_with_text (develop_window.Interface_names.m_formatter_separators @ l_i)
			l_i := l_i + 1
			l_empty_menu.disable_sensitive
			Result.extend (l_empty_menu)
			from
				l_managed_class_formatters := develop_window.managed_class_formatters
				l_managed_class_formatters.start
			until
				l_managed_class_formatters.after
			loop
				l_form := l_managed_class_formatters.item
				if l_form /= Void then
					Result.extend (l_form.new_menu_item)
				else
					create l_empty_menu.make_with_text (develop_window.Interface_names.m_formatter_separators @ l_i)
					l_i := l_i + 1
					l_empty_menu.disable_sensitive
					Result.extend (l_empty_menu)
				end
				l_managed_class_formatters.forth
			end
		end

	build_feature_info_menu: EV_MENU
			-- Build the feature format sub-menu.
		local
			l_form: EB_FEATURE_INFO_FORMATTER
			l_managed_feature_formatters: ARRAYED_LIST [EB_FEATURE_INFO_FORMATTER]
		do
			create Result.make_with_text (develop_window.Interface_names.m_feature_info)
			from
				l_managed_feature_formatters := develop_window.managed_feature_formatters
				l_managed_feature_formatters.start
			until
				l_managed_feature_formatters.after
			loop
				l_form := l_managed_feature_formatters.item
				if l_form /= Void then
					Result.extend (l_form.new_menu_item)
				end
				l_managed_feature_formatters.forth
			end
		end

	build_edit_menu
			-- Create and build `edit_menu'
		local
			l_command_menu_item: EB_COMMAND_MENU_ITEM
			l_sub_menu: EV_MENU
			l_cmd: EB_EDITOR_COMMAND
			l_os_cmd: EB_ON_SELECTION_COMMAND
			l_ln_cmd: EB_TOGGLE_LINE_NUMBERS_COMMAND
			l_insert_symb: EB_INSERT_SYMBOL_EDITOR_COMMAND
			l_find_brace_cmd: EB_FIND_MATCHING_BRACE_COMMAND

			l_command_controller: EB_EDITOR_COMMAND_CONTROLLER
			l_edit_menu: EV_MENU
			l_string: STRING_GENERAL

			l_shortcut: MANAGED_SHORTCUT
		do
			create l_command_controller.make
			develop_window.set_command_controller (l_command_controller)

			create l_edit_menu.make_with_text (develop_window.Interface_names.m_edit)
			develop_window.menus.set_edit_menu (l_edit_menu)

				-- Undo
			l_command_menu_item := develop_window.commands.undo_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.edit_menu.extend (l_command_menu_item)

				-- Redo
			l_command_menu_item := develop_window.commands.redo_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.edit_menu.extend (l_command_menu_item)

				-- Separator --------------------------------------
			develop_window.menus.edit_menu.extend (create {EV_MENU_SEPARATOR})

				-- Cut
			l_command_menu_item := develop_window.commands.editor_cut_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (develop_window.commands.editor_cut_cmd)
			l_command_controller.add_selection_command (develop_window.commands.editor_cut_cmd)
			develop_window.menus.edit_menu.extend (l_command_menu_item)

				-- Copy
			l_command_menu_item := develop_window.commands.editor_copy_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (develop_window.commands.editor_copy_cmd)
			l_command_controller.add_selection_command (develop_window.commands.editor_copy_cmd)
			develop_window.menus.edit_menu.extend (l_command_menu_item)

				-- Paste
			l_command_menu_item := develop_window.commands.editor_paste_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (develop_window.commands.editor_paste_cmd)
			l_command_controller.add_edition_command (develop_window.commands.editor_paste_cmd)
			develop_window.menus.edit_menu.extend (l_command_menu_item)

				-- Separator --------------------------------------
			develop_window.menus.edit_menu.extend (create {EV_MENU_SEPARATOR})

				-- Select all
			create l_cmd.make
			l_cmd.set_menu_name (develop_window.Interface_names.m_select_all)
			l_cmd.add_agent (agent develop_window.select_all)
			l_command_menu_item := l_cmd.new_menu_item
			l_command_controller.add_edition_command (l_cmd)
			auto_recycle (l_command_menu_item)
			develop_window.menus.edit_menu.extend (l_command_menu_item)
			develop_window.commands.editor_commands.extend (l_cmd)

				-- Separator --------------------------------------
			develop_window.menus.edit_menu.extend (create {EV_MENU_SEPARATOR})

				-- Line numbers
			create l_ln_cmd.make
			l_ln_cmd.set_is_for_main_editors (True)
			l_command_menu_item := l_ln_cmd.new_menu_item
			l_command_controller.add_edition_command (l_ln_cmd)
			auto_recycle (l_command_menu_item)
			develop_window.menus.edit_menu.extend (l_command_menu_item)
			develop_window.commands.editor_commands.extend (l_ln_cmd)

				-- Separator --------------------------------------
			develop_window.menus.edit_menu.extend (create {EV_MENU_SEPARATOR})

				-- Search
			create l_cmd.make
			l_string := develop_window.Interface_names.m_search
			l_shortcut := develop_window.preferences.misc_shortcut_data.shortcuts.item ("show_search_tool")
			l_cmd.enable_sensitive
			l_cmd.set_referred_shortcut (l_shortcut)
			l_cmd.set_menu_name (l_string)
			l_cmd.add_agent (agent editor_search)
			l_command_menu_item := l_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.commands.toolbarable_commands.extend (l_cmd)
			develop_window.menus.edit_menu.extend (l_command_menu_item)

				-- Go to
			create l_cmd.make
			l_cmd.set_menu_name (develop_window.Interface_names.m_go_to)
			l_cmd.set_is_for_main_editors (True)
			l_shortcut := develop_window.preferences.editor_data.shortcuts.item ("show_goto_dialog")
			l_cmd.set_accelerator ((create {EV_ACCELERATOR}.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)))
			l_cmd.set_referred_shortcut (l_shortcut)
			l_cmd.add_agent (agent develop_window.goto)
			l_command_menu_item := l_cmd.new_menu_item
			l_command_controller.add_edition_command (l_cmd)
			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (l_cmd)
			develop_window.menus.edit_menu.extend (l_command_menu_item)

				-- Insert Symbols
			create l_insert_symb.make (develop_window)
			l_insert_symb.set_is_for_main_editors (True)
			l_command_menu_item := l_insert_symb.new_menu_item
			l_command_controller.add_edition_command (l_insert_symb)
			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (l_insert_symb)
			develop_window.menus.edit_menu.extend (l_command_menu_item)

				-- Separator --------------------------------------
			develop_window.menus.edit_menu.extend (create {EV_MENU_SEPARATOR})

				-- Replace
			create l_cmd.make
			l_string := develop_window.Interface_names.m_replace
			l_shortcut := develop_window.preferences.editor_data.shortcuts.item ("show_search_and_replace_panel")
			l_cmd.enable_sensitive
			l_cmd.set_menu_name (l_string)
			l_cmd.add_agent (agent editor_replace)
			l_cmd.set_referred_shortcut (l_shortcut)
			l_command_menu_item := l_cmd.new_menu_item
			develop_window.commands.toolbarable_commands.extend (l_cmd)
			auto_recycle (l_command_menu_item)
			develop_window.menus.edit_menu.extend (l_command_menu_item)

				-- Find sub menu

			create l_sub_menu.make_with_text (develop_window.Interface_names.m_find)

				-- Find next
			create l_cmd.make
			l_string := develop_window.Interface_names.m_find_next
			l_shortcut := develop_window.preferences.editor_data.shortcuts.item ("search_forward")
			l_cmd.set_menu_name (l_string)
			l_cmd.add_agent (agent develop_window.find_next)
			l_cmd.set_referred_shortcut (l_shortcut)
			l_command_menu_item := l_cmd.new_menu_item
			l_command_controller.add_edition_command (l_cmd)
			develop_window.commands.editor_commands.extend (l_cmd)
			auto_recycle (l_command_menu_item)
			l_sub_menu.extend (l_command_menu_item)

				-- Find previous
			create l_cmd.make
			l_string := develop_window.Interface_names.m_find_previous
			l_shortcut := develop_window.preferences.editor_data.shortcuts.item ("search_backward")
			l_cmd.set_menu_name (l_string)
			l_cmd.add_agent (agent develop_window.find_previous)
			l_cmd.set_referred_shortcut (l_shortcut)
			l_command_menu_item := l_cmd.new_menu_item
			l_command_controller.add_edition_command (l_cmd)
			develop_window.commands.editor_commands.extend (l_cmd)
			auto_recycle (l_command_menu_item)
			l_sub_menu.extend (l_command_menu_item)

				-- Find selection forward
			create l_cmd.make
			l_string := develop_window.Interface_names.m_find_next_selection
			l_shortcut := develop_window.preferences.editor_data.shortcuts.item ("search_selection_forward")
			l_cmd.set_menu_name (l_string)
			l_cmd.add_agent (agent develop_window.find_next_selection)
			l_cmd.set_referred_shortcut (l_shortcut)
			l_command_menu_item := l_cmd.new_menu_item
			l_command_controller.add_edition_command (l_cmd)
			develop_window.commands.editor_commands.extend (l_cmd)
			auto_recycle (l_command_menu_item)
			l_sub_menu.extend (l_command_menu_item)

				-- Find selection backward
			create l_cmd.make
			l_string := develop_window.Interface_names.m_find_previous_selection
			l_shortcut := develop_window.preferences.editor_data.shortcuts.item ("search_selection_backward")
			l_cmd.set_menu_name (l_string)
			l_cmd.add_agent (agent develop_window.find_next_selection)
			l_cmd.set_referred_shortcut (l_shortcut)
			l_command_menu_item := l_cmd.new_menu_item
			l_command_controller.add_edition_command (l_cmd)
			develop_window.commands.editor_commands.extend (l_cmd)
			auto_recycle (l_command_menu_item)
			l_sub_menu.extend (l_command_menu_item)

			develop_window.menus.edit_menu.extend (l_sub_menu)

				-- Separator --------------------------------------
			develop_window.menus.edit_menu.extend (create {EV_MENU_SEPARATOR})

			create l_sub_menu.make_with_text (develop_window.Interface_names.m_advanced)

			create l_cmd.make
			l_cmd.set_needs_editable (True)
			l_cmd.set_menu_name (develop_window.interface_names.m_prettify)
			l_cmd.add_agent (agent editor_prettify)
			l_shortcut := develop_window.preferences.editor_data.shortcuts.item ("prettify")
			l_cmd.set_referred_shortcut (l_shortcut)
			l_command_menu_item := l_cmd.new_menu_item
			l_command_controller.add_edition_command (l_cmd)
			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (l_cmd)
			l_sub_menu.extend (l_command_menu_item)

			create l_os_cmd.make (develop_window)
			l_os_cmd.set_needs_editable (True)
			l_command_controller.add_selection_command (l_os_cmd)
			l_os_cmd.set_menu_name (develop_window.Interface_names.m_indent)
			l_os_cmd.add_agent (agent editor_indent_selection)
			l_command_menu_item := l_os_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (l_os_cmd)
			l_sub_menu.extend (l_command_menu_item)

			create l_os_cmd.make (develop_window)
			l_os_cmd.set_needs_editable (True)
			l_command_controller.add_selection_command (l_os_cmd)
			l_os_cmd.set_menu_name (develop_window.Interface_names.m_unindent)
			l_os_cmd.add_agent (agent editor_unindent_selection)
			l_command_menu_item := l_os_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (l_os_cmd)
			l_sub_menu.extend (l_command_menu_item)

			create l_os_cmd.make (develop_window)
			l_os_cmd.set_needs_editable (True)
			l_command_controller.add_selection_command (l_os_cmd)
			l_os_cmd.set_menu_name (develop_window.Interface_names.m_to_lower)
			l_os_cmd.add_agent (agent editor_set_selection_case (True))
			l_shortcut := develop_window.preferences.editor_data.shortcuts.item ("set_to_lowercase")
			l_os_cmd.set_referred_shortcut (l_shortcut)
			l_command_menu_item := l_os_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (l_os_cmd)
			l_sub_menu.extend (l_command_menu_item)

			create l_os_cmd.make (develop_window)
			l_os_cmd.set_needs_editable (True)
			l_command_controller.add_selection_command (l_os_cmd)
			l_os_cmd.set_menu_name (develop_window.Interface_names.m_to_upper)
			l_os_cmd.add_agent (agent editor_set_selection_case (False))
			l_shortcut := develop_window.preferences.editor_data.shortcuts.item ("set_to_uppercase")
			l_os_cmd.set_referred_shortcut (l_shortcut)
			l_command_menu_item := l_os_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (l_os_cmd)
			l_sub_menu.extend (l_command_menu_item)

			create l_cmd.make
			l_cmd.set_needs_editable (True)
			l_cmd.set_menu_name (develop_window.Interface_names.m_comment)
			l_cmd.add_agent (agent editor_comment_selection)
			l_shortcut := develop_window.preferences.editor_data.shortcuts.item ("comment")
			l_cmd.set_referred_shortcut (l_shortcut)
			l_command_menu_item := l_cmd.new_menu_item
			l_command_controller.add_edition_command (l_cmd)
			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (l_cmd)
			l_sub_menu.extend (l_command_menu_item)

			create l_cmd.make
			l_cmd.set_needs_editable (True)
			l_cmd.set_menu_name (develop_window.Interface_names.m_uncomment)
			l_cmd.add_agent (agent editor_uncomment_selection)
			l_shortcut := develop_window.preferences.editor_data.shortcuts.item ("uncomment")
			l_cmd.set_referred_shortcut (l_shortcut)
			l_command_menu_item := l_cmd.new_menu_item
			l_command_controller.add_edition_command (l_cmd)
			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (l_cmd)
			l_sub_menu.extend (l_command_menu_item)

				-- Separator --------------------------------------
			l_sub_menu.extend (create {EV_MENU_SEPARATOR})

				-- Insert if block
			create l_cmd.make
			l_cmd.set_needs_editable (True)
			l_cmd.set_menu_name (develop_window.Interface_names.m_if_block)
			l_cmd.add_agent (agent editor_embed_in_block("if  then", 3))
			l_command_menu_item := l_cmd.new_menu_item
			l_command_controller.add_edition_command (l_cmd)
			l_shortcut := develop_window.preferences.misc_shortcut_data.shortcuts.item ("embed_if_clause")
			l_cmd.set_referred_shortcut (l_shortcut)
			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (l_cmd)
			l_sub_menu.extend (l_command_menu_item)

				-- Insert debug block
			create l_cmd.make
			l_cmd.set_needs_editable (True)
			l_cmd.set_menu_name (develop_window.Interface_names.m_debug_block)
			l_cmd.add_agent (agent editor_embed_in_block("debug", 5))
			l_command_menu_item := l_cmd.new_menu_item
			l_command_controller.add_edition_command (l_cmd)
			l_shortcut := develop_window.preferences.misc_shortcut_data.shortcuts.item ("embed_debug_clause")
			l_cmd.set_referred_shortcut (l_shortcut)
			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (l_cmd)
			l_sub_menu.extend (l_command_menu_item)

				-- Separator --------------------------------------
			l_sub_menu.extend (create {EV_MENU_SEPARATOR})

				-- Complete word
			create l_cmd.make
			l_cmd.set_needs_editable (True)
			l_string := develop_window.Interface_names.m_complete_word
			l_string.append ("%T")
			l_string.append (develop_window.preferences.editor_data.shortcuts.item ("autocomplete").display_string)
			l_cmd.set_menu_name (l_string)
			l_command_menu_item := l_cmd.new_menu_item
			l_command_controller.add_edition_command (l_cmd)
			l_cmd.add_agent (agent editor_complete_feature_name)

			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (l_cmd)
			l_sub_menu.extend (l_command_menu_item)

				-- Complete class name
			create l_cmd.make
			l_cmd.set_needs_editable (True)
			l_string := develop_window.Interface_names.m_complete_class_name
			l_string.append ("%T")
			l_string.append (develop_window.preferences.editor_data.shortcuts.item ("class_autocomplete").display_string)
			l_cmd.set_menu_name (l_string)
			l_command_menu_item := l_cmd.new_menu_item
			l_command_controller.add_edition_command (l_cmd)
			l_cmd.add_agent (agent editor_complete_class_name)

			auto_recycle (l_command_menu_item)
			develop_window.commands.editor_commands.extend (l_cmd)
			l_sub_menu.extend (l_command_menu_item)

				-- Find matching brace				
			create l_find_brace_cmd.make (develop_window)
			auto_recycle (l_find_brace_cmd)
			l_command_menu_item := l_find_brace_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_command_controller.add_edition_command (l_find_brace_cmd)
			develop_window.commands.editor_commands.extend (l_find_brace_cmd)
			l_sub_menu.extend (l_command_menu_item)

			l_sub_menu.extend (create {EV_MENU_SEPARATOR})

				-- show/hide formatting marks.
			create l_cmd.make
			l_cmd.set_menu_name (develop_window.Interface_names.m_show_formatting_marks)
			develop_window.menus.set_formatting_marks_command_menu_item (l_cmd.new_menu_item)
			develop_window.refresh_toggle_formatting_marks_command
			l_command_controller.add_edition_command (l_cmd)
			l_cmd.add_agent (agent develop_window.toggle_formatting_marks)
			develop_window.commands.editor_commands.extend (l_cmd)

			auto_recycle (develop_window.menus.formatting_marks_command_menu_item)
			l_sub_menu.extend (develop_window.menus.formatting_marks_command_menu_item)

			develop_window.menus.edit_menu.extend (l_sub_menu)
		end

	build_view_menu
			-- Build the view menu.
		local
			l_menu_sep: EV_MENU_SEPARATOR
			l_view_menu: EV_MENU
			l_form: EB_CLASS_INFO_FORMATTER
			l_new_menu_item: EB_COMMAND_MENU_ITEM
			l_new_basic_item: EV_MENU_ITEM
			l_managed_main_formatters: ARRAYED_LIST [EB_CLASS_TEXT_FORMATTER]
		do
			create l_view_menu.make_with_text (develop_window.Interface_names.m_View)
			develop_window.menus.set_view_menu (l_view_menu)

				-- Explorer Bar
			develop_window.menus.set_tools_list_menu (tool_list_menu)
			l_view_menu.extend (develop_window.menus.tools_list_menu)
			develop_window.menus.set_tools_list_menu (develop_window.menus.tools_list_menu)
				-- Separator
			create l_menu_sep
			l_view_menu.extend (l_menu_sep)

			l_new_menu_item := develop_window.commands.toggle_stone_cmd.new_menu_item
			develop_window.menus.view_menu.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)

			l_new_menu_item := develop_window.commands.send_stone_to_context_cmd.new_menu_item
			develop_window.menus.view_menu.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)
				-- Go to menu
			l_new_basic_item := develop_window.history_manager.new_menu
			develop_window.menus.view_menu.extend (l_new_basic_item)

				-- Separator --------------------------------------
			develop_window.menus.view_menu.extend (create {EV_MENU_SEPARATOR})
			develop_window.menus.view_menu.extend (build_class_info_menu)
			develop_window.menus.view_menu.extend (build_feature_info_menu)

				-- Separator --------------------------------------
			develop_window.menus.view_menu.extend (create {EV_MENU_SEPARATOR})

			from
				l_managed_main_formatters := develop_window.managed_main_formatters
				l_managed_main_formatters.start
			until
				l_managed_main_formatters.after
			loop
				l_form := l_managed_main_formatters.item
				l_new_basic_item := l_form.new_menu_item
				l_new_basic_item.select_actions.put_front (agent l_form.invalidate)
				develop_window.menus.view_menu.extend (l_new_basic_item)
				--add_recyclable (new_basic_item)
				l_managed_main_formatters.forth
			end

				-- Separator --------------------------------------
			develop_window.menus.view_menu.extend (create {EV_MENU_SEPARATOR})

			develop_window.menus.set_tools_layout_menu (tools_layout_menu)
			develop_window.menus.view_menu.extend (develop_window.menus.tools_layout_menu)

			develop_window.menus.set_docking_lock_menu (docking_lock_menu)
			develop_window.menus.view_menu.extend (develop_window.menus.docking_lock_menu)

			develop_window.menus.set_editor_area_manipulation_menu (editor_area_manipulation_menu)
			develop_window.menus.view_menu.extend (develop_window.menus.editor_area_manipulation_menu)

			develop_window.menus.view_menu.extend (create {EV_MENU_SEPARATOR})

			develop_window.menus.set_zoom_font_menu (editor_font_zoom_menu)
			develop_window.menus.view_menu.extend (develop_window.menus.zoom_font_menu)

			set_docking_library_menu
		end

	build_favorites_menu
			-- Build the favorites menu
		local
			l_show_favorites_menu_item: EV_MENU_ITEM
		do
			develop_window.menus.set_favorites_menu (develop_window.favorites_manager.menu)
				-- We update the state of the `Add to Favorites' command.
			if attached {CLASSI_STONE} develop_window.stone then
				develop_window.menus.favorites_menu.first.enable_sensitive
			else
				develop_window.menus.favorites_menu.first.disable_sensitive
			end

			l_show_favorites_menu_item := develop_window.commands.show_shell_tool_commands.item (develop_window.shell_tools.tool ({ES_FAVORITES_TOOL})).new_menu_item
			develop_window.menus.set_show_favorites_menu_item (l_show_favorites_menu_item)
			develop_window.menus.show_favorites_menu_item.select_actions.extend (agent develop_window.execute_show_favorites)

			develop_window.menus.favorites_menu.start
			develop_window.menus.favorites_menu.put_right (develop_window.menus.show_favorites_menu_item)

				-- The favorites menu is already collected by the favorites manager.
			auto_recycle (develop_window.menus.favorites_menu)
		end

	build_project_menu
			-- Build the project menu.
		local
			l_command_menu_item: EB_COMMAND_MENU_ITEM
			l_project_menu: EV_MENU
		do
			create l_project_menu.make_with_text (develop_window.Interface_names.m_project)
			develop_window.menus.set_project_menu (l_project_menu)

				-- Melt
			l_command_menu_item := develop_window.Melt_project_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Discover melt
			l_command_menu_item := develop_window.discover_melt_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Override scan
			l_command_menu_item := develop_window.override_scan_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Freeze
			l_command_menu_item := develop_window.Freeze_project_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Finalize
			l_command_menu_item := develop_window.Finalize_project_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Precompile
			l_command_menu_item := develop_window.precompilation_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Cancel
			l_command_menu_item := develop_window.project_cancel_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Clean recompilation
			l_command_menu_item := develop_window.clean_compile_project_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Separator -------------------------------------------------
			l_project_menu.extend (create {EV_MENU_SEPARATOR})

				-- Compile Workbench C code
			l_command_menu_item := develop_window.commands.c_workbench_compilation_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Compile Finalized C code
			l_command_menu_item := develop_window.commands.c_finalized_compilation_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

			-- Jason Wei
				-- Terminate C compilation
			l_command_menu_item := develop_window.Terminate_c_compilation_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)
			-- Jason Wei

				-- Execute Workbench code
			l_command_menu_item := develop_window.run_workbench_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Execute Finalized code
			l_command_menu_item := develop_window.run_finalized_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)


				-- Separator -------------------------------------------------
			l_project_menu.extend (create {EV_MENU_SEPARATOR})

				-- Analyze
			l_command_menu_item := develop_window.analyze_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

			l_command_menu_item := develop_window.analyze_editor_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

			l_command_menu_item := develop_window.analyze_parent_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

			l_command_menu_item := develop_window.analyze_target_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

			l_command_menu_item := develop_window.analyzer_preferences_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)


				-- Separator -------------------------------------------------
			l_project_menu.extend (create {EV_MENU_SEPARATOR})

				-- Go to next error
			l_command_menu_item := develop_window.commands.go_to_next_error_command.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Go to previous error
			l_command_menu_item := develop_window.commands.go_to_previous_error_command.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Go to next warning
			l_command_menu_item := develop_window.commands.go_to_next_warning_command.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Go to previous warning
			l_command_menu_item := develop_window.commands.go_to_previous_warning_command.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Separator -------------------------------------------------
			l_project_menu.extend (create {EV_MENU_SEPARATOR})

				-- System Tool window
			l_command_menu_item := develop_window.system_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- System information
			l_command_menu_item := develop_window.commands.system_info_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Separator -------------------------------------------------
			l_project_menu.extend (create {EV_MENU_SEPARATOR})

				-- Generate Documentation
			l_command_menu_item := develop_window.document_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)

				-- Export XMI
			l_command_menu_item := develop_window.export_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_project_menu.extend (l_command_menu_item)
		end

	build_tools_menu
			-- Create and build `tools_menu'
		local
			l_command_menu_item: EB_COMMAND_MENU_ITEM
			l_tools_menu: EV_MENU
		do
			create l_tools_menu.make_with_text (develop_window.Interface_names.m_tools)
			develop_window.menus.set_tools_menu (l_tools_menu)

				-- New Library command.
			l_command_menu_item := develop_window.commands.new_library_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.tools_menu.extend (l_command_menu_item)

				-- New Cluster command.
			l_command_menu_item := develop_window.commands.new_cluster_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.tools_menu.extend (l_command_menu_item)

				-- New Class command.
			l_command_menu_item := develop_window.commands.new_class_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.tools_menu.extend (l_command_menu_item)

				-- New Feature command.
			l_command_menu_item := develop_window.commands.new_feature_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.tools_menu.extend (l_command_menu_item)

				-- Delete class/cluster command.
			l_command_menu_item := develop_window.commands.delete_class_cluster_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.tools_menu.extend (l_command_menu_item)

				-- Separator --------------------------------------
			develop_window.menus.tools_menu.extend (create {EV_MENU_SEPARATOR})

				-- Profiler Window
			l_command_menu_item := develop_window.commands.show_profiler.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.tools_menu.extend (l_command_menu_item)

				-- Precompile Wizard
			l_command_menu_item := develop_window.wizard_precompile_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			develop_window.menus.tools_menu.extend (l_command_menu_item)

				-- Dynamic Library Window
			l_command_menu_item := develop_window.show_dynamic_lib_tool.new_menu_item
			auto_recycle (l_command_menu_item)
			l_tools_menu.extend (l_command_menu_item)

				-- Separator -------------------------------------------------
			l_tools_menu.extend (create {EV_MENU_SEPARATOR})

			l_command_menu_item := develop_window.commands.customized_formatter_command.new_menu_item
			auto_recycle (l_command_menu_item)
			l_tools_menu.extend (l_command_menu_item)

			l_command_menu_item := develop_window.commands.customized_tool_command.new_menu_item
			auto_recycle (l_command_menu_item)
			l_tools_menu.extend (l_command_menu_item)

				-- Separator -------------------------------------------------
			l_tools_menu.extend (create {EV_MENU_SEPARATOR})

					-- Preferences
			l_command_menu_item := develop_window.Show_preferences_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_tools_menu.extend (l_command_menu_item)

					-- Settings import
			l_command_menu_item := develop_window.Show_settings_import_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_tools_menu.extend (l_command_menu_item)

			if attached es_cloud_s.service as l_cloud_service then
				l_command_menu_item := develop_window.show_cloud_account_cmd.new_menu_item
				auto_recycle (l_command_menu_item)
				l_tools_menu.extend (l_command_menu_item)
			end

				-- Separator -------------------------------------------------
			l_tools_menu.extend (create {EV_MENU_SEPARATOR})

					-- External commands editor
			l_command_menu_item := develop_window.commands.Edit_external_commands_cmd.new_menu_item
			auto_recycle (l_command_menu_item)
			l_tools_menu.extend (l_command_menu_item)

			rebuild_tools_menu
		end

	rebuild_tools_menu
			-- Refresh the list of external commands.
		local
			l_ms: LIST [EB_COMMAND_MENU_ITEM]
			l_sep: EV_MENU_SEPARATOR
			l_tools_menu: EV_MENU
		do
				-- Remove all the external commands, which are at the end of the menu.
			from
				l_tools_menu := develop_window.menus.tools_menu
				l_tools_menu.go_i_th (l_tools_menu.count + 1 - develop_window.menus.number_of_displayed_external_commands)
			until
				l_tools_menu.after
			loop
				l_tools_menu.remove
			end
			l_ms := develop_window.commands.Edit_external_commands_cmd.menus
			develop_window.menus.set_number_of_displayed_external_commands (l_ms.count)

			if
				not l_ms.is_empty and
				not l_tools_menu.is_empty and then
				not attached {EV_MENU_SEPARATOR} l_tools_menu.last
			then
				create l_sep
				l_tools_menu.extend (l_sep)
				develop_window.menus.set_number_of_displayed_external_commands (develop_window.menus.number_of_displayed_external_commands + 1)
			end

			from
				l_ms.start
			until
				l_ms.after
			loop
				l_tools_menu.extend (l_ms.item)
				auto_recycle (l_ms.item)
				l_ms.forth
			end
		end

	tools_layout_menu: EV_MENU
			-- Tools docking layout menu
		local
			l_new_menu_item: EB_COMMAND_MENU_ITEM
			l_menu: EV_MENU
		do
			create Result.make_with_text (develop_window.Interface_names.m_tools_layout)

			l_new_menu_item := develop_window.commands.reset_layout_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)

			Result.extend (create {EV_MENU_SEPARATOR})

			create l_menu.make_with_text (develop_window.interface_names.m_open_layout)
			auto_recycle (l_menu)
			add_exist_layouts_to (l_menu)
			develop_window.menus.set_exist_layouts_menu (l_menu)
			Result.extend (develop_window.menus.exist_layouts_menu)

			l_new_menu_item := develop_window.commands.save_layout_as_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)
		ensure
			not_void: Result /= Void
		end

	add_exist_layouts_to (a_menu: EV_MENU)
			-- Initlialize layout list items.
		require
			not_void: a_menu /= Void
			valid: is_open_layout_menu (a_menu)
		local
			l_item: EV_MENU_ITEM
			l_names: like {EB_NAMED_LAYOUT_MANAGER}.layouts
			l_manager: EB_NAMED_LAYOUT_MANAGER
		do
			from
				create l_manager.make (develop_window)
				l_names := l_manager.layouts
				l_names.start
			until
				l_names.after
			loop
				create l_item.make_with_text (l_names.key_for_iteration)
				l_item.select_actions.extend (agent l_manager.open_layout (l_names.key_for_iteration))
				auto_recycle (l_item)

				a_menu.extend (l_item)

				l_names.forth
			end

			if a_menu.count = 0 then
				a_menu.disable_sensitive
			else
				a_menu.enable_sensitive
			end
		end

	docking_lock_menu: EV_MENU
			-- Submenu for docking lock
		local
			l_new_menu_item: EB_COMMAND_MENU_ITEM
		do
			create Result.make_with_text (develop_window.Interface_names.m_docking_lock)

			l_new_menu_item := develop_window.commands.lock_tool_bar_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)

			l_new_menu_item := develop_window.commands.lock_docking_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)

			l_new_menu_item := develop_window.commands.lock_editor_docking_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)
		ensure
			not_void: Result /= Void
		end

	editor_area_manipulation_menu: EV_MENU
			-- Submenu for editor area manipulation
		local
			l_new_menu_item: EB_COMMAND_MENU_ITEM
		do
			create Result.make_with_text (develop_window.Interface_names.m_Editor_area)


			l_new_menu_item := develop_window.commands.maximize_editor_area_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)

			l_new_menu_item := develop_window.commands.minimize_editor_area_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)

			l_new_menu_item := develop_window.commands.restore_editor_area_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)

			Result.extend (create {EV_MENU_SEPARATOR})

			l_new_menu_item := develop_window.commands.minimize_editors_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)

			l_new_menu_item := develop_window.commands.restore_editors_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)
		ensure
			not_void: Result /= Void
		end

	editor_font_zoom_menu: EV_MENU
			-- Submenu for editor font zoom manipulation
		local
			l_new_menu_item: EB_COMMAND_MENU_ITEM
		do
			create Result.make_with_text (develop_window.Interface_names.m_zoom)

			l_new_menu_item := develop_window.commands.editor_font_zoom_in_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)

			l_new_menu_item := develop_window.commands.editor_font_zoom_out_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)

			Result.extend (create {EV_MENU_SEPARATOR})

			l_new_menu_item := develop_window.commands.editor_font_zoom_reset_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)
		ensure
			not_void: Result /= Void
		end

	tool_list_menu: EV_MENU
			-- Build toolbar corresponding to available left panels.
		do
			create Result.make_with_text (develop_window.Interface_names.m_Explorer_bar)
			Result.wipe_out
			insert_show_tool_menu_item (Result, {ES_FEATURES_TOOL})
			insert_show_tool_menu_item (Result, {ES_GROUPS_TOOL})
			Result.extend (create {EV_MENU_SEPARATOR})
			insert_show_tool_menu_item (Result, {ES_CLASS_TOOL})
			insert_show_tool_menu_item (Result, {ES_FEATURE_RELATION_TOOL})
			insert_show_tool_menu_item (Result, {ES_DEPENDENCY_TOOL})
			Result.extend (create {EV_MENU_SEPARATOR})
			if attached (create {SERVICE_CONSUMER [OUTPUT_MANAGER_S]}).service then
				insert_show_tool_menu_item (Result, {ES_OUTPUTS_TOOL})
			end
			insert_show_tool_menu_item (Result, {ES_CONSOLE_TOOL})
			if attached (create {SERVICE_CONSUMER [EVENT_LIST_S]}).service then
				Result.extend (create {EV_MENU_SEPARATOR})
				insert_show_tool_menu_item (Result, {ES_ERROR_LIST_TOOL})
			end
			Result.extend (create {EV_MENU_SEPARATOR})
			insert_show_tool_menu_item (Result, {ES_SEARCH_TOOL})
			insert_show_tool_menu_item (Result, {ES_SEARCH_REPORT_TOOL})
			Result.extend (create {EV_MENU_SEPARATOR})
			insert_show_tool_menu_item (Result, {ES_PROPERTIES_TOOL})
			insert_show_tool_menu_item (Result, {ES_DIAGRAM_TOOL})
			insert_show_tool_menu_item (Result, {ES_METRICS_TOOL})
			insert_show_tool_menu_item (Result, {ES_CONTRACT_TOOL})
			insert_show_tool_menu_item (Result, {ES_INFORMATION_TOOL})
			Result.extend (create {EV_MENU_SEPARATOR})
			insert_show_tool_menu_item (Result, {ES_WINDOWS_TOOL})
			insert_show_tool_menu_item (Result, {ES_FAVORITES_TOOL})
			if attached (create {SERVICE_CONSUMER [TEST_SUITE_S]}).service then
				Result.extend (create {EV_MENU_SEPARATOR})
				insert_show_tool_menu_item (Result, {ES_TESTING_TOOL})
				insert_show_tool_menu_item (Result, {ES_TESTING_RESULTS_TOOL})
			end
			if attached (create {SERVICE_CONSUMER [TOOL_MENU_EXTENSION_S]}).service as s then
				Result.extend (create {EV_MENU_SEPARATOR})
				s.extend (agent menu_extender.extend (?, ?, ?, ?, Result))
			end
		end

	build_window_menu
			-- Create and build `window_menu'
		local
			l_menu: EB_WINDOW_MANAGER_MENU
			l_menu_sep: EV_MENU_SEPARATOR
		do
			l_menu := develop_window.window_manager.new_menu

			l_menu.extend (develop_window.commands.reload_current_panel_command.new_menu_item)
			l_menu.extend (develop_window.commands.close_current_panel_command.new_menu_item)
			l_menu.extend (develop_window.commands.close_all_tab_command.new_menu_item)
			l_menu.extend (develop_window.commands.close_all_but_current_command.new_menu_item)
			l_menu.extend (develop_window.commands.close_all_empty_tab_command.new_menu_item)
			l_menu.extend (develop_window.commands.close_all_but_unsaved_command.new_menu_item)

			create l_menu_sep
			l_menu.extend (l_menu_sep)

			develop_window.menus.set_window_menu (l_menu)
			auto_recycle (develop_window.menus.window_menu)
		ensure
			window_menu_created: is_window_menu_created
		end

	build_help_menu
			-- Create and build `help_menu'
		local
			l_menu_item: EV_MENU_ITEM
			l_about_cmd: EB_ABOUT_COMMAND
			l_license_cmd: EB_LICENSE_COMMAND
			l_menu_sep: EV_MENU_SEPARATOR
			l_help_menu: EV_MENU
		do
			create l_help_menu.make_with_text (develop_window.Interface_names.m_Help)
			develop_window.menus.set_help_menu (l_help_menu)

				-- Guided Tour
			create l_menu_item.make_with_text (develop_window.Interface_names.m_Guided_tour)
			register_action (l_menu_item.select_actions, agent develop_window.display_guided_tour)
			l_help_menu.extend (l_menu_item)

				-- Contents
			create l_menu_item.make_with_text (develop_window.Interface_names.m_Contents)
			register_action (l_menu_item.select_actions, agent develop_window.display_help_contents)
			l_help_menu.extend (l_menu_item)

				-- How to's
			create l_menu_item.make_with_text (develop_window.Interface_names.m_How_to_s)
			register_action (l_menu_item.select_actions, agent develop_window.display_how_to_s)
			l_help_menu.extend (l_menu_item)

				-- Eiffel introduction
			create l_menu_item.make_with_text (develop_window.Interface_names.m_Eiffel_introduction)
			register_action (l_menu_item.select_actions, agent develop_window.display_eiffel_introduction)
			l_help_menu.extend (l_menu_item)

				-- Add the separator
			create l_menu_sep
			l_help_menu.extend (l_menu_sep)

				-- License
			create l_license_cmd
			if l_license_cmd.is_available then
				create l_menu_item.make_with_text (develop_window.Interface_names.m_license)
				register_action (l_menu_item.select_actions, agent l_license_cmd.execute)
				l_help_menu.extend (l_menu_item)
			end

				-- About
			create l_menu_item.make_with_text (develop_window.Interface_names.m_About)
			create l_about_cmd
			register_action (l_menu_item.select_actions, agent l_about_cmd.execute)
			l_help_menu.extend (l_menu_item)
		ensure
			help_menu_created: is_help_menu_created
		end

	insert_show_tool_menu_item (a_menu: EV_MENU; a_tool: TYPE [ES_TOOL [EB_TOOL]])
			-- Inserts a menu item for showing a tool.
			--
			-- `a_menu': The menu to insert a generated menu item into.
			-- `a_tool': The tool shim type used to activate and show the tool.
		require
			a_menu_attached: a_menu /= Void
			not_a_menu_is_destroyed: not a_menu.is_destroyed
			a_tool_attached: a_tool /= Void
		local
			l_tool: ES_TOOL [EB_TOOL]
			l_menu_item: EB_COMMAND_MENU_ITEM
			l_cmd: ES_SHOW_TOOL_COMMAND
		do
			l_tool := develop_window.shell_tools.tool (a_tool)
			l_cmd := develop_window.commands.show_shell_tool_commands.item (l_tool)
			if l_cmd = Void then
				create l_cmd.make (l_tool)
				develop_window.auto_recycle (l_cmd)
				develop_window.commands.show_shell_tool_commands.force (l_cmd, l_tool)
			end

			l_menu_item := l_cmd.new_menu_item
			auto_recycle (l_menu_item)
			a_menu.extend (l_menu_item)
		end

feature {EB_SAVE_LAYOUT_DIALOG, EB_DEBUGGER_MANAGER} -- Exist docking layout sub menu

	update_exist_layouts_menu
			-- Update open layout menu with exist layout files
		local
			l_menu: EV_MENU
			l_found: BOOLEAN
		do
			l_menu := develop_window.menus.tools_layout_menu
			from
				l_menu.start
			until
				l_menu.after or l_found
			loop
				if l_menu.item.text ~ develop_window.interface_names.m_open_layout then
					if attached {EV_MENU} l_menu.item as l_open_layout_menu then
						l_open_layout_menu.wipe_out
						add_exist_layouts_to (l_open_layout_menu)
						l_found := True
					end
				end

				l_menu.forth
			end
--			check must_found: l_found end

		end

feature {NONE} -- Agents for editor

	current_editor: EB_SMART_EDITOR
			-- Current editor
		do
			Result := develop_window.editors_manager.current_editor
		end

	editor_search
			-- Search some text in the focused editor.
		local
			l_tool: ES_TOOL [EB_TOOL]
			l_cmd: ES_SHOW_TOOL_COMMAND
		do
			if current_editor /= Void then
				current_editor.search
			else
				l_tool := develop_window.shell_tools.tool ({ES_SEARCH_TOOL})
				l_cmd := develop_window.commands.show_shell_tool_commands.item (l_tool)
				l_cmd.execute
			end
		end

	editor_replace
			-- Replace in current editor.
		local
			l_tool: ES_TOOL [EB_TOOL]
			l_cmd: ES_SHOW_TOOL_COMMAND
		do
			if current_editor /= Void then
				current_editor.replace
			else
				l_tool := develop_window.shell_tools.tool ({ES_SEARCH_TOOL})
				l_cmd := develop_window.commands.show_shell_tool_commands.item (l_tool)
				l_cmd.execute
			end
		end

	editor_prettify
			-- Prettify class in current editor.
		do
			if attached current_editor as l_editor then
				l_editor.prettify
			end
		end

	editor_indent_selection
			-- Indent selection in current editor.
		do
			if current_editor /= Void then
				current_editor.indent_selection
			end
		end

	editor_unindent_selection
			-- Unindent selection in current editor.
		do
			if current_editor /= Void then
				current_editor.unindent_selection
			end
		end

	editor_set_selection_case (a_case: BOOLEAN)
			-- Set selection case in current editor.
		do
			if current_editor /= Void then
				current_editor.set_selection_case (a_case)
			end
		end

	editor_comment_selection
			-- Comment selection in current editor.
		do
			if current_editor /= Void then
				current_editor.comment_selection
			end
		end

	editor_uncomment_selection
			-- Uncomment selection in current editor.
		do
			if current_editor /= Void then
				current_editor.uncomment_selection
			end
		end

	editor_embed_in_block (a_string: STRING; post_pos: INTEGER)
			-- Embed `a_string' in current editor.
		require
			a_string_not_void: a_string /= Void
			post_pos_valid: post_pos > 0 and then post_pos <= a_string.count
		do
			if current_editor /= Void then
				current_editor.embed_in_block (a_string, post_pos)
			end
		end

	editor_complete_feature_name
			-- Complete feature name in current editor.
		do
			if attached current_editor as e then
				e.complete_feature_name
			end
		end

	editor_complete_class_name
			-- Complete class name in current editor.
		do
			if current_editor /= Void then
				current_editor.complete_class_name
			end
		end

feature -- Contract support

	is_window_menu_created: BOOLEAN
			-- If window menu created?
		do
			Result := develop_window.menus.window_menu /= Void
		end

	is_help_menu_created: BOOLEAN
			-- If help menu created?
		do
			Result := develop_window.menus.help_menu /= Void
		end

	is_open_layout_menu (a_menu: EV_MENU): BOOLEAN
			-- If `a_menu' is open layout menu?
		require
			not_void: a_menu /= Void
		do
			Result := a_menu.text ~ develop_window.interface_names.m_open_layout
		end

feature -- Docking library menu items

	set_docking_library_menu
			-- Setup docking library notebook tab and title bar's menu items
		local
			l_shared: SD_SHARED
		do
			create l_shared
			if l_shared.notebook_tab_area_menu_items_agent = Void then
				l_shared.set_notebook_tab_area_menu_items_agent (agent docking_menu_item (?, True))
			end

			if l_shared.title_bar_area_menu_items_agent = Void then
				l_shared.set_title_bar_area_menu_items_agent (agent docking_menu_item (?, False))
			end
		end

	docking_menu_item (a_content: SD_CONTENT; a_with_separtor: BOOLEAN): ARRAYED_LIST [EV_MENU_ITEM]
			-- Docking library menu items agent
		local
			l_new_menu_item: EV_MENU_ITEM
			l_window_manager: EB_SHARED_WINDOW_MANAGER
			l_last_development_window: EB_DEVELOPMENT_WINDOW
		do
			create l_window_manager
			l_last_development_window := l_window_manager.window_manager.last_focused_development_window

			create Result.make (5)

			if a_with_separtor then
				Result.extend (create {EV_MENU_SEPARATOR})
			end

			append_file_location_menu (a_content, Result, l_last_development_window)

			l_new_menu_item := l_last_development_window.commands.lock_tool_bar_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)

			l_new_menu_item := l_last_development_window.commands.lock_docking_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)

			l_new_menu_item := l_last_development_window.commands.lock_editor_docking_command.new_menu_item
			Result.extend (l_new_menu_item)
			auto_recycle (l_new_menu_item)

			if a_content.type = {SD_ENUMERATION}.editor then
					-- Separator --------------------------------------
				Result.extend (create {EV_MENU_SEPARATOR})

				l_new_menu_item := l_last_development_window.commands.maximize_editor_area_command.new_menu_item
				Result.extend (l_new_menu_item)
				auto_recycle (l_new_menu_item)

				l_new_menu_item := l_last_development_window.commands.minimize_editor_area_command.new_menu_item
				Result.extend (l_new_menu_item)
				auto_recycle (l_new_menu_item)

				l_new_menu_item := l_last_development_window.commands.restore_editor_area_command.new_menu_item
				Result.extend (l_new_menu_item)
				auto_recycle (l_new_menu_item)

					-- Separator --------------------------------------
				Result.extend (create {EV_MENU_SEPARATOR})

				l_new_menu_item := l_last_development_window.commands.minimize_editors_command.new_menu_item
				Result.extend (l_new_menu_item)
				auto_recycle (l_new_menu_item)

				l_new_menu_item := l_last_development_window.commands.restore_editors_command.new_menu_item
				Result.extend (l_new_menu_item)
				auto_recycle (l_new_menu_item)

					-- Separator --------------------------------------
				Result.extend (create {EV_MENU_SEPARATOR})
				l_new_menu_item := l_last_development_window.commands.restore_tab_cmd.new_menu_item
				Result.extend (l_new_menu_item)
				auto_recycle (l_new_menu_item)

			end
		end

	append_file_location_menu (a_content: SD_CONTENT; a_list: LIST [EV_MENU_ITEM]; a_dev_window: EB_DEVELOPMENT_WINDOW)
			-- Depend on `a_content', add two file path menu entries to `a_list' if possible
		require
			not_void: a_content /= Void
			not_void: a_list /= Void
			not_void: a_dev_window /= Void
		local
			l_editor: EB_SMART_EDITOR
			l_all_editors: LIST [EB_SMART_EDITOR]
			l_file_name: like {FILED_STONE}.file_name
			l_menu_item: EV_MENU_ITEM
		do
			if a_content.type = {SD_ENUMERATION}.editor then
				if attached {EV_HORIZONTAL_BOX} a_content.user_widget as lt_box then

					from
						l_all_editors := a_dev_window.editors_manager.editors
						l_all_editors.start
					until
						l_all_editors.after or l_editor /= Void
					loop
						if a_content = l_all_editors.item.docking_content then
							l_editor := l_all_editors.item
						end
						l_all_editors.forth
					end
					if l_editor /= Void then
						if attached {CLASSI_STONE} l_editor.stone as lt_class_stone then
							l_file_name := lt_class_stone.file_name
							if not l_file_name.is_empty then
								create l_menu_item.make_with_text (a_dev_window.interface_names.m_Copy_full_path)
								l_menu_item.select_actions.extend (agent (a_path: READABLE_STRING_GENERAL)
										require
											not_void: a_path /= Void and then not a_path.is_empty
										local
											l_env: EV_ENVIRONMENT
										 do
											create l_env
											l_env.application.clipboard.set_text (a_path)
										end (l_file_name))
								a_list.extend (l_menu_item)
								auto_recycle (l_menu_item)
								create l_menu_item.make_with_text (a_dev_window.interface_names.m_open_containing_folder)
								l_menu_item.select_actions.extend (agent (a_path: READABLE_STRING_GENERAL)
									require
										not_void: a_path /= Void and then not a_path.is_empty
									local
										l_launcher: EB_PROCESS_LAUNCHER
									do
										l_launcher := (create {EB_SHARED_MANAGERS}).external_launcher
										l_launcher.open_file_in_file_browser (a_path)
									end (l_file_name))
								a_list.extend (l_menu_item)
								auto_recycle (l_menu_item)

								-- Separator --------------------------------------
								a_list.extend (create {EV_MENU_SEPARATOR})
							end
						end
					end

				end

			end
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
