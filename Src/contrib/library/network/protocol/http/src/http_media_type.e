note
	description: "[
			This class is to represent a media type
			
			the Internet Media Type of the attached entity if the type
			was provided via a "Content-type" field in the wgi_request header,
			or if the server can determine it in the absence of a supplied
			"Content-type" field. The syntax is the same as for the HTTP
			"Content-Type" header field.
			
			 CONTENT_TYPE = "" | media-type
			 media-type   = type "/" subtype *( ";" parameter)
			 type         = token
			 subtype      = token
			 parameter    = attribute "=" value
			 attribute    = token
			 value        = token | quoted-string
			
			The type, subtype, and parameter attribute names are not
			case-sensitive. Parameter values MAY be case sensitive. Media
			types and their use in HTTP are described in section 3.7 of
			the HTTP/1.1 specification [8].
			
			Example:
			
			 	application/x-www-form-urlencoded
				application/x-www-form-urlencoded; charset=UTF8

		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Wikipedia/Media Type", "protocol=URI", "src=http://en.wikipedia.org/wiki/Internet_media_type"
	EIS: "name=RFC2046", "protocol=URI", "src=http://tools.ietf.org/html/rfc2046"

class
	HTTP_MEDIA_TYPE

inherit
	DEBUG_OUTPUT

create
	make,
	make_from_string

feature {NONE} -- Initialization

	make (a_type, a_subtype: READABLE_STRING_8)
			-- Create Current based on `a_type/a_subtype'
		require
			not a_type.is_empty
			not a_subtype.is_empty
		do
			type := a_type
			subtype := a_subtype
		ensure
			has_no_error: not has_error
		end

	make_from_string (s: READABLE_STRING_8)
			-- Create Current from `s'
			-- if `s' does not respect the expected syntax, has_error is True
		local
			t: STRING_8
			i,n: INTEGER
			p: INTEGER
			cl: CELL [INTEGER]
		do
				-- Ignore starting space (should not be any)
			from
				i := 1
				n := s.count
			until
				i > n or not s[i].is_space
			loop
				i := i + 1
			end
			if i < n then
					-- Look for semi colon as parameter separation
				p := s.index_of (';', i)
				if p > 0 then
					t := s.substring (i, p - 1)
					from
						create cl.put (p)
						i := p + 1
					until
						i >= n
					loop
						add_parameter_from_string (s, i, cl)
						i := cl.item
					end
				else
					t := s.substring (i, n)
				end
					-- Remove eventual trailing space
				t.right_adjust

					-- Extract type and subtype
				p := t.index_of ('/', 1)
				if p = 0 then
					t.right_adjust
					type := t
					if t.same_string ("*") then
						--| Accept *; should be */*
					else
						has_error := True
					end
					subtype := "*"
				else
					subtype := t.substring (p + 1, t.count)
					type := t
					t.keep_head (p - 1)
				end
			else
				has_error := True
				type := ""
				subtype := type
			end
		ensure
			not has_error implies (create {HTTP_CONTENT_TYPE}.make_from_string (string)).same_string (string)
		end

feature -- Status report

	has_error: BOOLEAN
			-- Current has error?
			--| Mainly in relation with `make_from_string'

feature -- Access

	type: READABLE_STRING_8
			-- Main type

	subtype: READABLE_STRING_8
			-- Sub type

	has_parameter (a_name: READABLE_STRING_8): BOOLEAN
			-- Has Current a parameter?
		do
			if attached parameters as plst then
				Result := plst.has (a_name)
			end
		end

	parameter (a_name: READABLE_STRING_8): detachable READABLE_STRING_8
			-- Value for eventual parameter named `a_name'.
		do
			if attached parameters as plst then
				Result := plst.item (a_name)
			end
		end

	parameters: detachable HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]
			-- Parameters

feature -- Conversion

	string: READABLE_STRING_8
			-- String representation of type/subtype; attribute=value
		local
			res: like internal_string
		do
			res := internal_string
			if res = Void then
				create res.make_from_string (simple_type)
				if attached parameters as plst then
					across
						plst as p
					loop
						res.append_character (';')
						res.append_character (' ')
						res.append (p.key)
						res.append_character ('=')
						res.append_character ('%"')
						res.append (p.item)
						res.append_character ('%"')
					end
				end
				internal_string := res
			end
			Result := res
		end

	simple_type: READABLE_STRING_8
			-- String representation of type/subtype	
		local
			res: like internal_simple_type
			s: like subtype
		do
			res := internal_simple_type
			if res = Void then
				create res.make_from_string (type)
				s := subtype
				if not s.is_empty then
					check has_error: has_error end
						-- Just in case not is_valid, we keep in `type' the original string
					res.append_character ('/')
					res.append (s)
				end
				internal_simple_type := res
			end
			Result := res
		end

feature -- Status report

	same_as (other: HTTP_CONTENT_TYPE): BOOLEAN
			-- Current has same type/subtype and parameters as `other'?
		local
			plst,oplst: like parameters
		do
			Result := other.type.same_string (other.type) and then
						other.subtype.same_string (other.subtype)
			if Result then
				plst := parameters
				oplst := other.parameters
				if plst = oplst then
				elseif plst = Void then
					Result := False -- since oplst /= Void
				elseif oplst /= Void and then plst.count = oplst.count then
					across
						plst as p
					until
						not Result
					loop
						Result := attached oplst.item (p.key) as op_value and then p.item.same_string (op_value)
					end
				else
					Result := False
				end
			end
		end

	same_simple_type (s: READABLE_STRING_8): BOOLEAN
			-- Current has same type/subtype string representation as `s'?
		do
			Result := simple_type.same_string (s)
		end

	same_string (s: READABLE_STRING_8): BOOLEAN
			-- Current has same string representation as `s'?
		do
			Result := string.same_string (s)
		end

feature -- Element change

	add_parameter (a_name: READABLE_STRING_8; a_value: READABLE_STRING_8)
			-- Set parameter for `a_name' to `a_value'
		local
			plst: like parameters
		do
			plst := parameters
			if plst = Void then
				create plst.make (1)
				parameters := plst
			end
			plst.force (a_value, a_name)
			internal_string := Void
		end

	remove_parameter (a_name: READABLE_STRING_8)
			-- Remove parameter named `a_name'
		do
			if attached parameters as plst then
				plst.prune (a_name)
				if plst.is_empty then
					parameters := Void
				end
			end
			internal_string := Void
		end

feature {NONE} -- Implementation

	add_parameter_from_string (s: READABLE_STRING_8; start_index: INTEGER; out_end_index: CELL [INTEGER])
			-- Add parameter from string   "  attribute=value  "
			-- and put in `out_end_index' the index after found parameter.
		local
			n: INTEGER
			pn,pv: STRING_8
			i: INTEGER
			p, q: INTEGER
			err: BOOLEAN
		do
			n := s.count
				-- Skip spaces
			from
				i := start_index
			until
				i > n or not s[i].is_space
			loop
				i := i + 1
			end
			if s[i] = ';' then
					-- empty parameter
				out_end_index.replace (i + 1)
			elseif i < n then
				p := s.index_of ('=', i)
				if p > 0 then
					pn := s.substring (i, p - 1)
					if p >= n then
						pv := ""
						out_end_index.replace (n + 1)
					else
						if s[p+1] = '%"' then
							q := s.index_of ('%"', p + 2)
							if q > 0 then
								pv := s.substring (p + 2, q - 1)
								from
									i := q + 1
								until
									i > n or not s[i].is_space
								loop
									i := i + 1
								end
								if s[i] = ';' then
									i := i + 1
								end
								out_end_index.replace (i)
							else
								err := True
								pv := ""
								-- missing closing double quote.								
							end
						else
							q := s.index_of (';', p + 1)
							if q = 0 then
								q := n + 1
							end
							pv := s.substring (p + 1, q - 1)
							out_end_index.replace (q + 1)
						end
						pv.right_adjust
						if not err then
							add_parameter (pn, pv)
						end
					end
				else
					-- expecting: attribute "=" value
					err := True
				end
			end
			if err then
				out_end_index.replace (n + 1)
			end
			has_error := has_error or err
		ensure
			entry_processed: out_end_index.item > start_index
		end

feature {NONE} -- Internal

	internal_string: detachable STRING_8

	internal_simple_type: detachable STRING_8

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			if type /= Void and subtype /= Void then
				Result := type + "/" + subtype
				if attached parameters as plst then
					across
						plst as p
					loop
						Result.append ("; " + p.key + "=" + "%"" + p.item + "%"")
					end
				end
			else
				Result := ""
			end
		end

invariant
	type_and_subtype_not_empty: not has_error implies not type.is_empty and not subtype.is_empty

note
	copyright: "2011-2013, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
