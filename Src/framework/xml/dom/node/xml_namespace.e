note
	description: "Summary description for {XML_NAMESPACE}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_NAMESPACE

inherit
	HASHABLE

create

	make,
	make_default

feature {NONE} -- Initialization

	make (a_prefix: like ns_prefix; a_uri: like uri)
			-- Create a new namespace declaration.
		require
			uri_not_void: a_uri /= Void
		do
			ns_prefix := a_prefix
			uri := a_uri
		ensure
			ns_prefix_set: ns_prefix = a_prefix
			uri_set: uri = a_uri
		end

	make_default
			-- Make default namespace (empty URI)
		do
			make ("", "")
		ensure
			no_prefix: not has_prefix
			default_namespace: uri.count = 0
		end

feature -- Access

	ns_prefix: STRING
			-- Prefix of current namespace

	uri: STRING
			-- Namespace URI	

feature -- Status report

	hash_code: INTEGER
			-- Hash code of URI
		do
			Result := uri.hash_code
		end

feature -- Status report

	same_prefix (other: XML_NAMESPACE): BOOLEAN
			-- Same
		do
			Result := is_equal (other) and then
				((ns_prefix = other.ns_prefix) or else
					((ns_prefix /= Void and other.ns_prefix /= Void) and then ns_prefix ~ other.ns_prefix))
		ensure
			equal: Result implies is_equal (other)
			same_prefix: Result implies
				(ns_prefix = other.ns_prefix or else (ns_prefix ~ other.ns_prefix))
		end

	has_prefix: BOOLEAN
			-- Is there an explicit prefix?
			-- (not a default namespace declaration)
		do
			Result := (ns_prefix /= Void and then ns_prefix.count > 0)
		ensure
			definition: Result = (ns_prefix /= Void and then ns_prefix.count > 0)
		end

invariant
	uri_not_void: uri /= Void

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
