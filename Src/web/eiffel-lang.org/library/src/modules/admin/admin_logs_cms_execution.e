note
	description: "Summary description for {ADMIN_LOGS_CMS_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_LOGS_CMS_EXECUTION

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
			set_title ("Logs")
			-- check Permission !!!
			create b.make_empty
			if has_permission ("admin logs") then
				b.append ("<ul id=%"log-list%">")
				across
					storage.recent_logs (1, 25) as c
				loop
					if attached c.item as l_log then
						b.append ("<li class=%"log%">")
						b.append (link ("[" + l_log.id.out + "]", "/admin/log/" + l_log.id.out, Void))
						b.append (" <strong>" + l_log.category + "</strong> (level=" + l_log.level_name + ")")
						b.append (": " + truncated_string (l_log.message, 60, "..."))
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
