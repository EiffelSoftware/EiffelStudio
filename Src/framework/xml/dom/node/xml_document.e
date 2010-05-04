note
	description: "Summary description for {XML_DOCUMENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_DOCUMENT

inherit
	XML_COMPOSITE

create
	make,
	make_with_root_named

feature {NONE} -- Initialization

	make
			-- Create root node.
		do
			make_with_root_named (Default_name, Default_ns)
		end

	make_with_root_named (a_name: STRING; a_ns: XML_NAMESPACE)
			-- Create root node, with a root_element
			-- with given name.
		require
			not_void: a_name /= Void
			not_empty: a_name.count > 0
		do
			initialize
			create root_element.make (a_name, a_ns)
			root_element.attach_parent (Current)
			force_last (root_element)
		ensure
			root_element_name_set: root_element.name = a_name
		end

	Default_name: STRING = "root"

feature -- Access

	root_element: XML_ELEMENT
			-- Root element of current document

feature -- Access

	element_by_name (a_name: STRING): detachable XML_ELEMENT
			-- Direct child element with name `a_name';
			-- If there are more than one element with that name, anyone may be returned.
			-- Return Void if no element with that name is a child of current node.
		do
			if has_element_by_name (a_name) then
				Result := root_element
			end
		ensure then
			root_element: has_element_by_name (a_name) implies Result = root_element
		end

	element_by_qualified_name (a_uri: STRING; a_name: STRING): detachable XML_ELEMENT
			-- Root element, if name matches, Void otherwise.
		do
			if has_element_by_qualified_name (a_uri, a_name) then
				Result := root_element
			end
		ensure then
			root_element: has_element_by_qualified_name (a_uri, a_name) implies Result = root_element
		end

	has_element_by_name (a_name: STRING): BOOLEAN
			-- Has current node at least one direct child
			-- element with the name `a_name'?
			-- (Namespace is ignored on the root node because the
			-- root element defines the current namespace.)
		do
			Result := same_string (root_element.name, a_name)
		ensure then
			definition: Result = same_string (root_element.name, a_name)
		end

	has_element_by_qualified_name (a_uri: STRING; a_name: STRING): BOOLEAN
			-- Is this the qualified name of the root element?
		do
			Result := root_element.has_qualified_name (a_uri, a_name)
		ensure then
			definition: Result = root_element.has_qualified_name (a_uri, a_name)
		end

feature -- Setting

	set_root_element (an_element: like root_element)
			-- Set root element.
		require
			an_element_not_void: an_element /= Void
		do
			remove_previous_root_element
			root_element := an_element
			force_last (an_element)
		ensure
			root_element_parent: root_element.parent = Current
			root_element_set: root_element = an_element
			last_set: last = root_element
		end

feature {NONE} -- Parent processing		

--	before_addition (a_node: XML_NODE)
--			-- Remove node from original parent if not us.
--		do
--			if a_node /= Void then
--					-- Remove from previous parent.
--				if a_node.parent /= Void then
--					a_node.parent.equality_delete (a_node)
--				end
--				a_node.node_set_parent (Current)
--			end
--		ensure then
--			parent_accepted: a_node /= Void implies a_node.parent = Current
--		end

feature {NONE} -- Implementation

	remove_previous_root_element
			-- Remove previous root element from composite:
		local
			elts: like nodes
			c: CURSOR
		do
			elts := nodes
			c := elts.cursor
			from
				elts.start
			until
				elts.after
			loop
				if elts.item = root_element then
					elts.remove
					elts.finish
					elts.forth
				else
					elts.forth
				end
			end
			elts.go_to (c)
		end

feature -- Visitor processing

	process (a_processor: XML_NODE_VISITOR)
			-- Process current node with `a_processor'.
		do
			a_processor.process_document (Current)
		end

invariant
	root_element_not_void: root_element /= Void

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
