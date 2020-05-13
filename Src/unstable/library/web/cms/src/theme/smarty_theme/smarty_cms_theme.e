note
	description: "Smarty template CMS theme."
	date: "$Date$"
	revision: "$Revision$"

class
	SMARTY_CMS_THEME

inherit
	CMS_THEME

create
	make

feature {NONE} -- Initialization

	make (a_api: like api; a_info: like information; abs_site_url: READABLE_STRING_8)
		do
			api := a_api
			information := a_info
			if attached a_info.item ("template_dir") as s then
				templates_directory := a_api.theme_location.extended (s)
			else
				templates_directory := a_api.theme_location
			end
			set_site_url (abs_site_url)
		ensure
			api_set: api = a_api
			information_set: information = a_info
		end

feature -- Access

	name: STRING = "smarty-CMS"

	templates_directory: PATH

	information: CMS_THEME_INFORMATION

	regions: ARRAY [STRING]
		local
			i: INTEGER
			l_regions: like internal_regions
		do
			l_regions := internal_regions
			if l_regions = Void then
				if attached information.regions as tb and then not tb.is_empty then
					i := 1
					create l_regions.make_filled ("", i, i + tb.count - 1)
					across
						tb as ic
					loop
						l_regions.force (utf_8_encoded (ic.key), i) -- NOTE: UTF-8 encoded !
						i := i + 1
					end
				else
					l_regions := <<"top","header", "highlighted","help", "content", "footer", "first_sidebar", "second_sidebar", "bottom">>
				end
				internal_regions := l_regions
			end
			Result := l_regions
		end

	page_template: SMARTY_CMS_PAGE_TEMPLATE
		local
			tpl: like internal_page_template
		do
			tpl := internal_page_template
			if tpl = Void then
				create tpl.make ("page", Current)
				internal_page_template := tpl
			end
			Result := tpl
		end

feature -- Conversion

	prepare (page: CMS_HTML_PAGE)
		do
			page.register_variable (page, "page")
			page.register_variable (page.regions, "regions")
			across
				page.regions as ic
			loop
				page.register_variable (ic.item, {STRING_32} "region_" + ic.key.to_string_32)
			end
		end

	page_html (page: CMS_HTML_PAGE): STRING_8
		local
			l_page_inspector: detachable SMARTY_CMS_HTML_PAGE_INSPECTOR
			l_regions_inspector: detachable SMARTY_CMS_REGIONS_INSPECTOR
			l_table_inspector: detachable STRING_TABLE_OF_STRING_INSPECTOR
		do
			prepare (page)
			create l_page_inspector.register (page.generating_type.name)

			if attached {CMS_RESPONSE} page.variables.item ("cms") as l_cms then
				if attached l_cms.regions as l_regions then
					create l_regions_inspector.register (l_regions.generating_type.name)
				end
			end

			create l_table_inspector.register (({detachable STRING_TABLE [STRING_8]}).name)
			create l_table_inspector.register (({detachable STRING_TABLE [STRING_32]}).name)
			create l_table_inspector.register (({detachable STRING_TABLE [READABLE_STRING_8]}).name)
			create l_table_inspector.register (({detachable STRING_TABLE [READABLE_STRING_32]}).name)

			page_template.prepare (page)
			Result := page_template.to_html (page)

				-- Clean template inspector.
			if l_regions_inspector /= Void then
				l_regions_inspector.unregister
			end
			if l_page_inspector /= Void then
				l_page_inspector.unregister
			end
			l_table_inspector.unregister
		end

feature {NONE} -- Internal

	internal_regions: detachable like regions

	internal_page_template: detachable like page_template

invariant
	attached internal_page_template as inv_p implies inv_p.theme = Current
note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
