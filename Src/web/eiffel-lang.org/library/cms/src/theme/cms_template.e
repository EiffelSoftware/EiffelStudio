note
	description: "Summary description for {WSF_CMS_PAGE_TEMPLATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_TEMPLATE

feature -- Access

	theme: CMS_THEME
		deferred
		end

	variables: STRING_TABLE [detachable ANY]
		deferred
		end

	prepare  (page: CMS_HTML_PAGE)
		deferred
		end

	to_html (page: CMS_HTML_PAGE): STRING
		deferred
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
