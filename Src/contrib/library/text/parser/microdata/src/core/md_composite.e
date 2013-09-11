note
	description: "Summary description for {MD_COMPOSITE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_COMPOSITE

inherit
	MD_NODE

	ITERABLE [MD_NODE]

feature {NONE} -- Initialize

	initialize
		do
			create {ARRAYED_LIST [MD_NODE]} nodes.make (0)
		end

feature -- Access

	count: INTEGER
		do
			Result := nodes.count
		end

	nodes: LIST [MD_NODE]

	items: LIST [MD_ITEM]
		local
			l_nodes: like nodes
		do
			l_nodes := nodes
			create {ARRAYED_LIST [MD_ITEM]} Result.make (l_nodes.count)
			across
				l_nodes as c
			loop
				if attached {MD_ITEM} c.item as e then
					Result.force (e)
				end
			end
		end

feature -- Change

	wipe_out
		do
			nodes.wipe_out
		end

	put (a_node: MD_NODE)
		require
			(attached {MD_PROPERTY} a_node as l_prop) implies not l_prop.name.has (' ')
		local
			l_nodes: like nodes
		do
			l_nodes := nodes
			if attached {MD_PROPERTY} a_node as p then
				if attached property (p.name) as prev then
					prev.merge (p)
				else
					l_nodes.force (p)
					p.set_parent (Current)
				end
			else
				l_nodes.force (a_node)
				a_node.set_parent (Current)
			end
		end

	remove (a_node: MD_NODE)
		do
			nodes.prune_all (a_node)
		end

feature -- Report

	property (a_prop_name: READABLE_STRING_GENERAL): detachable MD_PROPERTY
		do
			across
				nodes as c
			until
				Result /= Void
			loop
				if
					attached {MD_PROPERTY} c.item as p and then
					a_prop_name.same_string (p.name)
				then
					Result := p
				end
			end
		end

	has (n: MD_NODE): BOOLEAN
		do
			Result := nodes.has (n)
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [MD_NODE]
			-- <Precursor>
		do
			Result := nodes.new_cursor
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
