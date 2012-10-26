note
	description: "Summary description for {XML_ATTRIBUTE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML_ATTRIBUTE

inherit
	XML_NAMED_NODE

create
	make,
	make_last

feature {NONE} -- Initialization

	make (a_name: like name; a_ns: like namespace; a_value: like value; a_parent: XML_ELEMENT)
			-- Create a new attribute.
		require
			a_name_not_void: a_name /= Void
			a_ns_not_void: a_ns /= Void
			a_name_not_empty: a_name.count > 0
			a_value_not_void: a_value /= Void
			a_parent_not_void: a_parent /= Void
		do
			name := a_name
			namespace := a_ns
			value := a_value
			parent := a_parent
		ensure
			parent_set: parent = a_parent
			name_set: name = a_name
			namespace_set: namespace = a_ns
			value_set: value = a_value
		end

	make_last (a_name: like name; a_ns: like namespace; a_value: like value; a_parent: XML_ELEMENT)
			-- Create a new attribute,
			-- and add it to parent..
		require
			a_name_not_void: a_name /= Void
			a_ns_not_void: a_ns /= Void
			a_name_not_empty: a_name.count > 0
			a_value_not_void: a_value /= Void
			a_parent_not_void: a_parent /= Void
		do
			name := a_name
			namespace := a_ns
			value := a_value
			a_parent.force_last (Current)
		ensure
			parent_set: parent = a_parent
			in_parent: a_parent.last = Current
			name_set: name = a_name
			ns_prefix_set: namespace = a_ns
			value_set: value = a_value
		end

feature -- Status report

	is_namespace_declaration: BOOLEAN
			-- Is current attribute a namespace declaration?
		do
			if attached ns_prefix as p and then has_prefix then
				Result := same_string (Xmlns, p)
			else
				Result := same_string (Xmlns, name)
			end
		end

feature -- Access

	namespace_declaration: XML_NAMESPACE
			-- Namespace corresponding to the declaration
			-- (Create a new object at each call)
		require
			is_namespace_declaration: is_namespace_declaration
		local
			a_prefix: STRING
		do
			if has_prefix then
				a_prefix := name
			else
					-- New empty string with the same dynamic type as `name'.
				create a_prefix.make_empty
			end
			create Result.make (a_prefix, value)
		ensure
			namespace_not_void: Result /= Void
		end

feature -- Access

	value: STRING
			-- Value	

feature -- Setting

	set_value (a_value: like value)
			-- Set `a_value' to `value'.
		require
			a_value_not_void: a_value /= Void
		do
			value := a_value
		ensure
			value_set: value = a_value
		end

feature -- Visitor processing

	process (a_processor: XML_NODE_VISITOR)
			-- Process current node with `a_processor'.
		do
			a_processor.process_attribute (Current)
		end

invariant
	value_not_void: value /= Void

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
