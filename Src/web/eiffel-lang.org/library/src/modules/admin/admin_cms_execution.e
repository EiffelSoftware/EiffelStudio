note
	description: "Summary description for {CMS_ADMIN_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_CMS_EXECUTION

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
			set_title ("Administration")
			-- check Permission !!!
			create b.make_empty
			if has_permission ("administrate modules") then
				b.append ("<li>" + link ("Modules", "/admin/modules/", Void) + "</li>")
			end
			if has_permission ("administrate blocks") then
				b.append ("<li>" + link ("Blocks", "/admin/blocks/", Void) + "</li>")
			end
			if has_permission ("administrate user-roles") then
				b.append ("<li>" + link ("User roles", "/admin/roles/", Void) + "</li>")
			end
			if has_permission ("administrate users") then
				b.append ("<li>" + link ("Users", "/admin/users/", Void) + "</li>")
			end
			if has_permission ("administrate logs") then
				b.append ("<li>" + link ("Logs", "/admin/logs/", Void) + "</li>")
			end


			set_main_content (b)
		end

end
