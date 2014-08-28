note
	description: "[
			]"

class
	USER_RESET_PASSWORD_CMS_EXECUTION

inherit
	CMS_EXECUTION

create
	make

feature -- Execution

	process
			-- Computed response message.
		local
			b: STRING_8
			u: detachable CMS_USER
			err: BOOLEAN
			t: INTEGER_64
			l_extra: detachable READABLE_STRING_8
		do
			create b.make_empty
			u := user
			if u /= Void then
				add_success_message ("You are logged in as " + u.name + ". " + link ("Change your password", "/user/" + u.id.out + "/edit", Void))
				set_redirection (front_page_url)
			else
				if attached {WSF_STRING} request.path_parameter ("uid") as p_uid and then p_uid.is_integer then
					u := service.storage.user_by_id (p_uid.integer_value)
				end
				if u /= Void then
					if attached non_empty_string_path_parameter ("last-signed") as p_last_signed then
						if p_last_signed.is_integer_64 then
							t := p_last_signed.to_integer_64
						else
							err := True
						end
						if t > 0 then
							if attached u.last_login_date as l_last then
								if t /= unix_timestamp (l_last) then
									err := True
								end
							else
								if t /= unix_timestamp (u.creation_date) then
									err := True
								end
							end
						end
					else
						err := True
					end
					if attached non_empty_string_path_parameter ("extra") as s_extra then
						l_extra := s_extra
						if l_extra /= Void then
							if attached {READABLE_STRING_8} u.data_item ("new_password_extra") as u_extra and then u_extra.same_string (l_extra) then
							else
								err := True
							end
						else
							err := True
						end
					else
						err := True
					end
					if not err then
						login (u, request)
						u.remove_data_item ("new_password_extra")
						service.storage.save_user (u)
						set_redirection (url ("/user/" + u.id.out + "/edit", Void))
						set_main_content (b)
					end
				else
					err := True
				end
				if err then
					add_warning_message ("The one-time login link you clicked is invalid.")
					set_redirection (front_page_url)
				end
			end
			set_main_content (b)
		end

end
