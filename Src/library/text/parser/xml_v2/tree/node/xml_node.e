note
	description: "Summary description for {XML_NODE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XML_NODE

inherit
	DEBUG_OUTPUT

feature -- Access

	parent: detachable XML_COMPOSITE
			-- Parent of current node;
			-- Void if current node is root	

feature -- Status

	parent_element: detachable XML_ELEMENT
			-- Parent element.
		require
			not_root_node: not is_root_node
			not_root_element: attached parent as l_parent and then not l_parent.is_root_node
		local
			p: like parent
		do
			p := parent
			if p /= Void then
				if attached {like parent_element} p as r then
					Result := r
				else
					Result := p.parent_element
				end
			end
		ensure
			result_not_void: not is_root_node implies Result /= Void
		end

	level: INTEGER
			-- Depth at which current node appears relative to its root
			-- (The root node has the level 1.)	
		do
			if is_root_node then
				Result := 1
			elseif attached parent as p then
				Result := p.level + 1
			else
				check is_not_root_node: not is_root_node end
			end
		ensure
			Result > 0
		end

	is_root_node: BOOLEAN
			-- Is current node the root node?
		do
			Result := (parent = Void)
		ensure
			definition: Result = (parent = Void)
		end

feature -- Element change

	attach_parent (a_parent: attached like parent)
			-- Set `parent' to `a_parent'.
		require
			a_parent_attached: a_parent /= Void
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

	set_parent (a_parent: attached like parent)
			-- Set `parent' to `a_parent'.
		require
			a_parent_attached: a_parent /= Void
			not_root_node: not is_root_node
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

feature {XML_COMPOSITE} -- Element change

	node_set_parent (a_parent: like parent)
			-- Set `parent' to `a_parent'.
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

feature {NONE} -- Implementation

	Default_ns: XML_NAMESPACE
			-- Shared default namespace constant object.
		once
			create Result.make_default
		ensure
			definition: Result.uri_is_empty
		end

	Xmlns: STRING_32 = "xmlns"

	Xml_prefix: STRING_32 = "xml"

	same_string (a,b: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := a.same_string (b)
		end

feature -- Status report

	debug_output_representation (s: READABLE_STRING_32): STRING_8
		local
			i,n: INTEGER
			c: CHARACTER_32
		do
			n := s.count
			from
				i := 1
				create Result.make (n)
			until
				i > n
			loop
				c := s.item (i)
				if c.is_character_8 then
					Result.append_character (c.to_character_8)
				else
					Result.append_character ('&')
					Result.append_character ('#')
					Result.append_natural_32 (c.natural_32_code)
					Result.append_character (';')
				end
				i := i + 1
			end
		end

	debug_output: STRING
		do
			create Result.make_empty
			Result.append_integer (level)
		end

feature -- Processing

	process (a_processor: XML_NODE_VISITOR)
			-- Process current node with `a_processor'.
		require
			a_processor_not_void: a_processor /= Void
		deferred
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
