note
	description: "Summary description for {CMS_PAGE_TEMPLATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEFAULT_CMS_PAGE_TEMPLATE

inherit
	CMS_PAGE_TEMPLATE

	DEFAULT_CMS_TEMPLATE

create
	make

feature {NONE} -- Initialization

	make (t: DEFAULT_CMS_THEME)
		do
			theme := t
			create variables.make (0)
		end

	variables: STRING_TABLE [detachable ANY]

feature -- Access

	theme: DEFAULT_CMS_THEME

	prepare (page: CMS_HTML_PAGE)
		do
			variables.make (10)

			across
				page.variables as ic
			loop
				variables.force (ic.item, ic.key)
			end

			if attached page.title as l_title then
				variables.force (l_title, "title")
			else
				variables.force ("", "title")
			end
			across
				theme.regions as r
			loop
				variables.force (page.region (r.item), r.item)
			end
		end

	to_html (page: CMS_HTML_PAGE): STRING
		do
			-- Process html generation
			create Result.make_from_string (template)
			apply_template_engine (Result)
		end

feature -- Registration

	register (v: STRING_8; k: STRING_8)
		do
			variables.force (v, k)
		end

feature {NONE} -- Implementation

	template: STRING
		once
			Result := "[
				<div id="page-wrapper">
					<div id="page">
						<div id="header">
						$header
						</div>
						<div id="main-wrapper">
							<div id="main">
								<div id="first_sidebar" class="sidebar $first_sidebar_css_class">$first_sidebar</div>
								<div id="content" class="$content_css_class">$content</div>
								<div id="second_sidebar" class="sidebar $second_sidebar_css_class">$second_sidebar</div>
							</div>
						</div>
						<div id="footer">$footer</div>
					</div>
				</div>
			]"
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
