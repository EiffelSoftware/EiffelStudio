note
	description: "Theme from the EWF framework, but dedicated for the CMS."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_TO_WSF_THEME

inherit
	WSF_THEME

create
	make

feature {NONE} -- Initialization

	make (res: CMS_RESPONSE; a_cms_theme: CMS_THEME)
		do
			request := res.request
			cms_theme := a_cms_theme
			set_response (res)
		end

feature -- Access

	request: WSF_REQUEST

	response: CMS_RESPONSE

	cms_theme: CMS_THEME

feature -- Element change

	set_response (a_response: CMS_RESPONSE)
			-- Set `response' to `a_response'.
		do
			response := a_response
		end

feature -- Core

	site_url: READABLE_STRING_8
			-- CMS site url.
		do
			Result := response.site_url
		end

	base_url: detachable READABLE_STRING_8
			-- Base url if any.
		do
			Result := response.base_url
		end

end
