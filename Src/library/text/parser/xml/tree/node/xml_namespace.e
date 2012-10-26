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

	make (a_prefix: detachable READABLE_STRING_32; a_uri: READABLE_STRING_32)
			-- Create a new namespace declaration.
		require
			uri_attached: a_uri /= Void
		do
			set_ns_prefix (a_prefix)
			set_uri (a_uri)
		ensure
			ns_prefix_set: (a_prefix = Void and ns_prefix = Void) or
						(a_prefix /= Void implies attached ns_prefix as p and then a_prefix.same_string (p))
			uri_set: a_uri.same_string (uri)
		end

	make_default
			-- Make default namespace (empty URI)
		do
			make (Void, {XML_XMLNS_CONSTANTS}.default_namespace)
		ensure
			no_prefix: not has_prefix
			default_namespace: uri.is_empty
		end

feature -- Status report

	uri_is_empty: BOOLEAN
			-- Is associated uri empty?
		do
			Result := uri.is_empty
		end

feature -- Access

	ns_prefix: detachable READABLE_STRING_32
			-- Prefix of current namespace	

	uri: READABLE_STRING_32
			-- Namespace URI

feature -- Element change

	set_ns_prefix (a_ns_prefix: detachable READABLE_STRING_32)
		do
			ns_prefix := a_ns_prefix
		ensure
			ns_prefix_set: (a_ns_prefix = Void and ns_prefix = Void) or
					((a_ns_prefix /= Void and attached ns_prefix as p) and then a_ns_prefix.same_string (p))
		end

	set_uri (a_uri: READABLE_STRING_32)
		do
			uri := a_uri
		ensure
			uri_set: a_uri.same_string (uri)
		end

feature -- Status report

	is_equal (other: like Current): BOOLEAN
		do
			if other = Current then
				Result := True
			else
				Result := other.has_same_uri (uri)
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
			Result := uri.as_string_8 -- FIXME: truncated...
		end

feature -- Status report

	has_same_uri (a_uri: like uri): BOOLEAN
			-- Current uri is same as `a_uri' ?
		local
			v: like uri
		do
			v := uri
			Result := (v = a_uri) or else v.same_string (a_uri)
		end

	has_same_ns_prefix (a_ns_prefix: like ns_prefix): BOOLEAN
			-- Current uri is same as `a_uri' ?
		local
			v: like ns_prefix
		do
			v := ns_prefix
			Result := (v = a_ns_prefix) or else (v /= Void and a_ns_prefix /= Void) and then v.same_string (a_ns_prefix)
		end

	same_prefix (other: XML_NAMESPACE): BOOLEAN
			-- Same
		do
			if is_equal (other) then
				Result := other.has_same_ns_prefix (ns_prefix)
			end
		ensure
			equal: Result implies is_equal (other)
			same_prefix: Result implies other.has_same_ns_prefix (ns_prefix)
		end

	has_prefix: BOOLEAN
			-- Is there an explicit prefix?
			-- (not a default namespace declaration)
		do
			Result := (attached ns_prefix as p and then not p.is_empty)
		ensure
			definition: Result = (attached ns_prefix as p and then not p.is_empty)
		end

invariant
	uri_not_void: uri /= Void

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
