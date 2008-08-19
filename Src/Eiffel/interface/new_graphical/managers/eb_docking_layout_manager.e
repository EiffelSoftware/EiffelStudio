indexing
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
		redefine
			internal_recycle
		end

create
	make

feature -- Normal mode command

	save_tools_docking_layout is
			-- Save all tools docking layout.
		local
			l_eb_debugger_manager: EB_DEBUGGER_MANAGER
			l_result: BOOLEAN
		do
			l_eb_debugger_manager ?= develop_window.debugger_manager
			-- If directly exiting Eiffel Studio from EB_DEBUGGER_MANAGER, then we don't save the tools layout,
			-- because current widgets layout is debug mode layout (not normal mode layout),
			-- and the debug mode widgets layout is saved by EB_DEBUGGER_MANAGER already.
			if l_eb_debugger_manager /= Void and then not l_eb_debugger_manager.is_exiting_eiffel_studio then
				l_result := develop_window.docking_manager.save_tools_data (eiffel_layout.user_docking_standard_file_name (develop_window.window_id))
				if not l_result then
					show_last_error
				end
			end
		end

	save_editors_docking_layout is
			-- Save all editors docking layout.
		local
			l_result: BOOLEAN
		do
			l_result := develop_window.docking_manager.save_editors_data (project_docking_standard_file_name)
			if not l_result then
				show_last_error
			end
		end

	construct_standard_layout_by_code is
			-- After docking manager have all widgets, set all tools to standard default layout.
		local
			l_tool: EB_TOOL
			l_last_tool: EB_TOOL
			l_tool_bar_content, l_tool_bar_content_2: SD_TOOL_BAR_CONTENT
			l_no_locked_window: BOOLEAN
			l_features_tool: ES_FEATURES_TOOL
		do
			l_no_locked_window := ((create {EV_ENVIRONMENT}).application.locked_window = Void)
			if l_no_locked_window then
				develop_window.window.lock_update
			end
			develop_window.close_all_tools

			-- Right bottom tools
			l_tool := develop_window.tools.c_output_tool
			l_tool.content.set_top ({SD_ENUMERATION}.bottom)

			l_tool := develop_window.shell_tools.tool ({ES_ERROR_LIST_TOOL}).panel
			l_tool.content.set_tab_with (develop_window.tools.c_output_tool.content, True)
			l_last_tool := l_tool

			l_tool := develop_window.tools.output_tool
			l_tool.content.set_tab_with (l_last_tool.content, True)

			l_tool := develop_window.tools.features_relation_tool
			l_tool.content.set_tab_with (develop_window.tools.output_tool.content, True)

			l_tool := develop_window.tools.class_tool
			l_tool.content.set_tab_with (develop_window.tools.features_relation_tool.content, True)

			l_tool.content.set_split_proportion (0.6)

			-- Right tools
			l_features_tool ?= develop_window.shell_tools.tool ({ES_FEATURES_TOOL})

			l_tool := develop_window.tools.favorites_tool
			l_tool.content.set_top ({SD_ENUMERATION}.right)
			l_tool := l_features_tool.panel
			l_tool.content.set_tab_with (develop_window.tools.favorites_tool.content, True)
			l_tool := develop_window.tools.cluster_tool
			l_tool.content.set_tab_with (l_features_tool.panel.content, True)
			l_tool.content.set_split_proportion (0.73)

			-- Auto hide tools
			l_tool := develop_window.tools.diagram_tool
			if l_tool.content.state_value /= {SD_ENUMERATION}.auto_hide then
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			else
				-- First we pin it, then pin it again. So we can make sure the tab stub order and tab stub direction.
				-- Docking library will add a feature to set auto hide tab stub order directly in the future. -- Larry 2007/7/13
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			end

			l_tool := develop_window.tools.dependency_tool
			if l_tool.content.state_value /= {SD_ENUMERATION}.auto_hide then
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			else
				-- First we pin it, then pin it again. So we can make sure the tab stub order and tab stub direction.
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			end

			l_tool := develop_window.tools.metric_tool
			l_tool.content.set_tab_with (develop_window.tools.dependency_tool.content, False)

			develop_window.shell_tools.tool ({ES_INFORMATION_TOOL}).panel.content.set_tab_with (l_tool.content, False)

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

	restore_tools_docking_layout is
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

	restore_editors_docking_layout is
			-- Restore docking layout information.
		local
			l_file_name: STRING
			l_file: RAW_FILE
		do
			l_file_name := project_docking_standard_file_name
			if l_file_name /= Void and then not l_file_name.is_empty then
				create l_file.make (l_file_name)
				if l_file.exists then
					develop_window.docking_manager.open_editors_config (l_file_name)
				end

				if not l_file.is_closed then
					l_file.close
				end
			end
		end

	restore_standard_tools_docking_layout is
			-- Restore statndard layout.
		local
			l_file_name: STRING
			l_file: RAW_FILE
			l_result: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				l_file_name := eiffel_layout.user_docking_standard_file_name (develop_window.window_id)
				create l_file.make (l_file_name)
				if l_file.exists then
					l_result := develop_window.docking_manager.open_tools_config (l_file_name)
					check open_tools_config_succeed: l_result end
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

	restore_debug_docking_layout is
			-- Restore debug docking layout
		local
			l_result: BOOLEAN
			l_file: RAW_FILE
		do
			create l_file.make (eiffel_layout.user_docking_debug_file_name (develop_window.window_id))
			if l_file.exists then
				l_result := develop_window.docking_manager.open_tools_config (eiffel_layout.user_docking_debug_file_name (develop_window.window_id))
			end
			if not l_result then
				restore_standard_debug_docking_layout
			end

			develop_window.menus.update_menu_lock_items
			develop_window.menus.update_show_tool_bar_items

			develop_window.eb_debugger_manager.refresh_breakpoints_tool
		end

	restore_standard_debug_docking_layout_by_code is
			-- Restore standard debug docking layout.
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_dyna_tools: ES_SHELL_TOOLS
			l_tool: EB_TOOL
			l_last_watch_tool: ES_WATCH_TOOL
			l_refer_tool_content: SD_CONTENT
			l_sd_button: SD_TOOL_BAR_ITEM
			l_wt_lst: LINKED_SET [ES_WATCH_TOOL]
			l_debugger_manager: EB_DEBUGGER_MANAGER
		do
			l_debugger_manager := develop_window.eb_debugger_manager

			-- Setup toolbar buttons
			check one_button: l_debugger_manager.restart_cmd.managed_sd_toolbar_items.count = 1 end
			l_sd_button := l_debugger_manager.restart_cmd.managed_sd_toolbar_items.first
			if l_sd_button /= Void then
				l_sd_button.enable_displayed
			end

			check one_button: l_debugger_manager.stop_cmd.managed_sd_toolbar_items.count = 1 end
			l_sd_button := l_debugger_manager.stop_cmd.managed_sd_toolbar_items.first
			if l_sd_button /= Void then
				l_sd_button.enable_displayed
			end

			check one_button: l_debugger_manager.quit_cmd.managed_sd_toolbar_items.count = 1 end
			l_sd_button := l_debugger_manager.quit_cmd.managed_sd_toolbar_items.first
			if l_sd_button /= Void then
				l_sd_button.enable_displayed
			end

			check one_button: l_debugger_manager.assertion_checking_handler_cmd.managed_sd_toolbar_items.count = 1 end
			l_sd_button := l_debugger_manager.assertion_checking_handler_cmd.managed_sd_toolbar_items.first
			if l_sd_button /= Void then
				l_sd_button.enable_displayed
			end

			check one_button: l_debugger_manager.ignore_breakpoints_cmd.managed_sd_toolbar_items.count = 1 end
			l_sd_button := l_debugger_manager.ignore_breakpoints_cmd.managed_sd_toolbar_items.first
			if l_sd_button /= Void then
				l_sd_button.enable_displayed
			end

			-- Setup tools
			develop_window.close_all_tools

			l_dyna_tools := develop_window.shell_tools

				--| Class tool (below the editor)
			l_tool := l_dyna_tools.tool ({ES_CLASS_TOOL}).panel
			l_tool.content.set_top ({SD_ENUMERATION}.bottom)
			l_refer_tool_content := l_tool.content

				--| Features relation tool (tabbed with Class tool)
			l_tool := l_dyna_tools.tool ({ES_FEATURE_RELATION_TOOL}).panel
			l_tool.content.set_tab_with (l_refer_tool_content, True)

				--| Call stack tool (on right)
			l_debugger_manager.call_stack_tool.panel.content.set_top ({SD_ENUMERATION}.right)

				--| Objects tool			
			l_debugger_manager.objects_tool.panel.content.set_top ({SD_ENUMERATION}.bottom)
			l_debugger_manager.objects_tool.show (True)
			l_refer_tool_content := l_debugger_manager.objects_tool.panel.content

				--| Breakpoints tool
			l_tool := l_dyna_tools.tool ({ES_BREAKPOINTS_TOOL}).panel
			l_tool.content.set_relative (l_refer_tool_content, {SD_ENUMERATION}.right)
			l_refer_tool_content := l_tool.content

				--| Threads tool
			l_debugger_manager.threads_tool.panel.content.set_tab_with (l_refer_tool_content, True)
			l_refer_tool_content := l_debugger_manager.threads_tool.panel.content

				--| Watch tools
			l_wt_lst := l_debugger_manager.watch_tool_list
			from
				l_wt_lst.finish
			until
				l_wt_lst.before
			loop
				if l_last_watch_tool = Void then
					l_wt_lst.item.panel.content.set_tab_with (l_refer_tool_content, True)
				else
					l_wt_lst.item.panel.content.set_tab_with (l_last_watch_tool.panel.content, True)
				end
				l_last_watch_tool := l_wt_lst.item
				l_wt_lst.back
			end

				--| Diagram tool
			l_tool := l_dyna_tools.tool ({ES_DIAGRAM_TOOL}).panel
			if l_tool.content.state_value = {SD_ENUMERATION}.auto_hide then
				-- Same reason as EB_DEVELOPMENT_WINDOW.internal_construct_standard_layout_by_code.
				-- First we pin it, then pin it again. So we can make sure the tab stub order and tab stub direction.
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			else
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			end

				--| Dependency tool
			l_tool := l_dyna_tools.tool ({ES_DEPENDENCY_TOOL}).panel
			if l_tool.content.state_value = {SD_ENUMERATION}.auto_hide then
				-- First we pin it, then pin it again. So we can make sure the tab stub order and tab stub direction.
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			else
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			end
			l_refer_tool_content := l_tool.content

				--| Metrics tool
			l_tool := l_dyna_tools.tool ({ES_METRICS_TOOL}).panel
			l_tool.content.set_tab_with (l_refer_tool_content, False)

				--| Error list tool
			l_tool := l_dyna_tools.tool ({ES_ERROR_LIST_TOOL}).panel
			if l_tool.content.state_value = {SD_ENUMERATION}.auto_hide then
				-- Same reason as EB_DEVELOPMENT_WINDOW.internal_construct_standard_layout_by_code.
				-- First we pin it, then pin it again. So we can make sure the tab stub order and tab stub direction.
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			else
				l_tool.content.set_auto_hide ({SD_ENUMERATION}.bottom)
			end

			-- We do this to make sure the minimized editor minized horizontally, otherwise the editor will be minimized vertically.

			l_refer_tool_content := l_debugger_manager.call_stack_tool.panel.content
			l_tool := l_dyna_tools.tool ({ES_FAVORITES_TOOL}).panel
			l_tool.content.set_tab_with (l_refer_tool_content, False)
			l_tool.content.hide

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

	save_debug_docking_layout is
			-- Save debug docking layout
		local
			l_result: BOOLEAN
		do
			if develop_window /= Void then
				l_result := develop_window.docking_manager.save_tools_data (eiffel_layout.user_docking_debug_file_name (develop_window.window_id))
				if not l_result then
					show_last_error
				end
			end
		end

	restore_standard_debug_docking_layout is
			-- Restore standard debug docking layout.
		local
			l_result: BOOLEAN
			l_file: RAW_FILE
			l_fn: STRING_8
		do
			l_fn := eiffel_layout.user_docking_debug_file_name (develop_window.window_id).string
			create l_file.make (l_fn)
			if l_file.exists then
				l_result := develop_window.docking_manager.open_tools_config (l_fn)
			end
			if not l_result then
				restore_standard_debug_docking_layout_by_code
			end
		end

feature {NONE} -- Implementation

	project_docking_standard_file_name: !FILE_NAME
			-- Docking config file name.
		do
			create Result.make_from_string (develop_window.project_location.target_path)
			Result.set_file_name (eiffel_layout.docking_standard_file + "_" + develop_window.window_id.out)
		end

	restore_agent_for_restore_action, restore_agent_for_maximize_action:  PROCEDURE [EB_DOCKING_LAYOUT_MANAGER, TUPLE]
			-- Restore agent recorded for cleanup

	restore_tools_docking_layout_immediately is
			-- Restore docking layout information immediately
		local
			l_result: BOOLEAN
			l_file_name: STRING
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
			create l_raw_file.make (l_file_name)
			if l_raw_file.exists then
				l_result := develop_window.docking_manager.open_tools_config (l_file_name)
			end

			if not l_result then
				restore_standard_tools_docking_layout
			end
			develop_window.menus.update_menu_lock_items
			develop_window.menus.update_show_tool_bar_items

		end

	internal_recycle is
			-- <Precursor>
		do
			Precursor {EB_DEVELOPMENT_WINDOW_PART}
		end

	show_last_error is
			-- Show last exception error
		local
			l_information: ES_PROMPT_PROVIDER
			l_exception: EXCEPTION_MANAGER
			l_meaning: STRING_GENERAL
		do
			create l_exception
			l_meaning := l_exception.last_exception.meaning
			if l_meaning = Void then
				l_meaning := interface_names.l_unknown_error
			end
			create l_information
			l_information.show_error_prompt (interface_names.l_saving_docking_data_error (l_meaning), void, void)
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class EB_DOCKING_LAYOUT_MANAGER
