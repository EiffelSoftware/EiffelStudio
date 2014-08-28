note
	description: "Summary description for {CMS_CONTENT_BLOCK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_CONTENT_BLOCK

inherit
	CMS_BLOCK

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_title: like title; a_body: like body; a_format: like format)
		do
			is_enabled := True
			name := a_name
			title := a_title
			body := a_body
			format := a_format
		end

feature -- Access

	name: READABLE_STRING_8

	title: detachable READABLE_STRING_32

	body: READABLE_STRING_8

	format: CMS_FORMAT

feature -- Conversion

	to_html (a_theme: CMS_THEME): STRING_8
		do
			Result := format.to_html (body)
		end

invariant

end
