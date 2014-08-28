note
	description: "Summary description for {ADMIN_USERS_CMS_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_USERS_CMS_EXECUTION

inherit
	CMS_EXECUTION

create
	make

feature -- Execution

	process
			-- Computed response message.
		local
			b: STRING_8
		do
			set_title ("Users")
			-- check Permission !!!
			create b.make_empty
			if has_permission ("administrate users") then

				b.append ("<ul id=%"user-list%">")
				across
					service.storage.all_users as c
				loop
					if attached c.item as u then
						b.append ("<li class=%"user%">")
						b.append ("<strong>" + user_link (u) + "</strong> (id=" + u.id.out + ")")
						if attached u.email as l_email then
							b.append (" [<a mailto=%""+ l_email +"%">"+ l_email +"</a>]")
						end
						if attached u.creation_date as dt then
							b.append (" - created: " + dt.out)
						end
						if attached u.last_login_date as dt then
							b.append (" - last signed: " + dt.out)
						end

						b.append ("</li>")
					end
				end
				b.append ("</ul>")
			else
				b.append ("<div class=%"denied%">Access denied</div>")
			end

			set_main_content (b)
		end

end
