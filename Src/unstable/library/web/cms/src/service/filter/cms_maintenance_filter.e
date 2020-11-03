note
	description: "Summary description for {CMS_MAINTENANCE_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MAINTENANCE_FILTER

inherit
	WSF_FILTER

create
	make

feature {NONE} -- Initialization	

	make (a_name: detachable READABLE_STRING_GENERAL; a_api: CMS_API)
		do
			api := a_api
			if a_name /= Void then
				maintenance_fn := a_name
			else
				maintenance_fn := ".maintenance"
			end
		end

feature -- Access

	api: CMS_API

	maintenance_fn: READABLE_STRING_GENERAL

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		local
			l_line,s: STRING
			h: HTTP_HEADER
			f: PLAIN_TEXT_FILE
			l_allow_user: STRING_8
			l_allow_ip: STRING_8
		do
			create f.make_with_name (maintenance_fn)
			if f.exists then
				create s.make (64)
				if f.is_access_readable then
					f.open_read
					from
					until
						f.exhausted
					loop
						f.read_line
						l_line := f.last_string
						if l_line.starts_with_general ("#") then
							if l_line.starts_with_general ("#allow-user:") then
								l_allow_user := l_line.substring (l_line.index_of (':', 1) + 1, l_line.count)
								l_allow_user.adjust
								if l_allow_user.is_empty then
									l_allow_user := Void
								end
							elseif l_line.starts_with_general ("#allow-ip:") then
								l_allow_ip := l_line.substring (l_line.index_of (':', 1) + 1, l_line.count)
								l_allow_ip.adjust
								if l_allow_ip.is_empty then
									l_allow_ip := Void
								end
							end
						else
							s.append (l_line)
							s.append_character ('%N')
						end
					end
					f.close
				end
				if s.is_empty then
					s.append ("In maintenance, please come back later ...")
				end
				if
					l_allow_user /= Void and then
					attached api.user as u and then
					u.name.same_string_general (l_allow_user)
				then
						-- User allowed!
					execute_next (req, res)
				elseif
					l_allow_ip /= Void and then
					req.remote_addr.same_string (l_allow_ip)
				then
						-- IP allowed!
					execute_next (req, res)
				else
					create h.make_with_count (1)
					h.put_content_length (s.count)
					h.put_content_type_utf_8_text_plain
					res.set_status_code ({HTTP_STATUS_CODE}.service_unavailable)
					res.put_header_lines (h)
					res.put_string (s)
				end
			else
				execute_next (req, res)
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
