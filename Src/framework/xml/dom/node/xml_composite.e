note
	description: "Summary description for {XML_COMPOSITE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XML_COMPOSITE

inherit
	XML_NODE

feature -- Initialization

	initialize
		do
			create elements.make (10)
		end

feature -- Access

	elements: ARRAYED_LIST [XML_NODE]

	start
		do
			elements.start
		end

	after: BOOLEAN
		do
			Result := elements.after
		end

	item_for_iteration: XML_NODE
		do
			Result := elements.item_for_iteration
		end

	forth
		do
			elements.forth
		end

	count: INTEGER
		do
			Result := elements.count
		end

	last: XML_NODE
		do
			Result := elements.last
		end

feature -- Element change

	force_last (a_node: XML_NODE)
		do
			before_addition (a_node)
			elements.force (a_node)
		end

feature {NONE} -- Preprocessing

	before_addition (a_node: XML_NODE)
			-- Called before an item is added to this container.
			-- Remove node from original parent if not us.
		do
			if a_node /= Void then
					-- Remove from previous parent.
				if attached a_node.parent as p then
					p.equality_delete (a_node)
				end
				a_node.node_set_parent (Current)
			end
		ensure then
			parent_accepted: a_node /= Void implies a_node.parent = Current
		end


feature {XML_NODE} -- Removal

	equality_delete (v: XML_NODE)
			-- Delete node if it is in current node, using
			-- object identity.
		local
			elts: like elements
			c: CURSOR
		do
			-- we do DS_LIST.delete by hand, because
			-- it takes a descendant type, while we don't
			-- really need to know the subtype for object
			-- equality.
			elts := elements
			c := elts.cursor
			from
				elts.start
			until
				elts.after
			loop
				if elts.item = v then
					elts.remove
				else
					elts.forth
				end
			end
			elts.go_to (c)
		end

feature -- Processing

	process_children (a_processor: XML_NODE_VISITOR)
			-- Process direct children.
		require
			a_processor_not_void: a_processor /= Void
		local
			elts: like elements
			c: CURSOR
		do
			elts := elements
			c := elts.cursor
			from elts.start until elts.after loop
				elts.item.process (a_processor)
				elts.forth
			end
			elts.go_to (c)
		end

	process_children_recursive (a_processor: XML_NODE_VISITOR)
			-- Process direct and indirect children.
		require
			processor_not_void: a_processor /= Void
		local
			elts: like elements
			c: CURSOR
		do
			elts := elements
			c := elts.cursor
			from elts.start until elts.after loop
				elts.item.process (a_processor)
				if attached {XML_ELEMENT} elts.item as e then
					e.process_children_recursive (a_processor)
				end
				elts.forth
			end
			elts.go_to (c)
		end

invariant
	elements_attached: elements /= Void

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
