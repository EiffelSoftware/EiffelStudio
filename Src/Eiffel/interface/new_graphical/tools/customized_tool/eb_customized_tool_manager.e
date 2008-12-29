note
	description: "Cstomized tool manager"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_TOOL_MANAGER

inherit
	EB_CUSTOMIZED_FORMATTER_RELATED_MANAGER [EB_CUSTOMIZED_TOOL_DESP]

feature -- Access

	change_actions: ACTION_SEQUENCE [TUPLE [LIST [STRING]]]
			-- Actions to be performed when customized tools changes
			-- Argument of the actions are list of ids of tools that are changed.			
			-- By "changed", it means that tools that are removed or newly added.
			-- By contrast, tools that has modifications such as name/pixmap location/stone handlers modification are
			-- called "modified".
		do
			if change_actions_internal = Void then
				create change_actions_internal
			end
			Result := change_actions_internal
		end

	tool_descriptors: LIST [EB_CUSTOMIZED_TOOL_DESP]
			-- List of loaded descriptors for customized tool
		do
			if tool_descriptors_internal = Void then
				create {LINKED_LIST [EB_CUSTOMIZED_TOOL_DESP]} tool_descriptors_internal.make
			end
			Result := tool_descriptors_internal
		ensure
			result_attached: Result /= Void
		end

	descriptor_by_id (a_id: STRING): EB_CUSTOMIZED_TOOL_DESP
			-- Tool descriptor from `tool_descriptors' whose id is `a_id'
			-- Void if no descriptor is found.
		local
			l_desps: like tool_descriptors
			l_cursor: CURSOR
		do
			l_desps := tool_descriptors
			l_cursor := l_desps.cursor
			from
				l_desps.start
			until
				l_desps.after or Result /= Void
			loop
				if l_desps.item.id.is_equal (a_id) then
					Result := l_desps.item
				end
				l_desps.forth
			end
			l_desps.go_to (l_cursor)
		end

	tools_by_ids (a_ids: LIST [STRING]; a_include: BOOLEAN; a_develop_window: EB_DEVELOPMENT_WINDOW): LIST [EB_CUSTOMIZED_TOOL]
			-- List of customized tool (for use by `a_develop_window') generated from `tools_descriptors'
			-- whose ids are included in `a_ids' if `a_include' is True, otherwise, not included in `a_ids'.
		require
			a_ids_attached: a_ids /= Void
			a_ids_valid: not a_ids.has (Void)
			a_develop_window_attached: a_develop_window /= Void
		local
			l_desps: like tool_descriptors
			l_cursor: CURSOR
			l_id_set: DS_HASH_SET [STRING]
			l_insert: BOOLEAN
		do
			create l_id_set.make (a_ids.count)
			l_id_set.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [STRING]}.make (agent (a_str, b_str: STRING): BOOLEAN do Result := equal (a_str, b_str) end))
			a_ids.do_all (agent l_id_set.force_last)
			l_desps := tool_descriptors
			l_cursor := l_desps.cursor
			create {LINKED_LIST [EB_CUSTOMIZED_TOOL]} Result.make
			from
				l_desps.start
			until
				l_desps.after
			loop
				if a_include then
					l_insert := l_id_set.has (l_desps.item.id)
				else
					l_insert := not l_id_set.has (l_desps.item.id)
				end
				if l_insert then
					Result.extend (l_desps.item.new_tool (a_develop_window))
				end
				l_desps.forth
			end
			l_desps.go_to (l_cursor)
		ensure
			result_atached: Result /= Void
		end

	tool_ids: LIST [STRING]
			-- IDs from `tool_descriptors'
		local
			l_desp: like tool_descriptors
			l_cursor: CURSOR
		do
			create {LINKED_LIST [STRING]} Result.make
			l_desp := tool_descriptors
			l_cursor := l_desp.cursor
			from
				l_desp.start
			until
				l_desp.after
			loop
				Result.extend (l_desp.item.id)
				l_desp.forth
			end
			l_desp.go_to (l_cursor)
		ensure
			result_attached: Result /= Void
		end

	tool_id_set: DS_HASH_SET [STRING]
			-- Set of ids from `tools'
		do
			create Result.make (10)
			Result.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [STRING]}.make (agent id_equal))
			tool_ids.do_all (agent Result.force_last)
		ensure
			result_attached: Result /= Void
		end

	id_equal (a_id, b_id: STRING): BOOLEAN
			-- Is `a_id' equal to `b_id'?
		require
			a_id_attached: a_id /= Void
			b_id_attached: b_id /= Void
		do
			Result := a_id.is_equal (b_id)
		end

	xml_for_descriptor (a_descriptor: EB_CUSTOMIZED_TOOL_DESP; a_parent: XM_COMPOSITE): XM_ELEMENT
			-- Xml element for `a_descriptor'
		require
			a_descriptor_attached: a_descriptor /= Void
			a_parent_attached: a_parent /= Void
		local
			l_namespace: XM_NAMESPACE
			l_pixmap: XM_ELEMENT
			l_handlers: XM_ELEMENT
			l_handler_table: HASH_TABLE [STRING, STRING]
			l_handler: XM_ELEMENT
		do
			create l_namespace.make_default
			create Result.make (a_parent, n_tool, l_namespace)
			Result.add_unqualified_attribute (n_name, a_descriptor.name.as_string_8)
			Result.add_unqualified_attribute (n_id, a_descriptor.id)

			create l_pixmap.make_last (Result, n_pixmap, l_namespace)
			l_pixmap.add_unqualified_attribute (n_location, a_descriptor.pixmap_location)

			create l_handlers.make_last (Result, n_handlers, l_namespace)
			from
				l_handler_table := a_descriptor.handlers
				l_handler_table.start
			until
				l_handler_table.after
			loop
				create l_handler.make_last (l_handlers, n_handler, l_namespace)
				l_handler.add_unqualified_attribute (n_stone, l_handler_table.key_for_iteration)
				l_handler.add_unqualified_attribute (n_default_tool, l_handler_table.item_for_iteration)
				l_handler_table.forth
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	has_tools: BOOLEAN
			-- Is there any customized tool?
		do
			Result := not tool_descriptors.is_empty
		end

feature -- Storage

	load (a_error_agent: PROCEDURE [ANY, TUPLE])
			-- Load information.
			-- `a_error_agent' is the agent invoked when error occurs during loading.
		local
			l_callback: EB_CUSTOMIZED_TOOL_XML_CALLBACK
			l_desp_tuple: like items_from_file
			l_id_set: like tool_id_set
			l_id_list: LINKED_LIST [STRING]
			l_cursor: DS_HASH_SET_CURSOR [STRING]
			l_old_id_set: like tool_id_set
			l_new_id_set: like tool_id_set
			l_changed_id_set: like tool_id_set
		do
			l_old_id_set := tool_id_set
			l_id_set := tool_id_set
			tool_descriptors.wipe_out
			create l_callback.make
			clear_last_error
			l_desp_tuple := items_from_file (tool_file, l_callback, agent l_callback.tools, agent l_callback.last_error, agent set_last_error (create{EB_METRIC_ERROR}.make (metric_names.err_file_not_readable (tool_file))))
			if last_error = Void then
				set_last_error (l_desp_tuple.error)
			end
			if a_error_agent /= Void then
				a_error_agent.call (Void)
				clear_last_error
			end
			tool_descriptors.append (l_desp_tuple.items)
			set_is_loaded (True)

				-- Calculate "changed" (either removed or newly added) tools.
			l_new_id_set := tool_id_set
			l_changed_id_set := l_old_id_set.union (l_new_id_set).subtraction (l_old_id_set.intersection (l_new_id_set))
			create l_id_list.make
			l_cursor := l_changed_id_set.new_cursor
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_id_list.extend (l_cursor.item)
				l_cursor.forth
			end
			change_actions.call ([l_id_list])
		end

	store
			-- Store information.
		do
			if has_tools then
				store_in_file (tool_descriptors, n_tools, agent xml_for_descriptor, global_file_path, tool_file_name)
			end
		end

	store_descriptors (a_descriptors: like tool_descriptors)
			-- Store `a_descriptors' in tool definition xml file.
		do
			store_in_file (a_descriptors, n_tools, agent xml_for_descriptor, global_file_path, tool_file_name)
		end

feature{NONE} -- Implementation

	tool_descriptors_internal: like tool_descriptors
			-- Implementation of `tool_descriptors'

	tool_file_name: STRING = "tools.xml"
			-- File name of customized tool definition xml

	tool_file: STRING
			-- File including path of customized tool definition xml
		do
			Result := absolute_file_name (global_file_path, tool_file_name)
		end

	change_actions_internal: like change_actions
			-- Implementation of `change_actions'

end

