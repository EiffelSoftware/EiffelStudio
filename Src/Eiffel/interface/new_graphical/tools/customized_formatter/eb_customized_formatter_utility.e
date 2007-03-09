indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_FORMATTER_UTILITY

inherit
	SHARED_BENCH_NAMES

	EB_CUSTOMIZED_FORMATTER_XML_CONSTANTS

feature -- Access

	xml_for_descriptor (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP; a_parent: XM_COMPOSITE): XM_ELEMENT is
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

	descriptors_from_parsing (a_parse_agent: PROCEDURE [ANY, TUPLE [XM_CALLBACKS]]): TUPLE [descriptors: LIST [EB_CUSTOMIZED_FORMATTER_DESP]; error: EB_METRIC_ERROR] is
			-- Setup related callbacks for parsing formatter definition xml and call `a_parse_agent' with those callbacks.
			-- Store descriptors retrieved in `descriptors'.
			-- If error occurred, it will be stored in `error', otherwise, `error' will be Void.
		require
			a_parse_agent_attached: a_parse_agent /= Void
		local
			l_retried: BOOLEAN
			l_ns_cb: XM_NAMESPACE_RESOLVER
			l_content_filter: XM_CONTENT_CONCATENATOR
			l_history_filter: EB_XML_LOCATION_HISTORY_FILTER
			l_callback: EB_CUSTOMIZED_FORMATTER_XML_CALLBACK
			l_filters: ARRAY [XM_CALLBACKS_FILTER]
			l_filter_factory: XM_CALLBACKS_FILTER_FACTORY
			l_error: EB_METRIC_ERROR
			l_descriptors:  LIST [EB_CUSTOMIZED_FORMATTER_DESP]
		do
			create {LINKED_LIST [EB_CUSTOMIZED_FORMATTER_DESP]} l_descriptors.make
			if not l_retried then
				create l_ns_cb.make_null
				create l_content_filter.make_null
				create l_history_filter.make
				create l_callback.make
				create l_filter_factory

				l_history_filter.set_history_item_output_function (agent metric_names.xml_location ({STRING}?, Void))
				create l_filters.make (1, 4)
				l_filters.put (l_ns_cb, 1)
				l_filters.put (l_content_filter, 2)
				l_filters.put (l_history_filter, 3)
				l_filters.put (l_callback, 4)

				a_parse_agent.call ([l_filter_factory.callbacks_pipe (l_filters)])
				l_descriptors.append (l_callback.formatters)
			else
				l_error := l_callback.last_error
				if l_error /= Void then
					l_error.set_location (l_history_filter.location)
				end
			end
			Result := [l_descriptors, l_error]
		ensure
			result_attached: Result /= Void
		rescue
			l_retried := True
			retry
		end

	xml_document_for_formatter (a_descriptors: LIST [EB_CUSTOMIZED_FORMATTER_DESP]): XM_DOCUMENT is
			-- Xml document for `a_descriptors'
		require
			a_descriptors_attached: a_descriptors /= Void
		local
			l_cursor: CURSOR
			l_root: XM_ELEMENT
		do
			create Result.make_with_root_named (n_formatters, create {XM_NAMESPACE}.make_default)
			l_cursor := a_descriptors.cursor
			from
				l_root := Result.root_element
				a_descriptors.start
			until
				a_descriptors.after
			loop
				l_root.force_last (xml_for_descriptor (a_descriptors.item, Result))
				a_descriptors.forth
			end
			a_descriptors.go_to (l_cursor)
		ensure
			result_attached: Result /= Void
		end

	descriptors_from_document (a_document: XM_DOCUMENT): LIST [EB_CUSTOMIZED_FORMATTER_DESP] is
			-- Formatter descriptors from `a_document'
		require
			a_document_attached: a_document /= Void
		local
			l_desp_tuple: like descriptors_from_parsing
		do
			l_desp_tuple := descriptors_from_parsing (agent a_document.process_to_events)
			check l_desp_tuple.error = Void end
			Result := l_desp_tuple.descriptors
		ensure
			result_attached: Result /= Void
		end

	descriptors_from_file (a_file_name: STRING; a_set_file_error_agent: PROCEDURE [ANY, TUPLE]): like descriptors_from_parsing is
			-- Customized fomatter descriptors from file named `a_file_name'.
			-- If error occurred, it will be stored in `error'
			-- If failed because of file issue, call `a_set_file_error_agent'.
		require
			a_file_name_attached: a_file_name /= Void
			a_set_file_error_agent_attached: a_set_file_error_agent /= Void
		local
			l_parser: XM_EIFFEL_PARSER
		do
			create l_parser.make
			Result := descriptors_from_parsing (agent parse_file (a_file_name, ?, l_parser, a_set_file_error_agent))

				-- Setup error information.
			if Result.error /= Void then
				Result.error.set_file_location (a_file_name)
				Result.error.set_xml_location ([l_parser.position.column, l_parser.position.row])
			end
		ensure
			result_attached: Result /= Void
		end

	satisfied_descriptors (a_descriptors: LIST [EB_CUSTOMIZED_FORMATTER_DESP]; a_criterion: FUNCTION [ANY, TUPLE [EB_CUSTOMIZED_FORMATTER_DESP], BOOLEAN]): LIST [EB_CUSTOMIZED_FORMATTER_DESP] is
			-- Formatter descriptors from `a_descriptors' which satisfy `a_criterion'
			-- If `a_criterion' is Void, all formatter descriptors will be returned.
		require
			a_descriptors_attached: a_descriptors /= Void
		local
			l_fmt_desp: EB_CUSTOMIZED_FORMATTER_DESP
			l_cursor: CURSOR
		do
			create {LINKED_LIST [EB_CUSTOMIZED_FORMATTER_DESP]} Result.make
			l_cursor := a_descriptors.cursor
			from
				a_descriptors.start
			until
				a_descriptors.after
			loop
				l_fmt_desp := a_descriptors.item
				if a_criterion = Void or else a_criterion.item ([l_fmt_desp]) then
					Result.extend (l_fmt_desp)
				end
				a_descriptors.forth
			end
			a_descriptors.go_to (l_cursor)
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_formatter_global_scope (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP): BOOLEAN is
			-- Is formatter defined by `a_descriptor' of global scope?
		require
			a_descriptor_attached: a_descriptor /= Void
		do
			Result := a_descriptor.is_global_scope
		end

	is_formatter_target_scope (a_descriptor: EB_CUSTOMIZED_FORMATTER_DESP): BOOLEAN is
			-- Is formatter defined by `a_descriptor' of target scope?
		require
			a_descriptor_attached: a_descriptor /= Void
		do
			Result := a_descriptor.is_target_scope
		end

feature -- Setting

	mark_descriptors (a_descriptors: LIST [EB_CUSTOMIZED_FORMATTER_DESP]; a_global: BOOLEAN) is
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

	store_xml (a_doc: XM_DOCUMENT; a_file: STRING) is
			-- Store xml defined in `a_doc' in file named `a_file'.
		require
			a_doc_attached: a_doc /= Void
			a_file_attached: a_file /= Void
		local
			l_file: KL_TEXT_OUTPUT_FILE
			l_retried: BOOLEAN
			l_printer: XM_INDENT_PRETTY_PRINT_FILTER
			l_filter_factory: XM_CALLBACKS_FILTER_FACTORY
		do
			if not l_retried then
				create l_file.make (a_file)
				create l_filter_factory
				create l_printer.make_null
				l_file.open_write
				l_printer.set_indent ("%T")
				l_printer.set_output_stream (l_file)
				a_doc.process_to_events (l_filter_factory.callbacks_pipe (<<l_printer>>))
				l_printer.flush
				l_file.close
			else
				if l_file /= Void and then not l_file.is_closed then
					l_file.close
				end
			end
		rescue
			l_retried := True
			retry
		end

feature -- Parsing

	parse_file (a_file: STRING; a_callback: XM_CALLBACKS; a_parser: XM_PARSER; a_set_file_error_agent: PROCEDURE [ANY, TUPLE]) is
			-- Parse `a_file' using `a_parser' with `a_callback'.			
			-- Raise exception if error occurs.
			-- If failed because of file issue, call `a_set_file_error_agent'.
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
			a_callback_attached: a_callback /= Void
			a_parser_attached: a_parser /= Void
			a_set_file_error_agent_attached: a_set_file_error_agent /= Void
		local
			l_file: KL_TEXT_INPUT_FILE
		do
			create l_file.make (a_file)
			l_file.open_read
			if l_file.exists and then l_file.is_open_read then
				a_parser.set_callbacks (a_callback)
				a_parser.parse_from_stream (l_file)
				l_file.close
			else
				if not l_file.is_closed then
					l_file.close
				end
				a_set_file_error_agent.call (Void)
			end
		end

end
