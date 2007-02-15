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
			if develop_window.unified_stone then
				develop_window.set_stone (a_stone)
			else
				develop_window.eb_debugger_manager.set_stone (a_stone)
				features_relation_tool.set_stone (a_stone)
				class_tool.set_stone (a_stone)
				dependency_tool.set_stone (a_stone)
				if develop_window.has_case then
					 diagram_tool.set_stone (a_stone)
				end
				stone := a_stone
			end
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
		do
			develop_window.history_manager.synchronize

			conv_dev := develop_window
			if conv_dev /= Void then
				if not conv_dev.unified_stone then
					if stone /= Void then
						stone := stone.synchronized_stone
					end
					class_tool.invalidate
					features_relation_tool.invalidate
					dependency_tool.invalidate
					set_stone (stone)
					if develop_window.has_case then
						diagram_tool.synchronize
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
		end

	show_default_tool_of_feature
		do
			features_relation_tool.show
			features_relation_tool.pop_default_formatter
			features_relation_tool.set_focus
		end

	show_default_tool_of_class
		do
			class_tool.show
			class_tool.pop_default_formatter
			class_tool.set_focus
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

