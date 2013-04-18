note
	description: "Summary description for {IRON_REPO_HTML_RESPONSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPO_HTML_RESPONSE

inherit
	IRON_REPO_CONSTANTS

	WSF_HTML_PAGE_RESPONSE
		rename
			make as make_response
		redefine
			append_html_body_code
		end

create
	make

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; a_iron: like iron)
		local
			css: CSS_TEXT
			css_style: CSS_STYLE
		do
			iron := a_iron
			request := req
			set_status_code ({HTTP_STATUS_CODE}.ok)

			make_response

			create css.make
			create css_style.make_with_string ("margin: 5px 0 5px 0;")
			css_style.put_background_color ("#ddddff")
			css.add_selector_style ("body", css_style)

			create css_style.make
			css_style.put_key_value ("margin", "auto")
			css_style.put_width ("800px")
			css_style.put_height ("auto")
			css_style.put_border ("left", "solid", "1px", "#ccf")
			css_style.put_border ("right", "solid", "1px", "#ccf")
			css_style.put_background_color ("#fff")
			css.add_selector_style ("div#page", css_style)

			create css_style.make
			css_style.put_padding ("5px", "5px", "5px", "15px")
--			css_style.put_border ("right", "solid", "1px", "#ccf")
			css.add_selector_style ("div#main", css_style)

			create css_style.make
--			css_style.put_border ("right", "solid", "1px", "#ccf")
			css.add_selector_style ("#menu", css_style)


			create css_style.make
			css_style.put_text_decoration_none
			css_style.put_font_bold
			css_style.put_color ("#009")
			css.add_selector_style ("a", css_style)

			create css_style.make
			css_style.put_text_decoration_underline
			css.add_selector_style ("a:hover", css_style)

			create css_style.make_with_string ("[
							-webkit-border-radius: 20px;
							-webkit-border-top-left-radius: 0;
							-webkit-border-bottom-right-radius: 0;
							-moz-border-radius: 20px;
							-moz-border-radius-topleft: 0;
							-moz-border-radius-bottomright: 0;
							border-radius: 20px;
							border-top-left-radius: 0;
							border-bottom-right-radius: 0;
						]")
			css_style.append ("margin-bottom: 20px; padding: 20px; font-size: 140%%; border: solid 1px #00f; color: #fff; background-color: #009; text-align: center;")
			css_style.put_key_value ("position", "relative")
			css_style.put_margin_top ("30px")
			css_style.put_key_value ("top", "-20px")

			css.add_selector_style ("div#header", css_style)

			create css_style.make_with_string ("[
							-webkit-border-radius: 20px;
							-webkit-border-top-left-radius: 0;
							-webkit-border-top-right-radius: 0;
							-moz-border-radius: 20px;
							-moz-border-radius-topleft: 0;
							-moz-border-radius-topright: 0;
							border-radius: 20px;
							border-top-left-radius: 0;
							border-top-right-radius: 0;
						]")
			css_style.append ("border-top: dotted 1px #00f; background-color: #cfcfdf; text-align: center; min-height: 40px; padding: 5px;")
			css_style.put_key_value ("position", "relative")
--			css_style.put_margin_top ("30px")
			css_style.put_key_value ("bottom", "-20px")

			css.add_selector_style ("div#footer", css_style)

			create css_style.make
			css_style.put_padding_left ("30px")
			css.add_selector_style ("ul", css_style)

			create css_style.make
			css_style.put_list_style ("none")
			css_style.put_border ("top", "solid", "1px", "#dedede")
			css_style.put_border ("left", "solid", "1px", "#dedede")
			css_style.put_padding ("4px", "5px", "5px", "4px")
			css_style.put_margin_bottom ("5px")
			css.add_selector_style ("ul li.package", css_style)

			create css_style.make
			css_style.put_padding ("3px", "3px", "3px", "3px")
			css_style.put_border (Void, "solid", "2px", "#00f")
			css.add_selector_style ("ul li.package:hover", css_style)

			create css_style.make_with_string ("padding-left: 25px;")
			css.add_selector_style ("ul li.package div.description", css_style)
			css.add_selector_style ("ul li.package div.archive", css_style)

			css.add_selector_style (".error", "background-color: red;")
			css.add_selector_style (".warning", "background-color: orange;")
			css.add_selector_style (".dialog.message", "border: solid 1px #aa6; margin: 5px auto 5px auto; padding: 10px; width: 80%%; background-color: #ffc;")

			css.add_selector_style ("span.packageid", "float: right; font-style: italic; color: #ccc;")
			create css_style.make
			css_style.put_padding ("20px", "20px", "20px", "20px")
			css.add_selector_style ("div.description", css_style)

			css.add_selector_style ("ul.menu", "list-style-type: none;")
			css.add_selector_style ("ul.menu li", "display: inline; border: solid 1px #900; padding: 2px 5px 2px 5px;")
			css.add_selector_style ("ul.menu li:hover", "background-color: #FF9;")

			head_lines.force ("<style type=%"text/css%">" + css.string + "</style>%N")
		end

	iron: IRON_REPO

	request: WSF_REQUEST

	iron_version: detachable IRON_REPO_VERSION

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
			h,f: STRING
			l_version: detachable IRON_REPO_VERSION
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
			f := "</div><div id=%"footer%"> -- IRON package repository (<a href=%""+ request.script_url ("/access/api/") +"%">API</a>) -- "
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

end
