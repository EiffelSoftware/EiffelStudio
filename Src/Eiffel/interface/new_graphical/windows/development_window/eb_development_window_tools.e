indexing
	description: "All tool for EB_DEVELOPMENT_WINDOW"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_TOOLS

inherit
	EB_DEVELOPMENT_WINDOW_PART

	EB_STONABLE

create
	make

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
			if develop_window.has_case then
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
					invalidate_tools
					if conv_dev.link_tools then
						if stone /= Void then
							stone := stone.synchronized_stone
						end
						set_stone (stone)
						if develop_window.has_case then
							diagram_tool.synchronize
						end
					else
						l_stone := diagram_tool.last_stone
						if l_stone /= Void and develop_window.has_case then
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
			if develop_window.has_case then
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

	show_tool_by_id (a_id: STRING) is
			-- Show the tool from `all_tools' whose id is `a_id' if possible.
		require
			a_id_attached: a_id /= Void
		local
			l_tool: EB_TOOL
		do
			l_tool := tool_by_id (a_id)
			if l_tool /= Void then
				l_tool.show_with_setting
			end
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

feature -- Default tools

	default_class_tool: EB_STONABLE_TOOL is
		do
			Result := class_tool
		end

	default_feature_tool: EB_STONABLE_TOOL is
		do
			Result := features_relation_tool
		end

feature -- Query

	stone: STONE
			-- Stone current related.
			-- In the non-docking Eiffel Studio, it's context tool's stone.

	all_tools: ARRAYED_LIST [EB_TOOL] is
			-- All tools
		do
			create Result.make (17)
			if favorites_tool /= Void then
				Result.extend (favorites_tool)
			end
			if properties_tool /= Void then
				Result.extend (properties_tool)
			end
			if class_tool /= Void then
				Result.extend (cluster_tool)
			end
			if search_tool /= Void then
				Result.extend (search_tool)
			end
			if search_report_tool /= Void then
				Result.extend (search_report_tool)
			end
			if features_tool /= Void then
				Result.extend (features_tool)
			end
			if breakpoints_tool /= Void then
				Result.extend (breakpoints_tool)
			end
			if windows_tool /= Void then
				Result.extend (windows_tool)
			end
			if output_tool /= Void then
				Result.extend (output_tool)
			end
			if diagram_tool /= Void then
				Result.extend (diagram_tool)
			end
			if class_tool /= Void then
				Result.extend (class_tool)
			end
			if features_relation_tool /= Void then
				Result.extend (features_relation_tool)
			end
			if dependency_tool /= Void then
				Result.extend (dependency_tool)
			end
			if metric_tool /= Void then
				Result.extend (metric_tool)
			end
			if external_output_tool /= Void then
				Result.extend (external_output_tool)
			end
			if c_output_tool /= Void then
				Result.extend (c_output_tool)
			end
			if errors_tool /= Void then
				Result.extend (errors_tool)
			end
			if warnings_tool /= Void then
				Result.extend (warnings_tool)
			end
			Result.append (develop_window.eb_debugger_manager.all_tools)
			Result.append (customized_tools)
		ensure
			not_void: Result /= Void
		end

	favorites_tool: EB_FAVORITES_TOOL
			-- Favorites tool.

	properties_tool: EB_PROPERTIES_TOOL
			-- Properties tool.

	cluster_tool: EB_CLUSTER_TOOL
			-- Cluster tool.

	search_tool: EB_MULTI_SEARCH_TOOL
			-- Search tool.

	search_report_tool: EB_SEARCH_REPORT_TOOL
			-- Search report tool.

	features_tool: EB_FEATURES_TOOL
			-- Features tool.

	breakpoints_tool: ES_BREAKPOINTS_TOOL
			-- Breakpoints tool.

	windows_tool: EB_WINDOWS_TOOL
			-- Windows tool.

	output_tool: EB_OUTPUT_TOOL
			-- Output tool.
			-- This tool was orignal belong to context_tool

	diagram_tool: EB_DIAGRAM_TOOL
			-- Diagram tool
			-- This tool was orignal belong to context_tool

	class_tool: EB_CLASS_TOOL
			-- Class tool
			-- This tool was orignal belong to context_tool

	features_relation_tool: EB_FEATURES_RELATION_TOOL
			-- Features relation tool
			-- This tool was orignal belong to context_tool

	dependency_tool: EB_DEPENDENCY_TOOL
			-- Dependency tool

	metric_tool: EB_METRIC_TOOL
			-- Metric tool
			-- This tool was orignal belong to context_tool

	external_output_tool: EB_EXTERNAL_OUTPUT_TOOL
			-- External output tool
			-- This tool was orignal belong to context_tool

	c_output_tool: EB_C_OUTPUT_TOOL
			-- C output tool
			-- This tool was orignal belong to context_tool

	errors_tool: EB_ERRORS_TOOL
			-- Errors tool
			-- This tool was orignal belong to context_tool

	warnings_tool: EB_WARNINGS_TOOL
			-- Warnings tool
			-- This tool was orignal belong to context_tool

	customized_tools: LIST [EB_CUSTOMIZED_TOOL] is
			-- Customized tools
		do
			if customized_tools_internal = Void then
				create {LINKED_LIST [EB_CUSTOMIZED_TOOL]} customized_tools_internal.make
			end
			Result := customized_tools_internal
		ensure
			result_attached: Result /= Void
		end

	satisfied_tools (a_tools: like all_tools; a_agent: FUNCTION [ANY, TUPLE [EB_TOOL], BOOLEAN]): like all_tools is
			-- List of tools from `a_tools' which are satisfied by `a_agent'
		require
			a_tools_attached: a_tools /= Void
			a_agent_attached: a_agent /= Void
		do
			Result := a_tools.twin
			from
				Result.start
			until
				Result.after
			loop
				if a_agent.item ([Result.item]) then
					Result.forth
				else
					Result.remove
				end
			end
		ensure
			result_attached: Result /= Void
		end

	tools_by_id (a_tools: like all_tools; a_ids: LIST [STRING]; a_include: BOOLEAN): like all_tools is
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

	customized_tools_from_tools (a_tools: LIST [EB_TOOL]): LIST [EB_CUSTOMIZED_TOOL] is
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

	tool_by_id (a_id: STRING): EB_TOOL is
			-- Tool from `all_tools' whose id is `a_id'
			-- Void if no such tool is found.
		require
			a_id_attached: a_id /= Void
		local
			l_tools: like all_tools
			l_cursor: CURSOR
		do
			l_tools := all_tools
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

feature {EB_DEVELOPMENT_WINDOW_MAIN_BUILDER, EB_DEVELOPMENT_WINDOW} -- Setting

	set_features_tool (a_tool: like features_tool) is
			-- Set `a_tool'
		do
			features_tool := a_tool
		ensure
			set: features_tool = a_tool
		end

	set_cluster_tool (a_tool: like cluster_tool) is
			-- Set cluster_tool
		do
			cluster_tool := a_tool
		ensure
			set: cluster_tool = a_tool
		end

	set_output_tool (a_tool: like output_tool) is
			-- Set `output_tool.
		do
			output_tool := a_tool
		ensure
			set: output_tool = a_tool
		end

	set_diagram_tool (a_tool: like diagram_tool) is
			-- Set `diagram_tool.
		do
			diagram_tool := a_tool
		ensure
			set: diagram_tool = a_tool
		end

	set_class_tool (a_tool: like class_tool) is
			-- Set 'class_tool'
		do
			class_tool := a_tool
		ensure
			set: class_tool = a_tool
		end

	set_features_relation_tool (a_tool: like features_relation_tool) is
			-- Set `features_relation_tool'
		do
			features_relation_tool := a_tool
		ensure
			set: features_relation_tool = a_tool
		end

	set_dependency_tool (a_tool: like dependency_tool) is
			-- Set `dependency_tool'
		do
			dependency_tool := a_tool
		ensure
			set: dependency_tool = a_tool
		end

	set_metric_tool (a_tool: like metric_tool) is
			-- Set `metric_tool'
		do
			metric_tool := a_tool
		ensure
			set: metric_tool = a_tool
		end

	set_external_output_tool (a_tool: like external_output_tool) is
			-- Set `external_output_tool'
		do
			external_output_tool := a_tool
		ensure
			set: external_output_tool = a_tool
		end

	set_c_output_tool (a_tool: like c_output_tool) is
			-- Set `c_output_tool'
		do
			c_output_tool := a_tool
		ensure
			set: c_output_tool = a_tool
		end

	set_errors_tool (a_tool: like errors_tool) is
			-- Set `errors_tool'
		do
			errors_tool := a_tool
		ensure
			set: errors_tool = a_tool
		end

	set_search_tool (a_tool: like search_tool) is
			-- Set `search_tool'
		do
			search_tool := a_tool
		ensure
			set: search_tool = a_tool
		end

	set_search_report_tool (a_tool: like search_report_tool) is
			-- Set `search_report_tool'
		do
			search_report_tool := a_tool
		ensure
			set: search_report_tool /= Void
		end

	set_warnings_tool (a_tool: like warnings_tool) is
			-- Set `warnings_tool'
		do
			warnings_tool := a_tool
		ensure
			set: warnings_tool = a_tool
		end

	set_breakpoints_tool (a_tool: like breakpoints_tool) is
			-- Set `breakpoints_tool'
		do
			breakpoints_tool := a_tool
		ensure
			set: breakpoints_tool = a_tool
		end

	set_favorites_tool (a_tool: like favorites_tool) is
			-- Set `favorites_tool'
		do
			favorites_tool := a_tool
		ensure
			set: favorites_tool = a_tool
		end

	set_properties_tool (a_tool: like properties_tool) is
			-- Set `properties_tool'
		do
			properties_tool	:= a_tool
		ensure
			set: properties_tool = a_tool
		end

	set_windows_tool (a_tool: like windows_tool) is
			-- Set `windows_tool'
		do
			windows_tool := a_tool
		ensure
			set: windows_tool = a_tool
		end

feature{NONE} -- Implementation

	customized_tools_internal: like customized_tools
			-- Implementation of `customized_tools'

	invalidate_tools is
			-- Invalidate tools which will force a refresh of all currently selected formatters.
		do
			class_tool.invalidate
			features_relation_tool.invalidate
			dependency_tool.invalidate
			if not customized_tools.is_empty then
				customized_tools.do_all (agent (a_tool: EB_CUSTOMIZED_TOOL) do a_tool.invalidate end)
			end
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

end -- class EB_DEVELOPMENT_WINDOW_TOOLS

