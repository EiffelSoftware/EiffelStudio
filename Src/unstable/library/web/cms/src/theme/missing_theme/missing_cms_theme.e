note
	description: "[
			Theme used when expected theme is missing.
			It is mainly used to report missing theme error.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	MISSING_CMS_THEME

inherit

	CMS_THEME

create
	make

feature {NONE} -- Initialization

	make (a_api: like api; a_info: like information; abs_site_url: READABLE_STRING_8)
		do
			api := a_api
			information := a_info
			set_site_url (abs_site_url)
		ensure
			api_set: api = a_api
		end

feature -- Access

	information: CMS_THEME_INFORMATION

	name: STRING = "missing theme"

	regions: ARRAY [STRING]
		do
			create Result.make_empty
		end

	page_template: CMS_TEMPLATE
			-- theme template page.
		do
			create {MISSING_CMS_TEMPLATE} Result.make (Current)
		end

	page_html (page: CMS_HTML_PAGE): STRING_8
		do
			to_implement ("Add a better response message, maybe using smarty template")
			Result := "Service Unavailable (missing theme!)"
		end
note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
