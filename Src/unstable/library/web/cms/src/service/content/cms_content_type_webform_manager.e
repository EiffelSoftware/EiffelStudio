note
	description: "[
				Html builder for content type `content_type'.
				This is used to build webform and html output for a specific node, or node content type.
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_CONTENT_TYPE_WEBFORM_MANAGER [G -> CMS_CONTENT]

inherit
	CMS_API_ACCESS

feature {NONE} -- Initialization

	make (a_type: like content_type)
		do
			content_type := a_type
		end

feature -- Access

	content_type: CMS_CONTENT_TYPE
			-- Associated content type.

	name: READABLE_STRING_8
			-- Associated content type name.
		do
			Result := content_type.name
		end

feature -- Conversion		

	append_content_as_html_to (a_content: G; is_teaser: BOOLEAN; a_output: STRING; a_response: CMS_RESPONSE)
			-- Append `a_content' as html to `a_output', and adapt output according to `is_teaser' (full output, or teaser).
			-- In the context of optional `a_response'.
		deferred
		end

	append_formatted_content_to (a_content: READABLE_STRING_GENERAL; a_format: CONTENT_FORMAT; a_output: STRING)
			-- Format string `a_content' with format `a_format', and append to `a_output'.
		do
			a_format.append_formatted_to (a_content, a_output)
		end

note
	copyright: "2011-2018, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
