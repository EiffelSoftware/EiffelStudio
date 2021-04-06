note
	description: "All tool for EB_DEVELOPMENT_WINDOW"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_TOOLS

obsolete
	"[
		This class is being deprecated and may not be available in the 6.3 release cycle.
		Tool access should now be facilitated through {ES_SHELL_TOOLS}.tool passing
		a tool shim type.
	]"

inherit
	EB_DEVELOPMENT_WINDOW_PART

	EB_STONABLE

create
	make

feature -- Access

	class_tool: ES_CLASS_TOOL_PANEL
			-- Class tool
			-- This tool was orignal belong to context_tool
		require
			not_is_recycled: not is_recycled
		do
			if attached {ES_CLASS_TOOL} develop_window.shell_tools.tool ({ES_CLASS_TOOL}) as l_tool then
				Result := l_tool.panel
			else
				check tool_not_found: False end
			end
		ensure
			result_attached: Result /= Void
		end

	cluster_tool: ES_GROUPS_TOOL_PANEL
			-- Cluster tool.
		require
			not_is_recycled: not is_recycled
		do
			if attached {ES_GROUPS_TOOL} develop_window.shell_tools.tool ({ES_GROUPS_TOOL}) as l_tool then
				Result := l_tool.panel
			else
				check tool_not_found: False end
			end
		ensure
			result_attached: Result /= Void
		end

	dependency_tool: ES_DEPENDENCY_TOOL_PANEL
			-- Dependency tool
		require
			not_is_recycled: not is_recycled
		do
			if attached {ES_DEPENDENCY_TOOL} develop_window.shell_tools.tool ({ES_DEPENDENCY_TOOL}) as l_tool then
				Result := l_tool.panel
			else
				check tool_not_found: False end
			end
		ensure
			result_attached: Result /= Void
		end

	diagram_tool: ES_DIAGRAM_TOOL_PANEL
			-- Diagram tool
			-- This tool was orignal belong to context_tool
		require
			not_is_recycled: not is_recycled
		do
			if attached {ES_DIAGRAM_TOOL} develop_window.shell_tools.tool ({ES_DIAGRAM_TOOL}) as l_tool then
				Result := l_tool.panel
			else
				check tool_not_found: False end
			end
		ensure
			result_attached: Result /= Void
		end

	external_output_tool: ES_CONSOLE_TOOL_PANEL
			-- External output tool
			-- This tool was orignal belong to context_tool
		require
			not_is_recycled: not is_recycled
		do
			if attached {ES_CONSOLE_TOOL} develop_window.shell_tools.tool ({ES_CONSOLE_TOOL}) as l_tool then
				Result := l_tool.panel
			else
				check tool_not_found: False end
			end
		ensure
			result_attached: Result /= Void
		end

	favorites_tool: ES_FAVORITES_TOOL_PANEL
			-- Favorites tool.
		require
			not_is_recycled: not is_recycled
		do
			if attached {ES_FAVORITES_TOOL} develop_window.shell_tools.tool ({ES_FAVORITES_TOOL}) as l_tool then
				Result := l_tool.panel
			else
				check tool_not_found: False end
			end
		ensure
			result_attached: Result /= Void
		end

	features_relation_tool: ES_FEATURES_RELATION_TOOL_PANEL
			-- Features relation tool
			-- This tool was orignal belong to context_tool
		require
			not_is_recycled: not is_recycled
		do
			if attached {ES_FEATURE_RELATION_TOOL} develop_window.shell_tools.tool ({ES_FEATURE_RELATION_TOOL}) as l_tool then
				Result := l_tool.panel
			else
				check tool_not_found: False end
			end
		ensure
			result_attached: Result /= Void
		end

	metric_tool: ES_METRICS_TOOL_PANEL
			-- Metric tool
			-- This tool was orignal belong to context_tool
		require
			not_is_recycled: not is_recycled
		do
			if attached {ES_METRICS_TOOL} develop_window.shell_tools.tool ({ES_METRICS_TOOL}) as l_tool then
				Result := l_tool.panel
			else
				check tool_not_found: False end
			end
		ensure
			result_attached: Result /= Void
		end

	properties_tool: ES_PROPERTIES_TOOL_PANEL
			-- Properties tool.
		require
			not_is_recycled: not is_recycled
		do
			if attached {ES_PROPERTIES_TOOL} develop_window.shell_tools.tool ({ES_PROPERTIES_TOOL}) as l_tool then
				Result := l_tool.panel
			else
				check tool_not_found: False end
			end
		ensure
			result_attached: Result /= Void
		end

	search_report_tool: ES_SEARCH_REPORT_TOOL_PANEL
			-- Search report tool.
		require
			not_is_recycled: not is_recycled
		do
			if attached {ES_SEARCH_REPORT_TOOL} develop_window.shell_tools.tool ({ES_SEARCH_REPORT_TOOL}) as l_tool then
				Result := l_tool.panel
			else
				check tool_not_found: False end
			end
		ensure
			result_attached: Result /= Void
		end

	search_tool: ES_MULTI_SEARCH_TOOL_PANEL
			-- Search tool.
		require
			not_is_recycled: not is_recycled
		do
			if attached {ES_SEARCH_TOOL} develop_window.shell_tools.tool ({ES_SEARCH_TOOL}) as l_tool then
				Result := l_tool.panel
			else
				check tool_not_found: False end
			end
		ensure
			result_attached: Result /= Void
		end

	cloud_account_tool: detachable ES_CLOUD_ACCOUNT_TOOL
			-- Account tool
		require
			not_is_recycled: not is_recycled
		do
			if attached {ES_CLOUD_ACCOUNT_TOOL} develop_window.shell_tools.tool ({ES_CLOUD_ACCOUNT_TOOL}) as l_tool then
				Result := l_tool
			else
					-- Cloud service is not activated!
			end
		end

	scm_tool: detachable SCM_TOOL
			-- SCM tool
		require
			not_is_recycled: not is_recycled
		do
			if attached {SCM_TOOL} develop_window.shell_tools.tool ({SCM_TOOL}) as l_tool then
				Result := l_tool
			else
					-- SCM service is not activated!
			end
		end

	info_tool: ES_INFORMATION_TOOL
			-- Info tool
		require
			not_is_recycled: not is_recycled
		do
			if attached {ES_INFORMATION_TOOL} develop_window.shell_tools.tool ({ES_INFORMATION_TOOL}) as l_tool then
				Result := l_tool
			else
				check tool_not_found: False end
			end
		ensure
			result_attached: Result /= Void
		end

	breakpoints_tool: ES_BREAKPOINTS_TOOL
			-- Breakpoints tool.
		require
			not_is_recycled: not is_recycled
		do
			if attached {ES_BREAKPOINTS_TOOL} develop_window.shell_tools.tool ({ES_BREAKPOINTS_TOOL}) as l_tool then
				Result := l_tool
			else
				check tool_not_found: False end
			end
		ensure
			result_attached: Result /= Void
		end

	customizable_tools: ARRAYED_LIST [EB_CUSTOMIZED_TOOL]
			-- Access to list of tools that can be customized
		local
			l_tools: DS_ARRAYED_LIST_CURSOR [ES_TOOL [EB_TOOL]]
			l_customized_tools: like customized_tools
		do
			create Result.make (3)
			l_customized_tools := customized_tools

				-- Fetch list of shell tool and extract the customizable ones.
			l_tools := develop_window.shell_tools.all_tools.new_cursor
			from l_tools.start until l_tools.after loop
				if
					attached {ES_FORMATTER_TOOL [ES_FORMATTER_TOOL_PANEL_BASE]} l_tools.item as l_format_tool and then
					l_format_tool.is_customizable
				then
						-- The tool is customizable so activate the tool instance
					if attached {EB_CUSTOMIZED_TOOL} l_format_tool.panel as l_tool and then not l_customized_tools.has (l_tool) then
							-- Only add the tool if it's not a customized tool because these will be added later
						Result.extend (l_tool)
					end
				end
				l_tools.forth
			end

				-- Add the customized tools
			Result.append (l_customized_tools)
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
		end

	customized_tools: LIST [EB_CUSTOMIZED_TOOL]
			-- Access to list of customized tools added by the user
		do
			Result := internal_customized_tools
			if Result = Void then
				create {LINKED_LIST [EB_CUSTOMIZED_TOOL]} Result.make
				internal_customized_tools := Result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = customized_tools
		end

	web_browser_tool: ES_WEB_BROWSER_TOOL_PANEL
			-- Web browser tool
		require
			not_is_recycled: not is_recycled
		do
			if attached {ES_WEB_BROWSER_TOOL} develop_window.shell_tools.tool ({ES_WEB_BROWSER_TOOL}) as l_tool then
				Result := l_tool.panel
			else
				check tool_not_found: False end
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Commands

	launch_stone (a_stone: STONE)
			--	Lanunch stone.
		do
			if develop_window.is_unified_stone then
				develop_window.set_stone (a_stone)
			else
				set_stone (a_stone)
			end
		end

	set_stone (a_stone: detachable STONE)
			-- Dispatch stone to tools for linking
			-- Orignal version from EB_CONTEXT_TOOL set_stone.
		do
			develop_window.eb_debugger_manager.set_stone (a_stone)
			diagram_tool.set_stone (a_stone)
			features_relation_tool.set_stone (a_stone)
			class_tool.set_stone (a_stone)
			dependency_tool.set_stone (a_stone)
			set_stone_to_customized_tools (a_stone)
			info_tool.set_stone (a_stone)

			stone := a_stone
		end

	set_last_stone (a_stone: STONE)
			-- Set `stone' without setting to tools.
			-- For synchronizing use.
		do
			stone := a_stone
		ensure
			stone_set: stone = a_stone
		end

	set_stone_and_pop_tool (a_stone: STONE)
			-- Set stone and show proper tool as context.
		do
			set_stone (a_stone)
			if a_stone /= Void then
				if attached {FEATURE_STONE} a_stone then
					show_default_tool_of_feature
				elseif attached {CLASSI_STONE} a_stone then
					show_default_tool_of_class
				end
			end
		end

	synchronize
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchonization.
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
			l_stone: STONE
		do
			develop_window.history_manager.synchronize

			conv_dev := develop_window
			if conv_dev /= Void then
				if not conv_dev.is_unified_stone then
					invalidate_customizable_tools
					if conv_dev.link_tools then
						if stone /= Void then
							stone := stone.synchronized_stone
						end
						set_stone (stone)
						diagram_tool.synchronize
					else
						l_stone := diagram_tool.last_stone
						if l_stone = Void then
							l_stone := diagram_tool.stone
						end
						if l_stone /= Void then
							l_stone := l_stone.synchronized_stone
							diagram_tool.set_stone (l_stone)
						end
						refresh
					end
				end
			else
				if stone /= Void then
					stone := stone.synchronized_stone
					set_stone (stone)
				end
				refresh
			end
		end

	refresh
			-- Class has changed in `development_window'.
		do
			diagram_tool.synchronize
			class_tool.refresh
			features_relation_tool.set_refresh_needed
			dependency_tool.refresh
			customized_tools.do_all (agent {EB_CUSTOMIZED_TOOL}.refresh)
		end

	show_default_tool_of_feature
		do
			default_feature_tool.show_with_setting
		end

	show_default_tool_of_class
		do
			default_class_tool.show_with_setting
		end

feature -- Default tools

	default_class_tool: EB_STONABLE_TOOL
			-- Default class stone tool
		do
			Result := class_tool
		end

	default_feature_tool: EB_STONABLE_TOOL
			-- Default feature stone tool
		do
			Result := features_relation_tool
		end

feature -- Query

	stone: detachable STONE
			-- Stone current related.
			-- In the non-docking Eiffel Studio, it's context tool's stone.

feature -- Custom tools

	set_stone_to_customized_tools (a_stone: STONE)
			-- Set `a_stone' to `customized_tools'.
		local
			l_cus_tools: like customized_tools
			l_cursor: CURSOR
		do
			l_cus_tools := customized_tools
			l_cursor := l_cus_tools.cursor
			from
				l_cus_tools.start
			until
				l_cus_tools.after
			loop
				l_cus_tools.item.set_stone (a_stone)
				l_cus_tools.forth
			end
			l_cus_tools.go_to (l_cursor)
		end

	refresh_customized_tool_appearance (a_tool: EB_CUSTOMIZED_TOOL)
			-- Refresh appearance such as title, pixmap, stone handlers for `a_tool'.
		require
			a_tool_attached: a_tool /= Void
		local
			l_manager: EB_CUSTOMIZED_TOOL_MANAGER
			l_tool_desp: EB_CUSTOMIZED_TOOL_DESP
		do
			l_manager := develop_window.customized_tool_manager
			l_tool_desp := l_manager.descriptor_by_id (a_tool.title_for_pre)
			check l_tool_desp /= Void end
			a_tool.set_title (l_tool_desp.name)
			a_tool.set_stone_handlers (l_tool_desp.handlers)
			a_tool.set_pixmap_location (l_tool_desp.pixmap_location)
-- FIXME: To reinstantiate as this code does not compile anymore
--			a_tool.content.set_long_title (a_tool.title)
--			a_tool.content.set_short_title (a_tool.title)
--			a_tool.content.set_pixel_buffer (a_tool.pixel_buffer)
--			a_tool.content.set_pixmap (a_tool.pixmap)
--			develop_window.menus.update_item_from_tools_list_menu (a_tool)
		end

	customized_tools_from_tools (a_tools: like customizable_tools): LIST [EB_CUSTOMIZED_TOOL]
			-- Customized tools from `a_tools'.
		require
			a_tools_attached: a_tools /= Void
			a_tools_valid: not a_tools.has (Void)
		local
			l_cursor: CURSOR
		do
			create {LINKED_LIST [EB_CUSTOMIZED_TOOL]} Result.make
			l_cursor := a_tools.cursor
			from
				a_tools.start
			until
				a_tools.after
			loop
				if a_tools.item.is_customized_tool then
					if attached {EB_CUSTOMIZED_TOOL} a_tools.item as l_customized_tool then
						Result.extend (l_customized_tool)
					else
						check is_customized_tool: False end
					end
				end
				a_tools.forth
			end
			a_tools.go_to (l_cursor)
		ensure
			result_attached: Result /= Void
		end

	customizable_tool_by_id (a_id: STRING): EB_TOOL
			-- Tool from `all_tools' whose id is `a_id'
			-- Void if no such tool is found.
		require
			a_id_attached: a_id /= Void
		local
			l_tools: like customizable_tools
			l_cursor: CURSOR
		do
			l_tools := customizable_tools
			l_cursor := l_tools.cursor
			from
				l_tools.start
			until
				l_tools.after or Result /= Void
			loop
				if l_tools.item.title_for_pre.is_equal (a_id) then
					Result := l_tools.item
				end
				l_tools.forth
			end
			l_tools.go_to (l_cursor)
		end

	customizable_tools_by_id (a_tools: like customizable_tools; a_ids: LIST [STRING]; a_include: BOOLEAN): like customizable_tools
			-- Tools from `a_tools' whose IDs are in `a_ids' if `a_include' is True,
			-- otherwise, return tools from `a_tools' whose IDS are not in `a_ids'.
		require
			a_tools_attached: a_tools /= Void
			a_ids_attached: a_ids /= Void
		local
			l_set: DS_HASH_SET [STRING]
			l_keep: BOOLEAN
		do
			create l_set.make (a_ids.count)
			l_set.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [STRING]}.make (agent (a_str, b_str: STRING): BOOLEAN do Result := equal (a_str, b_str) end))
			a_ids.do_all (agent l_set.force_last)
			Result := a_tools.twin
			from
				Result.start
			until
				Result.after
			loop
				if a_include then
					l_keep := l_set.has (Result.item.title_for_pre)
				else
					l_keep := not l_set.has (Result.item.title_for_pre)
				end
				if l_keep then
					Result.forth
				else
					Result.remove
				end
			end
		ensure
			result_attached: Result /= Void
		end

	invalidate_customizable_tools
			-- Invalidate tools which will force a refresh of all currently selected formatters.
		do
			class_tool.invalidate
			features_relation_tool.invalidate
			dependency_tool.invalidate
			if not customized_tools.is_empty then
				customized_tools.do_all (agent (a_tool: EB_CUSTOMIZED_TOOL) do a_tool.invalidate end)
			end
		end

	customized_tools_internal: like customized_tools
			-- Implementation of `customized_tools'

feature {NONE} -- Internal implementation cache

	internal_customized_tools: like customized_tools
			-- Cached version of `customized_tools'
			-- Note: Do not use directly!

;note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

end -- class EB_DEVELOPMENT_WINDOW_TOOLS


