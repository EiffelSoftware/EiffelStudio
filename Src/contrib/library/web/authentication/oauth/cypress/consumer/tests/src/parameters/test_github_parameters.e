note
	description: "Summary description for {TEST_GITHUB_PARAMETERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_GITHUB_PARAMETERS

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
			username := "Missing Username"
			password := "Missing Password"
			load
		end

feature -- Basic operation

	load
		local
			f: RAW_FILE
			u: detachable STRING_8
			s: STRING_8
			p: INTEGER
		do
			create f.make_with_name ("github.data")
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
							if u.same_string ("username") then
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
				io.put_string ("Username ? >")
				io.read_line
				u := io.last_string
				u.left_adjust
				u.right_adjust
			end
			if not u.is_empty then
				username := u
				create f.make_with_name ("github." + u)
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
						else
							p := s.index_of (':', 1)
							if p > 0 then
								u := s.substring (1, p-1)
								u.left_adjust
								u.right_adjust
								if u.same_string ("username") then
									u := s.substring (p+1, s.count)
									u.left_adjust
									u.right_adjust
									is_valid := u.same_string (username)
								elseif u.same_string ("password") then
									u := s.substring (p+1, s.count)
									u.left_adjust
									u.right_adjust
									password := u
								elseif u.same_string ("token") then
									u := s.substring (p+1, s.count)
									u.left_adjust
									u.right_adjust
									token := u
								else
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
				create f.make_with_name ("github.data")
				f.create_read_write
				f.put_string ("username:")
				f.put_string (username)
				f.put_new_line
				f.close

				create f.make_with_name ("github." + username)
				f.create_read_write
				f.put_string ("username:")
				f.put_string (username)
				f.put_new_line
				f.put_string ("password:")
				f.put_string (password)
				f.put_new_line
				if attached token as t then
					f.put_string ("token:")
					f.put_string (t)
				else
					f.put_string ("#token:")
				end
				f.put_new_line
				f.close
			end
		end

	set_token (t: READABLE_STRING_8)
		do
			token := t
		end

feature -- Access

	is_valid: BOOLEAN

	username: STRING
	password: STRING
	token: detachable STRING

;note
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
