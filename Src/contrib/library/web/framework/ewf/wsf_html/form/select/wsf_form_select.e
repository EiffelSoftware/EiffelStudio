note
	description: "Summary description for {WSF_FORM_SELECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM_SELECT

inherit
	WSF_FORM_FIELD

	WSF_FORM_UTILITY

	WSF_WITH_HTML_ATTRIBUTE

create
	make

feature {NONE} -- Initialization

	make (a_name: like name)
		do
			name := a_name
			create options.make (0)
		end

feature -- Access

	options: ARRAYED_LIST [WSF_FORM_SELECT_OPTION]

feature -- Element change

	set_text_by_value (a_text: detachable READABLE_STRING_GENERAL)
		local
			opt: WSF_FORM_SELECT_OPTION
			l_found: BOOLEAN
			v: READABLE_STRING_8
		do
			if a_text /= Void then
				v := html_encoded_string (a_text)
				across
					options as o
				loop
					if o.item.is_same_value (v) then
						l_found := True
						o.item.set_is_selected (True)
					else
						o.item.set_is_selected (False)
					end
				end
				if not l_found then
					create opt.make (v, Void)
					opt.set_is_selected (True)
					add_option (opt)
				end
			else
				across
					options as o
				loop
					o.item.set_is_selected (False)
				end
			end
		end

	select_value_by_text (a_text: detachable READABLE_STRING_GENERAL)
		local
			l_found: BOOLEAN
			v: READABLE_STRING_8
		do
			if a_text /= Void then
				v := html_encoded_string (a_text)
				across
					options as o
				loop
					if o.item.is_same_text (v) then
						l_found := True
						o.item.set_is_selected (True)
					else
						o.item.set_is_selected (False)
					end
				end
			else
				across
					options as o
				loop
					o.item.set_is_selected (False)
				end
			end
		end

	set_value (v: detachable WSF_VALUE)
		do
			if attached {WSF_STRING} v as s then
				set_text_by_value (s.value)
			else
				set_text_by_value (Void)
			end
		end

	add_option (opt: WSF_FORM_SELECT_OPTION)
		do
			options.force (opt)
		end

feature -- Conversion

	append_item_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		local
			l_is_already_selected: BOOLEAN
			h: detachable STRING_8
			l_item_html_text: READABLE_STRING_8
		do
			a_html.append ("<select name=%""+ name +"%" ")
			if css_id = Void then
				set_css_id (name + "-select")
			end
			append_css_class_to (a_html, Void)
			append_css_id_to (a_html)
			append_css_style_to (a_html)
			append_html_attributes_to (a_html)

			if is_readonly then
				a_html.append (" readonly=%"readonly%" />")
			else
				a_html.append ("/>")
			end

			across
				options as o
			loop
				a_html.append ("<option value=%"" + html_encoded_string (o.item.value) + "%" ")
--				if not l_is_already_selected then
					if
						o.item.is_selected
					then
						l_is_already_selected := True
						a_html.append (" selected=%"selected%"")
					end
--				end
				l_item_html_text := html_encoded_string (o.item.text)
				a_html.append (">" + l_item_html_text + "</option>%N")
				if attached o.item.description as d then
					if h = Void then
						create h.make_empty
					end
					h.append ("<div id=%"" + name + "-" + html_encoded_string (o.item.value) + "%" class=%"option%"><strong>"+ l_item_html_text +"</strong>:"+ d + "</div>")
				end
			end
			a_html.append ("</select>%N")
			if h /= Void then
				a_html.append ("<div class=%"select help collapsible%" id=%"" + name + "-help%">" + h + "</div>%N")
			end
		end

end
