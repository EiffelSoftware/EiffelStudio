note
	description: "Summary description for {XML_NAMED_NODE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XML_NAMED_NODE

inherit
	XML_NODE
		redefine
			debug_output
		end

feature -- Status report

	has_namespace: BOOLEAN = True
			-- Has the name of current node been defined with namespace?

	has_prefix: BOOLEAN
			-- Has a prefix been used to define the namespace?
			-- (It could also be that the namespace used was the default namespace)
		do
			Result := (attached ns_prefix as p and then not p.is_empty)
		ensure
			definition: Result = (attached ns_prefix as p and then not p.is_empty)
		end

	same_namespace (other: XML_NAMED_NODE): BOOLEAN
			-- Has current node same namespace as other?
		require
			other_attached: other /= Void
		do
			Result := other.has_namespace and then namespace ~ other.namespace
		ensure
			equal_namespaces: Result implies namespace ~ other.namespace
		end

	same_name (other: XML_NAMED_NODE): BOOLEAN
			-- Has current node same name and namespace as other?
		require
			other_attached: other /= Void
		do
			Result := same_namespace (other) and other.has_same_name (name)
		ensure
			definition: Result = (same_namespace (other) and same_name (other))
		end

	has_qualified_name (a_uri: READABLE_STRING_GENERAL; a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Does this node match the qualified name?
		require
			a_uri_not_void: a_uri /= Void
			a_name_not_void: a_name /= Void
		do
			Result := namespace.has_same_uri (a_uri) and has_same_name (a_name)
		ensure
			definition: Result = (namespace.has_same_uri (a_uri) and has_same_name (a_name))
		end

feature -- Access

	name: READABLE_STRING_32

	namespace: XML_NAMESPACE

feature -- Access

	ns_prefix: like namespace.ns_prefix
			-- Namespace prefix used to declare the namespace of the
			-- name of current node
		do
			Result := namespace.ns_prefix
		ensure
			definition: Result = namespace.ns_prefix
		end

	ns_uri: like namespace.uri
			-- URI of namespace.
		do
			Result := namespace.uri
		ensure
			definition: Result = namespace.uri
		end

feature -- Element change

	set_name (a_name: READABLE_STRING_32)
			-- Set `name' to `a_name'.
		require
			a_name_attached: a_name /= Void
			a_name_not_empty: a_name.count > 0
		do
			name := a_name
		ensure
			name_set: a_name.same_string (name)
		end

	set_namespace (a_namespace: like namespace)
			-- Set `namespace' to `a_namespace'.
		require
			a_namespace_attached: a_namespace /= Void
		do
			namespace := a_namespace
		ensure
			namespace_set: namespace = a_namespace
		end

feature -- Status report

	has_same_name (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Current name is same as `a_name' ?
		local
			v: like name
		do
			v := name
			Result := (v = a_name) or else a_name.same_string (v)
		end

	has_same_ns_uri (a_uri: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := namespace.has_same_uri (a_uri)
		end

	has_same_ns_prefix (a_ns_prefix: detachable READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := namespace.has_same_ns_prefix (a_ns_prefix)
		end

feature -- Status report

	debug_output: STRING
		do
			Result := Precursor
			Result.append_character (' ')
			Result.append_character ('-')
			Result.append_character (' ')
			if attached ns_prefix as p and then not p.is_empty then
				Result.append_string (debug_output_representation (p))
				Result.append_character (':')
			end
			Result.append_string (debug_output_representation (name))
		end

invariant
	name_attached: name /= Void
	name_not_empty: not name.is_empty

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
