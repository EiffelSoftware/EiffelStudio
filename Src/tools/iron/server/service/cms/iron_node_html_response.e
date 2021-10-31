note
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_HTML_RESPONSE

inherit

	IRON_NODE_CONSTANTS

	WSF_HTML_PAGE_RESPONSE
		rename
			make as make_response
		redefine
			append_html_body_code,
			send_to
		end

	SHARED_TEMPLATE_CONTEXT

create
	make, make_with_body, make_not_permitted, make_not_found

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; a_iron: like iron)
		do
			iron := a_iron
			request := req
			set_status_code ({HTTP_STATUS_CODE}.ok)
			make_response
			add_style (req.absolute_script_url (iron.html_page (iron_version, "style.css")), Void)
			add_javascript_url (req.absolute_script_url (iron.html_page (iron_version, "iron.js")))
--			add_style ("//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css", Void)
--			add_style ("//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap-theme.min.css", Void)
--			add_javascript_url ("//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js")
		end

	make_with_body (b: READABLE_STRING_8; req: WSF_REQUEST; a_iron: like iron)
		do
			make (req, a_iron)
			set_body (b)
		end

	make_not_permitted (req: WSF_REQUEST; a_iron: like iron)
		do
			make (req, a_iron)
			set_body ("Operation not permitted.")
		end

	make_not_found (req: WSF_REQUEST; a_iron: like iron)
		do
			make (req, a_iron)
			set_body ("Resource not found.")
		end

feature -- Access		

	iron: IRON_NODE

	request: WSF_REQUEST

	iron_version: detachable IRON_NODE_VERSION

	iron_version_package: detachable IRON_NODE_VERSION_PACKAGE

	parameters: detachable STRING_TABLE [ANY]
			-- Associated data, mainly for template mode.

feature -- Status report

	is_front: BOOLEAN
			-- Is front page?			

feature -- Change

	set_iron_version (v: like iron_version)
		do
			iron_version := v
		end

	set_iron_version_package (p: like iron_version_package)
		do
			iron_version_package := p
		end

	set_location (v: detachable READABLE_STRING_8)
		do
			if v = Void then
				set_status_code ({HTTP_STATUS_CODE}.ok)
				header.remove_location
			else
				set_status_code ({HTTP_STATUS_CODE}.found)
				header.put_location (v)
			end
		end

	set_is_front (b: BOOLEAN)
		do
			is_front := b
		end

	add_parameter (v: READABLE_STRING_GENERAL; k: READABLE_STRING_8)
		local
			d: like parameters
		do
			d := parameters
			if d = Void then
				create d.make (1)
				parameters := d
			end
			d.force (v, k)
		end

feature -- Messages

	message_type_normal: INTEGER = 0

	message_type_warning: INTEGER = 1

	message_type_error: INTEGER = 2

	add_normal_message (m: READABLE_STRING_8)
		do
			add_message (m, 0)
		end

	add_warning_message (m: READABLE_STRING_8)
		do
			add_message (m, 1)
		end

	add_error_message (m: READABLE_STRING_8)
		do
			add_message (m, 2)
		end

	add_message (m: READABLE_STRING_8; k: INTEGER)
		require
			valid_k: k = message_type_normal or k = message_type_warning or k = message_type_error
		local
			lst: like messages
		do
			lst := messages
			if lst = Void then
				create lst.make (1)
				messages := lst
			end
			lst.force ([m, k])
		end

	messages: detachable ARRAYED_LIST [TUPLE [message: READABLE_STRING_8; kind: INTEGER]]

	menu_items: detachable ARRAYED_LIST [IRON_NODE_HTML_LINK]

	add_menu (a_title: READABLE_STRING_8; a_url: READABLE_STRING_8)
		local
			i: IRON_NODE_HTML_LINK
		do
			create i.make (a_url, a_title)
			add_menu_item (i)
		end

	add_menu_item (lnk: IRON_NODE_HTML_LINK)
		local
			lst: like menu_items
		do
			lst := menu_items
			if lst = Void then
				create lst.make (1)
				menu_items := lst
			end
			lst.force (lnk)
		end

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
		local
			l_version: detachable IRON_NODE_VERSION
			p: PATH
			ut: FILE_UTILITIES
			tpl: TEMPLATE_FILE
			s: STRING
			h: like header
			l_versions_alternatives: ARRAYED_LIST [IRON_NODE_HTML_LINK]
			l_url: READABLE_STRING_8
			l_new_url: STRING_8
			lnk: IRON_NODE_HTML_LINK
			utf: UTF_CONVERTER
		do
			p := iron.layout.html_template_path.extended ("page.tpl")
			if ut.file_path_exists (p) then
				template_context.set_template_folder (iron.layout.html_template_path)
				create tpl.make_from_file (p.name)
				tpl.analyze

				if attached parameters as l_parameters then
					across
						l_parameters as ic
					loop
						tpl.add_value (ic, utf.escaped_utf_32_string_to_utf_8_string_8 (@ ic.key)) -- Conversion to STRING_8 !!
					end
				end

				tpl.add_value (is_front.out, "is_front")

				tpl.add_value (request.absolute_script_url (""), "base_url")
				tpl.add_value (request.request_uri, "current_url")
				if attached iron_version_package as l_iron_version_package then
					tpl.add_value (l_iron_version_package, "current_package")
				end

					-- <head>...
				tpl.add_value (title, "title")
				create s.make_empty
				if attached head_lines as l_lines and then not l_lines.is_empty then
					across l_lines as ic loop
						s.append (ic)
						s.append_character ('%N')
					end
				end
				tpl.add_value (s, "head")

					-- Body data
				tpl.add_value (iron.page_redirection (Void), "redirection_url")
				tpl.add_value ("IRON package repository", "big_title")

				l_version := iron_version
				if l_version /= Void then
					if l_version.is_default then
						l_version := Void
					else
						tpl.add_value (l_version, "iron_version")
					end
				end
				if attached iron.database.versions as l_versions then
					l_versions.reverse_sort
					create l_versions_alternatives.make (0)
					l_url := request.request_uri
					across
						l_versions as c
					loop
						if l_version /= Void then
							create l_new_url.make_from_string (l_url)
							l_new_url.replace_substring_all ("/" + l_version.value + "/", "/" + c.value + "/")
						else
							create l_new_url.make_from_string (iron.page (c, "/"))
						end
						create lnk.make (l_new_url, c.value)
						lnk.set_is_active (l_version ~ c)
						l_versions_alternatives.force (lnk)
					end
					tpl.add_value (l_versions_alternatives, "iron_version_switch_urls")
				end

					-- menu
				tpl.add_value (menu_items, "menu")

					-- main
				create s.make_empty
				append_html_messages_code (s)
				if attached title as t then
					tpl.add_value (t, "page_title")
				end

				if attached body as l_body then
					s.append (l_body)
				end
				tpl.add_value (s, "main")

					-- footer
				create s.make_empty
				append_html_body_footer_code (s)
				tpl.add_value (s, "footer")

				create s.make_empty

				tpl.get_output
				if attached tpl.output as l_output then
					h := header
					res.set_status_code (status_code)
					if not h.has_content_length then
						h.put_content_length (l_output.count)
					end
					if not h.has_content_type then
						h.put_content_type_text_html
					end
					res.put_header_text (h.string)
					res.put_string (l_output)
				else
					Precursor (res)
				end
			else
				Precursor (res)
			end
		end

feature {NONE} -- HTML Generation

	append_html_body_header_code (s: STRING)
		local
			l_version: detachable IRON_NODE_VERSION
			l_form: WSF_FORM
			l_combo: WSF_FORM_SELECT
			l_combo_item: WSF_FORM_SELECT_OPTION
			l_url: READABLE_STRING_8
			l_new_url: STRING_8
		do
			s.append ("IRON package repository")
			l_version := iron_version
			if l_version /= Void and then l_version.is_default then
				l_version := Void
			end
			if attached iron.database.versions as l_versions then
				l_versions.reverse_sort
				create l_form.make (iron.page_redirection (Void), "redirection")
				l_form.set_method_get
				create l_combo.make ("redirection")
				l_url := request.request_uri
				across
					l_versions as c
				loop
					if l_version /= Void then
						create l_new_url.make_from_string (l_url)
						l_new_url.replace_substring_all ("/" + l_version.value + "/", "/" + c.value + "/")
					else
						create l_new_url.make_from_string (iron.page (c, "/"))
					end
					create l_combo_item.make (l_new_url, c.value)
					l_combo_item.set_is_selected (l_version ~ c)
					l_combo.add_option (l_combo_item)
				end
				l_form.extend (l_combo)
				l_combo.add_html_attribute ("onchange", "this.form.submit()")
				l_form.append_to_html (create {WSF_REQUEST_THEME}.make_with_request (request), s)
			end
		end

	append_html_menu_code (s: STRING)
		do
			s.append ("<ul id=%"menu%" class=%"menu%">")
			if attached menu_items as lst then
				across
					lst as c
				loop
					s.append ("<li><a href=%"" + c.url + "%">" + html_encoder.general_encoded_string (c.title) + "</a>")
					if attached c.sub_links as sublst then
						s.append ("<ul>")
						across sublst as ic_sub loop
							s.append ("<li><a href=%"" + ic_sub.url + "%">" + html_encoder.general_encoded_string (ic_sub.title) + "</a>")
						end
						s.append ("</ul>%N")
					end
					s.append ("</li>%N")
				end
			end
			s.append ("</ul>")
		end

	append_html_messages_code (s: STRING)
		do
			if attached messages as lst then
				s.append ("<div id=%"dialog message%"><ul>")
				across
					lst as c
				loop
					s.append ("<li>")
					s.append (c.message)
					s.append ("</li>")
				end
				s.append ("</ul></div>")
			end
		end

	append_html_big_title_code (s: STRING)
		do
			if attached title as l_title then
				s.append ("<h2 class=%"bigtitle%">" + l_title + "</h2>")
			end
		end

	append_html_body_main_code (s: STRING)
		do
			append_html_menu_code (s)
			append_html_messages_code (s)
			append_html_big_title_code (s)
		end

	append_html_body_footer_code (s: STRING)
		do
			s.append ("-- IRON package repository (")
			s.append ("<a href=%"" + request.script_url (iron.api_resource ("/api/")) + "%">API</a>")
			if iron.is_documentation_available then
				s.append (" | ")
				s.append ("<a href=%"" + request.script_url (iron.cms_page ("/doc/")) + "%">Documentation</a>")
			end
			s.append (") -- ")
			s.append ("<br/>version " + version)
		end

	append_html_body_code (s: STRING_8)
		local
			old_body, b: like body
		do
			old_body := body

			create b.make_empty
			b.append ("<div id=%"header%">")
			append_html_body_header_code (b)
			b.append ("</div>")
			b.append ("<div id=%"main%">")
			append_html_body_main_code (b)
			if old_body /= Void then
				b.append (old_body)
			end
			b.append ("</div>")
			b.append ("<div id=%"footer%">")
			append_html_body_footer_code (b)
			b.append ("</div>")
			set_body (b)
			Precursor (s)
			set_body (old_body)
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
