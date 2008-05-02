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
		redefine
			internal_detach_entities
		end

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
			create internal_requested_tools.make_default
			window := a_window
		ensure
			window_set: window = a_window
		end

feature {NONE} -- Clean up

	internal_recycle is
			-- Called to clean up resources of Current.
		local
			l_win: like window
		do
			l_win := window
			if l_win /= Void and then l_win.docking_manager /= Void then
				l_win.docking_manager.close_all
			end
				-- Recycle all activated tools.
			internal_requested_tools.do_all (agent (a_items: ARRAY [ES_TOOL [EB_TOOL]])
				local
					l_count, i: INTEGER
				do
					l_count := a_items.count
					from i := 1 until i > l_count loop
						(a_items [i]).recycle
						i := i + 1
					end
				end)
		end

	internal_detach_entities
			-- Detaches objects from their container
		do
			internal_requested_tools := Void
			internal_all_tools := Void
			window := Void

			Precursor {EB_RECYCLABLE}
		ensure then
			internal_requested_tools_detached: internal_requested_tools = Void
			internal_all_tools_detached: internal_all_tools = Void
			window_detached: window = Void
		end

	clean_requested_tools
			-- Performs a clean up for `requested_tools' to remove any recycled tools from it.
		require
			is_interface_usable: is_interface_usable
		local
			l_requested_tools: like internal_requested_tools
			l_cursor: DS_HASH_TABLE_CURSOR [ARRAY [ES_TOOL [EB_TOOL]], STRING_8]
			l_tools: ARRAY [ES_TOOL [EB_TOOL]]
			l_tool: ES_TOOL [EB_TOOL]
			l_count, i: INTEGER
			l_remove_indexes: DS_ARRAYED_LIST [INTEGER]
			l_remove_keys: DS_ARRAYED_LIST [STRING_8]
			l_new_tools: ARRAY [ES_TOOL [EB_TOOL]]
			l_index: INTEGER
		do
			l_requested_tools := internal_requested_tools

				-- Perform a clean up so the requested tools never returns any recycled tools.
				-- This way any request for a tool will always return an activated tool because
				-- the tool function will not find an activated and recycled tool, and therefore
				-- will create a new tool instance.
			l_cursor := l_requested_tools.new_cursor
			from l_cursor.start until l_cursor.after loop
					-- Iterate through the tool types to examine the array of activated tools.

				l_remove_indexes := Void
				l_tools := l_cursor.item
				from i := 1; l_count := l_tools.count until i > l_count loop
						-- Examine each activated tool
					l_tool := l_tools.item (i)

					if l_tool.is_recycled then
							-- Tool has been recycled so it needs to be removed
						if l_remove_indexes = Void then
							create l_remove_indexes.make_default
						end
						l_remove_indexes.force_last (i)
					end

					i := i + 1
				end

				if l_remove_indexes /= Void then
						-- Need to remove recycled items

					if l_remove_indexes.count = l_tools.count then
							-- All the tools are recycled so we just need remove the bucket instead of
							-- creating a new array, for the bucket, with no items.
						if l_remove_keys = Void then
							create l_remove_keys.make_default
						end
						l_remove_keys.force_last (l_cursor.key)
					else
							-- One or more tools have been recycled so we need to reorganize the tool array
							-- to remove unwanted, recycled tools.
						check l_count_unmodified: l_count = l_tools.count end

						create l_new_tools.make (1, l_count - l_remove_indexes.count)
						from i := 1; l_index := 1 until i > l_count loop
							if not l_remove_indexes.has (i) then
								l_tool := l_tools.item (i)
									-- Must set the correct edition
								l_tool.set_edition (l_index.to_natural_8)
								l_new_tools.put (l_tool, l_index)
								l_index := l_index + 1
							end
							i := i + 1
						end

							-- Set new tool array
						l_requested_tools.replace (l_new_tools, l_cursor.key)
					end
				end
				l_cursor.forth
			end

			if l_remove_keys /= Void then
					-- Remove buckets for a given key.
				from l_remove_keys.start until l_remove_keys.after loop
					l_requested_tools.remove (l_remove_keys.item_for_iteration)
					l_remove_keys.forth
				end
			end
		end

feature -- Access

	window: EB_DEVELOPMENT_WINDOW
			-- Development window where tools are hosted

	frozen all_tools: DS_ARRAYED_LIST [ES_TOOL [EB_TOOL]]
			-- List of available first-edition tools, that can be used by Current.
			-- Note: If you need access to later editions please use `tool_edition'.
		require
			is_interface_usable: is_interface_usable
		local
			l_types: like tool_types
			l_cursor: DS_BILINEAR_CURSOR [TYPE [ES_TOOL [EB_TOOL]]]
		do
			Result := internal_all_tools
			if Result = Void then
				l_types := tool_types
				l_cursor := l_types.new_cursor
				create Result.make_default
				from l_cursor.start until l_cursor.after loop
					Result.append_last (tools (l_cursor.item))
					l_cursor.forth
				end
				internal_all_tools := Result
			end
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
			result_count_matches_tool_types: tool_types.count = Result.count
			result_consistent: Result = all_tools
		end

	frozen all_requested_tools: DS_ARRAYED_LIST [ES_TOOL [EB_TOOL]]
			-- List of all tools requested and initialized. The resulting list may contain multiple editions of the same tool.
		require
			is_interface_usable: is_interface_usable
		local
			l_cursor: DS_HASH_TABLE_CURSOR [ARRAY [ES_TOOL [EB_TOOL]], STRING_8]
			l_tools: like requested_tools
			l_editions: ARRAY [ES_TOOL [EB_TOOL]]
			l_count, i: INTEGER
		do
			l_tools := requested_tools
			l_cursor := l_tools.new_cursor
			create Result.make (l_tools.count)
			from l_cursor.start until l_cursor.after loop
				l_editions := l_cursor.item
				from
					i := 1
					l_count := l_editions.count
				until i > l_count loop
					Result.force_last (l_editions [i])
					i := i + 1
				end
				l_cursor.forth
			end
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
		end

feature {NONE} -- Access

	tool_types: DS_BILINEAR [TYPE [ES_TOOL [EB_TOOL]]]
			-- List of predefined available tools in the EiffelStudio shell.
		require
			is_interface_usable: is_interface_usable
		local
			l_tools: DS_ARRAYED_LIST [TYPE [ES_TOOL [EB_TOOL]]]
		once
			create l_tools.make (26)

				-- Common tools
			l_tools.put_last ({ES_CLASS_TOOL})
			l_tools.put_last ({ES_CONSOLE_TOOL})
			l_tools.put_last ({ES_C_OUTPUT_TOOL})
			l_tools.put_last ({ES_DEPENDENCY_TOOL})
			l_tools.put_last ({ES_DIAGRAM_TOOL})
			l_tools.put_last ({ES_ERROR_LIST_TOOL})
			l_tools.put_last ({ES_FAVORITES_TOOL})
			l_tools.put_last ({ES_FEATURES_TOOL})
			l_tools.put_last ({ES_FEATURE_RELATION_TOOL})
			l_tools.put_last ({ES_GROUPS_TOOL})
			l_tools.put_last ({ES_METRICS_TOOL})
			l_tools.put_last ({ES_OUTPUT_TOOL})
			l_tools.put_last ({ES_PROPERTIES_TOOL})
			l_tools.put_last ({ES_SEARCH_REPORT_TOOL})
			l_tools.put_last ({ES_SEARCH_TOOL})
			l_tools.put_last ({ES_WINDOWS_TOOL})
			l_tools.put_last ({ES_CONTRACT_TOOL})
			l_tools.put_last ({ES_INFORMATION_TOOL})
			l_tools.put_last ({ES_TESTING_TOOL})
			l_tools.put_last ({ES_TESTING_RESULT_TOOL})

				-- Custom formatter tools
				-- FIXME: Custom formatter tools have been tricking to adapt for 6.1. Given the time-frame
				--        optimizations will be deferred for a later release, hopefully 6.2.
			--l_tools.put_last ({ES_CUSTOM_FORMATTER_TOOL})

				-- Debugger tools
			l_tools.put_last ({ES_BREAKPOINTS_TOOL})
			l_tools.put_last ({ES_THREADS_TOOL})
			l_tools.put_last ({ES_CALL_STACK_TOOL})
			l_tools.put_last ({ES_WATCH_TOOL})
			l_tools.put_last ({ES_OBJECTS_TOOL})
			l_tools.put_last ({ES_OBJECT_VIEWER_TOOL})

			l_tools.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [TYPE [ES_TOOL [EB_TOOL]]]}.make (agent {TYPE [ES_TOOL [EB_TOOL]]}.is_equal))
			Result := l_tools
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
		end

	requested_tools: DS_HASH_TABLE [ARRAY [ES_TOOL [EB_TOOL]], STRING_8] is
			-- Table of requested, and therefore created, tools.
		do
			if not is_recycled then
				clean_requested_tools
			end
			Result := internal_requested_tools
		end

feature -- Status reporting

	is_multi_edition_tool (a_type: TYPE [ES_TOOL [EB_TOOL]]): BOOLEAN
			-- Determines if a tool support multiple editions
			--
			-- `a_type': The type of tool requested.
			-- `Result': True if multiple editions are supported, False otherwise.
		require
			is_interface_usable: is_interface_usable
			a_type_attached: a_type /= Void
		local
			l_tool: ES_TOOL [EB_TOOL]
		do
				-- Fetch first edition to determine if it supports multiple instances.
			l_tool := tool (a_type)
			if l_tool /= Void then
				Result := l_tool.is_supporting_multiple_instances
			end
		end

feature {NONE} -- Helpers

	frozen internal: INTERNAL
			-- Shared access to an instance of {INTERNAL}
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Query

	dynamic_tool_type (a_type: STRING_8): TYPE [ES_TOOL [EB_TOOL]]
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

	frozen tool (a_type: TYPE [ES_TOOL [EB_TOOL]]): ES_TOOL [EB_TOOL]
			-- Retrieves an activate tool associated with a particular type.
			-- Note: Requesting a tool descriptor that has not yet been instantiated will instatiate it before
			--       it is returned.
			--
			-- `a_type': The type of tool requested.
			-- `Result': An activated tool corresponding to the supplied type.
		require
			is_interface_usable: is_interface_usable
			a_type_attached: a_type /= Void
		do
			Result := tool_edition (a_type, 1)
		ensure
			result_attached: Result /= Void
			not_result_is_recycled: not Result.is_recycled
			requested_tools_has_a_type: requested_tools.has (tool_id (a_type))
			result_sited: Result.window = window
		end

	frozen tools (a_type: TYPE [ES_TOOL [EB_TOOL]]): DS_ARRAYED_LIST [ES_TOOL [EB_TOOL]]
			-- Retrieves an activate all tools associated with a particular type.
			-- Note: Requesting a tool descriptor that has not yet been instantiated will instatiate it before
			--       it is returned.
			--
			-- `a_type': The type of tool requested.
			-- `Result': A list of activated tools corresponding to the supplied type.
		require
			is_interface_usable: is_interface_usable
			a_type_attached: a_type /= Void
		local
			l_count, i: like editions_of_tool
		do
			create Result.make_default
			l_count := editions_of_tool (a_type, False)
			if l_count = 0 then
					-- No requests made yet, so we force the retrival of the first edition
				Result.force_last (tool (a_type))
			else
					-- Iterate over the available editions.
				from i := {NATURAL_8} 1 until i > l_count loop
					Result.force_last (tool_edition (a_type, i))
					i := i + 1
				end
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_attached_items: not Result.has (Void)
			result_contains_valid_items: Result.for_all (agent (a_tool: ES_TOOL [EB_TOOL]): BOOLEAN
				do
					Result := not a_tool.is_recycled and then
						a_tool.window = window and then
						requested_tools.has (tool_id_from_tool (a_tool))
				end)
		end

	tool_edition (a_type: TYPE [ES_TOOL [EB_TOOL]]; a_edition: NATURAL_8): ES_TOOL [EB_TOOL]
			-- Retrieves an activate edition of a tool associated with a particular type.
			-- Note: Requesting a tool descriptor that has not yet been instantiated will instatiate it before
			--       it is returned.
			--
			-- `a_type': The type of tool requested.
			-- `a_edition': The edition number of the tool to retrieve, for multiple instance supported tool.
			-- `Result': An activated tool corresponding to the supplied type.
		require
			is_interface_usable: is_interface_usable
			a_type_attached: a_type /= Void
			a_type_is_multi_edition_tool: a_edition > 1 implies is_multi_edition_tool (a_type)
			a_edition_positive: a_edition > 0
			a_edition_small_enough: a_edition <= editions_of_tool (a_type, False) + 1
		local
			l_tools: like internal_requested_tools
			l_id: like tool_id
			l_editions: ARRAY [ES_TOOL [EB_TOOL]]
			l_tool: like create_tool
		do
			l_tools := internal_requested_tools
			l_id := tool_id (a_type)
			if l_tools.has (l_id) then
				l_editions := l_tools.item (l_id)
				if a_edition > l_editions.count then
					l_tool := create_tool (a_type, a_edition)
					l_editions.grow (a_edition)
					l_editions.put (l_tool, a_edition)
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
			-- Note: Requesting a tool descriptor that has not yet been instantiated will instatiate it before
			--       it is returned.
			--
			-- `a_type': The type of tool requested.
			-- `a_reuse': Attempts to reuse a uninitialized or closed tool instead of incrementing the number of tool.
			-- `Result': An activated tool corresponding to the supplied type.
		require
			is_interface_usable: is_interface_usable
			a_type_attached: a_type /= Void
		local
			l_editions: like editions_of_tool
			l_tools: ARRAY [ES_TOOL [EB_TOOL]]
			l_tool: ES_TOOL [EB_TOOL]
			l_count, i: INTEGER
		do
			l_tool := tool_edition (a_type, 1)
			if not l_tool.is_tool_instantiated then
					-- We reuse the first edition if it hasn't been created because `all_tools'
					-- will add an descriptor instances, even if the tool is never used.
				Result := l_tool
			else
				l_editions := editions_of_tool (a_type, False)
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
							(not l_tool.is_tool_instantiated or else
							(not l_tool.panel.is_recycled and then not l_tool.panel.shown))
						then
							Result := l_tool
						end
						i := i + 1
					end
				end

				if Result = Void then
					Result := tool_edition (a_type, l_editions + 1)
				end
			end
		ensure
			result_attached: Result /= Void
			not_result_is_recycled: not Result.is_recycled
			requested_tools_has_a_type: requested_tools.has (tool_id (a_type))
			result_sited: Result.window = window
			--editions_of_tool_increment: not a_reuse implies editions_of_tool (a_type, False) = old editions_of_tool (a_type, False) + 1
		end

	editions_of_tool (a_type: TYPE [ES_TOOL [EB_TOOL]]; a_active: BOOLEAN): NATURAL_8
			-- Retrieves the number of editions of a particular tool.
			--
			-- `a_type': Tool type to retrieve the number of active editions for.
			-- `a_active': True to retrieve the number of "activated" (instantiated) tool instances; False for the available instances.
			-- `Result': A positive number of active tools or 0 to indicate the tool has not yet been requested.
		require
			is_interface_usable: is_interface_usable
			a_type_attached: a_type /= Void
		local
			l_tool_types: like requested_tools
			l_tools: ARRAY [ES_TOOL [EB_TOOL]]
			l_tool: ES_TOOL [EB_TOOL]
			l_id: like tool_id
			l_count, i: INTEGER
		do
			l_tool_types := requested_tools
			l_id := tool_id (a_type)
			if l_tool_types.has (l_id) then
				l_tools := l_tool_types.item (l_id)
			end
			if l_tools /= Void then
				if a_active then
						-- Active instances only.
					from i := 1; l_count := l_tools.count until i > l_count loop
						l_tool := l_tools[i]
						if l_tool.is_tool_instantiated then
							Result := Result + 1
						end
						i := i + 1
					end
				else
						-- All instances, active and not.
					Result := l_tools.count.to_natural_8
				end
			end
		ensure
				-- Postcondition is far too complex to test when `a_active' is true.
			result_positive: (not a_active and requested_tools.has (tool_id (a_type))) implies Result > 0
		end

feature {NONE} -- Query

	tool_id (a_type: TYPE [ES_TOOL [EB_TOOL]]): STRING_8
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

	tool_id_from_tool (a_tool: ES_TOOL [EB_TOOL]): STRING_8
			-- Retrieve tool identifier for a given tool.
			--
			-- `a_tool': Tool to retrieve a ID for.
			-- `Result': A string identifier identifying the tool type supplied.
		require
			a_tool_attached: a_tool /= Void
		local
			l_type: TYPE [ES_TOOL [EB_TOOL]]
		do
			l_type ?= internal.type_of (a_tool)
			Result := tool_id (l_type)
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_consistent: Result.is_equal (tool_id_from_tool (a_tool))
		end

feature -- Basic operation

	show_tool (a_type: TYPE [ES_TOOL [EB_TOOL]]; a_activate: BOOLEAN)
			-- Forces the display of a tool associated with the given type.
			--
			-- `a_type': Tool type to show an active tool for.
			-- `a_activate': True to set focus to the shown tool; False otherwise.
		require
			is_interface_usable: is_interface_usable
			a_type_attached: a_type /= Void
		do
			show_tool_edition (a_type, 1, a_activate)
		ensure
			tool_is_instatiated: tool (a_type).is_tool_instantiated
			tool_is_shown: tool (a_type).panel.shown
		end

	show_tool_edition (a_type: TYPE [ES_TOOL [EB_TOOL]]; a_edition: NATURAL_8; a_activate: BOOLEAN)
			-- Forces the display of a tool edition associated with the given type.
			--
			-- `a_type': Tool type to show an active tool for.
			-- `a_edition': The edition number of the tool to show, for multiple instance supported tool.
			-- `a_activate': True to set focus to the shown tool; False otherwise.
		require
			is_interface_usable: is_interface_usable
			a_type_attached: a_type /= Void
			a_type_is_multi_edition_tool: a_edition > 1 implies is_multi_edition_tool (a_type)
			a_edition_positive: a_edition > 0
			a_edition_small_enough: a_edition <= editions_of_tool (a_type, False) + 1
		local
			l_tool: like tool
		do
			l_tool := tool_edition (a_type, a_edition)
			l_tool.show (a_activate)
		ensure
			tool_is_instatiated: tool_edition (a_type, a_edition).is_tool_instantiated
			tool_is_shown: tool_edition (a_type, a_edition).panel.shown
		end

	show_tool_next_available_edition (a_type: TYPE [ES_TOOL [EB_TOOL]]; a_reuse: BOOLEAN; a_activate: BOOLEAN)
			-- Forces the display of the next available tool associated with the given type.
			--
			-- `a_type': The type of tool requested.
			-- `a_reuse': Attempts to reuse a uninitialized or closed tool instead of incrementing the number of tools.
			-- `a_activate': True to set focus to the shown tool; False otherwise.
		require
			is_interface_usable: is_interface_usable
			a_type_attached: a_type /= Void
		local
			l_tool: like tool
		do
			l_tool := tool_next_available_edition (a_type, a_reuse)
			l_tool.show (a_activate)
		ensure
			tool_is_instatiated: (old tool_next_available_edition (a_type, a_reuse)).is_tool_instantiated
			tool_is_shown: (old tool_next_available_edition (a_type, a_reuse)).panel.shown
		end

feature {ES_TOOL} -- Removal

	close_tool (a_tool: ES_TOOL [EB_TOOL]) is
			-- Performs clean up of tool and removes it from the cached heap of tools.
			-- Note: This should be called only by ES_TOOL! Calling it from elsewhere
			--       will only perform the recycling.
			--
			-- `a_tool': Tool to close and clean up.
		require
			a_tool_attached: a_tool /= Void
		do
			if not a_tool.is_recycled and then not a_tool.is_hide_requested and then a_tool.is_recycled_on_closing then
				a_tool.recycle
				a_tool.set_window (Void)
				if not is_recycled then
					clean_requested_tools
				end
			end
		ensure
			a_tool_is_recycled: a_tool.is_recycled or else not a_tool.is_recycled_on_closing
			not_requested_tools: (a_tool.is_recycled or else a_tool.is_recycled_on_closing) implies (not requested_tools.has (tool_id_from_tool (a_tool)) or not
				requested_tools.item (tool_id_from_tool (a_tool)).has (a_tool))
		end

feature {NONE} -- Factory

	create_tool (a_type: TYPE [ES_TOOL [EB_TOOL]]; a_edition: NATURAL_8): ES_TOOL [EB_TOOL]
			-- Creates and initializes a tool.
			--
			-- `a_type': Tool type to initialize a tool for.
			-- `a_edition': The edition number of the tool to create, for multiple instance supported tool.
			-- `Result': An new initialized tool corresponding to the supplied tool type.
		require
			is_interface_usable: is_interface_usable
			a_type_attached: a_type /= Void
			a_edition_positive: a_edition > 0
			a_edition_small_enough: a_edition <= editions_of_tool (a_type, False) + 1
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

feature {NONE} -- Internal implementation cache

	internal_all_tools: like all_tools
			-- Cached version of `all_tools'
			-- Note: Do not use directly!

	internal_requested_tools: like requested_tools
			-- Mutable version of `requested_tools'
			-- Note: Functions wanting to add tools to `requested_tools' should use this attribute instead
			--       of `requested_tools'. All queries should use `requested_tools' and not this attribute!

invariant
	window_attached: not is_recycled implies window /= Void
	not_window_is_recycled: not is_recycled implies not window.is_recycled
	internal_requested_tools_attached: not is_recycled implies internal_requested_tools /= Void
	internal_requested_tools_contains_attached_items: not is_recycled implies not internal_requested_tools.has_item (Void)

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
