note
	description: "Security protection based on Regular expression."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Regular expression protection", "src=https://docs.apigee.com/api-services/reference/regular-expression-protection", "protocol=uri"
	
class
	WSF_PROTECTION_REGEXP

inherit
	WSF_PROTECTION

create
	make,
	make_caseless,
	make_with_regexp

convert
	make_with_regexp ({REGULAR_EXPRESSION})

feature {NONE} -- Initialization

	make (a_regexp_pattern: READABLE_STRING_8; a_caseless: BOOLEAN)
		local
			r: REGULAR_EXPRESSION
		do
			create r
			r.set_caseless (a_caseless)
			r.compile (a_regexp_pattern)
			make_with_regexp (r)
		end

	make_caseless (a_regexp_pattern: READABLE_STRING_8)
		do
			make (a_regexp_pattern, True)
		end

	make_with_regexp (a_regexp: REGULAR_EXPRESSION)
		do
			regexp := a_regexp
		end


feature -- Access

	regexp: REGULAR_EXPRESSION

feature -- String Protection

	string_8 (s: READABLE_STRING_8): detachable READABLE_STRING_8
		local
			reg: like regexp
		do
			reg := regexp
			reg.match (s)
			if reg.has_matched then
				Result := Void
			else
				Result := s
			end
		end

	string_value (v: WSF_STRING): detachable WSF_STRING
		local
			vs: READABLE_STRING_8
		do
			vs := v.url_encoded_value
			if attached string_8 (vs) as s then
				if vs = s then
					Result := v
				else
					create Result.make (v.name, s)
				end
			end
		end

feature -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
			-- i.e: if the association regular expression is successfully compiled.
		do
			Result := is_compiled
		end

	is_compiled: BOOLEAN
		do
			Result := regexp.is_compiled
		end

feature {NONE} -- Implementation

	compiled_regexp (p: STRING; caseless: BOOLEAN): REGULAR_EXPRESSION
		require
			p /= Void
		do
			create Result
			Result.set_caseless (caseless)
			Result.compile (p)
		ensure
			is_compiled: Result.is_compiled
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
