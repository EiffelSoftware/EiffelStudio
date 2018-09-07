note
	description: "[
			Summary description for {GITHUB}.

		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=API", "protocol=URI", "src=http://developer.github.com/"

class
	GITHUB
inherit
	JSON_PARSER_ACCESS

create
	make

feature {NONE} -- Initialization

	make (u, p: READABLE_STRING_8)
		do
			name := "EWF Github"
			create {ARRAYED_LIST [GITHUB_AUTHORIZATION]} authorizations.make (0)
			username := u
			password := p
		end

feature -- Access

	name: STRING

	username: READABLE_STRING_8
	password: READABLE_STRING_8

	active_authorization: detachable GITHUB_AUTHORIZATION

feature -- Change

	set_active_authorization (a: like active_authorization)
		do
			active_authorization := a
		end

feature -- Query

	authorizations: LIST [GITHUB_AUTHORIZATION]
			-- Use get_authorizations to fill data

feature -- Authenticated query

	repositories: detachable LIST [GITHUB_REPOSITORY]
		note
			EIS: "name=Repositories", "protocol=URI", "src=http://developer.github.com/v3/repos/"
		local
			lst: ARRAYED_LIST [GITHUB_REPOSITORY]
			cl: DEFAULT_HTTP_CLIENT
			sess: HTTP_CLIENT_SESSION
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			p: JSON_PARSER
		do
			if attached active_authorization as auth and then attached auth.token as tok then
				create lst.make (0)

				create cl
				sess := cl.new_session ("https://api.github.com/")
				create ctx.make_with_credentials_required
				ctx.add_query_parameter ("sort", "updated")
				sess.set_credentials (username, password)
				sess.add_header ("Authorization", "token " + tok)
				sess.set_is_insecure (True)
				if attached sess.get ("user/repos", ctx) as res then
					if res.error_occurred then
						print (res)
					elseif attached res.body as b then
						create p.make_with_string (b)
						if attached {JSON_ARRAY} p.next_parsed_json_value as jarr and then p.is_valid then
							across
								jarr.array_representation as c
							loop
								if attached {JSON_OBJECT} c.item as j then
									lst.force (create {GITHUB_REPOSITORY}.make_from_json_object (j))
								end
							end
						end
					end
				end
				Result := lst
			end
		end

feature -- Authorization

	new_authorization_token (a_scopes: ITERABLE [READABLE_STRING_8]): detachable GITHUB_AUTHORIZATION
		local
			cl: DEFAULT_HTTP_CLIENT
			sess: HTTP_CLIENT_SESSION
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			s: STRING
		do
			create cl
			sess := cl.new_session ("https://api.github.com/")
			create ctx.make_with_credentials_required
			sess.set_credentials (username, password)
			sess.set_is_insecure (True)
			create s.make_empty
			across
				a_scopes as c
			loop
				if not s.is_empty then
					s.append_character (',')
				end
				s.append_character ('%"')
				s.append (c.item)
				s.append_character ('%"')
			end
			s := "{%"scopes%": [" + s + "], %"note%":%""+ name +"%"}"
			if attached sess.post ("authorizations", ctx, s) as res then
				if res.error_occurred then
					print (res)
				elseif attached res.body as b then
					create Result.make_from_json (b)
				end
			end
		end

	get_authorizations
		note
			EIS: "name=Authorization", "protocol=URI", "src=http://developer.github.com/v3/oauth/"
		local
			cl: DEFAULT_HTTP_CLIENT
			sess: HTTP_CLIENT_SESSION
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			p: JSON_PARSER
		do
			create cl
			sess := cl.new_session ("https://api.github.com/")
			create ctx.make_with_credentials_required
			sess.set_credentials (username, password)
			sess.set_is_insecure (True)
			if attached sess.get ("authorizations", ctx) as res then
				if res.error_occurred then
					print (res)
				elseif attached res.body as b then
					create p.make_with_string (b)
					if attached {JSON_ARRAY} p.next_parsed_json_value as arr and then p.is_valid then
						across
							arr.array_representation as c
						loop
							if attached {JSON_OBJECT} c.item as j then
								authorizations.force (create {GITHUB_AUTHORIZATION}.make_from_json_object (j))
							end
						end
					end
				end
			end
		end

note
	copyright: "2013-2018, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
