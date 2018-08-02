note
	description: "Summary description for {WDOCS_TYPE_WEBFORM_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_TYPE_WEBFORM_MANAGER

inherit
	CMS_CONTENT_TYPE_WEBFORM_MANAGER [CMS_WDOCS_CONTENT]
		rename
			make as old_make
		redefine
			content_type
		end

create
	make

feature {NONE} -- Initialization

	make (a_type: like content_type; a_wdocs_api: WDOCS_API)
		do
			wdocs_api := a_wdocs_api
			old_make (a_type)
		end

feature -- Access

	content_type: CMS_WDOCS_CONTENT_TYPE
			-- Associated content type.	

	wdocs_api: WDOCS_API
			-- Associated wdocs api.

	cms_api: CMS_API
			-- API for current instance of CMS.
		do
			Result := wdocs_api.cms_api
		end

feature -- Conversion		

	append_content_as_html_to (a_content: CMS_WDOCS_CONTENT; is_teaser: BOOLEAN; a_output: STRING; a_response: CMS_RESPONSE)
			-- Append `a_content' as html to `a_output', and adapt output according to `is_teaser' (full output, or teaser).
			-- In the context of optional `a_response'.
		do
			if
				attached {CMS_TAXONOMY_API} cms_api.module_api ({CMS_TAXONOMY_MODULE}) as l_taxonomy_api
			then
				l_taxonomy_api.append_taxonomy_to_xhtml (a_content, a_response, a_output)
			end
		end

end
