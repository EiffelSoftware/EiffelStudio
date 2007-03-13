indexing
	description: "Customized formatter description file loader"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_FORMATTER_XML_CALLBACK

inherit
	XM_CALLBACKS_FILTER
		redefine
			on_error,
			on_start_tag,
			on_attribute,
			on_start_tag_finish,
			on_end_tag,
			on_content
		end

	EXCEPTIONS

	SHARED_BENCH_NAMES

	EB_XML_PARSE_HELPER

	EB_CUSTOMIZED_FORMATTER_XML_CONSTANTS

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize Current.
		do
			initialize_state_transitions_tag
			initialize_tag_attributes
			initialize_processors
			initialize_attribute_name

			create formatters.make
			create formatter_receiver.make
			create content_receiver.make
			create tool_receiver.make
			create current_tag.make
			create current_attributes.make (3)
			create current_content.make (256)
		end

feature -- Access

	formatters: LINKED_LIST [EB_CUSTOMIZED_FORMATTER_DESP]
			-- List of parsed formatter discriptors

	last_error: EB_METRIC_ERROR
			-- Last reported error

feature -- Status report

	has_error: BOOLEAN is
			-- Did error occur during xml parsing?
		do
			Result := last_error /= Void
		end

feature -- Event handlers

	on_error (a_message: STRING) is
			-- Event producer detected an error.
		do
			create_last_error (a_message)
		end

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Start of start tag.
		local
			l_trans: HASH_TABLE [INTEGER, STRING]
			l_tag: INTEGER
		do
			if current_tag.is_empty then
				current_tag.extend (t_none)
			end
			l_trans := state_transitions_tag.item (current_tag.item)
			if l_trans /= Void then
				l_tag := l_trans.item (a_local_part)
			end
			if l_tag = 0 then
				create_last_error (xml_names.err_invalid_tag_position (a_local_part))
			else
				current_tag.extend (l_tag)
			end
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING) is
			-- Start of attribute.
		local
			l_attr: HASH_TABLE [INTEGER, STRING]
			l_attribute: INTEGER
		do
			if
				not a_local_part.is_case_insensitive_equal ("xmlns") and
				not	a_local_part.is_case_insensitive_equal ("xsi") and
				not a_local_part.is_case_insensitive_equal ("schemaLocation")
			then
				a_local_part.to_lower

					-- check if the attribute is valid for the current state
				l_attr := tag_attributes.item (current_tag.item)
				if l_attr /= Void then
					l_attribute := l_attr.item (a_local_part)
				end
				if current_attributes = Void then
					create current_attributes.make (1)
				end
				if l_attribute /= 0 and then not current_attributes.has (l_attribute) then
					current_attributes.force (a_value, l_attribute)
				else
					create_last_error (xml_names.err_invalid_attribute (a_local_part))
				end
			end
		end

	on_start_tag_finish is
			-- End of start tag.
		local
			l_tag: INTEGER
			l_start_prc: like tag_start_processors
		do
			l_tag := current_tag.item
			l_start_prc := tag_start_processors
			if l_start_prc.has (l_tag) then
				l_start_prc.item (l_tag).call (Void)
			end
			current_attributes.clear_all
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- End tag.
		local
			l_tag: INTEGER
			l_finish_prc: like tag_finish_processors
		do
			l_tag := current_tag.item
			l_finish_prc := tag_finish_processors
			if l_finish_prc.has (l_tag) then
				l_finish_prc.item (l_tag).call (Void)
			end
			current_content.wipe_out
			current_tag.remove
		end

	current_content: STRING
			-- Current content

	on_content (a_content: STRING) is
			-- Text content.
		do
			current_content.append (a_content)
		end

feature{NONE} -- Node processors

	on_formatters_start is
			-- Action to be performed when start tag of "formatters" finishes.
		do
			formatter_receiver.extend (agent formatters.extend)
		end

	on_formatter_start is
			-- Action to be performed when start tag of "formatter" finishes.
		do
			check not formatter_receiver.is_empty end
			retrieve_attribute_value (at_name)
			formatter_receiver.item.call ([create{EB_CUSTOMIZED_FORMATTER_DESP}.make (last_tested_attribute)])
		end

	on_tooltip_start is
			-- Action to be performed when start tag of "tooltip" finishes.
		do
			check not formatters.is_empty end
			content_receiver.extend (agent (formatters.last).set_tooltip ({STRING}?))
		end

	on_header_start is
			-- Action to be performed when start tag of "header" finishes.
		do
			check not formatters.is_empty end
			content_receiver.extend (agent (formatters.last).set_header ({STRING}?))
		end

	on_temp_header_start is
			-- Action to be performed when start tag of "temp_header" finishes.
		do
			check not formatters.is_empty end
			content_receiver.extend (agent (formatters.last).set_temp_header ({STRING}?))
		end

	on_pixmap_start is
			-- Action to be performed when start tag of "pixmap" finishes.
		do
			retrieve_attribute_value (at_location)
			check not formatters.is_empty end
			formatters.last.set_pixmap_location (last_tested_attribute)
		end

	on_tools_start is
			-- Action to be performed when start tag of "tools" finishes.
		do
			check not formatters.is_empty end
			tool_receiver.extend (agent (formatters.last).extend_tool)
		end

	on_tool_start is
			-- Action to be performed when start tag of "tool" finishes.
		local
			l_name: STRING
			l_viewer: STRING
			l_order: STRING
		do
			check not tool_receiver.is_empty end
			retrieve_attribute_value (at_name)
			l_name := last_tested_attribute.twin

			retrieve_attribute_value (at_viewer)
			l_viewer := last_tested_attribute.twin

			test_ommitable_attribute (at_sorting_order, current_attributes, "")
			l_order := last_tested_attribute

			tool_receiver.item.call ([l_name, l_viewer, l_order])
		end

	on_metric_start is
			-- Action to be performed when start tag of "metric" finishes.
		do
			check not formatters.is_empty end
			retrieve_attribute_value (at_name)
			formatters.last.set_metric_name (last_tested_attribute)

			retrieve_attribute_value (at_filter)
			test_non_void_boolean_attribute (last_tested_attribute, xml_names.err_boolean_value_invalid (n_filter, last_tested_attribute))
			formatters.last.set_is_filter_enabled (last_tested_boolean)
		end

	on_formatters_finish is
			-- Action to be performed when tag of "formatters" finishes.
		do
			formatter_receiver.remove
		ensure
			formatter_receiver.is_empty
		end

	on_tooltip_finish is
			-- Action to be performed when tag of "tooltip" finishes.
		do
			record_content
			content_receiver.remove
		end

	on_header_finish is
			-- Action to be performed when tag of "header" finishes.
		do
			record_content
			content_receiver.remove
		end

	on_temp_header_finish is
			-- Action to be performed when tag of "temp_header" finishes.
		do
			record_content
			content_receiver.remove
		end

	on_tools_finish is
			-- Action to be performed when tag of "tools" finishes.
		do
			tool_receiver.remove
		end

feature{NONE} -- Implementation

	create_last_error (a_message: STRING_GENERAL) is
			-- Create `last_error' with `a_message'.
			-- Raise an exception
		do
			create last_error.make (a_message)
			raise ("XML parser error")
		ensure then
			has_error: has_error
		end

	retrieve_attribute_value (a_attr_id: INTEGER) is
			-- Retrieve value of attribute whose id is `a_attr_id' from `current_attributes'.
			-- If succeeded, store last retrieved attribute value in `last_tested_attribute',
			-- otherwise raise an error.
		do
			test_attribute (a_attr_id, current_attributes, agent create_last_error (xml_names.err_attribute_missing (n_name)))
		end

	record_content is
			-- Record content in `current_content' in last content receiver.
		local
			l_content: like current_content
		do
			l_content := current_content
			l_content.left_adjust
			l_content.right_adjust
			check not content_receiver.is_empty end
			content_receiver.item.call ([l_content])
		end

feature{NONE} -- Implementation

	formatter_receiver: LINKED_STACK [PROCEDURE [ANY, TUPLE [EB_CUSTOMIZED_FORMATTER_DESP]]]
			-- Stack of receivers to get foramtters

	content_receiver: LINKED_STACK [PROCEDURE [ANY, TUPLE [STRING]]]
			-- Stack of receivers for contents

	tool_receiver: LINKED_STACK [PROCEDURE [ANY, TUPLE [STRING, STRING, STRING]]]
			-- Tool receiver

	current_tag: LINKED_STACK [INTEGER]
			-- The stack of tags we are currently processing

	current_attributes: HASH_TABLE [STRING, INTEGER]
			-- The values of the current attributes	

	state_transitions_tag: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER]
			-- Mapping of possible tag state transitions from `current_tag' with the tag name to the new state.

	tag_attributes: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER]
			-- Mapping of possible attributes of tags.

	tag_start_processors: HASH_TABLE [PROCEDURE [ANY, TUPLE], INTEGER]
			-- Table of processors to be called when start tag finish is met.
			-- [processor, tag id]

	tag_finish_processors: HASH_TABLE [PROCEDURE [ANY, TUPLE], INTEGER]
			-- Table of processors to be called when tag finish is met.
			-- [processor, tag id]

	attribute_name: HASH_TABLE [STRING, INTEGER]
			-- Table of names of attributes indexed by attribute id.

feature{NONE} -- Implementation

	initialize_state_transitions_tag is
			-- Initialize `state_transitions_tag'.
		local
			l_trans: HASH_TABLE [INTEGER, STRING]
			l_states: like state_transitions_tag
		do
			create l_states.make (3)

				-- => none
			create l_trans.make (1)
			l_trans.force (t_formatters, n_formatters)
			l_states.force (l_trans, t_none)

				-- => formatters
			create l_trans.make (1)
			l_trans.force (t_formatter, n_formatter)
			l_states.force (l_trans, t_formatters)

				-- => formatter
			create l_trans.make (2)
			l_trans.force (t_tooltip, n_tooltip)
			l_trans.force (t_header, n_header)
			l_trans.force (t_temp_header, n_temp_header)
			l_trans.force (t_pixmap, n_pixmap)
			l_trans.force (t_metric, n_metric)
			l_trans.force (t_tools, n_tools)
			l_states.force (l_trans, t_formatter)

				-- => tools
			create l_trans.make (1)
			l_trans.force (t_tool, n_tool)
			l_states.force (l_trans, t_tools)

			state_transitions_tag := l_states
		end

	initialize_tag_attributes is
			-- Initialize `tag_attributes'.
		local
			l_tag_attrs: like tag_attributes
			l_attr: HASH_TABLE [INTEGER, STRING]
		do
			create l_tag_attrs.make (2)

				-- formatter node
				-- * name
			create l_attr.make (1)
			l_attr.force (at_name, n_name)
			l_tag_attrs.force (l_attr, t_formatter)

				-- pixmap node
				-- * location
			create l_attr.make (1)
			l_attr.force (at_location, n_location)
			l_tag_attrs.force (l_attr, t_pixmap)

				-- metric node
			create l_attr.make (1)
			l_attr.force (at_name, n_name)
			l_attr.force (at_filter, n_filter)
			l_tag_attrs.force (l_attr, t_metric)

				-- tool node
				-- * name
				-- * viewer				
				-- * sorting order
			create l_attr.make (2)
			l_attr.force (at_name, n_name)
			l_attr.force (at_viewer, n_viewer)
			l_attr.force (at_sorting_order, n_sorting_order)
			l_tag_attrs.force (l_attr, t_tool)

			tag_attributes := l_tag_attrs
		end

	initialize_processors is
			-- Initialize processors for analysing nodes.
		local
			l_start_prc: like tag_start_processors
			l_finish_prc: like tag_finish_processors
		do
				-- Initialize processors which are to be invoked when a start tag finishs
			create l_start_prc.make (10)
			tag_start_processors := l_start_prc
			l_start_prc.put (agent on_formatters_start, t_formatters)
			l_start_prc.put (agent on_formatter_start, t_formatter)
			l_start_prc.put (agent on_tooltip_start, t_tooltip)
			l_start_prc.put (agent on_header_start, t_header)
			l_start_prc.put (agent on_temp_header_start, t_temp_header)
			l_start_prc.put (agent on_pixmap_start, t_pixmap)
			l_start_prc.put (agent on_tools_start, t_tools)
			l_start_prc.put (agent on_tool_start, t_tool)
			l_start_prc.put (agent on_metric_start, t_metric)

			create l_finish_prc.make (10)
			l_finish_prc.put (agent on_formatters_finish, t_formatters)
			l_finish_prc.put (agent on_tooltip_finish, t_tooltip)
			l_finish_prc.put (agent on_header_finish, t_header)
			l_finish_prc.put (agent on_temp_header_finish, t_temp_header)
			l_finish_prc.put (agent on_tools_finish, t_tools)
			tag_finish_processors := l_finish_prc
		end

	initialize_attribute_name is
			-- Initialize `attribute_name'.
		local
			l_names: like attribute_name
		do
			create l_names.make (3)
			l_names.put (n_name, at_name)
			l_names.put (n_location, at_location)
			l_names.put (n_filter, at_filter)
			attribute_name := l_names
		end

feature{NONE} -- Implementation/XML node names

	t_formatters: INTEGER is 2001
	t_formatter: INTEGER is 2002
	t_tooltip: INTEGER is 2004
	t_header: INTEGER is 2005
	t_temp_header: INTEGER is 2006
	t_pixmap: INTEGER is 2007
	t_tools: INTEGER is 2008
	t_viewer: INTEGER is 2010
	t_tool: INTEGEr is 2011

	at_location: INTEGER is 2052
	at_viewer: INTEGER is 2053
	at_sorting_order: INTEGER is 2054

invariant
	state_transitions_tag_attached: state_transitions_tag /= Void
	tag_attributes_attached: tag_attributes /= Void
	formatters_attached: formatters /= Void
	formatter_receiver_attached: formatter_receiver /= Void
	tag_start_processors_attached: tag_start_processors /= Void
	tag_finish_processors_attached: tag_finish_processors /= Void
	attribute_name_attached: attribute_name /= Void
	content_receiver_attached: content_receiver /= Void
	tool_receiver_attached: tool_receiver /= Void

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


end
