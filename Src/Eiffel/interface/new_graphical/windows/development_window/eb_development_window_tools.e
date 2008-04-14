indexing
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
			Result ?= develop_window.shell_tools.tool ({ES_CLASS_TOOL}).panel
		ensure
			result_attached: Result /= Void
		end

	cluster_tool: ES_GROUPS_TOOL_PANEL
			-- Cluster tool.
		require
			not_is_recycled: not is_recycled
		do
			Result ?= develop_window.shell_tools.tool ({ES_GROUPS_TOOL}).panel
		ensure
			result_attached: Result /= Void
		end

	c_output_tool: ES_C_OUTPUT_TOOL_PANEL
			-- C output tool
			-- This tool was orignal belong to context_tool
		require
			not_is_recycled: not is_recycled
		do
			Result ?= develop_window.shell_tools.tool ({ES_C_OUTPUT_TOOL}).panel
		ensure
			result_attached: Result /= Void
		end

	dependency_tool: ES_DEPENDENCY_TOOL_PANEL
			-- Dependency tool
		require
			not_is_recycled: not is_recycled
		do
			Result ?= develop_window.shell_tools.tool ({ES_DEPENDENCY_TOOL}).panel
		ensure
			result_attached: Result /= Void
		end

	diagram_tool: ES_DIAGRAM_TOOL_PANEL
			-- Diagram tool
			-- This tool was orignal belong to context_tool
		require
			not_is_recycled: not is_recycled
		do
			Result ?= develop_window.shell_tools.tool ({ES_DIAGRAM_TOOL}).panel
		ensure
			result_attached: Result /= Void
		end

	external_output_tool: ES_CONSOLE_TOOL_PANEL
			-- External output tool
			-- This tool was orignal belong to context_tool
		require
			not_is_recycled: not is_recycled
		do
			Result ?= develop_window.shell_tools.tool ({ES_CONSOLE_TOOL}).panel
		ensure
			result_attached: Result /= Void
		end

	favorites_tool: ES_FAVORITES_TOOL_PANEL
			-- Favorites tool.
		require
			not_is_recycled: not is_recycled
		do
			Result ?= develop_window.shell_tools.tool ({ES_FAVORITES_TOOL}).panel
		ensure
			result_attached: Result /= Void
		end

	features_relation_tool: ES_FEATURES_RELATION_TOOL_PANEL
			-- Features relation tool
			-- This tool was orignal belong to context_tool
		require
			not_is_recycled: not is_recycled
		do
			Result ?= develop_window.shell_tools.tool ({ES_FEATURE_RELATION_TOOL}).panel
		ensure
			result_attached: Result /= Void
		end

	metric_tool: ES_METRICS_TOOL_PANEL
			-- Metric tool
			-- This tool was orignal belong to context_tool
		require
			not_is_recycled: not is_recycled
		do
			Result ?= develop_window.shell_tools.tool ({ES_METRICS_TOOL}).panel
		ensure
			result_attached: Result /= Void
		end

	output_tool: ES_OUTPUT_TOOL_PANEL
			-- Output tool.
			-- This tool was orignal belong to context_tool
		require
			not_is_recycled: not is_recycled
		do
			Result ?= develop_window.shell_tools.tool ({ES_OUTPUT_TOOL}).panel
		ensure
			result_attached: Result /= Void
		end

	properties_tool: ES_PROPERTIES_TOOL_PANEL
			-- Properties tool.
		require
			not_is_recycled: not is_recycled
		do
			Result ?= develop_window.shell_tools.tool ({ES_PROPERTIES_TOOL}).panel
		ensure
			result_attached: Result /= Void
		end

	search_report_tool: ES_SEARCH_REPORT_TOOL_PANEL
			-- Search report tool.
		require
			not_is_recycled: not is_recycled
		do
			Result ?= develop_window.shell_tools.tool ({ES_SEARCH_REPORT_TOOL}).panel
		ensure
			result_attached: Result /= Void
		end

	search_tool: ES_MULTI_SEARCH_TOOL_PANEL
			-- Search tool.
		require
			not_is_recycled: not is_recycled
		do
			Result ?= develop_window.shell_tools.tool ({ES_SEARCH_TOOL}).panel
		ensure
			result_attached: Result /= Void
		end

	breakpoints_tool: ES_BREAKPOINTS_TOOL_PANEL
			-- Breakpoints tool.
		require
			not_is_recycled: not is_recycled
		do
			Result ?= develop_window.shell_tools.tool ({ES_BREAKPOINTS_TOOL}).panel
		ensure
			result_attached: Result /= Void
		end

	customizable_tools: ARRAYED_LIST [EB_TOOL] is
			-- Access to list of tools that can be customized
		local
			l_tools: DS_ARRAYED_LIST_CURSOR [ES_TOOL [EB_TOOL]]
			l_format_tool: ES_FORMATTER_TOOL [ES_FORMATTER_TOOL_PANEL_BASE]
			l_tool: EB_TOOL
			l_customized_tools: LIST [EB_TOOL]
		do
			create Result.make (3)
			l_customized_tools := customized_tools

				-- Fetch list of shell tool and extract the customizable ones.
			l_tools := develop_window.shell_tools.all_tools.new_cursor
			from l_tools.start until l_tools.after loop
				l_format_tool ?= l_tools.item
				if l_format_tool /= Void and then l_format_tool.is_customizable then
						-- The tool is customizable so activate the tool instance
					l_tool := l_format_tool.panel
					if not l_customized_tools.has (l_tool) then
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

	customized_tools: LIST [EB_CUSTOMIZED_TOOL] is
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

feature -- Commands

	launch_stone (a_stone: STONE) is
			--	Lanunch stone.
		do
			if develop_window.unified_stone then
				develop_window.set_stone (a_stone)
			else
				set_stone (a_stone)
			end
		end

	set_stone (a_stone: STONE) is
			-- Dispatch stone to tools.
			-- Orignal version from EB_CONTEXT_TOOL set_stone.
		do
			develop_window.eb_debugger_manager.set_stone (a_stone)
			features_relation_tool.set_stone (a_stone)
			class_tool.set_stone (a_stone)
			dependency_tool.set_stone (a_stone)
			if eiffel_layout.has_diagram then
				 diagram_tool.set_stone (a_stone)
			end
			set_stone_to_customized_tools (a_stone)

			stone := a_stone
		end

	set_last_stone (a_stone: STONE) is
			-- Set `stone' without setting to tools.
			-- For synchronizing use.
		do
			stone := a_stone
		ensure
			stone_set: stone = a_stone
		end

	set_stone_and_pop_tool (a_stone: STONE) is
			-- Set stone and show proper tool as context.
		local
			l_class_stone: CLASSI_STONE
			l_feature_stone: FEATURE_STONE
		do
			set_stone (a_stone)
			if a_stone /= Void then
				l_class_stone ?= a_stone
				l_feature_stone ?= a_stone
				if l_feature_stone /= Void then
					show_default_tool_of_feature
				elseif l_class_stone /= Void then
					show_default_tool_of_class
				end
			end
		end

	synchronize is
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchonization.
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
			l_stone: STONE
		do
			develop_window.history_manager.synchronize

			conv_dev := develop_window
			if conv_dev /= Void then
				if not conv_dev.unified_stone then
					invalidate_customizable_tools
					if conv_dev.link_tools then
						if stone /= Void then
							stone := stone.synchronized_stone
						end
						set_stone (stone)
						if eiffel_layout.has_diagram then
							diagram_tool.synchronize
						end
					else
						l_stone := diagram_tool.last_stone
						if l_stone /= Void and eiffel_layout.has_diagram then
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

	refresh is
			-- Class has changed in `development_window'.
		do
			if eiffel_layout.has_diagram then
				 diagram_tool.synchronize
			end
			class_tool.refresh
			features_relation_tool.refresh
			dependency_tool.refresh
			customized_tools.do_all (agent (a_tool: EB_CUSTOMIZED_TOOL)
				do
					a_tool.refresh
				end)
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

	default_class_tool: EB_STONABLE_TOOL is
			-- Default class stone tool
		do
			Result := class_tool
		end

	default_feature_tool: EB_STONABLE_TOOL is
			-- Default feature stone tool
		do
			Result := features_relation_tool
		end

feature -- Query

	stone: STONE
			-- Stone current related.
			-- In the non-docking Eiffel Studio, it's context tool's stone.

feature -- Custom tools

	set_stone_to_customized_tools (a_stone: STONE) is
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

	refresh_customized_tool_appearance (a_tool: EB_CUSTOMIZED_TOOL) is
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

			a_tool.content.set_long_title (a_tool.title)
			a_tool.content.set_short_title (a_tool.title)
			a_tool.content.set_pixel_buffer (a_tool.pixel_buffer)
			a_tool.content.set_pixmap (a_tool.pixmap)
			develop_window.menus.update_item_from_tools_list_menu (a_tool)
		end

	customized_tools_from_tools (a_tools: like customizable_tools): LIST [EB_CUSTOMIZED_TOOL] is
			-- Customized tools from `a_tools'.
		require
			a_tools_attached: a_tools /= Void
			a_tools_valid: not a_tools.has (Void)
		local
			l_cursor: CURSOR
			l_customized_tool: EB_CUSTOMIZED_TOOL
		do
			create {LINKED_LIST [EB_CUSTOMIZED_TOOL]} Result.make
			l_cursor := a_tools.cursor
			from
				a_tools.start
			until
				a_tools.after
			loop
				if a_tools.item.is_customized_tool then
					l_customized_tool ?= a_tools.item
					Result.extend (l_customized_tool)
				end
				a_tools.forth
			end
			a_tools.go_to (l_cursor)
		ensure
			result_attached: Result /= Void
		end

	customizable_tool_by_id (a_id: STRING): EB_TOOL is
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

	customizable_tools_by_id (a_tools: like customizable_tools; a_ids: LIST [STRING]; a_include: BOOLEAN): like customizable_tools is
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

	invalidate_customizable_tools is
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

;indexing
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

end -- class EB_DEVELOPMENT_WINDOW_TOOLS


