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
			create nodes.make (10)
		end

feature -- Access

	nodes: ARRAYED_LIST [XML_NODE]
			-- List of nodes for Current composite.

	start
		do
			nodes.start
		end

	after: BOOLEAN
		do
			Result := nodes.after
		end

	item_for_iteration: XML_NODE
		do
			Result := nodes.item_for_iteration
		end

	forth
		do
			nodes.forth
		end

	count: INTEGER
		do
			Result := nodes.count
		end

	last: XML_NODE
		do
			Result := nodes.last
		end

feature -- Access

	element_by_name (a_name: STRING): detachable XML_ELEMENT
			-- Direct child element with name `a_name';
			-- If there are more than one element with that name, anyone may be returned.
			-- Return Void if no element with that name is a child of current node.
		require
			a_name_not_void: a_name /= Void
		deferred
		ensure
			element_not_void: has_element_by_name (a_name) = (Result /= Void)
			--namespace: Result /= Void implies same_namespace (Result)
		end

	element_by_qualified_name (a_uri: STRING; a_name: STRING): detachable XML_ELEMENT
			-- Direct child element with given qualified name;
			-- If there are more than one element with that name, anyone may be returned.
			-- Return Void if no element with that name is a child of current node.
		require
			a_uri_not_void: a_uri /= Void
			a_name_not_void: a_name /= Void
		deferred
		ensure
			element_not_void: has_element_by_qualified_name (a_uri, a_name) = (Result /= Void)
		end

	has_element_by_name (a_name: STRING): BOOLEAN
			-- Has current node at least one direct child
			-- element with the name `a_name'?
		require
			a_name_not_void: a_name /= Void
		deferred
		end

	has_element_by_qualified_name (a_uri: STRING; a_name: STRING): BOOLEAN
			-- Has current node at least one direct child
			-- element with given qualified name ?
		require
			a_uri_not_void: a_uri /= Void
			a_name_not_void: a_name /= Void
		deferred
		end

	elements: LIST [XML_ELEMENT]
			-- List of all direct child elements in current element
			-- (Create a new list at each call.)
		local
			c: CURSOR
			lst: like nodes
		do
			create {LINKED_LIST [XML_ELEMENT]} Result.make
			lst := nodes
			c := lst.cursor
			from
				lst.start
			until
				lst.after
			loop
				if attached {XML_ELEMENT} lst.item as e then
					Result.force (e)
				end
				lst.forth
			end
			lst.go_to (c)
		ensure
			not_void: Result /= Void
		end

feature -- Text

	text: detachable STRING
			-- Concatenation of all texts directly found in
			-- current element; Void if no text found
			-- (Return a new string at each call.)
		local
			c: CURSOR
			lst: like nodes
		do
			lst := nodes
			c := lst.cursor
			from
				lst.start
			until
				lst.after
			loop
				if attached {XML_CHARACTER_DATA} lst.item as l_cdata then
					if Result = Void then
						Result := l_cdata.content.string
					else
						Result.append_string (l_cdata.content.string)
					end
				end
				lst.forth
			end
			lst.go_to (c)
		end


feature -- Element change

	force_last (a_node: XML_NODE)
		do
			before_addition (a_node)
			nodes.force (a_node)
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
			lst: like nodes
			c: CURSOR
		do
			-- we do DS_LIST.delete by hand, because
			-- it takes a descendant type, while we don't
			-- really need to know the subtype for object
			-- equality.
			lst := nodes
			c := lst.cursor
			from
				lst.start
			until
				lst.after
			loop
				if lst.item = v then
					lst.remove
				else
					lst.forth
				end
			end
			lst.go_to (c)
		end

feature -- Processing

	process_children (a_processor: XML_NODE_VISITOR)
			-- Process direct children.
		require
			a_processor_not_void: a_processor /= Void
		local
			lst: like nodes
			c: CURSOR
		do
			lst := nodes
			c := lst.cursor
			from lst.start until lst.after loop
				lst.item.process (a_processor)
				lst.forth
			end
			lst.go_to (c)
		end

	process_children_recursive (a_processor: XML_NODE_VISITOR)
			-- Process direct and indirect children.
		require
			processor_not_void: a_processor /= Void
		local
			lst: like nodes
			c: CURSOR
		do
			lst := nodes
			c := lst.cursor
			from lst.start until lst.after loop
				lst.item.process (a_processor)
				if attached {XML_ELEMENT} lst.item as e then
					e.process_children_recursive (a_processor)
				end
				lst.forth
			end
			lst.go_to (c)
		end

invariant
	elements_attached: nodes /= Void

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
