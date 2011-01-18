note
	description: "Summary description for {XML_NAMESPACE}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_NAMESPACE

inherit
	HASHABLE
		redefine
			is_equal,
			out
		end

create

	make,
	make_default

feature {NONE} -- Initialization

	make (a_prefix: like ns_prefix; a_uri: like uri)
			-- Create a new namespace declaration.
		require
			uri_attached: a_uri /= Void
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
			make (Void, "")
		ensure
			no_prefix: not has_prefix
			default_namespace: uri.count = 0
		end

feature -- Access

	ns_prefix: detachable STRING
			-- Prefix of current namespace

	uri: STRING
			-- Namespace URI	

feature -- Status report

	is_equal (other: like Current): BOOLEAN
		local
			u, v: like uri
		do
			if other = Current then
				Result := True
			else
				u := uri
				v := other.uri
				Result := (u = v) or else u.same_string (v)
			end
		end

	hash_code: INTEGER
			-- Hash code of URI
		do
			Result := uri.hash_code
		end

	out: STRING
			-- Out
		do
			Result := uri
		end

feature -- Status report

	same_prefix (other: XML_NAMESPACE): BOOLEAN
			-- Same
		local
			p,q: like ns_prefix
		do
			if is_equal (other) then
				p := ns_prefix
				q := other.ns_prefix
				Result := (p = q) or else (
							(p /= Void and q /= Void) and then p.same_string (q)
						)
			end
		ensure
			equal: Result implies is_equal (other)
			same_prefix: Result implies
				((ns_prefix = other.ns_prefix) or else (ns_prefix ~ other.ns_prefix))
		end

	has_prefix: BOOLEAN
			-- Is there an explicit prefix?
			-- (not a default namespace declaration)
		do
			Result := (attached ns_prefix as p and then p.count > 0)
		ensure
			definition: Result = (attached ns_prefix as p and then p.count > 0)
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
