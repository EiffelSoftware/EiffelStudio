note
	description: "[
		Abstract interface for a CMS Template, as part of the theme design.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_TEMPLATE

feature -- Access

	theme: CMS_THEME
			-- Associated theme.
		deferred
		end

	variables: STRING_TABLE [detachable ANY]
			-- Variables used for Current template rendering.
		deferred
		end

	prepare (page: CMS_HTML_PAGE)
			-- Prepare `page' with current template.
		deferred
		end

	to_html (page: CMS_HTML_PAGE): STRING
			-- HTML rendering for page `page'.
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
