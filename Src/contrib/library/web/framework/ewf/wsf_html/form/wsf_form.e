note
	description: "Summary description for {WSF_FORM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM

inherit
	WSF_WIDGET

	WSF_FORM_COMPOSITE

	WSF_WITH_HTML_ATTRIBUTE

	WSF_WITH_CSS_ID

	WSF_WITH_CSS_CLASS

	WSF_WITH_CSS_STYLE

create
	make

feature {NONE} -- Initialization

	make (a_action: READABLE_STRING_8; a_id: detachable READABLE_STRING_8)
		do
			action := a_action
			id := a_id
			initialize_with_count (10)
			create html_classes.make (2)
			set_method_post
			create validation_actions
			create submit_actions
		end

feature -- Access

	action: READABLE_STRING_8
			-- URL for the web form

	id: detachable READABLE_STRING_8
			-- Optional id of the form

	is_get_method: BOOLEAN
		do
			Result := method.same_string ("GET")
		end

	is_post_method: BOOLEAN
		do
			Result := not is_get_method
		end

	method: READABLE_STRING_8
			-- Form's method
			--| GET or POST

	encoding_type: detachable READABLE_STRING_8
			-- Encoding type

feature -- Basic operation

	process (req: WSF_REQUEST; a_before_callback, a_after_callback: detachable PROCEDURE [WSF_FORM_DATA])
			-- Process Current form with request `req`,
			-- and build `last_data: WSF_FORM_DATA` object containing the field values.
			-- agent `a_before_callback` is called before the validation
			-- agent `a_after_callback` is called after the validation
		local
			fd: WSF_FORM_DATA
		do
			create fd.make (req, Current)
			last_data := fd
			if a_before_callback /= Void then
				a_before_callback.call ([fd])
			end
			fd.validate
			fd.apply_to_associated_form -- Maybe only when has error?
			if fd.is_valid then
				fd.submit
			end
			if a_after_callback /= Void then
				a_after_callback.call ([fd])
			end
		end

	last_data: detachable WSF_FORM_DATA

feature -- Validation

	validation_actions: ACTION_SEQUENCE [TUPLE [WSF_FORM_DATA]]
			-- Procedure to validate the data
			-- report error if not valid

	submit_actions: ACTION_SEQUENCE [TUPLE [WSF_FORM_DATA]]
			-- Submit actions

feature -- Element change

	set_method_get
		do
			method := "GET"
		end

	set_method_post
		do
			method := "POST"
		end

	set_encoding_type (s: like encoding_type)
		do
			encoding_type := s
		end

	set_multipart_form_data_encoding_type
		do
			encoding_type := "multipart/form-data"
		end

feature -- Optional

	html_classes: ARRAYED_LIST [STRING_8]

feature -- Conversion

	append_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		do
			a_html.append ("<form action=%""+ action +"%"")
			a_html.append (" method=%""+ method +"%"")
			if attached encoding_type as enctype then
				a_html.append (" enctype=%""+ enctype +"%"")
			end
			if attached id as l_id then
				a_html.append (" id=%""+ l_id +"%"")
			end
			append_css_id_to (a_html)
			append_css_class_to (a_html, html_classes)
			append_css_style_to (a_html)
			append_html_attributes_to (a_html)
			a_html.append (">%N")
			across
				items as c
			loop
				c.item.append_to_html (a_theme, a_html)
			end
			a_html.append ("</form>%N")
		end

end
