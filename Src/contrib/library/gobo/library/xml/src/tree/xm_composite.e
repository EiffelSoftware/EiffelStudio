note

	description:

		"XML nodes that can contain other xml nodes"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2001-2013, Andreas Leitner and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class XM_COMPOSITE

inherit

	XM_NODE

	KL_IMPORTED_STRING_ROUTINES

feature -- Status report

	is_empty: BOOLEAN
			-- Is there no children?
		do
			Result := children.is_empty
		end

feature -- Access

	count: INTEGER
			-- Number of children
		do
			Result := children.count
		ensure
			count_not_negative: Result >= 0
		end

	first: like last
			-- Last child
		require
			not_empty: not is_empty
		do
			Result := children.first
		end

	last: XM_COMPOSITE_NODE
			-- Last child
		require
			not_empty: not is_empty
		do
			Result := children.last
		end

	element_by_name (a_name: STRING): detachable XM_ELEMENT
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

	element_by_qualified_name (a_uri: STRING; a_name: STRING): detachable XM_ELEMENT
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

	elements: DS_LIST [XM_ELEMENT]
			-- List of all direct child elements in current element
			-- (Create a new list at each call.)
		local
			a_cursor: DS_LINEAR_CURSOR [XM_NODE]
		do
			create {DS_BILINKED_LIST [XM_ELEMENT]} Result.make
			a_cursor := new_cursor
			from a_cursor.start until a_cursor.after loop
				if attached {XM_ELEMENT} a_cursor.item as l_element then
					Result.force_last (l_element)
				end
				a_cursor.forth
			end
		ensure
			not_void: Result /= Void
		end

	new_cursor: DS_LINKED_LIST_CURSOR [like last]
			-- New external cursor for traversal
		do
			Result := children.new_cursor
		ensure
			new_cursor_not_void: Result /= Void
		end

feature -- Text

	text: detachable STRING
			-- Concatenation of all texts directly found in
			-- current element; Void if no text found
			-- (Return a new string at each call.)
		local
			a_cursor: DS_LINEAR_CURSOR [XM_NODE]
		do
			a_cursor := new_cursor
			from a_cursor.start until a_cursor.after loop
				if attached {XM_CHARACTER_DATA} a_cursor.item as l_character_data then
					if Result = Void then
						Result := STRING_.cloned_string (l_character_data.content)
					else
						Result := STRING_.appended_string (Result, l_character_data.content)
					end
				end
				a_cursor.forth
			end
		end

	join_text_nodes
			-- Join sequences of text nodes.
		deferred
		end

feature -- Element change

	put_first, force_first (a_node: like last)
			-- Add `a_node' to beginning of list of children.
		require
			a_node_not_void: a_node /= Void
		do
			if is_empty or else first /= a_node then
				before_addition (a_node)
				children.force_first (a_node)
			end
		ensure
			one_more: children.count = old children.count + 1
			inserted: first = a_node
		end

	put_last, force_last (a_node: like last)
			-- Add `a_node' to then end of list of children.
		require
			a_node_not_void: a_node /= Void
		do
			if is_empty or else last /= a_node then
				before_addition (a_node)
				children.force_last (a_node)
			end
		ensure
			one_more: children.count = old children.count + 1
			inserted: last = a_node
		end

feature {NONE} -- Preprocessing

	before_addition (a_node: like last)
			-- Remove node from original parent if not us.
		require
			a_node_not_void: a_node /= Void
		do
				-- Remove from previous parent.
			a_node.parent.equality_delete (a_node)
			a_node.node_set_parent (Current)
		ensure then
			parent_accepted: a_node.parent = Current
		end

feature -- Removal

	equality_delete (v: XM_COMPOSITE_NODE)
			-- Delete node, using object identity.
		local
			a_cursor: like new_cursor
		do
			-- we do DS_LIST.delete by hand, because
			-- it takes a descendant type, while we don't
			-- really need to know the subtype for object
			-- equality.
			from
				a_cursor := new_cursor
				a_cursor.start
			until
				a_cursor.after
			loop
				if a_cursor.item = v then
					a_cursor.remove
				else
					a_cursor.forth
				end
			end
		end

feature {NONE} -- Implementation

	children: XM_LINKED_LIST [like last]
			-- Children

feature -- Processing

	process_children (a_processor: XM_NODE_PROCESSOR)
			-- Process direct children.
		require
			a_processor_not_void: a_processor /= Void
		local
			a_cursor: DS_LINEAR_CURSOR [XM_COMPOSITE_NODE]
		do
			a_cursor := new_cursor
			from a_cursor.start until a_cursor.after loop
				a_cursor.item.process (a_processor)
				a_cursor.forth
			end
		end

	process_children_recursive (a_processor: XM_NODE_PROCESSOR)
			-- Process direct and indirect children.
		require
			processor_not_void: a_processor /= Void
		local
			a_cursor: DS_LINEAR_CURSOR [XM_COMPOSITE_NODE]
		do
			a_cursor := new_cursor
			from a_cursor.start until a_cursor.after loop
				a_cursor.item.process (a_processor)
				if attached {XM_ELEMENT} a_cursor.item as l_element then
					l_element.process_children_recursive (a_processor)
				end
				a_cursor.forth
			end
		end

invariant

	children_not_void: children /= Void

end
