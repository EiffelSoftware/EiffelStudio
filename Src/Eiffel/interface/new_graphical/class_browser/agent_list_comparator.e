indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AGENT_LIST_COMPARATOR [G]

inherit
	KL_PART_COMPARATOR [G]

create
	make

feature {NONE} -- Initialization

	make (a_action_list: like action_list) is
			-- Use `a_action_list' to compare two elements of type G.
		require
			a_action_list_not_void: a_action_list /= Void
			not_a_action_list_is_empty: not a_action_list.is_empty
		do
			action_list := a_action_list
		ensure
			action_list_set: action_list = a_action_list
		end

feature -- Access

	action_list: LIST [FUNCTION [ANY, TUPLE [G, G], BOOLEAN]]
			-- Action performed to compare two non-void items.

feature -- Status report

	less_than (u, v: G): BOOLEAN is
			-- Is `u' considered less than `v'?
		local
			l_cursor: CURSOR
			l_tuple: TUPLE [G, G]
			l_tuple2: TUPLE [G, G]
			done: BOOLEAN
			l_item: FUNCTION [ANY, TUPLE [G, G], BOOLEAN]
		do
			create l_tuple
			l_tuple.put (u, 1)
			l_tuple.put (v, 2)
			if action_list.count = 1 then
				Result := action_list.first.item (l_tuple)
			else
				create l_tuple2
				l_tuple2.put (v, 1)
				l_tuple2.put (u, 2)
				l_cursor := action_list.cursor
				from
					Result := False
					action_list.start
				until
					action_list.after or Result or done
				loop
					check action_list.item /= Void end
					l_item := action_list.item
					Result := l_item.item (l_tuple)
					if not Result then
						done := l_item.item (l_tuple2)
					end
					action_list.forth
				end
				action_list.go_to (l_cursor)
			end
		end

invariant
	action_list_not_void: action_list /= Void
	not_action_list_is_empty: not action_list.is_empty

end
