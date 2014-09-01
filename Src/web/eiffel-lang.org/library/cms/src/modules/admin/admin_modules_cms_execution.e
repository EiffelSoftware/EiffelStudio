note
	description: "Summary description for {ADMIN_MODULES_CMS_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_MODULES_CMS_EXECUTION

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
			set_title ("Modules")
			-- check Permission !!!
			create b.make_empty
			if has_permission ("administrate modules") then
				b.append ("<ul id=%"module-list%">")
				across
					service.modules as m
				loop
					if attached m.item as mod then
						if mod.is_enabled then
							b.append ("<li class=%"enabled%">")
						else
							b.append ("<li class=%"disabled%">")
						end
						b.append ("<strong>" + mod.name + "</strong> (version:" + mod.version + ")")
						b.append (" package=" + mod.package)
						if mod.is_enabled then
							b.append (" [<a href=%"%">disable</a>]")
						else
							b.append (" [<a href=%"%">enable</a>]")
						end
						b.append ("<pre>" + mod.description + "</pre>")

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
