note
	description: "[
			]"

class
	USER_LOGOUT_CMS_EXECUTION

inherit
	CMS_EXECUTION

create
	make

feature -- Execution

	process
			-- Computed response message.
		local
--			l_url: READABLE_STRING_8
			b: STRING_8
		do
			logout (request)

			if
				attached {WSF_STRING} request.item ("destination") as s_dest
			then
				set_redirection (request.script_url (s_dest.value))
			else
				set_redirection (request.script_url ("/"))
			end

			set_title ("Logout")
			create b.make_empty
			set_main_content (b)
--			l_url := request.script_url ("/info/")
--			res.redirect_now_with_content (l_url, "Redirection to " + l_url, "text/html")
		end

end
