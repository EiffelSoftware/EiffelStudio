indexing
	description: "[
		Access to a development window's collection of tools.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_SHELL_TOOLS

inherit
	EB_RECYCLABLE

create
	make

feature {NONE} -- Initialization

	make (a_window: like window)
			-- Initialize tool collection for a given development window.
			--
			-- `a_window': Window to supply access to tool for.
		require
			a_window_attached: a_window /= Void
			not_a_window_is_recycled: not a_window.is_recycled
		do
			create requested_tools.make_default
			window := a_window
		ensure
			window_set: window = a_window
		end

feature {NONE} -- Clean up

	internal_recycle is
			-- Called to clean up resources of Current.
		do
				-- Recycle all activated tools.
			requested_tools.do_all (agent (a_items: ARRAY [ES_TOOL [EB_TOOL]])
				local
					l_count, i: INTEGER
				do
					l_count := a_items.count
					from i := 1 until i > l_count loop
						(a_items [i]).recycle
						i := i + 1
					end
				end)
			requested_tools.wipe_out
		ensure then
			requested_tools_is_empty: requested_tools.is_empty
		end

feature -- Access

	window: EB_DEVELOPMENT_WINDOW
			-- Development window where tools are hosted

	frozen tools: DS_BILINEAR [ES_TOOL [EB_TOOL]]
			-- List of available first-edition tools, that can be used by Current.
			-- Note: If you need access to later editions please use `tool_edition'.
		require
			not_is_recycled: not is_recycled
		local
			l_types: like tool_types
			l_cursor: DS_BILINEAR_CURSOR [TYPE [ES_TOOL [EB_TOOL]]]
			l_tools: DS_ARRAYED_LIST [ES_TOOL [EB_TOOL]]
		once
			l_types := tool_types
			l_cursor := l_types.new_cursor

			create l_tools.make (l_types.count)
			from l_cursor.start until l_cursor.after loop
				l_tools.put_last (tool (l_cursor.item))
				l_cursor.forth
			end

			Result := l_tools
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
			result_count_matches_tool_types: tool_types.count = Result.count
		end

	tool_types: DS_BILINEAR [TYPE [ES_TOOL [EB_TOOL]]]
			-- List of available tools, that can be used by Current.
		require
			not_is_recycled: not is_recycled
		local
			l_tools: DS_ARRAYED_LIST [TYPE [ES_TOOL [EB_TOOL]]]
		once
			create l_tools.make (23)

				-- Add tools here
			l_tools.put_last ({ES_CLASS_TOOL})
			l_tools.put_last ({ES_CONSOLE_TOOL})
			l_tools.put_last ({ES_C_OUTPUT_TOOL})
			l_tools.put_last ({ES_DEPENDENCY_TOOL})
			l_tools.put_last ({ES_DIAGRAM_TOOL})
			l_tools.put_last ({ES_ERROR_LIST_TOOL})
			l_tools.put_last ({ES_FAVORITES_TOOL})
			l_tools.put_last ({ES_FEATURES_TOOL})
			l_tools.put_last ({ES_FEATURE_RELATION_TOOL})
			l_tools.put_last ({ES_GROUP_TOOL})
			l_tools.put_last ({ES_METRICS_TOOL})
			l_tools.put_last ({ES_OUTPUT_TOOL})
			l_tools.put_last ({ES_PROPERTIES_TOOL})
			l_tools.put_last ({ES_SEARCH_REPORT_TOOL})
			l_tools.put_last ({ES_SEARCH_TOOL})
			l_tools.put_last ({ES_WINDOWS_TOOL})

				-- Debugger tools
			l_tools.put_last ({ES_DEBUGGER_BREAKPOINTS_TOOL})
			l_tools.put_last ({ES_DEBUGGER_THREADS_TOOL})
			l_tools.put_last ({ES_DEBUGGER_CALL_STACK_TOOL})
			l_tools.put_last ({ES_DEBUGGER_WATCH_TOOL})
			l_tools.put_last ({ES_DEBUGGER_OBJECTS_TOOL})
			l_tools.put_last ({ES_DEBUGGER_OBJECT_VIEWER_TOOL})

			l_tools.put_last ({ES_LOGGER_TOOL})

			l_tools.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [TYPE [ES_TOOL [EB_TOOL]]]}.make (agent {TYPE [ES_TOOL [EB_TOOL]]}.is_equal))
			Result := l_tools
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
		end

feature {NONE} -- Access

	requested_tools: DS_HASH_TABLE [ARRAY [ES_TOOL [EB_TOOL]], STRING]
			-- Table of requested, and therefore created, tools

feature {NONE} -- Helpers

	frozen internal: INTERNAL
			-- Shared access to an instance of {INTERNAL}
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Query

	dynamic_tool_type (a_type: STRING_32): TYPE [ES_TOOL [EB_TOOL]]
			-- Retrieves a type object dynamically from a string representation of the type.
			--
			-- `a_type': A string representation of a type that implemented {ES_TOOL}. e.g. "MY_TOOL" => TYPE [MY_TOOL]
			-- `Result': A type object representing the string type passed in.
		local
			l_internal: like internal
			l_id: INTEGER
		do
			l_internal := internal
			if l_internal.is_valid_type_string (a_type) then
				l_id := l_internal.dynamic_type_from_string (a_type)
				if l_id > 0 then
					Result ?= l_internal.type_of_type (l_id)
				end
			end
		end

	tool (a_type: TYPE [ES_TOOL [EB_TOOL]]): ES_TOOL [EB_TOOL]
			-- Retrieves an activate tool associated with a particular type.
			-- Note: Requesting a tool that has not yet been activated/instantiated will activate it before
			--       it is returned.
			--
			-- `a_type': The type of tool requested.
			-- `Result': An activated tool corresponding to the supplied type.
		require
			not_is_recycled: not is_recycled
			a_type_attached: a_type /= Void
			tool_types_has_a_type: tool_types.has (a_type)
		do
			Result := tool_edition (a_type, 1)
		ensure
			result_attached: Result /= Void
			not_result_is_recycled: not Result.is_recycled
			requested_tools_has_a_type: requested_tools.has (tool_id (a_type))
			result_sited: Result.window = window
		end

	tool_edition (a_type: TYPE [ES_TOOL [EB_TOOL]]; a_edition: NATURAL_8): ES_TOOL [EB_TOOL]
			-- Retrieves an activate edition of a tool associated with a particular type.
			-- Note: Requesting a tool that has not yet been activated/instantiated will activate it before
			--       it is returned.
			--
			-- `a_type': The type of tool requested.
			-- `a_edition': The edition number of the tool to retrieve, for multiple instance supported tool.
			-- `Result': An activated tool corresponding to the supplied type.
		require
			not_is_recycled: not is_recycled
			a_type_attached: a_type /= Void
			tool_types_has_a_type: tool_types.has (a_type)
			a_edition_positive: a_edition > 0
			a_edition_small_enough: a_edition <= editions_of_tool (a_type) + 1
		local
			l_tools: like requested_tools
			l_id: like tool_id
			l_editions: ARRAY [ES_TOOL [EB_TOOL]]
		do
			l_tools := requested_tools
			l_id := tool_id (a_type)
			if l_tools.has (l_id) then
				l_editions := l_tools.item (l_id)
				if a_edition > l_editions.count then
					l_editions.grow (a_edition)
					l_editions.put (create_tool (a_type, a_edition), a_edition)
				end
			else
				create l_editions.make (1, 1)
				l_editions.put (create_tool (a_type, 1), 1)
				l_tools.force (l_editions, l_id)
			end

			check
				l_editions_attached: l_editions /= Void
				l_editions_big_enough: l_editions.count >= a_edition
			end
			Result := l_editions.item (a_edition)
		ensure
			result_attached: Result /= Void
			not_result_is_recycled: not Result.is_recycled
			requested_tools_has_a_type: requested_tools.has (tool_id (a_type))
			result_sited: Result.window = window
		end

	tool_next_available_edition (a_type: TYPE [ES_TOOL [EB_TOOL]]; a_reuse: BOOLEAN): ES_TOOL [EB_TOOL]
			-- Retrieves the next available tool associated with a particular type.
			-- Note: Requesting a tool that has not yet been activated/instantiated will activate it before
			--       it is returned.
			--
			-- `a_type': The type of tool requested.
			-- `a_reuse': Attempts to reuse a uninitialized or closed tool instead of incrementing the number of tool.
			-- `Result': An activated tool corresponding to the supplied type.
		require
			not_is_recycled: not is_recycled
			a_type_attached: a_type /= Void
			tool_types_has_a_type: tool_types.has (a_type)
		local
			l_editions: like editions_of_tool
			l_tools: ARRAY [ES_TOOL [EB_TOOL]]
			l_tool: ES_TOOL [EB_TOOL]
			l_count, i: INTEGER
		do
			l_editions := editions_of_tool (a_type)
			if a_reuse and then l_editions > 0 then
					-- Check if there are any unactivated tools, or tools not show.
				l_tools := requested_tools.item (tool_id (a_type))
				from
					i := 1
					l_count := l_tools.count
				until
					i > l_count or Result /= Void
				loop
					l_tool := l_tools[i]
					if
						not l_tool.is_recycled and then
						not l_tool.is_tool_instantiated or else
						(l_tool.tool.is_recycled and then not l_tool.tool.shown)
					then
						Result := l_tool
					end
					i := i + 1
				end
			end

			if Result = Void then
				Result := tool_edition (a_type, l_editions + 1)
			end
		ensure
			result_attached: Result /= Void
			not_result_is_recycled: not Result.is_recycled
			requested_tools_has_a_type: requested_tools.has (tool_id (a_type))
			result_sited: Result.window = window
			editions_of_tool_increment: not a_reuse implies editions_of_tool (a_type) = old editions_of_tool (a_type) + 1
		end

	editions_of_tool (a_type: TYPE [ES_TOOL [EB_TOOL]]): NATURAL_8
			-- Retrieves the number of active editions of a particular tool.
			--
			-- `a_type': Tool type to retrieve the number of active editions for.
			-- `Result': A positive number of active tools or 0 to indicate the tool has not yet been requested.
		require
			not_is_recycled: not is_recycled
			a_type_attached: a_type /= Void
		local
			l_tools: like requested_tools
			l_id: like tool_id
		do
			l_tools := requested_tools
			l_id := tool_id (a_type)
			if l_tools.has (l_id) then
				Result := l_tools.item (l_id).count.to_natural_8
			end
		ensure
			result_positive: requested_tools.has (tool_id (a_type)) implies Result > 0
		end

feature {NONE} -- Query

	tool_id (a_type: TYPE [ES_TOOL [EB_TOOL]]): STRING_32
			-- Retrieve tool identifier for a given type.
			--
			-- `a_type': Tool type to retrieve a ID for.
			-- `Result': A string identifier identifying the tool type supplied.
		require
			a_type_attached: a_type /= Void
		do
			Result := a_type.generating_type
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_consistent: Result.is_equal (tool_id (a_type))
		end

feature -- Basic operation

	show_tool (a_type: TYPE [ES_TOOL [EB_TOOL]]; a_activate: BOOLEAN)
			-- Forces the display of a tool associated with the given type.
			--
			-- `a_type': Tool type to show an active tool for.
			-- `a_activate': True to set focus to the shown tool; False otherwise.
		require
			not_is_recycled: not is_recycled
			a_type_attached: a_type /= Void
			tool_types_has_a_type: tool_types.has (a_type)
		do
			show_tool_edition (a_type, 1, a_activate)
		ensure
			tool_is_instatiated: tool (a_type).is_tool_instantiated
			tool_is_shown: tool (a_type).tool.shown
		end

	show_tool_edition (a_type: TYPE [ES_TOOL [EB_TOOL]]; a_edition: NATURAL_8; a_activate: BOOLEAN)
			-- Forces the display of a tool edition associated with the given type.
			--
			-- `a_type': Tool type to show an active tool for.
			-- `a_edition': The edition number of the tool to show, for multiple instance supported tool.
			-- `a_activate': True to set focus to the shown tool; False otherwise.
		require
			not_is_recycled: not is_recycled
			a_type_attached: a_type /= Void
			tool_types_has_a_type: tool_types.has (a_type)
			a_edition_positive: a_edition > 0
			a_edition_small_enough: a_edition <= editions_of_tool (a_type) + 1
		local
			l_tool: like tool
		do
			l_tool := tool_edition (a_type, a_edition)
			l_tool.show (a_activate)
		ensure
			tool_is_instatiated: tool_edition (a_type, a_edition).is_tool_instantiated
			tool_is_shown: tool_edition (a_type, a_edition).tool.shown
		end

	show_tool_next_available_edition (a_type: TYPE [ES_TOOL [EB_TOOL]]; a_reuse: BOOLEAN; a_activate: BOOLEAN)
			-- Forces the display of the next available tool associated with the given type.
			--
			-- `a_type': The type of tool requested.
			-- `a_reuse': Attempts to reuse a uninitialized or closed tool instead of incrementing the number of tools.
			-- `a_activate': True to set focus to the shown tool; False otherwise.
		require
			not_is_recycled: not is_recycled
			a_type_attached: a_type /= Void
			tool_types_has_a_type: tool_types.has (a_type)
		local
			l_tool: like tool
		do
			l_tool := tool_next_available_edition (a_type, a_reuse)
			l_tool.show (a_activate)
		ensure
			tool_is_instatiated: (old tool_next_available_edition (a_type, a_reuse)).is_tool_instantiated
			tool_is_shown: (old tool_next_available_edition (a_type, a_reuse)).tool.shown
		end

feature {NONE} -- Factory

	create_tool (a_type: TYPE [ES_TOOL [EB_TOOL]]; a_edition: NATURAL_8): ES_TOOL [EB_TOOL]
			-- Creates and initializes a tool.
			--
			-- `a_type': Tool type to initialize a tool for.
			-- `a_edition': The edition number of the tool to create, for multiple instance supported tool.
			-- `Result': An new initialized tool corresponding to the supplied tool type.
		require
			not_is_recycled: not is_recycled
			a_type_attached: a_type /= Void
			a_edition_positive: a_edition > 0
			a_edition_small_enough: a_edition <= editions_of_tool (a_type) + 1
		local
			l_internal: like internal
		do
			l_internal := internal
			Result ?= l_internal.new_instance_of (l_internal.generic_dynamic_type (a_type, 1))
			check
				result_attached: Result /= Void
				result_supports_multiple_editions: a_edition > 1 implies Result.is_supporting_multiple_instances
			end
			Result.set_edition (a_edition)
			Result.set_window (window)
		ensure
			result_attached: Result /= Void
			result_sited: Result.window = window
		end

invariant
	window_attached: window /= Void
	not_window_is_recycled: not window.is_recycled
	requested_tools_attached: requested_tools /= Void
	requested_tools_contains_attached_items: not requested_tools.has_item (Void)

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
