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

	make (a_prefix: detachable READABLE_STRING_GENERAL; a_uri: READABLE_STRING_GENERAL)
			-- Create a new namespace declaration.
		require
			uri_attached: a_uri /= Void
		do
			set_ns_prefix (a_prefix)
			set_uri (a_uri)
		ensure
			ns_prefix_set: (a_prefix = Void and internal_ns_prefix = Void) or
						(a_prefix /= Void implies attached internal_ns_prefix as p and then a_prefix.same_string (p))
			uri_set: a_uri.same_string (internal_uri)
		end

	make_default
			-- Make default namespace (empty URI)
		do
			make (Void, "")
		ensure
			no_prefix: not has_prefix
			default_namespace: internal_uri.is_empty
		end

feature -- Status report

	ns_prefix_is_valid_as_string_8: BOOLEAN
			-- Is the associated ns_prefix a valid string_8 string?
		do
			if attached internal_ns_prefix as p then
				Result := p.is_valid_as_string_8
			end
		end

	uri_is_valid_as_string_8: BOOLEAN
			-- Is the associated uri a valid string_8 string?
		do
			Result := internal_uri.is_valid_as_string_8
		end

	uri_is_empty: BOOLEAN
			-- Is associated uri empty?
		do
			Result := internal_uri.is_empty
		end

feature -- Access

	ns_prefix_8, ns_prefix: detachable STRING_8
			-- Prefix of current namespace	
		require
			ns_prefix_is_valid_as_string_8: ns_prefix_is_valid_as_string_8
		do
			if attached internal_ns_prefix as p then
				Result := p.as_string_8
			end
		end

	ns_prefix_32: detachable READABLE_STRING_32
			-- Prefix of current namespace	
		do
			if attached internal_ns_prefix as p then
				Result := to_readable_string_32 (p)
			end
		end

	uri_8, uri: STRING_8
			-- Namespace URI
		require
			uri_is_valid_as_string_8: uri_is_valid_as_string_8
		do
			Result := internal_uri.as_string_8
		end

	uri_32: READABLE_STRING_32
			-- Namespace URI
		do
			Result := to_readable_string_32 (internal_uri)
		end

feature {XML_EXPORTER} -- Access

	internal_ns_prefix: detachable READABLE_STRING_GENERAL
			-- Internal Prefix of current namespace	

	internal_uri: READABLE_STRING_GENERAL
			-- Internal Namespace URI		

feature -- Element change

	set_ns_prefix (a_ns_prefix: detachable READABLE_STRING_GENERAL)
		do
			if a_ns_prefix = Void then
				internal_ns_prefix := Void
			else
				internal_ns_prefix := a_ns_prefix
			end
		ensure
			ns_prefix_set: (a_ns_prefix = Void and internal_ns_prefix = Void) or
					((a_ns_prefix /= Void and attached internal_ns_prefix as p) and then a_ns_prefix.same_string (p))
		end

	set_uri (a_uri: READABLE_STRING_GENERAL)
		do
			internal_uri := a_uri
		ensure
			uri_set: a_uri.same_string (internal_uri)
		end

feature -- Status report

	is_equal (other: like Current): BOOLEAN
		do
			if other = Current then
				Result := True
			else
				Result := other.has_same_uri (internal_uri)
			end
		end

	hash_code: INTEGER
			-- Hash code of URI
		do
			Result := internal_uri.hash_code
		end

	out: STRING
			-- Out
		do
			Result := internal_uri.as_string_8 -- FIXME: truncated...
		end

feature -- Status report

	has_same_uri (a_uri: like internal_uri): BOOLEAN
			-- Current uri is same as `a_uri' ?
		local
			v: like internal_uri
		do
			v := internal_uri
			Result := (v = a_uri) or else v.same_string (a_uri)
		end

	has_same_ns_prefix (a_ns_prefix: like internal_ns_prefix): BOOLEAN
			-- Current uri is same as `a_uri' ?
		local
			v: like internal_ns_prefix
		do
			v := internal_ns_prefix
			Result := (v = a_ns_prefix) or else (v /= Void and a_ns_prefix /= Void) and then v.same_string (a_ns_prefix)
		end

	same_prefix (other: XML_NAMESPACE): BOOLEAN
			-- Same
		do
			if is_equal (other) then
				Result := other.has_same_ns_prefix (internal_ns_prefix)
			end
		ensure
			equal: Result implies is_equal (other)
			same_prefix: Result implies other.has_same_ns_prefix (internal_ns_prefix)
		end

	has_prefix: BOOLEAN
			-- Is there an explicit prefix?
			-- (not a default namespace declaration)
		do
			Result := (attached internal_ns_prefix as p and then not p.is_empty)
		ensure
			definition: Result = (attached internal_ns_prefix as p and then not p.is_empty)
		end

feature {NONE} -- Conversion

	to_readable_string_32 (s: READABLE_STRING_GENERAL): READABLE_STRING_32
			-- String `s' converted as {READABLE_STRING_32}
		do
			if attached {READABLE_STRING_32} s as s32 then
				Result := s32
			else
				Result := s.to_string_32
			end
		end

invariant
	uri_not_void: internal_uri /= Void

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
