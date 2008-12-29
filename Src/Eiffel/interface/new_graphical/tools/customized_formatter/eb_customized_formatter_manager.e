note
	description: "Manager to handle customized formatters"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_FORMATTER_MANAGER

inherit
	EB_CUSTOMIZED_FORMATTER_RELATED_MANAGER [EB_CUSTOMIZED_FORMATTER_DESP]

	EB_SHARED_METRIC_MANAGER

	PROJECT_CONTEXT

	SHARED_EIFFEL_PROJECT

feature -- Access

	change_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when change occurs
			-- This maybe because modification through customized formatter setup procedure or
			-- through metric definition change.
		do
			if change_actions_internal = Void then
				create change_actions_internal
			end
			Result := change_actions_internal
		ensure
			result_attached: Result /= Void
		end

	formatters (a_tool_name: STRING; a_manager: EB_STONABLE): LIST [EB_CUSTOMIZED_FORMATTER]
			-- Loaded customized formatters whose default tool is `a_tool_name'
			-- Always create new formatter instances from `formatter_descriptors'.
		local
			l_formatters: LINKED_LIST [EB_CUSTOMIZED_FORMATTER]
			l_fmt_desp: EB_CUSTOMIZED_FORMATTER_DESP
			l_desp: like formatter_descriptors
			l_cursor: CURSOR
		do
			l_desp := formatter_descriptors
			l_cursor := l_desp.cursor
			create l_formatters.make
			from
				l_desp.start
			until
				l_desp.after
			loop
				l_fmt_desp := l_desp.item
				if l_fmt_desp.has_tool (a_tool_name) then
					l_formatters.extend (l_fmt_desp.new_formatter (a_tool_name, a_manager))
				end
				l_desp.forth
			end
			l_desp.go_to (l_cursor)
			Result := l_formatters
		ensure
			result_attached: Result /= Void
		end

	formatter_descriptors: LIST [EB_CUSTOMIZED_FORMATTER_DESP]
			-- List of formatter descriptors loaded by `items_from_file'
		do
			if formatter_descriptors_internal = Void then
				create {LINKED_LIST [EB_CUSTOMIZED_FORMATTER_DESP]} formatter_descriptors_internal.make
			end
			Result := formatter_descriptors_internal
		end

	xml_for_descriptor (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP; a_parent: XM_COMPOSITE): XM_ELEMENT
			-- Xml element for `a_descriptor'
		require
			a_descriptor_attached: a_descriptor /= Void
			a_parent_attached: a_parent /= Void
		local
			l_namespace: XM_NAMESPACE
			l_tooltip: XM_ELEMENT
			l_header: XM_ELEMENT
			l_temp_header: XM_ELEMENT
			l_metric: XM_ELEMENT
			l_tools: XM_ELEMENT
			l_tool: XM_ELEMENT
			l_pixmap: XM_ELEMENT
			l_content: XM_CHARACTER_DATA
			l_tool_tbl: HASH_TABLE [STRING, STRING]
			l_order_tbl: HASH_TABLE [STRING, STRING]
			l_tool_name: STRING
		do
			create l_namespace.make_default
			create Result.make (a_parent, n_formatter, l_namespace)
			Result.add_unqualified_attribute (n_name, a_descriptor.name)

			create l_tooltip.make_last (Result, n_tooltip, l_namespace)
			create l_content.make_last (l_tooltip, a_descriptor.tooltip)

			create l_header.make_last (Result, n_header, l_namespace)
			create l_content.make_last (l_header, a_descriptor.header)

			create l_temp_header.make_last (Result, n_temp_header, l_namespace)
			create l_content.make_last (l_temp_header, a_descriptor.temp_header)

			create l_metric.make_last (Result, n_metric, l_namespace)
			l_metric.add_unqualified_attribute (n_name, a_descriptor.metric_name)
			l_metric.add_unqualified_attribute (n_filter, a_descriptor.is_filter_enabled.out)

			create l_pixmap.make_last (Result, n_pixmap, l_namespace)
			l_pixmap.add_unqualified_attribute (n_location, a_descriptor.pixmap_location)

			create l_tools.make_last (Result, n_tools, l_namespace)
			from
				l_tool_tbl := a_descriptor.tools
				l_order_tbl := a_descriptor.sorting_orders
				l_tool_tbl.start
			until
				l_tool_tbl.after
			loop
				l_tool_name := l_tool_tbl.key_for_iteration
				create l_tool.make_last (l_tools, n_tool, l_namespace)
				l_tool.add_unqualified_attribute (n_name, l_tool_name)
				l_tool.add_unqualified_attribute (n_viewer, l_tool_tbl.item_for_iteration)
				l_tool.add_unqualified_attribute (n_sorting_order, l_order_tbl.item (l_tool_name))
				l_tool_tbl.forth
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	has_formatters: BOOLEAN
			-- Is there any customized formatter loaded?
		do
			Result := not formatter_descriptors.is_empty
		end

	is_formatter_global_scope (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP): BOOLEAN
			-- Is formatter defined by `a_descriptor' of global scope?
		require
			a_descriptor_attached: a_descriptor /= Void
		do
			Result := a_descriptor.is_global_scope
		end

	is_formatter_target_scope (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP): BOOLEAN
			-- Is formatter defined by `a_descriptor' of target scope?
		require
			a_descriptor_attached: a_descriptor /= Void
		do
			Result := a_descriptor.is_target_scope
		end

feature -- Setting

	load (a_error_agent: PROCEDURE [ANY, TUPLE])
			-- Load global and target scope formatters.
			-- `a_error_agent' is the agent invoked when error occurs during loading.
		local
			l_file: RAW_FILE
		do
			formatter_descriptors.wipe_out

			load_formatters (global_formatter_file, True, a_error_agent)
			if workbench.universe_defined then
				create l_file.make (target_formatter_file)
				if l_file.exists then
					load_formatters (target_formatter_file, False, a_error_agent)
				end
			end
			set_is_loaded (True)
			change_actions.call (Void)
		end

	store
			-- Store formatters in xml files.
		do
			if has_formatters then
				store_descriptors (formatter_descriptors)
			end
		end

	store_descriptors (a_descriptors: LIST [EB_CUSTOMIZED_FORMATTER_DESP])
			-- Store `a_descriptors' in global or target scope xml files.
		require
			a_descriptors_attached: a_descriptors /= Void
			a_descriptors_valid: not a_descriptors.has (Void)
		do
			workbench.create_data_directory
			store_in_file (satisfied_items (a_descriptors, agent is_formatter_global_scope), n_formatters, agent xml_for_descriptor, global_file_path, formatter_file_name)
			if workbench.universe_defined then
				store_in_file (satisfied_items (a_descriptors, agent is_formatter_target_scope), n_formatters, agent xml_for_descriptor, target_formatter_file_path, formatter_file_name)
			end
		end

feature{NONE} -- Implementation

	load_formatters (a_file: STRING; a_global: BOOLEAN; a_error_agent: PROCEDURE [ANY, TUPLE])
			-- Load formatters contained in file `a_file' and mark loaded formatters as of global scope if `a_global' is True,
			-- otherwise as of target scope.
			-- If error occurs, call `a_error_agent'.
		require
			a_file_attached: a_file /= Void
		local
			l_descriptors: like formatter_descriptors
			l_desp_tuple: like items_from_file
			l_callback: EB_CUSTOMIZED_FORMATTER_XML_CALLBACK
		do
			create l_callback.make
			set_is_file_readable (True)
			clear_last_error
			l_desp_tuple := items_from_file (a_file, l_callback, agent l_callback.formatters, agent l_callback.last_error, agent set_last_error (create{EB_METRIC_ERROR}.make (metric_names.err_file_not_readable (a_file))))
			l_descriptors := l_desp_tuple.items
			if not has_error then
				set_last_error (l_desp_tuple.error)
			end
			if a_error_agent /= Void and then has_error then
				a_error_agent.call (Void)
				clear_last_error
			end
			mark_descriptors (l_descriptors, a_global)
			formatter_descriptors.append (l_descriptors)
		end

	mark_descriptors (a_descriptors: LIST [EB_CUSTOMIZED_FORMATTER_DESP]; a_global: BOOLEAN)
			-- Mark descriptors given by `a_descriptors' as of global scope if `a_global' is True,
			-- otherwise as of target scope.
		require
			a_descriptors_attached: a_descriptors /= Void
			a_descriptors_valid: not a_descriptors.has (Void)
		do
			if a_global then
				a_descriptors.do_all (agent (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP) do a_descriptor.enable_global_scope end)
			else
				a_descriptors.do_all (agent (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP) do a_descriptor.enable_target_scope end)
			end
		end

feature{NONE} -- Implementation/Data

	formatter_descriptors_internal: like formatter_descriptors
			-- Implementation of `formatter_descriptors'

	formatter_file_name: STRING = "formatters.xml"
			-- File name of formatter definition

	target_formatter_file_path: FILE_NAME
			-- Path to store target formatter file
		require
			system_defined: workbench.universe_defined
		do
			Result := formatter_file_path (project_location.data_path)
		ensure
			result_attached: Result /= Void
		end

	global_formatter_file: STRING
			-- File to store global customized formatters information
		do
			Result := absolute_file_name (global_file_path, formatter_file_name)
		end

	target_formatter_file: STRING
			-- File to store target customized formatters information
		require
			system_defined: workbench.universe_defined
		do
			Result := absolute_file_name (target_formatter_file_path, formatter_file_name)
		end

	change_actions_internal: like change_actions;
			-- Implementation of `change_actions'

note
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

end
