note
	description: "Summary description for {CMS_ADMIN_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_RESPONSE

inherit
	CMS_RESPONSE

create
	make

feature -- Process

	process
		local
			b: STRING
		do
			create b.make_empty
			set_title (translation ("Admin Page", Void))
			b.append ("<ul id=%"content-types%">")
			fixme ("Check how to make it configurable")
			if has_permissions (<< "admin users">>) then
				b.append ("<li>" + link ("Users", "admin/users", Void))
				b.append ("<div class=%"description%">View/Edit/Add Users</div>")
				b.append ("</li>")
			end
			if has_permissions (<< "admin roles">>) then
				b.append ("<li>" + link ("Roles", "admin/roles", Void))
				b.append ("<div class=%"description%">View/Edit/Add Roles</div>")
				b.append ("</li>")
			end
			b.append ("</ul>")
			set_main_content (b)
		end

end
