note
	description: "Summary description for {LOGIN_WITH_GITHUB_SETUP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_GITHUB_SETUP

create
	make_from_path

feature {NONE} -- Initialization

	make_from_path (p: PATH)
		local
			f: PLAIN_TEXT_FILE
			s,k: STRING
			i: INTEGER
		do
			api_key := ""
			api_secret := ""

			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				f.open_read
				from

				until
					f.exhausted or f.end_of_file
				loop
					f.read_line
					s := f.last_string
					s.left_adjust
					if s.is_whitespace then
					elseif s.starts_with ("#") then
					else
						i := s.index_of ('=', 1)
						if i > 0 then
							k := s.head (i - 1)
							k.right_adjust
							s.remove_head (i)
							s.left_adjust
							s.right_adjust
							if k.is_case_insensitive_equal ("callback") then
								create callback.make_from_string (s)
							elseif k.is_case_insensitive_equal ("api_key") then
								create api_key.make_from_string (s)
							elseif k.is_case_insensitive_equal ("api_secret") then
								create api_secret.make_from_string (s)
							end
						end
					end
				end
				f.close
			end
		end

feature -- Access

	callback: detachable IMMUTABLE_STRING_8

	api_key: IMMUTABLE_STRING_8

	api_secret: IMMUTABLE_STRING_8

feature -- Status report

	is_valid: BOOLEAN
		do
			Result := attached callback as cb and then not cb.is_whitespace and
					  not api_key.is_whitespace and
					  not api_secret.is_whitespace
		end

invariant

end
