note
	description: "XML callbacks used for customized tool definition file parsing"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_TOOL_XML_CALLBACK

inherit
	EB_XML_CALLBACKS

	EB_CUSTOMIZED_FORMATTER_XML_CONSTANTS

create
	make

feature{NONE} -- Initialization

	make
			-- Initialize.
		do
			make_null
			initialize
			create handler_receiver.make
			create tool_receiver.make
			create {LINKED_LIST [EB_CUSTOMIZED_TOOL_DESP]} tools.make
		end

feature -- Access

	tools: LIST [EB_CUSTOMIZED_TOOL_DESP]
			-- Tools retrieved by Current callback

feature{NONE} -- Implementation

	tool_receiver: LINKED_STACK [PROCEDURE [ANY, TUPLE [EB_CUSTOMIZED_TOOL_DESP]]]
			-- Receiver stack for customized tool

	handler_receiver: LINKED_STACK [PROCEDURE [ANY, TUPLE [tool_id: STRING; stone_name: STRING]]]
			-- Receiver stack for handler

feature{NONE} -- Actions

	on_tools_start
			-- Action to be performed when start tag of "tools" finishes.
		do
			tool_receiver.extend (agent tools.extend)
		end

	on_tools_end
			-- Action to be performed when tag of "tools" finishes.
		do
			tool_receiver.remove
		ensure
			tool_receiver_is_empty: tool_receiver.is_empty
		end

	on_tool_start
			-- Action to be performed when start tag of "tool" finishes.
		local
			l_name: STRING_GENERAL
			l_id: STRING
		do
			check not tool_receiver.is_empty end
			retrieve_attribute_value (at_name)
			l_name := last_tested_attribute.twin
			retrieve_attribute_value (at_id)
			l_id := last_tested_attribute.twin
			tool_receiver.item.call ([create {EB_CUSTOMIZED_TOOL_DESP}.make (l_name, l_id)])
		end

	on_handlers_start
			-- Action to be performed when start tag of "handlers" finishes.
		do
			handler_receiver.extend (agent (tools.last).extend_handler)
		end

	on_handlers_end
			-- Action to be performed when tag of "handlers" finishes.
		do
			handler_receiver.remove
		end

	on_pixmap_start
			-- Action to be performed when start tag of "pixmap" finishes.
		do
			check not tools.is_empty end
			retrieve_attribute_value (at_location)
			tools.last.set_pixmap_location (last_tested_attribute.twin)
		end

	on_handler_start
			-- Action to be performed when start tag of "handler" finishes.
		local
			l_stone_name: STRING
			l_tool_id: STRING
		do
			check not handler_receiver.is_empty end
			retrieve_attribute_value (at_stone)
			l_stone_name := last_tested_attribute.twin
			retrieve_attribute_value (at_default_tool)
			l_tool_id := last_tested_attribute.twin
			handler_receiver.item.call ([l_tool_id, l_stone_name])
		end

feature{NONE}  -- Implementation

	initialize_state_transitions_tag
			-- Initialize `state_transitions_tag'.
		local
			l_trans: HASH_TABLE [INTEGER, STRING]
			l_states: like state_transitions_tag
		do
			create l_states.make (3)

				-- => none
			create l_trans.make (1)
			l_trans.force (t_tools, n_tools)
			l_states.force (l_trans, t_none)

				-- => tools
			create l_trans.make (1)
			l_trans.force (t_tool, n_tool)
			l_states.force (l_trans, t_tools)

				-- => tool
			create l_trans.make (2)
			l_trans.force (t_handlers, n_handlers)
			l_trans.force (t_pixmap, n_pixmap)
			l_states.force (l_trans, t_tool)

				-- => handlers
			create l_trans.make (1)
			l_trans.force (t_handler, n_handler)
			l_states.force (l_trans, t_handlers)

			state_transitions_tag := l_states
		end

	initialize_tag_attributes
			-- Initialize `tag_attributes'.
		local
			l_tag_attrs: like tag_attributes
			l_attr: HASH_TABLE [INTEGER, STRING]
		do
			create l_tag_attrs.make (2)

				-- tool node
				-- * name
				-- * id
			create l_attr.make (1)
			l_attr.force (at_name, n_name)
			l_attr.force (at_id, n_id)
			l_tag_attrs.force (l_attr, t_tool)

				-- pixmap node
				-- * location
			create l_attr.make (1)
			l_attr.force (at_location, n_location)
			l_tag_attrs.force (l_attr, t_pixmap)

				-- handler node
				-- * stone
				-- * default_tool
			create l_attr.make (2)
			l_attr.force (at_stone, n_stone)
			l_attr.force (at_default_tool, n_default_tool)
			l_tag_attrs.force (l_attr, t_handler)

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
			l_start_prc.put (agent on_tools_start, t_tools)
			l_start_prc.put (agent on_tool_start, t_tool)
			l_start_prc.put (agent on_pixmap_start, t_pixmap)
			l_start_prc.put (agent on_handlers_start, t_handlers)
			l_start_prc.put (agent on_handler_start, t_handler)

			create l_finish_prc.make (10)
			l_finish_prc.put (agent on_tools_end, t_tools)
			l_finish_prc.put (agent on_handlers_end, t_handlers)
			tag_finish_processors := l_finish_prc
		end

invariant
	tools_attached: tools /= Void
	tool_receiver_attached: tool_receiver /= Void
	handler_receiver_attached: handler_receiver /= Void

end
