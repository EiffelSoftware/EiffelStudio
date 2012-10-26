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
			Result := (attached ns_prefix as p and then p.count > 0)
		ensure
			definition: Result = (attached ns_prefix as p and then p.count > 0)
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
			Result := same_namespace (other) and
				(name ~ other.name)
		ensure
			definition: Result = (same_namespace (other) and same_name (other))
		end

	has_qualified_name (a_uri: STRING; a_name: STRING): BOOLEAN
			-- Does this node match the qualified name?
		require
			a_uri_not_void: a_uri /= Void
			a_name_not_void: a_name /= Void
		do
			Result := ((a_uri ~ namespace.uri)
					and (a_name ~ name))
		ensure
			definition: Result = ((a_uri ~ namespace.uri)
					and (a_name ~ name))
		end

feature -- Access

	name: STRING

	namespace: XML_NAMESPACE

feature -- Access

	ns_prefix: detachable STRING
			-- Namespace prefix used to declare the namespace of the
			-- name of current node
		do
			Result := namespace.ns_prefix
		ensure
			definition: Result = namespace.ns_prefix
		end

	ns_uri: STRING
			-- URI of namespace.
		do
			Result := namespace.uri
		ensure
			definition: Result = namespace.uri
		end

feature -- Element change

	set_name (a_name: like name)
			-- Set `name' to `a_name'.
		require
			a_name_attached: a_name /= Void
			a_name_not_empty: a_name.count > 0
		do
			name := a_name
		ensure
			name_set: name = a_name
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

	debug_output: STRING
		do
			Result := Precursor
			Result.append_character (' ')
			Result.append_character ('-')
			Result.append_character (' ')
			if attached ns_prefix as p and then not p.is_empty then
				Result.append_string (p)
				Result.append_character (':')
			end
			Result.append_string (name)
		end

invariant
	name_attached: name /= Void
	name_not_empty: name.count > 0

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
