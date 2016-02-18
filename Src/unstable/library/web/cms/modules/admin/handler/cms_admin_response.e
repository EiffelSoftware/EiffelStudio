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
			l_admin_links: ARRAYED_LIST [TUPLE [package: READABLE_STRING_8; permissions: ARRAY [READABLE_STRING_GENERAL]; link: CMS_LINK; help: READABLE_STRING_GENERAL]]
			lst: detachable ARRAYED_LIST [TUPLE [permissions: ARRAY [READABLE_STRING_GENERAL]; link: CMS_LINK; help: READABLE_STRING_GENERAL]]
			categories: STRING_TABLE [ARRAYED_LIST [TUPLE [permissions: ARRAY [READABLE_STRING_GENERAL]; link: CMS_LINK; help: READABLE_STRING_GENERAL]]]
			l_package: READABLE_STRING_8
		do
			create l_admin_links.make (5)
			l_admin_links.force (["core", <<"admin users">>, local_link ("Users", "admin/users"), "View/Edit/Add Users"])
			l_admin_links.force (["core", <<"admin roles">>, local_link ("Roles", "admin/roles"), "View/Edit/Add Roles"])
			l_admin_links.force (["core", <<"admin modules">>, local_link ("Modules", "admin/modules"), "(un)Install modules"])
			l_admin_links.force (["core", <<"view logs">>, local_link ("Logs", "admin/logs"), "View logs"])
			l_admin_links.force (["support", <<"admin cache">>, local_link ("Cache", "admin/cache"), "Clear caches"])
			l_admin_links.force (["support", <<"admin export">>, local_link ("Export", "admin/export"), "Export CMS contents, and modules contents."])
			create categories.make_caseless (3)
			across
				l_admin_links as ic
			loop
				l_package := ic.item.package
				lst := categories.item (l_package)
				if lst = Void then
					create lst.make (1)
					categories.force (lst, l_package)
				end
				lst.force ([ic.item.permissions, ic.item.link, ic.item.help])
			end

			create b.make_empty
			set_title (translation ("Admin Page", Void))
			fixme ("Check how to make it configurable")
			across
				categories as cats_ic
			loop
				lst := cats_ic.item
				b.append ("<h3>")
				b.append (html_encoded (cats_ic.key))
				b.append ("</h3>")
				b.append ("<ul>")
				across
					lst as ic
				loop
					if has_permissions (ic.item.permissions) then
						b.append ("<li>")
						if attached ic.item.link as lnk then
							b.append (link (lnk.title, lnk.location, Void))
						end
						b.append ("<div class=%"description%">")
						b.append (html_encoded (ic.item.help))
						b.append ("</div>")
						b.append ("</li>")
					end
				end
				b.append ("</ul>")
			end

			set_main_content (b)
		end

end
