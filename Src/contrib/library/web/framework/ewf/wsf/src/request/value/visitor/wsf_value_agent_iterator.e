note
	description: "[
			Iterator visitor on WSF_VALUE using agent for callback
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_VALUE_AGENT_ITERATOR

inherit
	WSF_VALUE_ITERATOR
		redefine
			process_table,
			process_multiple_string,
			process_string
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create on_table_actions
			create on_string_actions
			create on_multiple_string_actions
		end

feature -- Actions

	on_table_actions: ACTION_SEQUENCE [TUPLE [WSF_TABLE]]

	on_string_actions: ACTION_SEQUENCE [TUPLE [WSF_STRING]]

	on_multiple_string_actions: ACTION_SEQUENCE [TUPLE [WSF_MULTIPLE_STRING]]

feature -- Visitor

	process_table (v: WSF_TABLE)
		do
			on_table_actions.call ([v])
			process_iterable_of_value (v)
		end

	process_string (v: WSF_STRING)
		do
			on_string_actions.call ([v])
		end

	process_multiple_string (v: WSF_MULTIPLE_STRING)
		do
			on_multiple_string_actions.call ([v])
			process_iterable_of_value (v)
		end

;note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
