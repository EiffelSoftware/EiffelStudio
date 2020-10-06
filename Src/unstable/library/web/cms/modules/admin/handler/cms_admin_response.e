note
	description: "Response for the /admin request."
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
			l_admin_links: ARRAYED_LIST [TUPLE [package: READABLE_STRING_GENERAL; permissions: detachable ITERABLE [READABLE_STRING_GENERAL]; link: CMS_LINK; help: detachable READABLE_STRING_GENERAL]]
			lst: detachable ARRAYED_LIST [TUPLE [permissions: detachable ITERABLE [READABLE_STRING_GENERAL]; link: CMS_LINK; help: detachable READABLE_STRING_GENERAL]]
			categories: STRING_TABLE [ARRAYED_LIST [TUPLE [permissions: detachable ITERABLE [READABLE_STRING_GENERAL]; link: CMS_LINK; help: detachable READABLE_STRING_GENERAL]]]
			l_package: READABLE_STRING_GENERAL
			lnk: CMS_LINK
		do
			create l_admin_links.make (5)

			if attached menu_system.management_menu.item_by_location (api.administration_path_location ("")) as l_admin_lnk then
				if attached l_admin_lnk.children as l_children then
					across
						l_children as ic
					loop
						lnk := ic.item
						if attached {CMS_LOCAL_LINK} lnk as loc_lnk then
							l_admin_links.force (["core", loc_lnk.permission_arguments, lnk, lnk.help])
							if
								attached loc_lnk.children as l_sub_children and then
								not l_sub_children.is_empty
							then
								across
									l_sub_children as sub_ic
								loop
									lnk := sub_ic.item
									if attached {CMS_LOCAL_LINK} lnk as loc_sub_lnk then
										l_admin_links.force ([loc_lnk.title, loc_sub_lnk.permission_arguments, loc_sub_lnk, loc_sub_lnk.help])
									else
										l_admin_links.force ([loc_lnk.title, Void, lnk, lnk.help])
									end
								end
							end
						else
							l_admin_links.force (["core", Void, lnk, lnk.help])
						end
					end
				end
			end

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
				b.append ("<a name=%""+ url_encoded (cats_ic.key) +"%"></a>")
				b.append (html_encoded (cats_ic.key))
				b.append ("</h3>")
				b.append ("<ul>")
				across
					lst as ic
				loop
					if
						not attached ic.item.permissions as l_permissions
						or else has_permissions (l_permissions)
					then
						b.append ("<li>")
						if attached ic.item.link as i_lnk then
							b.append (link (i_lnk.title, i_lnk.location, Void))
						end
						if attached ic.item.help as l_help then
							b.append ("<div class=%"description%">")
							b.append (html_encoded (l_help))
							b.append ("</div>")
						end
						b.append ("</li>")
					end
				end
				b.append ("</ul>")
			end

			set_main_content (b)
		end

end
