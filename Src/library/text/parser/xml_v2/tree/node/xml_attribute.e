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

	make (a_name: READABLE_STRING_GENERAL; a_ns: like namespace; a_value: READABLE_STRING_GENERAL; a_parent: XML_ELEMENT)
			-- Create a new attribute.
		require
			a_name_not_void: a_name /= Void
			a_ns_not_void: a_ns /= Void
			a_name_not_empty: a_name.count > 0
			a_value_not_void: a_value /= Void
			a_parent_not_void: a_parent /= Void
		do
			namespace := a_ns
			set_name (a_name)
			set_value (a_value)
			parent := a_parent
		ensure
			parent_set: parent = a_parent
			name_set: a_name.same_string (internal_name)
			namespace_set: namespace = a_ns
			value_set: a_value.same_string (internal_value)
		end

	make_last (a_name: READABLE_STRING_GENERAL; a_ns: like namespace; a_value: READABLE_STRING_GENERAL; a_parent: XML_ELEMENT)
			-- Create a new attribute,
			-- and add it to parent..
		require
			a_name_not_void: a_name /= Void
			a_ns_not_void: a_ns /= Void
			a_name_not_empty: a_name.count > 0
			a_value_not_void: a_value /= Void
			a_parent_not_void: a_parent /= Void
		do
			namespace := a_ns
			set_name (a_name)
			set_value (a_value)
			a_parent.force_last (Current)
		ensure
			parent_set: parent = a_parent
			in_parent: a_parent.last = Current
			name_set: a_name.same_string (internal_name)
			ns_prefix_set: namespace = a_ns
			value_set: a_value.same_string (internal_value)
		end

feature -- Status report

	is_namespace_declaration: BOOLEAN
			-- Is current attribute a namespace declaration?
		do
			if has_prefix then
				Result := has_same_ns_prefix (Xmlns)
			else
				Result := has_same_name (Xmlns)
			end
		end

feature -- Access

	namespace_declaration: XML_NAMESPACE
			-- Namespace corresponding to the declaration
			-- (Create a new object at each call)
		require
			is_namespace_declaration: is_namespace_declaration
		local
			a_prefix: READABLE_STRING_GENERAL
		do
			if has_prefix then
				a_prefix := internal_name
			else
					-- New empty string with the same dynamic type as `name'.
				create {STRING_32} a_prefix.make_empty
			end
			create Result.make (a_prefix, internal_value)
		ensure
			namespace_not_void: Result /= Void
		end

feature -- Status report

	value_is_valid_as_string_8: BOOLEAN
			-- Is the associated value a valid string_8 string?
		do
			Result := internal_value.is_valid_as_string_8
		end

feature -- Access		

	value_8, value: STRING_8
		require
			value_is_valid_as_string_8: value_is_valid_as_string_8
		do
			Result := internal_value.as_string_8
		end

	value_32: READABLE_STRING_32
			-- Value
		do
			Result := to_readable_string_32 (internal_value)
		end

feature {XML_EXPORTER} -- Access

	internal_value: READABLE_STRING_GENERAL
			-- Internal value

feature -- Setting

	set_value (a_value: READABLE_STRING_GENERAL)
			-- Set `a_value' to `value'.
		require
			a_value_not_void: a_value /= Void
		do
			internal_value := a_value
		ensure
			value_set: a_value.same_string (internal_value)
		end

feature -- Visitor processing

	process (a_processor: XML_NODE_VISITOR)
			-- Process current node with `a_processor'.
		do
			a_processor.process_attribute (Current)
		end

invariant
	value_not_void: internal_value /= Void

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
