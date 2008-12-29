note
	description: "Customized formatter description file loader"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_FORMATTER_XML_CALLBACK

inherit
	EB_XML_CALLBACKS

	EB_CUSTOMIZED_FORMATTER_XML_CONSTANTS

create
	make

feature{NONE} -- Initialization

	make
			-- Initialize Current.
		do
			make_null
			initialize
			create formatters.make
			create formatter_receiver.make
			create content_receiver.make
			create tool_receiver.make
		end

feature -- Access

	formatters: LINKED_LIST [EB_CUSTOMIZED_FORMATTER_DESP]
			-- List of parsed formatter discriptors

feature{NONE} -- Node processors

	on_formatters_start
			-- Action to be performed when start tag of "formatters" finishes.
		do
			formatter_receiver.extend (agent formatters.extend)
		end

	on_formatter_start
			-- Action to be performed when start tag of "formatter" finishes.
		do
			check not formatter_receiver.is_empty end
			retrieve_attribute_value (at_name)
			formatter_receiver.item.call ([create{EB_CUSTOMIZED_FORMATTER_DESP}.make (last_tested_attribute)])
		end

	on_tooltip_start
			-- Action to be performed when start tag of "tooltip" finishes.
		do
			check not formatters.is_empty end
			content_receiver.extend (agent (formatters.last).set_tooltip ({STRING}?))
		end

	on_header_start
			-- Action to be performed when start tag of "header" finishes.
		do
			check not formatters.is_empty end
			content_receiver.extend (agent (formatters.last).set_header ({STRING}?))
		end

	on_temp_header_start
			-- Action to be performed when start tag of "temp_header" finishes.
		do
			check not formatters.is_empty end
			content_receiver.extend (agent (formatters.last).set_temp_header ({STRING}?))
		end

	on_pixmap_start
			-- Action to be performed when start tag of "pixmap" finishes.
		do
			retrieve_attribute_value (at_location)
			check not formatters.is_empty end
			formatters.last.set_pixmap_location (last_tested_attribute)
		end

	on_tools_start
			-- Action to be performed when start tag of "tools" finishes.
		do
			check not formatters.is_empty end
			tool_receiver.extend (agent (formatters.last).extend_tool)
		end

	on_tool_start
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

	on_metric_start
			-- Action to be performed when start tag of "metric" finishes.
		do
			check not formatters.is_empty end
			retrieve_attribute_value (at_name)
			formatters.last.set_metric_name (last_tested_attribute)

			retrieve_attribute_value (at_filter)
			test_non_void_boolean_attribute (last_tested_attribute, xml_names.err_boolean_value_invalid (n_filter, last_tested_attribute))
			formatters.last.set_is_filter_enabled (last_tested_boolean)
		end

	on_formatters_finish
			-- Action to be performed when tag of "formatters" finishes.
		do
			formatter_receiver.remove
		ensure
			formatter_receiver.is_empty
		end

	on_tooltip_finish
			-- Action to be performed when tag of "tooltip" finishes.
		do
			record_content
			content_receiver.remove
		end

	on_header_finish
			-- Action to be performed when tag of "header" finishes.
		do
			record_content
			content_receiver.remove
		end

	on_temp_header_finish
			-- Action to be performed when tag of "temp_header" finishes.
		do
			record_content
			content_receiver.remove
		end

	on_tools_finish
			-- Action to be performed when tag of "tools" finishes.
		do
			tool_receiver.remove
		end

feature{NONE} -- Implementation

	record_content
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

feature{NONE} -- Implementation

	initialize_state_transitions_tag
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

	initialize_tag_attributes
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

	initialize_processors
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

invariant
	formatters_attached: formatters /= Void
	formatter_receiver_attached: formatter_receiver /= Void
	content_receiver_attached: content_receiver /= Void
	tool_receiver_attached: tool_receiver /= Void

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
