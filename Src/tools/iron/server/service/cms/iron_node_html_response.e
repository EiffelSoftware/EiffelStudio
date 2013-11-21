note
	description: "Summary description for {IRON_NODE_HTML_RESPONSE}."
	author: ""
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
			append_html_body_code
		end

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

	iron: IRON_NODE

	request: WSF_REQUEST

	iron_version: detachable IRON_NODE_VERSION

feature -- Access

	location: detachable READABLE_STRING_8
			-- Redirected location if any.

feature -- Change

	set_iron_version (v: like iron_version)
		do
			iron_version := v
		end

	set_location (v: like location)
		do
			if v = Void then
				set_status_code ({HTTP_STATUS_CODE}.ok)
				header.remove_location
			else
				set_status_code ({HTTP_STATUS_CODE}.found)
				header.put_location (v)
			end
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

	menu_items: detachable ARRAYED_LIST [TUPLE [title: READABLE_STRING_32; url: READABLE_STRING_8]]

	add_menu (a_title: READABLE_STRING_32; a_url: READABLE_STRING_8)
		local
			lst: like menu_items
		do
			lst := menu_items
			if lst = Void then
				create lst.make (1)
				menu_items := lst
			end
			lst.force ([a_title, a_url])
		end

feature {NONE} -- HTML Generation

	append_html_body_code (s: STRING_8)
		local
			old_body, b: like body
			h, f: STRING
			l_version: detachable IRON_NODE_VERSION
			l_form: WSF_FORM
			l_combo: WSF_FORM_SELECT
			l_combo_item: WSF_FORM_SELECT_OPTION
			l_url: READABLE_STRING_8
			l_new_url: STRING_8
		do
			h := "<div id=%"page%"><div id=%"header%"> IRON package repository"
			l_version := iron_version
			if l_version /= Void and then l_version.is_default then
				l_version := Void
			end
			if l_version /= Void and attached iron.database.versions as l_versions then
				create l_form.make (iron.page_redirection (Void), "redirection")
				l_form.set_method_get
				create l_combo.make ("redirection")
				l_url := request.request_uri
				across
					l_versions as c
				loop
					if l_version /= Void then
						create l_new_url.make_from_string (l_url)
						l_new_url.replace_substring_all ("/" + l_version.value + "/", "/" + c.item.value + "/")
					else
						create l_new_url.make_from_string (iron.page (c.item, "/"))
					end
					create l_combo_item.make (l_new_url, c.item.value)
					l_combo_item.set_is_selected (l_version ~ c.item)
					l_combo.add_option (l_combo_item)
				end
				l_form.extend (l_combo)
				l_combo.add_html_attribute ("onchange", "this.form.submit()")
				l_form.append_to_html (create {WSF_REQUEST_THEME}.make_with_request (request), h)
			end
			h.append ("</div>")
			h.append ("<ul id=%"menu%" class=%"menu%">")
			if attached menu_items as lst then
				across
					lst as c
				loop
					h.append ("<li><a href=%"" + c.item.url + "%">" + html_encoder.encoded_string (c.item.title) + "</a></li>%N")
				end
			end
			h.append ("</ul>")
			h.append ("<div id=%"main%">")
			if attached messages as lst then
				h.append ("<div id=%"dialog message%"><ul>")
				across
					lst as c
				loop
					h.append ("<li>")
					h.append (c.item.message)
					h.append ("</li>")
				end
				h.append ("</ul></div>")
			end
			if attached title as l_title then
				h.append ("<h2 class=%"bigtitle%">" + html_encoded_string (l_title) + "</h2>")
			end
			f := "</div><div id=%"footer%"> -- IRON package repository ("
			f.append ("<a href=%"" + request.script_url (iron.cms_page ("/api/")) + "%">API</a>")
			if iron.is_documentation_available then
				f.append (" | ")
				f.append ("<a href=%"" + request.script_url (iron.cms_page ("/doc/")) + "%">Documentation</a>")
			end
			f.append (") -- ")
			f.append ("<br/>version " + version)
			f.append ("</div></div>")
			old_body := body
			if old_body /= Void then
				create b.make (h.count + old_body.count + f.count)
				b.append (h)
				b.append (old_body)
				b.append (f)
			else
				create b.make (h.count + f.count)
				b.append (h)
				b.append (f)
			end
			set_body (b)
			Precursor (s)
			set_body (old_body)
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
