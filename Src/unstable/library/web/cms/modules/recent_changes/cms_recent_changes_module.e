note
	description: "CMS module that brings support for recent changes."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_RECENT_CHANGES_MODULE

inherit
	CMS_MODULE
		rename
			module_api as recent_changes_api
		redefine
			setup_hooks,
			permissions
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_BLOCK

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
			a_router.handle ("/recent_changes/feed", create {WSF_URI_AGENT_HANDLER}.make (agent handle_recent_changes_feed (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/recent_changes/feed.{format}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_recent_changes_feed (a_api, ?, ?)), a_router.methods_head_get)
		end

feature -- Hook		

	block_list: ITERABLE [like {CMS_BLOCK}.name]
			-- List of block names, managed by current object.
			-- If prefixed by "?", condition will be check
			-- to determine if it should be displayed (and computed) or not.
		do
			Result := <<"?recent_changes">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
			-- Get block object identified by `a_block_id' and associate with `a_response'.
		local
			b: CMS_CONTENT_BLOCK
			s, l_content: STRING
			gen: FEED_TO_XHTML_VISITOR
			nb: NATURAL_32
		do
			if a_block_id.same_string_general ("recent_changes") then
				create l_content.make (1024)
				create gen.make (l_content)

				create s.make_empty
				s.append_string ("<liv class=%"nav%">")
				s.append_string (a_response.link ("See more ...", "recent_changes/", Void))
				s.append_string ("</li>")
				gen.set_footer (s)

				nb := 10
				if
					attached a_response.block_options (a_block_id) as l_options and then
					attached {READABLE_STRING_GENERAL} l_options.item ("size") as l_size and then
					l_size.is_integer
				then
					nb := l_size.to_natural_32
				end

				recent_changes_feed (a_response, nb, Void).accept (gen)

				create b.make (a_block_id, Void, l_content, Void)
				a_response.add_block (b, Void)
			end
		end

	recent_changes_feed (a_response: CMS_RESPONSE; a_size: NATURAL_32; a_source: detachable READABLE_STRING_8): FEED
		local
			l_changes: CMS_RECENT_CHANGE_CONTAINER
			ch: CMS_RECENT_CHANGE_ITEM
			l_user: detachable CMS_USER
			l_feed: FEED
			l_feed_name: STRING_32
			l_feed_item: FEED_ITEM
			lnk: FEED_LINK
			nb: NATURAL_32
			s: STRING_32
		do
			l_user := Void -- Public access for the feed!
			create l_changes.make (a_size, create {DATE_TIME}.make_now_utc, a_source, Void)
			if attached a_response.api.hooks.subscribers ({CMS_RECENT_CHANGES_HOOK}) as lst then
				across
					lst as ic
				loop
					if attached {CMS_RECENT_CHANGES_HOOK} ic.item as h then
						if attached h.recent_changes_sources as h_sources then
							if
								a_source = Void
								or else across h_sources as h_ic some h_ic.item.is_case_insensitive_equal (a_source) end
							then
								h.populate_recent_changes (l_changes, l_user)
							end
						end
					end
				end
			end
			create l_feed_name.make_from_string (a_response.api.setup.site_name)
			l_feed_name.append_string ({STRING_32} " : recent changes")
			create l_feed.make (l_feed_name)
			l_feed.set_id (a_response.api.absolute_url (a_response.request.percent_encoded_path_info, Void))
			l_feed.set_date (create {DATE_TIME}.make_now_utc)
			nb := a_size
			across
				l_changes as ic
			until
				nb = 0
			loop
				ch := ic.item
				create l_feed_item.make (ch.link.title)
				l_feed_item.set_date (ch.date)
				if attached ch.id as l_ch_id then
					l_feed_item.set_id (l_ch_id)
				end
				if attached ch.author as l_author then
					l_feed_item.set_author (create {FEED_AUTHOR}.make (a_response.api.real_user_display_name (l_author)))
				end

				create s.make_empty
				if attached ch.information as l_information then
					s.append_string_general (l_information)
				end
				if attached ch.summary as sum then
					if not s.is_empty then
						s.append ("%N%N")
					end
					s.append (sum)
				end
				l_feed_item.set_description (s)
				if attached ch.categories as lst then
					across
						lst as cats_ic
					loop
						l_feed_item.set_category (cats_ic.item)
					end
				end
				create lnk.make (a_response.absolute_url (ch.link.location, Void))
				l_feed_item.links.force (lnk, "")
				l_feed.extend (l_feed_item)
				nb := nb - 1
			end
			l_feed.sort
			Result := l_feed
		end

feature -- Handler

	handle_recent_changes_feed (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			htdate: HTTP_DATE
			l_content: STRING
			l_until_date: detachable DATE_TIME
			l_until_date_timestamp: INTEGER_64
			l_filter_source: detachable READABLE_STRING_8
			l_size: NATURAL_32
			mesg: CMS_CUSTOM_RESPONSE_MESSAGE
		do
			if attached {WSF_STRING} req.query_parameter ("date") as p_until_date then
				l_until_date_timestamp := p_until_date.value.to_integer_64
				create htdate.make_from_timestamp (l_until_date_timestamp)
				l_until_date := htdate.date_time
			end
			if attached {WSF_STRING} req.query_parameter ("source") as p_filter then
				l_filter_source := p_filter.url_encoded_value
				if l_filter_source.is_empty then
					l_filter_source := Void
				end
			end
			if attached {WSF_STRING} req.query_parameter ("size") as p_size then
				l_size := p_size.integer_value.to_natural_32
			end
			if l_size = 0 then
				l_size := 25
			end

			create mesg.make ({HTTP_STATUS_CODE}.ok)

			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			create l_content.make (1024)
			if
				attached {WSF_STRING} req.path_parameter ("format") as p_format and then
				p_format.same_string ("rss")
			then
				mesg.header.put_content_type ("application/rss+xml")

				recent_changes_feed (r, l_size, l_filter_source).accept (create {RSS_2_FEED_GENERATOR}.make (l_content))
			else
				mesg.header.put_content_type ("application/atom+xml")

				recent_changes_feed (r, l_size, l_filter_source).accept (create {ATOM_FEED_GENERATOR}.make (l_content))
			end
			mesg.set_payload (l_content)
			res.send (mesg)
		end

	handle_recent_changes (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_changes: CMS_RECENT_CHANGE_CONTAINER
			l_sources: ARRAYED_LIST [READABLE_STRING_8]
			dt,	prev_dt: detachable DATE_TIME
			prev_info: detachable READABLE_STRING_8
			ch: detachable CMS_RECENT_CHANGE_ITEM
			htdate: HTTP_DATE
			l_content: STRING
			l_form: CMS_FORM
			l_select: WSF_FORM_SELECT
			l_author_field: WSF_FORM_TEXT_INPUT
			l_size_field: WSF_FORM_NUMBER_INPUT
			l_date_field: WSF_FORM_HIDDEN_INPUT
			l_submit: WSF_FORM_SUBMIT_INPUT
			l_until_date: detachable DATE_TIME
			l_until_date_timestamp: INTEGER_64
			l_filter_source: detachable READABLE_STRING_8
			l_filter_author: detachable READABLE_STRING_32
			l_filter_username: detachable READABLE_STRING_32
			l_size: NATURAL_32
			l_query: STRING
			opt: WSF_FORM_SELECT_OPTION
			l_user: detachable CMS_USER
			i: INTEGER
		do
			if attached {WSF_STRING} req.query_parameter ("date") as p_until_date then
				l_until_date_timestamp := p_until_date.value.to_integer_64
				create htdate.make_from_timestamp (l_until_date_timestamp)
				l_until_date := htdate.date_time
--				l_until_date.second_add (-1)
			end
			if attached {WSF_STRING} req.query_parameter ("source") as p_filter then
				l_filter_source := p_filter.url_encoded_value
				if l_filter_source.is_empty then
					l_filter_source := Void
				end
			elseif attached {WSF_STRING} req.query_parameter ("filter") as p_filter then
				l_filter_source := p_filter.url_encoded_value
				if l_filter_source.is_empty then
					l_filter_source := Void
				end
			end
			if attached {WSF_STRING} req.query_parameter ("author") as p_author then
				l_filter_author := p_author.value
				if l_filter_author.is_empty then
					l_filter_author := Void
				end
			end
			if attached {WSF_STRING} req.query_parameter ("size") as p_size then
				l_size := p_size.integer_value.to_natural_32
			end
			if l_size = 0 then
				l_size := 25
			end

			if api.has_permission ("view recent changes") then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				l_user := api.user
				if l_filter_author /= Void then
					if attached api.user_api.user_by_id_or_name (l_filter_author) as u then
						l_filter_username := u.name
					elseif
						attached api.user_api.users_by_profile_name (l_filter_author) as lst and then
						lst.count = 1
					then
						l_filter_username := lst.first.name
					end
				end
				create l_changes.make (l_size, l_until_date, l_filter_source, l_filter_username)

				create l_content.make (1024)
				if attached api.hooks.subscribers ({CMS_RECENT_CHANGES_HOOK}) as lst then
					create l_sources.make (lst.count)

					across
						lst as ic
					loop
						if attached {CMS_RECENT_CHANGES_HOOK} ic.item as h then
							if attached h.recent_changes_sources as h_sources then
								l_sources.append (h_sources)
								if
									l_filter_source = Void
									or else across h_sources as h_ic some h_ic.item.is_case_insensitive_equal (l_filter_source) end
								then
									h.populate_recent_changes (l_changes, l_user)
								end
							end
						end
					end
					create l_form.make (req.percent_encoded_path_info, "recent-changes")
					l_form.set_method_get
					create l_select.make ("source")
					l_select.set_label ("Sources")
					create opt.make ("", "Any source")
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

					create l_author_field.make ("author")
					if l_filter_author /= Void then
						l_author_field.set_text_value (l_filter_author)
					end
					l_author_field.set_label ("By author")
					l_form.extend (l_author_field)


					create l_size_field.make_with_text ("size", l_size.out)
					l_size_field.set_size (25)
					l_size_field.set_label ("Items per page")
					l_form.extend (l_size_field)

					if l_until_date /= Void then
						create l_date_field.make_with_text ("date", l_until_date_timestamp.out)
						l_form.extend (l_date_field)
					end

					create l_submit.make_with_text ("op", "Filter")
					l_form.extend (l_submit)
					l_form.extend_html_text ("<br/>")
					l_form.append_to_html (r.wsf_theme, l_content)
				end

				l_changes.reverse_sort
				l_content.append ("<table class=%"recent-changes%">")
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
					if l_changes.has_expected_author (ch) then
						dt := ch.date
						if prev_dt = Void or else dt.date /~ prev_dt.date then
							l_content.append ("<tr>")
							l_content.append ("<td class=%"title%" colspan=%"5%">")
							l_content.append (dt.date.formatted_out ("ddd, dd mmm yyyy"))
							l_content.append ("</td>")
							l_content.append ("</tr>")
						end
						l_content.append ("<tr>")
						l_content.append ("<td class=%"date%">")
						if dt /~ prev_dt then
							create htdate.make_from_date_time (dt)
							htdate.append_to_rfc1123_string (l_content)
						else
							l_content.append ("<span class=%"same-value%">''</span>")
						end
						l_content.append ("</td>")

						l_content.append ("<td class=%"source%">" + ch.source + "</td>")
						l_content.append ("<td class=%"resource%">")
						l_content.append (r.link (ch.link.title, ch.link.location, Void))
						l_content.append ("</td>")
						l_content.append ("<td class=%"user%">")
						if attached ch.author as u then
							l_content.append (r.link (r.user_profile_name (u), "user/" + u.id.out, Void))
						elseif attached ch.author_name as un then
							l_content.append (r.html_encoded (un))
						end
						l_content.append ("</td>")
						l_content.append ("<td class=%"info%">")
						if attached ch.information as l_info and then not l_info.is_empty then
							if prev_dt ~ dt and prev_info ~ l_info then
								l_content.append ("<span class=%"same-value%">''</span>")
							else
								i := l_info.index_of ('%N', 1)
								if i > 0 and i < l_info.count then
									l_content.append (l_info.substring (1, i - 1))
									l_content.append ("<span class=%"tooltip%">")
									l_content.append (l_info.substring (i, l_info.count))
									l_content.append ("</span>")
								else
									l_content.append (l_info)
								end
							end
							prev_info := l_info
						else
							prev_info := Void
						end
						l_content.append ("</td>")
						l_content.append ("</tr>%N")
						prev_dt := dt
					end
				end
				l_content.append ("</tbody>")
				l_content.append ("</table>%N")

					-- Reset date filter!
				if l_until_date /= Void then
					l_content.append (" <a href=%"")
					l_content.append (r.request_url (Void))
					l_content.append ("?size=" + l_size.out + "%">&lt;&lt;</a> ")
				end

				dt := l_changes.last_date
				if dt = Void and ch /= Void then
					dt := ch.date
				end
				if dt /= Void then
					if l_until_date /~ dt then
						create htdate.make_from_date_time (dt)
						create l_query.make_from_string ("size=" + l_size.out)
						l_query.append ("&date=")
						l_query.append (htdate.timestamp.out)
						if l_filter_source /= Void then
							l_query.append ("&source=")
							l_query.append (percent_encoded (l_filter_source))
						end
						if l_filter_author /= Void then
							l_query.append ("&author=")
							l_query.append (percent_encoded (l_filter_author))
						end
						l_content.append ("<a href=%"")
						l_content.append (r.request_url (create {CMS_API_OPTIONS}.make_from_manifest (<<["query", l_query]>>)))
						l_content.append ("%">See more ...</a>")
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
			else
				api.response_api.send_permissions_access_denied (Void, <<"view recent changes">>, req, res)
			end
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
			a_hooks.subscribe_to_response_alter_hook (Current)
			a_hooks.subscribe_to_block_hook (Current)
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
