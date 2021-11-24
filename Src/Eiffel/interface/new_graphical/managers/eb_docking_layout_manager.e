note
	description: "[
					Docking layout response for opening/saving development	
					window normal/debug docking layouts
																			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DOCKING_LAYOUT_MANAGER

inherit
	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_DEVELOPMENT_WINDOW_PART

create
	make

feature -- Normal mode command

	save_tools_docking_layout
			-- Save all tools docking layout.
		local
			l_result: BOOLEAN
		do
			-- If directly exiting Eiffel Studio from EB_DEBUGGER_MANAGER, then we don't save the tools layout,
			-- because current widgets layout is debug mode layout (not normal mode layout),
			-- and the debug mode widgets layout is saved by EB_DEBUGGER_MANAGER already.
			if
				attached {EB_DEBUGGER_MANAGER} develop_window.debugger_manager as l_eb_debugger_manager and then
				not l_eb_debugger_manager.is_exiting_eiffel_studio
			then
				l_result := develop_window.docking_manager.save_tools_data_with_path (eiffel_layout.user_docking_standard_file_name (develop_window.window_id))
				if not l_result then
					show_last_error
				end
			end
		end

	construct_standard_layout_by_code
			-- After docking manager contains all widgets, set all tools to standard default layout.
		do
			develop_window.editors_manager.synchronize_with_docking_manager
			construct_standard_layout_by_code_imp
		end

	restore_tools_docking_layout
			-- Restore docking layout information
		do
			-- We can't restore tools layout when `window'.`is_minimized' since EV_SPLIT_AREA can't be restored if window minimized
			-- See bug#14309
			if develop_window.window.is_minimized then
				restore_agent_for_restore_action := agent restore_tools_docking_layout_immediately
				develop_window.window.restore_actions.extend_kamikaze (restore_agent_for_restore_action)

				-- If window is minized from maximized states directly...
				restore_agent_for_maximize_action := agent restore_tools_docking_layout_immediately
				develop_window.window.maximize_actions.extend_kamikaze (restore_agent_for_maximize_action)
			else
				restore_tools_docking_layout_immediately
			end
		end

	restore_standard_tools_docking_layout
			-- Restore statndard layout.
		local
			l_file_name: PATH
			l_file: RAW_FILE
			l_result: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				l_file_name := eiffel_layout.user_docking_standard_file_name (develop_window.window_id)
				create l_file.make_with_path (l_file_name)
				if l_file.exists then
					l_result := develop_window.docking_manager.open_tools_config_with_path (l_file_name)
					if not l_result then
						construct_standard_layout_by_code
					end
				else
					construct_standard_layout_by_code
				end
			else
				construct_standard_layout_by_code
			end
			develop_window.menus.update_menu_lock_items
			develop_window.menus.update_show_tool_bar_items
		rescue
			if not retried then
				retried := True
				retry
			end
		end

feature -- Debug mode command

	restore_debug_docking_layout
			-- Restore debug docking layout
		local
			l_result: BOOLEAN
			l_file: RAW_FILE
		do
			create l_file.make_with_path (eiffel_layout.user_docking_debug_file_name (develop_window.window_id))
			if l_file.exists then
				l_result := develop_window.docking_manager.open_tools_config_with_path (eiffel_layout.user_docking_debug_file_name (develop_window.window_id))
			end
			if not l_result then
				restore_standard_debug_docking_layout
			end

			develop_window.menus.update_menu_lock_items
			develop_window.menus.update_show_tool_bar_items

			develop_window.eb_debugger_manager.refresh_breakpoints_tool
		end

	restore_standard_debug_docking_layout_by_code
			-- Restore standard debug docking layout.
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_shell_tools: ES_SHELL_TOOLS
			l_tool: ES_TOOL [EB_TOOL]
			l_last_tool: ES_TOOL [EB_TOOL]
			l_watch_tools: LINKED_SET [ES_WATCH_TOOL]
			l_sd_button: SD_TOOL_BAR_ITEM
			l_debugger_manager: EB_DEBUGGER_MANAGER
			l_tool_bar_content: SD_TOOL_BAR_CONTENT
			l_env: EV_ENVIRONMENT
		do
			l_debugger_manager := develop_window.eb_debugger_manager

			l_tool_bar_content := develop_window.docking_manager.tool_bar_manager.content_by_title (develop_window.Interface_names.to_Project_toolbar)
			check not_void: l_tool_bar_content /= Void end

			-- Setup toolbar buttons
			check at_least_one_button: l_debugger_manager.restart_cmd.managed_sd_toolbar_items.count >= 1 end
			l_sd_button := tool_bar_item_belong_to (l_tool_bar_content, l_debugger_manager.restart_cmd.managed_sd_toolbar_items)
			if l_sd_button /= Void then
				l_sd_button.enable_displayed
			end

			check at_least_one_button: l_debugger_manager.stop_cmd.managed_sd_toolbar_items.count >= 1 end
			l_sd_button := tool_bar_item_belong_to (l_tool_bar_content, l_debugger_manager.stop_cmd.managed_sd_toolbar_items)
			if l_sd_button /= Void then
				l_sd_button.enable_displayed
			end

			check at_least_one_button: l_debugger_manager.quit_cmd.managed_sd_toolbar_items.count >= 1 end
			l_sd_button := tool_bar_item_belong_to (l_tool_bar_content, l_debugger_manager.quit_cmd.managed_sd_toolbar_items)
			if l_sd_button /= Void then
				l_sd_button.enable_displayed
			end

			check at_least_one_button: l_debugger_manager.attach_cmd.managed_sd_toolbar_items.count >= 1 end
			l_sd_button := tool_bar_item_belong_to (l_tool_bar_content, l_debugger_manager.attach_cmd.managed_sd_toolbar_items)
			if l_sd_button /= Void then
				l_sd_button.enable_displayed
			end

			check at_least_one_button: l_debugger_manager.detach_cmd.managed_sd_toolbar_items.count >= 1 end
			l_sd_button := tool_bar_item_belong_to (l_tool_bar_content, l_debugger_manager.detach_cmd.managed_sd_toolbar_items)
			if l_sd_button /= Void then
				l_sd_button.enable_displayed
			end

			check at_least_one_button: l_debugger_manager.assertion_checking_handler_cmd.managed_sd_toolbar_items.count >= 1 end
			l_sd_button := tool_bar_item_belong_to (l_tool_bar_content, l_debugger_manager.assertion_checking_handler_cmd.managed_sd_toolbar_items)
			if l_sd_button /= Void then
				l_sd_button.enable_displayed
			end

			check at_least_one_button: l_debugger_manager.ignore_breakpoints_cmd.managed_sd_toolbar_items.count >= 1 end
			l_sd_button := tool_bar_item_belong_to (l_tool_bar_content, l_debugger_manager.ignore_breakpoints_cmd.managed_sd_toolbar_items)
			if l_sd_button /= Void then
				l_sd_button.enable_displayed
			end

			l_tool_bar_content.refresh

				-- Setup tools
			develop_window.close_all_tools

			l_shell_tools := develop_window.shell_tools

				--| Class tool (below the editor)
			l_tool := l_shell_tools.tool ({ES_CLASS_TOOL})
			l_tool.content.set_top ({SD_ENUMERATION}.bottom)
			l_last_tool := l_tool

				--| Features relation tool (tabbed with Class tool)
			l_tool := l_shell_tools.tool ({ES_FEATURE_RELATION_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)
			l_last_tool := l_tool

				--| Objects tool
			l_tool := l_shell_tools.tool ({ES_OBJECTS_TOOL})
			l_tool.content.set_top ({SD_ENUMERATION}.bottom)
			l_last_tool := l_tool

			-- FIXIT: *Maybe* here is a Windows bug or Vision2 bug, when "reset tools layout" (from menu), if we
			-- call `l_debugger_manager.objects_tool).show (True)' directy, the widgets will not be diplayed correctly (all grey)
			-- so we do it in idle actions
			-- However, this is not total fix...sometimes, it still not work...
			create l_env
			l_env.application.do_once_on_idle (
				agent (ia_debugger_manager: EB_DEBUGGER_MANAGER)
					local
						la_tool: ES_OBJECTS_TOOL
					do
						la_tool := ia_debugger_manager.objects_tool
						if la_tool /= Void and then la_tool.is_interface_usable then
							la_tool.show (True)
						end
					end (l_debugger_manager))

				--| Breakpoints tool
			l_tool := l_shell_tools.tool ({ES_BREAKPOINTS_TOOL})
			l_tool.content.set_relative (l_last_tool.content, {SD_ENUMERATION}.right)
			l_last_tool := l_tool

				--| Threads tool
			l_tool := l_shell_tools.tool ({ES_THREADS_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)
			l_last_tool := l_tool

				--| Watch tools
			l_watch_tools := l_debugger_manager.watch_tool_list
			from
				l_watch_tools.finish
			until
				l_watch_tools.before
			loop
				l_watch_tools.item.content.set_tab_with (l_last_tool.content, True)
				l_last_tool := l_watch_tools.item
				l_watch_tools.back
			end

				--| Diagram tool
			l_tool := l_shell_tools.tool ({ES_DIAGRAM_TOOL})
			if l_tool.content.state_value = {SD_ENUMERATION}.auto_hide then
				-- Same reason as EB_DEVELOPMENT_WINDOW.internal_construct_standard_layout_by_code.
				-- First we pin it, then pin it again. So we can make sure the tab stub order and tab stub direction.
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			else
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			end

				--| Dependency tool
			l_tool := l_shell_tools.tool ({ES_DEPENDENCY_TOOL})
			if l_tool.content.state_value = {SD_ENUMERATION}.auto_hide then
				-- First we pin it, then pin it again. So we can make sure the tab stub order and tab stub direction.
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			else
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			end
			l_last_tool := l_tool

				--| Metrics tool
			l_tool := l_shell_tools.tool ({ES_METRICS_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, False)
			l_last_tool := l_tool

				--| Error list tool
			l_tool := l_shell_tools.tool ({ES_ERROR_LIST_TOOL})
			if l_tool.content.state_value = {SD_ENUMERATION}.auto_hide then
				-- Same reason as EB_DEVELOPMENT_WINDOW.internal_construct_standard_layout_by_code.
				-- First we pin it, then pin it again. So we can make sure the tab stub order and tab stub direction.
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			else
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			end
			l_last_tool := l_tool

				--| Adding call stack tool to the left of the testing tool (which will appear in front)
			l_tool := l_shell_tools.tool ({ES_CALL_STACK_TOOL})
			l_tool.content.set_top ({SD_ENUMERATION}.right)
			l_last_tool := l_tool

				--| Testing tool to the right (which will be the actual position of the previous tool)
			l_tool := l_shell_tools.tool ({ES_TESTING_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, False)
			l_last_tool := l_tool

				--| Source control tool to the right (which will be the actual position of the previous tool)
			l_tool := l_shell_tools.tool ({ES_SCM_TOOL})
			if l_tool /= Void then
				l_tool.content.set_tab_with (l_last_tool.content, False)
				l_last_tool := l_tool
			end

				--| Adding favourites tool to the right of the testing tool (hidden)
			l_tool := l_shell_tools.tool ({ES_FAVORITES_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, False)
			l_last_tool := l_tool

				-- We do this to make sure the minimized editor minized horizontally, otherwise the editor will be minimized vertically.

				--| Minimize all editors
			from
				l_contents := develop_window.docking_manager.contents
				l_contents.start
			until
				l_contents.after
			loop
				if l_contents.item.type = {SD_ENUMERATION}.editor then
					l_contents.item.minimize
				end
				l_contents.forth
			end
		end

	save_debug_docking_layout
			-- Save debug docking layout
		local
			l_result: BOOLEAN
		do
			if develop_window /= Void then
				l_result := develop_window.docking_manager.save_tools_data_with_path (eiffel_layout.user_docking_debug_file_name (develop_window.window_id))
				if not l_result then
					show_last_error
				end
			end
		end

	restore_standard_debug_docking_layout
			-- Restore standard debug docking layout.
		local
			l_result: BOOLEAN
			l_file: RAW_FILE
			l_fn: PATH
		do
			l_fn := eiffel_layout.user_docking_debug_file_name (develop_window.window_id)
			create l_file.make_with_path (l_fn)
			if l_file.exists then
				l_result := develop_window.docking_manager.open_tools_config_with_path (l_fn)
			end
			if not l_result then
					-- Synchronize editors with docking contents
				develop_window.editors_manager.synchronize_with_docking_manager
				restore_standard_debug_docking_layout_by_code
			end
		end

feature {NONE} -- Implementation

	tool_bar_item_belong_to (a_tool_bar_content: SD_TOOL_BAR_CONTENT; a_all_items: LIST [SD_TOOL_BAR_ITEM]): SD_TOOL_BAR_ITEM
			-- Find one item in `a_all_items' which belong to `a_tool_bar_content'
		require
			not_void: a_tool_bar_content /= Void
			not_void: a_all_items /= Void
		local
			l_tool_bar_items: SET [SD_TOOL_BAR_ITEM]
		do
			from
				l_tool_bar_items := a_tool_bar_content.items
				a_all_items.start
			until
				a_all_items.after or Result /= Void
			loop
				if l_tool_bar_items.has (a_all_items.item) then
					Result := a_all_items.item
				end

				a_all_items.forth
			end
		end

	project_docking_standard_file_name: PATH
			-- Docking config file name.
		do
			Result := develop_window.project_location.target_path.extended (eiffel_layout.docking_standard_file + "_" + develop_window.window_id.out)
		end

	restore_agent_for_restore_action, restore_agent_for_maximize_action:  PROCEDURE
			-- Restore agent recorded for cleanup

	restore_tools_docking_layout_immediately
			-- Restore docking layout information immediately
		local
			l_result: BOOLEAN
			l_file_name: PATH
			l_raw_file: RAW_FILE
		do
			-- Cleanup agents
			if (restore_agent_for_maximize_action /= Void)then
				develop_window.window.maximize_actions.prune_all (restore_agent_for_maximize_action)
				restore_agent_for_maximize_action := Void
			end

			if (restore_agent_for_restore_action /= Void) then
				develop_window.window.restore_actions.prune_all (restore_agent_for_restore_action)
				restore_agent_for_restore_action := Void
			end

			l_file_name := eiffel_layout.user_docking_standard_file_name (develop_window.window_id)
			create l_raw_file.make_with_path (l_file_name)
			if l_raw_file.exists then
				l_result := develop_window.docking_manager.open_tools_config_with_path (l_file_name)
			end

			if not l_result then
				restore_standard_tools_docking_layout
			end
			develop_window.menus.update_menu_lock_items
			develop_window.menus.update_show_tool_bar_items
		end

	construct_standard_layout_by_code_imp
			-- Implementation of `construct_standard_layout_by_code'
		local
			l_shell_tools: ES_SHELL_TOOLS
			l_tool: ES_TOOL [EB_TOOL]
			l_last_tool: ES_TOOL [EB_TOOL]
			l_tool_bar_content, l_tool_bar_content_2: SD_TOOL_BAR_CONTENT
			l_no_locked_window: BOOLEAN
		do
			l_shell_tools := develop_window.shell_tools

			l_no_locked_window := ((create {EV_ENVIRONMENT}).application.locked_window = Void)
			if l_no_locked_window then
				develop_window.window.lock_update
			end
			develop_window.close_all_tools

				-- Right bottom tools
			l_tool := l_shell_tools.tool ({ES_TESTING_RESULTS_TOOL})
			l_tool.content.set_top ({SD_ENUMERATION}.bottom)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_ERROR_LIST_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_OUTPUTS_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_FEATURE_RELATION_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_CLASS_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)
			l_last_tool := l_tool

			l_tool.content.set_split_proportion ({REAL_32} 0.6)

				-- Right tools
			l_tool := l_shell_tools.tool ({ES_FAVORITES_TOOL})
			l_tool.content.set_top ({SD_ENUMERATION}.right)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_TESTING_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_SCM_TOOL})
			if l_tool /= Void then
				l_tool.content.set_tab_with (l_last_tool.content, True)
				l_last_tool := l_tool
			end

			l_tool := l_shell_tools.tool ({ES_FEATURES_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_GROUPS_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, True)

			l_tool.content.set_split_proportion ({REAL_32} 0.73)

				-- Auto hide (bottom) tools
			l_tool := l_shell_tools.tool ({ES_DIAGRAM_TOOL})
			if l_tool.content.state_value /= {SD_ENUMERATION}.auto_hide then
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			else
				-- First we pin it, then pin it again. So we can make sure the tab stub order and tab stub direction.
				-- Docking library will add a feature to set auto hide tab stub order directly in the future. -- Larry 2007/7/13
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			end
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_DEPENDENCY_TOOL})
			if l_tool.content.state_value /= {SD_ENUMERATION}.auto_hide then
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			else
				-- First we pin it, then pin it again. So we can make sure the tab stub order and tab stub direction.
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			end
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_METRICS_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, False)
			l_last_tool := l_tool

			l_tool := l_shell_tools.tool ({ES_INFORMATION_TOOL})
			l_tool.content.set_tab_with (l_last_tool.content, False)
			l_last_tool := l_tool

			-- Tool bars
			l_tool_bar_content := develop_window.docking_manager.tool_bar_manager.content_by_title (interface_names.to_standard_toolbar)
			l_tool_bar_content_2 := l_tool_bar_content
			check not_void: l_tool_bar_content /= Void end
			l_tool_bar_content.set_top ({SD_ENUMERATION}.top)

			l_tool_bar_content := develop_window.docking_manager.tool_bar_manager.content_by_title (interface_names.to_address_toolbar)
			check not_void: l_tool_bar_content /= Void end
			l_tool_bar_content.set_top ({SD_ENUMERATION}.top)

			l_tool_bar_content := develop_window.docking_manager.tool_bar_manager.content_by_title (interface_names.to_project_toolbar)
			check not_void: l_tool_bar_content /= Void end
			l_tool_bar_content.set_top_with (l_tool_bar_content_2)

			l_tool_bar_content := develop_window.docking_manager.tool_bar_manager.content_by_title (interface_names.to_refactory_toolbar)
			check not_void: l_tool_bar_content /= Void end
			l_tool_bar_content.set_top ({SD_ENUMERATION}.top)
			-- We first call `set_top' because we want set a default location for the tool bar.
			l_tool_bar_content.hide

			if l_no_locked_window then
				develop_window.window.unlock_update
			end
		end

	show_last_error
			-- Show last exception error
		local
			l_information: ES_PROMPT_PROVIDER
			l_exception: EXCEPTION_MANAGER
			l_tag: READABLE_STRING_GENERAL
			l_last_exception: EXCEPTION
		do
			create l_exception
			l_last_exception := l_exception.last_exception
			if l_last_exception /= Void then
				l_tag := l_last_exception.tag
				if l_tag = Void then
					l_tag := interface_names.l_unknown_error
				end
				create l_information
				l_information.show_error_prompt (interface_names.l_saving_docking_data_error (l_tag), Void, Void)
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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

end -- class EB_DOCKING_LAYOUT_MANAGER
