note
	description: "Summary description for {TEST_GOOGLE_PARAMETERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_GOOGLE_PARAMETERS

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			account := "Missing Account"
			client_id := "Missing client_id"
			client_secret := "Missing client_secret"
			redirect_uri := "urn:ietf:wg:oauth:2.0:oob"
			load
		end

feature -- Access

	is_valid: BOOLEAN

	account: READABLE_STRING_8

	client_id: READABLE_STRING_8

	client_secret: READABLE_STRING_8

	redirect_uri: READABLE_STRING_8

	code: detachable READABLE_STRING_8
	refresh_token: detachable READABLE_STRING_8
	access_token: detachable READABLE_STRING_8
	token_type: detachable READABLE_STRING_8

	others: STRING_TABLE [READABLE_STRING_8]
	commented_lines: ARRAYED_LIST [READABLE_STRING_8]

feature -- Basic operation

	load
		local
			f: RAW_FILE
			u: detachable STRING_8
			s: STRING_8
			p: INTEGER
		do
			create f.make_with_name ("google.data")
			if f.exists and f.is_readable then
				f.open_read
				from
				until
					u /= Void or f.exhausted
				loop
					f.read_line
					s := f.last_string
					if s.starts_with ("#") then
						-- skip
					else
						p := s.index_of (':', 1)
						if p > 0 then
							u := s.substring (1, p-1)
							u.left_adjust
							u.right_adjust
							if u.same_string ("account") then
								u := s.substring (p+1, s.count)
								u.left_adjust
								u.right_adjust
							else
								u := Void
							end
						end
					end
				end
				f.close
			end
			if u = Void then
				io.put_string ("Account ? >")
				io.read_line
				u := io.last_string
				u.left_adjust
				u.right_adjust
			end

			create others.make (0)
			create commented_lines.make (0)

			if not u.is_empty then
				account := u
				create f.make_with_name ("google." + u)
				if f.exists and f.is_readable then
					f.open_read
					from
					until
						f.exhausted
					loop
						f.read_line
						s := f.last_string
						if s.starts_with ("#") then
							-- skip
							commented_lines.force (s)
						else
							p := s.index_of (':', 1)
							if p > 0 then
								u := s.substring (1, p-1)
								u.left_adjust
								u.right_adjust
								if u.same_string ("account") then
									u := s.substring (p+1, s.count)
									u.left_adjust
									u.right_adjust
									is_valid := u.same_string (account)
								elseif u.same_string ("client_id") then
									u := s.substring (p+1, s.count)
									u.left_adjust
									u.right_adjust
									client_id := u
								elseif u.same_string ("client_secret") then
									u := s.substring (p+1, s.count)
									u.left_adjust
									u.right_adjust
									client_secret := u
								elseif u.same_string ("redirect_uri") then
									u := s.substring (p+1, s.count)
									u.left_adjust
									u.right_adjust
									redirect_uri := u
								elseif u.same_string ("code") then
									u := s.substring (p+1, s.count)
									u.left_adjust
									u.right_adjust
									code := u
								elseif u.same_string ("refresh_token") then
									u := s.substring (p+1, s.count)
									u.left_adjust
									u.right_adjust
									refresh_token := u
								elseif u.same_string ("access_token") then
									u := s.substring (p+1, s.count)
									u.left_adjust
									u.right_adjust
									access_token := u
								elseif u.same_string ("token_type") then
									u := s.substring (p+1, s.count)
									u.left_adjust
									u.right_adjust
									token_type := u
								else
									others.force (s.substring (p+1, s.count), u)
									u := Void
								end
							end
						end
					end
					f.close
				end
			end
		end

	save
		local
			f: RAW_FILE
		do
			if is_valid then
				create f.make_with_name ("google.data")
				f.create_read_write
				f.put_string ("account:")
				f.put_string (account)
				f.put_new_line
				f.close

				create f.make_with_name ("google." + account)
				f.create_read_write
				f.put_string ("account:")
				f.put_string (account)
				f.put_new_line
				f.put_string ("client_id:")
				f.put_string (client_id)
				f.put_new_line
				f.put_string ("client_secret:")
				f.put_string (client_secret)
				f.put_new_line
				f.put_string ("redirect_uri:")
				f.put_string (redirect_uri)
				f.put_new_line
				if attached code as l_code then
					f.put_string ("code:")
					f.put_string (l_code)
					f.put_new_line
				end
				if attached refresh_token as l_refresh_token then
					f.put_string ("refresh_token:")
					f.put_string (l_refresh_token)
					f.put_new_line
				end
				if attached access_token as l_access_token then
					f.put_string ("access_token:")
					f.put_string (l_access_token)
					f.put_new_line
				end
				if attached token_type as l_token_type then
					f.put_string ("token_type:")
					f.put_string (l_token_type)
					f.put_new_line
				end
				across
					others as c
				loop
					f.put_string (c.key.as_string_8)
					f.put_string (":")
					f.put_string (c.item)
					f.put_new_line
				end
				across
					commented_lines as c
				loop
					f.put_string (c.item)
					f.put_new_line
				end
			end
		end

	set_code (a_code: like code)
		do
			code := a_code
		end

	set_refresh_token (a_refresh_token: like refresh_token)
		do
			refresh_token := a_refresh_token
		end

	set_access_token (a_access_token: like access_token)
		do
			access_token := a_access_token
		end

	set_token_type (a_token_type: like token_type)
		do
			token_type := a_token_type
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
