note
	description: "Collection of utilities routines for WSF_REQUEST."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_REQUEST_UTILITY

inherit
	ANY

	WSF_FORMAT_UTILITY
		export
			{NONE} all
		end

	WSF_VALUE_UTILITY

feature -- Url Query

	script_absolute_url (req: WSF_REQUEST; a_path: STRING): STRING
			-- Absolute Url for the script if any, extended by `a_path'
		do
			Result := req.absolute_script_url (a_path)
		end

	script_url (req: WSF_REQUEST; a_path: STRING): STRING
			-- Url relative to script name if any, extended by `a_path'
		require
			a_path_attached: a_path /= Void
		do
			Result := req.script_url (a_path)
		end

	url (req: WSF_REQUEST; a_path: STRING; args: detachable STRING; abs: BOOLEAN): STRING
			-- Associated url based on `path' and `args'
			-- if `abs' then return absolute url
		local
			s,t: detachable STRING
		do
			s := args
			if s /= Void and then s.count > 0 then
				create t.make_from_string (a_path)
				if s[1] /= '/' and t[t.count] /= '/' then
					t.append_character ('/')
					t.append (s)
				else
					t.append (s)
				end
				s := t
			else
				s := a_path
			end
			if abs then
				Result := script_absolute_url (req, s)
			else
				Result := script_url (req, s)
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Query

	request_accepted_content_type (req: WSF_REQUEST; a_supported_content_types: detachable ARRAY [READABLE_STRING_8]): detachable READABLE_STRING_8
			-- Accepted content-type for the request, among the supported content types `a_supported_content_types'
		local
			s: detachable READABLE_STRING_8
			i,n: INTEGER
		do
			if
				attached accepted_content_types (req) as l_accept_lst and then
				not l_accept_lst.is_empty
			then
				from
					l_accept_lst.start
				until
					l_accept_lst.after or Result /= Void
				loop
					s := l_accept_lst.item
					if a_supported_content_types /= Void then
						from
							i := a_supported_content_types.lower
							n := a_supported_content_types.upper
						until
							i > n or Result /= Void
						loop
							if a_supported_content_types [i].same_string (s) then
								Result := s
							end
							i := i + 1
						end
					else
						Result := s
					end
					l_accept_lst.forth
				end
			end
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
