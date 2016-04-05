note
	description: "Summary description for {WDOCS_EDIT_FORM_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_EDIT_FORM_RESPONSE

inherit
	CMS_RESPONSE
		rename
			make as make_response
		end

	WDOCS_MODULE_HELPER
		rename
			percent_encoder as wdocs_percent_encoder
		end

create
	make

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: like api; a_wdocs_api: WDOCS_API; a_wdocs_edit_module: WDOCS_EDIT_MODULE)
		do
			wdocs_api := a_wdocs_api
			wdocs_module := a_wdocs_edit_module.wdocs_module
			make_response (req, res, a_api)
		end

feature -- Access

	wdocs_api: WDOCS_API

	wdocs_module: WDOCS_MODULE

feature -- Execution

	wiki_page_info_from_request: detachable TUPLE [page: attached like {WDOCS_MANAGER}.page; bookid: READABLE_STRING_GENERAL; manager: WDOCS_MANAGER]
		do
			Result := wdocs_module.wikipage_data_from_request (request)
		end

	wiki_page_from_request: detachable WIKI_BOOK_PAGE
		do
			Result := wdocs_module.wikipage_from_request (request)
		end

	process
			-- Computed response message.
		local
			b: STRING_8
			fd: detachable WSF_FORM_DATA
			f: like new_edit_form
			new_pg,pg: detachable WIKI_BOOK_PAGE
			mng: WDOCS_MANAGER
			l_bookid: detachable READABLE_STRING_GENERAL
			l_text: STRING
			l_preview: BOOLEAN
		do
			create b.make_empty
			if attached wiki_page_info_from_request as pg_info then
				pg := pg_info.page
				mng := pg_info.manager
				l_bookid := pg_info.bookid
			else
				if attached {WSF_STRING} request.path_parameter ("bookid") as p_bookid then
					l_bookid := p_bookid.value
				end
				if attached {WSF_STRING} request.path_parameter ("version") as p_version then
					mng := wdocs_api.manager (p_version.value)
				else
					mng := wdocs_api.manager (Void)
				end
			end
			if
				location.ends_with_general ("/edit") and then
				has_permission ({WDOCS_EDIT_MODULE}.perm_edit_wdocs_page)
			then
				if pg /= Void then
					set_title (formatted_string (translation ("Edit %"$1%"", Void), [pg.title]))
					add_to_primary_tabs (create {CMS_LOCAL_LINK}.make ("View", view_location))
				else
					set_title (translation ("New doc page", Void))
				end

				f := new_edit_form (pg, mng, url (request.percent_encoded_path_info, Void), "wdocs_edit")
				if l_bookid /= Void then
					f.extend (create {WSF_FORM_HIDDEN_INPUT}.make_with_text ("bookid", l_bookid.as_string_32))
				end

				api.hooks.invoke_form_alter (f, fd, Current)
				if request.is_post_request_method then
					if l_bookid = Void then
						add_error_message ("Missing book name information!")
					else
						f.validation_actions.extend (agent edit_form_validate (?, pg, mng, b))
						f.submit_actions.extend (agent edit_form_submit (?, mng, pg, l_bookid, b))
						f.process (Current)
						fd := f.last_data

						if fd /= Void and then fd.is_valid then
							l_preview := attached {WSF_STRING} fd.item ("op") as l_op and then l_op.same_string ("Preview")
							if l_preview then
								f.append_to_html (wsf_theme, b)
							else
								if pg /= Void then
									if mng.is_default_version then
										set_redirection (mng.wiki_page_uri_path (pg, l_bookid, Void))
									else
										set_redirection (mng.wiki_page_uri_path (pg, l_bookid, mng.version_id))
									end
								else
									set_redirection (view_location)
								end
							end
						else
							f.append_to_html (wsf_theme, b)
						end
					end
				else
					f.append_to_html (wsf_theme, b)
				end
			elseif
				location.ends_with_general ("/add-child") and then
				has_permission ({WDOCS_EDIT_MODULE}.perm_create_wdocs_page) and then
				l_bookid /= Void and then not l_bookid.is_empty -- FIXME: remove and handle the new Book creation.
			then
--				if l_bookid = Void or else l_bookid.is_empty then
--						-- Create new book
--					set_title (translation ("Create Book", Void))
--					pg := Void
--				else
					if pg /= Void then
						set_title (formatted_string (translation ("Add child to doc page %"$1%"", Void), [pg.title]))
					else
						set_title (translation ("New doc page", Void))
					end
--				end
				if pg /= Void then
					new_pg := mng.new_wiki_child_page ("", pg)
				else
					if l_bookid /= Void and then not l_bookid.is_empty then
						new_pg := mng.new_wiki_page ("", utf_8_string (l_bookid))
					else
						new_pg := mng.new_wiki_page ("", "")
					end
				end
				create l_text.make_empty
				if attached new_pg.metadata_table as tb then
					across
						tb as ic
					loop
						l_text.append ("[[Property:" + utf_8_string (ic.key) + ":" + utf_8_string (ic.item) + "]]%N")
					end
				end
				new_pg.set_text (create {WIKI_CONTENT_TEXT}.make_from_string (l_text))

				f := new_edit_form (new_pg, mng, url (request.percent_encoded_path_info, Void), "wdocs_edit")
				if l_bookid /= Void then
					f.extend (create {WSF_FORM_HIDDEN_INPUT}.make_with_text ("bookid", l_bookid.as_string_32))
				end
				if pg /= Void then
					f.extend (create {WSF_FORM_HIDDEN_INPUT}.make_with_text ("parent", pg.title))
				end

				api.hooks.invoke_form_alter (f, fd, Current)
				if request.is_post_request_method then
					if l_bookid = Void then
						add_error_message ("Missing book name information!")
						f.append_to_html (wsf_theme, b)
					else
						f.validation_actions.extend (agent edit_form_validate (?, new_pg, mng, b))
						f.submit_actions.extend (agent edit_form_submit (?, mng, new_pg, l_bookid, b))
						f.process (Current)
						fd := f.last_data
						if fd /= Void and then fd.is_valid then
							b.append ("<p>View wiki page ")
							if mng.is_default_version then
								b.append (link (new_pg.title, mng.wiki_page_uri_path (new_pg, l_bookid, Void), Void))
							else
								b.append (link (new_pg.title, mng.wiki_page_uri_path (new_pg, l_bookid, mng.version_id), Void))
							end
							b.append (".</p>")

							if pg /= Void then
								b.append ("<p>Back to parent page ")
								b.append (link (pg.title, view_location, Void))
								b.append (".</p>")
							else
								b.append ("<p>Back to ")
								b.append (link ("parent page", view_location, Void))
								b.append (".</p>")
							end
							if mng.is_default_version then
								set_redirection (mng.wiki_page_uri_path (new_pg, l_bookid, Void))
							else
								set_redirection (mng.wiki_page_uri_path (new_pg, l_bookid, mng.version_id))
							end
						else
							f.append_to_html (wsf_theme, b)
						end
					end
				else
					f.append_to_html (wsf_theme, b)
				end
			else
				b.append ("<h1>")
				b.append (translation ("Access denied", Void))
				b.append ("</h1>")
			end
			set_main_content (b)
		end

	view_location: STRING
		do
			create Result.make_from_string (location)
			if Result.ends_with_general ("/edit") then
				Result.remove_tail (5)
			elseif Result.ends_with_general ("/add-child") then
				Result.remove_tail (10)
			end
		end

feature -- Form	

	edit_form_validate (fd: WSF_FORM_DATA; pg: detachable WIKI_BOOK_PAGE; a_manager: WDOCS_MANAGER; b: STRING)
		local
			l_preview: BOOLEAN
--			l_format: detachable CONTENT_FORMAT
			l_title: detachable READABLE_STRING_32
			l_source: detachable READABLE_STRING_32
			l_xhtml: READABLE_STRING_8
		do
--			if fd.item ("bookid") = Void then
--				fd.report_error ("Missing book name information!")
--			end
			if attached {WSF_STRING} fd.item ("modification_date") as f_date then
				if pg /= Void and then attached pg.path as l_path then
					if file_timestamp (l_path) /= f_date.value.to_integer then
						fd.report_error ("This document was modified by someone else, please " + link ("reload", location, Void) + ".")
					end
				end
			end

			l_preview := attached {WSF_STRING} fd.item ("op") as l_op and then l_op.same_string (translation ("Preview", Void))
			if l_preview then
				b.append ("<strong>Preview</strong><div class=%"preview%">")
				l_title := fd.string_item ("title")
				l_source := fd.string_item ("source")
				if l_title /= Void and l_source /= Void then
					l_xhtml := wiki_to_xhtml (wdocs_api, l_title, l_source, pg, a_manager)
					b.append ("<strong>Title:</strong><div class=%"title%">" + html_encoded (l_title) + "</div>")

					b.append ("<strong>Content:</strong><div class=%"body%">")
					b.append (l_xhtml)
					b.append ("</div>")
				end
				b.append ("</div>")
			else
			end
		end

	edit_form_submit (fd: WSF_FORM_DATA; a_manager: WDOCS_MANAGER; pg: detachable WIKI_BOOK_PAGE; a_bookid: READABLE_STRING_GENERAL; b: STRING)
		local
			l_preview: BOOLEAN
			l_path: detachable PATH
			l_page: detachable WIKI_BOOK_PAGE
			l_link_title_value, l_title_value, l_source_value: detachable READABLE_STRING_8
			l_content: detachable READABLE_STRING_8
			l_changed: BOOLEAN
			l_meta_link_title, l_meta_uuid: detachable READABLE_STRING_32
			s: STRING
			e: CMS_EMAIL
			fn: STRING_32
			ctx: WDOCS_CHANGE_CONTEXT
		do
			l_preview := attached {WSF_STRING} fd.item ("op") as l_op and then l_op.same_string (translation ("Preview", Void))
			if not l_preview then
				debug ("cms")
					across
						fd as c
					loop
						b.append ("<li>" +  html_encoded (c.key) + "=")
						if attached c.item as v then
							b.append (html_encoded (v.string_representation))
						end
						b.append ("</li>")
					end
				end
				l_title_value := safe_utf_8_string (fd.string_item ("title"))
				l_link_title_value := safe_utf_8_string (fd.string_item ("link_title"))
				l_source_value := safe_utf_8_string (fd.string_item ("source"))

				if location.ends_with_general ("/add-child") then
					if l_title_value /= Void and a_bookid /= Void then
						if pg /= Void then
							l_page := pg
							l_page.set_title (l_title_value)
						else
							l_page := wdocs_api.new_wiki_page (l_title_value, utf_8_string (a_bookid))
						end
						l_changed := True
					end
				else
					if pg /= Void then
						l_meta_link_title := pg.metadata ("link_title")
						l_meta_uuid := pg.metadata ("uuid")
						l_path := pg.path
						l_page := pg
						l_content := wdocs_api.wiki_text (pg)
						if attached pg.metadata_table as tb then
							tb.wipe_out
						end
					elseif l_title_value /= Void and a_bookid /= Void then
						l_page := wdocs_api.new_wiki_page (l_title_value, utf_8_string (a_bookid))
						l_changed := True
					end
				end
				if l_page = Void or l_title_value = Void then
					b.append ("<strong>Can not create a new wiki doc. Not enough information!</strong>")
				else
					if l_source_value /= Void then
						l_changed := l_content = Void or else not l_content.same_string (l_source_value)
						l_page.set_text (create {WIKI_CONTENT_TEXT}.make_from_string (l_source_value))
					end
					if not l_page.title.same_string (l_title_value) then
						l_page.set_title (l_title_value)
						l_changed := True
					end
					if l_meta_link_title = Void or else l_meta_link_title.is_whitespace then
						if l_link_title_value /= Void and then not l_link_title_value.is_whitespace then
							l_page.set_metadata (l_link_title_value, "link_title")
							l_changed := True
						end
					else
						if l_link_title_value = Void or else l_link_title_value.is_whitespace then
							l_page.set_metadata (Void, "link_title")
							l_changed := True
						elseif not l_meta_link_title.same_string (l_link_title_value) then
							l_page.set_metadata (l_link_title_value, "link_title")
							l_changed := True
						end
					end
					if l_changed then
						if l_path = Void then
							if attached fd.string_item ("parent") as l_parent then
								if attached a_manager.page_by_title (l_parent, fd.string_item ("bookid")) as l_parent_page then
									l_path := l_parent_page.path
									if l_path /= Void then
										if l_parent_page.is_index_page then
											l_path := l_path.parent
										else
											fn := l_path.name
											if attached l_path.extension as ext then
												fn.remove_tail (1 + ext.count)
											end
											create l_path.make_from_string (fn)
										end
									end
								end
							end
						end
						l_page.update_from_metadata
						create ctx
						ctx.set_user (user)
						ctx.set_log ({STRING_32} "Update wikipage " + l_page.title + ".")

						wdocs_api.save_wiki_page (l_page, pg, l_source_value, l_path, a_bookid, a_manager, ctx)
						if wdocs_api.has_error then
							fd.report_error ("Error: could not save wiki page!")
							add_error_message ("Error: could not save wiki page!")
						else
							create s.make_from_string ("Wiki page %"" + l_page.title + "%" was updated")
							if attached user as u then
								s.append (" (by ")
								s.append (utf_8_string (u.name))
								s.append (")")
							end
							s.append (".")

							-- FIXME: hardcoded link to admin wdocs clear-cache ! change that.
							add_warning_message ("You may need to " + link ("clear the cache", "admin/module/wdocs/clear-cache?destination=" + url_encoded (view_location), Void) + ".")

							api.log ("wdocs", "Wiki page changed", 0, create {CMS_LOCAL_LINK}.make (l_page.title, location))
							add_success_message ("Wiki doc saved.")

							if l_content /= Void then
								e := api.new_email (api.setup.site_email, "Updated wiki page", s + l_content)
							else
								e := api.new_email (api.setup.site_email, "Updated wiki page", s)
							end
							b.append (s)
							b.append_character ('%N')
							api.process_email (e)
--							set_redirection (view_location)
						end
					else
						b.append ("No change.")
					end
				end
			end
		end

	new_edit_form (pg: detachable WIKI_BOOK_PAGE; mng: WDOCS_MANAGER; a_url: READABLE_STRING_8; a_formid: STRING): CMS_FORM
			-- Create a web form named `a_formid' for wiki page `pg' (if set), using form action url `a_url'.
		local
			f: CMS_FORM
			tf: WSF_FORM_TEXTAREA
			f_title, f_link_title: WSF_FORM_TEXT_INPUT
			bt_preview, bt_save: WSF_FORM_SUBMIT_INPUT
			bt_reset: WSF_FORM_RESET_INPUT
			th: WSF_FORM_HIDDEN_INPUT
		do
			create f.make (a_url, a_formid)
			f.set_method_post

			if pg /= Void then
				create th.make ("wiki_location")
				th.set_text_value (location)
				f.extend (th)
			end

			if pg /= Void then
				create f_title.make_with_text ("title", pg.title)
			else
				create f_title.make_with_text ("title", "")
			end
			f_title.set_size (40)
			f_title.set_validation_action (agent (fd: WSF_FORM_DATA)
					do
						if
							not attached fd.string_item ("title") as f_title
							or else f_title.is_whitespace
						then
							fd.report_invalid_field ("title", "Please set the title!")
						end
					end)
--			f_title.set_placeholder ("Enter Page Title")
			f_title.set_label ("Title")
			f_title.set_description ("The page title will be used as wiki name for reference, such as [[WikiName|Text]].")
			f.extend (f_title)

			if pg /= Void and then attached pg.metadata ("link_title") as l_link_title then
				create f_link_title.make_with_text ("link_title", l_link_title)
			else
				create f_link_title.make_with_text ("link_title", "")
			end
			f_link_title.set_label ("Short Title")
			f_link_title.set_description ("Optional short title, used in menu or link.")
			f.extend (f_link_title)

			create tf.make ("source")
			tf.set_cols (90)
			tf.set_rows (25)
			tf.set_description ("[
				<p>
				Put at the beginning of this content, the wiki properties <strong>[[Property:name|value]]</strong> which are used to set metadata such as: uuid, title, link_title, description, weight.
				<ul>
				  <li>[[Property:<strong>title</strong>|A title]]: Wiki page title (<em>set from title field</em>).</li>
				  <li>[[Property:<strong>uuid</strong>|a_uuid_value]]: unique identifier for the wiki page (<em>if none, initialized by the application</em>).</li>
				  <li>[[Property:<strong>link_title</strong>|a short title]]: short version of `title', mostly used in link.</li>
				  <li>[[Property:<strong>description</strong>|A summary of the page]]: description for wiki page, not used for now.</li>
				  <li>[[Property:<strong>weight</strong>|a numeric value]]: weight of the wiki page, it is used to order sibling pages (lower weight is first, upper is last).</li>
				</ul>
				</p>
				<p>Use wikitext formatting to provide the content.</p>
			]")
			tf.set_description_collapsible (False)
			tf.set_label ("Content")
			if pg /= Void then
				if attached wdocs_api.wiki_text (pg) as l_wiki_text then
					tf.set_text_value (utf_32_string (l_wiki_text))
				else
					add_error_message ("Unable to retrieve related wiki text.")
				end
				if attached pg.path as l_path then
					create th.make_with_text ("modification_date", file_timestamp (l_path).out)
					f.extend (th)
				end
			end
			f.extend (tf)

			create bt_preview.make_with_text ("op", translation ("Preview", Void))
			f.extend (bt_preview)

			create bt_save.make_with_text ("op", "Save")
			f.extend (bt_save)

			create bt_reset.make ("reset")
			f.extend (bt_reset)

			populate_form_with_taxonomy (Current, f, pg, mng)

			Result := f
		end

	populate_form_with_taxonomy (a_response: CMS_RESPONSE; a_form: CMS_FORM; a_page: detachable WIKI_PAGE; a_manager: WDOCS_MANAGER)
		local
			c: detachable CMS_WDOCS_CONTENT
		do
			if attached {CMS_TAXONOMY_API} a_response.api.module_api ({CMS_TAXONOMY_MODULE}) as l_taxonomy_api then
				if
					a_page /= Void and then
					attached wdocs_api.wiki_page_uuid (a_page, a_manager.version_id) as l_uuid
				then
					create {CMS_WDOCS_CONTENT} c.make (a_page, l_uuid)
				end
				l_taxonomy_api.populate_edit_form (a_response, a_form, {CMS_WDOCS_CONTENT_TYPE}.name, c)
			end
		end

	safe_utf_8_string (s: detachable READABLE_STRING_GENERAL): detachable STRING
		do
			if s /= Void then
				Result := utf_8_string (s)
			end
		end

	utf_8_string (s: READABLE_STRING_GENERAL): STRING
		local
			utf: UTF_CONVERTER
		do
			Result := utf.utf_32_string_to_utf_8_string_8 (s)
		end

	utf_32_string (s8: READABLE_STRING_8): STRING_32
		local
			utf: UTF_CONVERTER
		do
			Result := utf.utf_8_string_8_to_string_32 (s8)
		end


end
