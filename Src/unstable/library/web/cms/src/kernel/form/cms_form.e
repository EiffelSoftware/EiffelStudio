note
	description: "Summary description for {CMS_FORM}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FORM

inherit
	WSF_FORM
		rename
			process as process_form
		redefine
			append_to_html
		end

create
	make

feature -- Access

	before_widgets: detachable ARRAYED_LIST [WSF_WIDGET]
			-- Optional widget before the Current form.

	after_widgets: detachable ARRAYED_LIST [WSF_WIDGET]
			-- Optional widget after the Current form.

feature -- Element change

	put_widget_before_form (w: WSF_WIDGET)
		local
			lst: like before_widgets
		do
			lst := before_widgets
			if lst = Void then
				create lst.make (1)
				before_widgets := lst
			end
			lst.extend (w)
		end

	put_widget_after_form (w: WSF_WIDGET)
		local
			lst: like after_widgets
		do
			lst := after_widgets
			if lst = Void then
				create lst.make (1)
				after_widgets := lst
			end
			lst.extend (w)
		end

feature -- Conversion

	append_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		do
			if attached before_widgets as lst then
				across
					lst as ic
				loop
					ic.item.append_to_html (a_theme, a_html)
				end
			end
			Precursor (a_theme, a_html)
			if attached after_widgets as lst then
				across
					lst as ic
				loop
					ic.item.append_to_html (a_theme, a_html)
				end
			end
		end

feature -- Basic operation

	process (a_response: CMS_RESPONSE_I)
		do
			if attached {CMS_RESPONSE} a_response as rep_cms then
				process_cms_response (rep_cms)
			else
					-- FIXME: check webapi for hook need!
				process_form (a_response.request, Void, Void)
			end
		end

feature -- CMS response

	prepare (a_response: CMS_RESPONSE)
		do
			a_response.api.hooks.invoke_form_alter (Current, Void, a_response)
		end

	process_cms_response (a_response: CMS_RESPONSE)
		do
			process_form (a_response.request, agent on_prepared (a_response, ?), agent on_processed (a_response, ?))
		end

	on_prepared (a_response: CMS_RESPONSE; fd: WSF_FORM_DATA)
		do
			a_response.api.hooks.invoke_form_alter (Current, fd, a_response)
		end

	on_processed (a_response: CMS_RESPONSE; fd: WSF_FORM_DATA)
		do
			if not fd.is_valid or fd.has_error then
				a_response.report_form_errors (fd)
			end
		end

feature -- Helpers

	extend_text_field (a_name: READABLE_STRING_8; a_text: detachable READABLE_STRING_GENERAL)
			-- Extend new text field `a_name` with value `a_text`.
		local
			tf: WSF_FORM_TEXT_INPUT
		do
			if a_text /= Void then
				create tf.make_with_text (a_name, a_text.as_string_32)
			else
				create tf.make (a_name)
			end
			extend (tf)
		end

	extend_password_field (a_name: READABLE_STRING_8; a_text: detachable READABLE_STRING_GENERAL)
			-- Extend new password field `a_name` with value `a_text`.
		local
			tf: WSF_FORM_PASSWORD_INPUT
		do
			if a_text /= Void then
				create tf.make_with_text (a_name, a_text.as_string_32)
			else
				create tf.make (a_name)
			end
			extend (tf)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
