note
	description: "CMS module that bring support for recent changes."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_RECENT_CHANGES_MODULE

inherit
	CMS_MODULE
		rename
			module_api as recent_changes_api
		redefine
			register_hooks,
			permissions
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_RESPONSE_ALTER

create
	make

feature {NONE} -- Initialization

	make
			-- Create Current module, disabled by default.
		do
			version := "1.0"
			description := "Service to access recent changes"
			package := "notification"
		end

feature -- Access

	name: STRING = "recent_changes"

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force ("view recent changes")
		end

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			a_router.handle ("/recent_changes/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_recent_changes (a_api, ?, ?)), a_router.methods_head_get)
		end

feature -- Handler

	handle_recent_changes (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_changes: CMS_RECENT_CHANGE_CONTAINER
			l_sources: ARRAYED_LIST [READABLE_STRING_8]
			dt, prev_dt: detachable DATE
			ch: detachable CMS_RECENT_CHANGE_ITEM
			htdate: HTTP_DATE
			l_content: STRING
			l_form: CMS_FORM
			l_select: WSF_FORM_SELECT
			l_until_date: detachable DATE_TIME
			l_filter_source: detachable READABLE_STRING_8
			l_size: NATURAL_32
			l_query: STRING
			opt: WSF_FORM_SELECT_OPTION
		do
			if attached {WSF_STRING} req.query_parameter ("date") as p_until_date then
				create htdate.make_from_timestamp (p_until_date.value.to_integer_64)
				l_until_date := htdate.date_time
--				l_until_date.second_add (-1)
			end
			if attached {WSF_STRING} req.query_parameter ("filter") as p_filter then
				l_filter_source := p_filter.url_encoded_value
			end
			if attached {WSF_STRING} req.query_parameter ("size") as p_size then
				l_size := p_size.integer_value.to_natural_32
			end
			if l_size = 0 then
				l_size := 25
			end

			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			create l_changes.make (l_size, l_until_date, l_filter_source)

			create l_content.make (1024)
			if attached r.hooks.subscribers ({CMS_RECENT_CHANGES_HOOK}) as lst then
				create l_sources.make (lst.count)
				across
					lst as ic
				loop
					if attached {CMS_RECENT_CHANGES_HOOK} ic.item as h then
						h.populate_recent_changes (l_changes, l_sources)
					end
				end
				create l_form.make (req.percent_encoded_path_info, "recent-changes")
				create l_select.make ("source")
				l_select.set_label ("Sources")
				create opt.make ("", "...")
				l_select.add_option (opt)
				across
					l_sources as ic
				loop
					create opt.make (ic.item, ic.item)
					if l_filter_source /= Void and then ic.item.is_case_insensitive_equal (l_filter_source) then
						opt.set_is_selected (True)
					end
					l_select.add_option (opt)
				end
				l_form.extend (l_select)
				l_form.extend_html_text ("<br/>")
				l_form.append_to_html (create {CMS_TO_WSF_THEME}.make (r, r.theme), l_content)
			end

			l_changes.reverse_sort
			l_content.append ("<table class=%"recent-changes%" style=%"border-spacing: 5px;%">")
			l_content.append ("<thead>")
			l_content.append ("<tr>")
			l_content.append ("<th>Date</th>")
			l_content.append ("<th>Source</th>")
			l_content.append ("<th>Resource</th>")
			l_content.append ("<th>User</th>")
			l_content.append ("<th>Information</th>")
			l_content.append ("</tr>")
			l_content.append ("</thead>")
			l_content.append ("<tbody>")

			across
				l_changes as ic
			loop
				ch := ic.item
				dt := ch.date.date
				if dt /~ prev_dt then
					l_content.append ("<tr>")
					l_content.append ("<td class=%"title%" colspan=%"5%">")
					l_content.append (dt.formatted_out ("ddd, dd mmm yyyy"))
					l_content.append ("</td>")
					l_content.append ("</tr>")
				end
				prev_dt := dt
				l_content.append ("<tr>")
				l_content.append ("<td class=%"date%">")
				create htdate.make_from_date_time (ch.date)
				htdate.append_to_rfc1123_string (l_content)
				l_content.append ("</td>")
				l_content.append ("<td class=%"source%">" + ch.source + "</td>")
				l_content.append ("<td class=%"resource%">")
				l_content.append (r.link (ch.link.title, ch.link.location, Void))
				l_content.append ("</td>")
				l_content.append ("<td class=%"user%">")
				if attached ch.author as u then
					l_content.append (r.link (u.name, "user/" + u.id.out, Void))
				end
				l_content.append ("</td>")
				l_content.append ("<td class=%"info%">")
				if attached ch.information as l_info then
					l_content.append ("<strong>" + l_info + "</strong> ")
				end
				l_content.append ("</td>")
				l_content.append ("</tr>%N")
			end
			l_content.append ("</tbody>")
			l_content.append ("</table>%N")

			if ch /= Void then
				if l_until_date /= Void then
					l_content.append (" <a href=%"")
					l_content.append (r.url (r.location, Void))
					l_content.append ("?size=" + l_size.out + "%">&lt;&lt;</a> ")
				end

				if l_until_date /~ ch.date then
					create htdate.make_from_date_time (ch.date)
					create l_query.make_from_string ("size=" + l_size.out)
					l_query.append ("&date=")
					l_query.append (htdate.timestamp.out)
					if l_filter_source /= Void then
						l_query.append ("&filter=")
						l_query.append (l_filter_source)
					end
					l_content.append ("<a href=%"")
					l_content.append (r.url (r.location, create {CMS_API_OPTIONS}.make_from_manifest (<<["query", l_query]>>)))
					l_content.append ("%">More  ...</a>")
				end
			end

			r.set_main_content (l_content)
			if l_until_date = Void then
				r.set_title ("Recent changes")
			else
				create htdate.make_from_date_time (l_until_date)
				r.set_title ("Recent changes before " + htdate.string)
			end

			r.execute
		end

feature -- Hooks configuration

	register_hooks (a_response: CMS_RESPONSE)
			-- Module hooks configuration.
		do
			a_response.hooks.subscribe_to_menu_system_alter_hook (Current)
			a_response.hooks.subscribe_to_response_alter_hook (Current)
		end

feature -- Hook

	response_alter (a_response: CMS_RESPONSE)
		do
			a_response.add_additional_head_line ("[
					<style>
						table.recent-changes th { padding: 3px; }
						table.recent-changes td { padding: 3px; border: dotted 1px #ddd; }
						table.recent-changes td.date { padding-left: 15px; }
						table.recent-changes td.title { font-weight: bold; }
						</style>
				]", True)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
		do
			create lnk.make ("Recent changes", "recent_changes/")
			lnk.set_permission_arguments (<<"view recent changes">>)
			a_menu_system.navigation_menu.extend (lnk)
		end


end
