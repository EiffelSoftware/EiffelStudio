note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	HTTP_AUTHORIZATION

inherit
	REFACTORING_HELPER

create
	make,
	make_basic_auth,
	make_custom_auth

feature {NONE} -- Initialization

	make (a_http_authorization: detachable READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		local
			i: INTEGER
			t, s: STRING_8
			u,p: READABLE_STRING_8
		do
			if a_http_authorization /= Void then
				s := a_http_authorization.as_string_8
				create http_authorization.make_from_string (s)
				if not s.is_empty then
					i := 1
					if s[i] = ' ' then
						i := i + 1
					end
					i := s.index_of (' ', i)
					if i > 0 then
						t := s.substring (1, i - 1).as_lower
						t.right_adjust; t.left_adjust
						type := t
						if t.same_string ("basic") then
							s := (create {BASE64}).decoded_string (s.substring (i + 1, s.count))
							i := s.index_of (':', 1) --| Let's assume ':' is forbidden in login ...
							if i > 0 then
								u := s.substring (1, i - 1).as_string_32
								p := s.substring (i + 1, s.count).as_string_32
								login := u
								password := p
								check
									(create {HTTP_AUTHORIZATION}.make_custom_auth (u, p, t)).http_authorization ~ http_authorization
								end
							end
						elseif t.same_string ("digest") then
							to_implement ("HTTP Authorization %"digest%", not yet implemented")
						else
							to_implement ("HTTP Authorization %""+ t +"%", not yet implemented")
						end
					end
				end
			else
				http_authorization := Void
			end
		end

	make_basic_auth (u: READABLE_STRING_32; p: READABLE_STRING_32)
		do
			make_custom_auth (u, p, "basic")
		end

	make_custom_auth (u: READABLE_STRING_32; p: READABLE_STRING_32; a_type: READABLE_STRING_8)
		local
			t: STRING_8
		do
			login := u
			password := p
			create t.make_from_string (a_type.as_lower)
			t.left_adjust; t.right_adjust
			type := t
			if t.same_string ("basic") then
				create http_authorization.make_from_string ("Basic " + (create {BASE64}).encoded_string (u + ":" + p))
			else
				to_implement ("HTTP Authorization %""+ t +"%", not yet implemented")
			end
		end

feature -- Access

	type: detachable READABLE_STRING_8

	login: detachable READABLE_STRING_32

	password: detachable READABLE_STRING_32

	http_authorization: detachable IMMUTABLE_STRING_8

feature -- Status report

	is_basic: BOOLEAN
			-- Is Basic authorization?
		do
			if attached type as t then
				Result := t.same_string ("basic")
			end
		end

invariant

	type_is_lower: attached type as t implies t.same_string (t.as_lower)


end
