note
	description: "Summary description for {WSF_CMS_THEME}."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_CMS_THEME

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

	response: detachable CMS_RESPONSE

	cms_theme: CMS_THEME

feature -- Element change

	set_response (a_response: CMS_RESPONSE)
		do
			response := a_response
		end

feature -- Core

	site_url: READABLE_STRING_8
		do
			if attached response as r then
				Result := r.site_url
			else
				Result := request.absolute_script_url ("")
			end
		end

	base_url: detachable READABLE_STRING_8
			-- Base url if any.
		do
			if attached response as r then
				Result := r.base_url
			end
		end

end
