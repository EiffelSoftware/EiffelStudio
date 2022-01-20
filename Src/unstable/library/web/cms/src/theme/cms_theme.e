note
	description: "Abstract class describing a generic theme"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_THEME

inherit
	CMS_ENCODERS

	CMS_URL_UTILITIES

	REFACTORING_HELPER


feature {NONE} -- Access

	api: CMS_API

	site_url: IMMUTABLE_STRING_8
			-- Absolute URL for Current CMS site.

	base_url: detachable IMMUTABLE_STRING_8
			-- Optional base url of current CMS site.

feature -- Access

	name: STRING
			-- theme name.
		deferred
		end

	regions: ARRAY [STRING]
			-- theme's regions.
		deferred
		end

	page_template: CMS_TEMPLATE
			-- theme template page.
		deferred
		end

feature -- Status report

	has_region (a_region_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Current theme has region `a_region_name' declared?
		do
			Result := across regions as ic some a_region_name.is_case_insensitive_equal (ic.item) end
		end

feature -- Element change

	set_site_url (a_url: READABLE_STRING_8)
			-- Set `site_url' to `a_url'.
		require
			a_url.ends_with_general ("/")
		local
			i,j: INTEGER
		do
			base_url := Void
			if a_url [a_url.count] = '/' then
				create site_url.make_from_string (a_url)
			else
				create site_url.make_from_string (a_url + "/")
			end

			i := a_url.substring_index ("://", 1)
			if i > 0 then
				j := a_url.index_of ('/', i + 3)
				if j > 0 then
					if a_url [a_url.count] = '/' then
						create base_url.make_from_string (a_url.substring (j, a_url.count - 1))
					else
						create base_url.make_from_string (a_url.substring (j, a_url.count))
					end
				end
			end
		ensure
			valid_site_url: site_url.ends_with ("/")
			valid_base_url: attached base_url as e_base_url implies not e_base_url.ends_with ("/")
		end

feature -- Conversion

	menu_html (a_menu: CMS_MENU; is_horizontal: BOOLEAN; a_options: detachable CMS_HTML_OPTIONS): STRING_8
		local
			cl: STRING
		do
			debug ("refactor_fixme")
				fixme ("Refactor HTML code to use the new Bootstrap theme template")
			end
			create cl.make_from_string ("menu")
			if a_options /= Void and then attached a_options.css_classes as lst then
				across
					lst as ic
				loop
					cl.append_character (' ')
					cl.append (ic.item)
				end
			end
			create Result.make_from_string ("<div id=%"")
			Result.append (a_menu.name)
			Result.append ("%" class=%"")
			Result.append (cl)
			Result.append ("%">")
			if is_horizontal then
				Result.append ("<ul class=%"horizontal%" >%N")
			else
				Result.append ("<ul class=%"vertical%" >%N")
			end
			across
				a_menu as c
			loop
				append_cms_link_to (c.item, Result)
			end
			Result.append ("</ul>%N")
			Result.append ("</div>")
		end

	block_html (a_block: CMS_BLOCK): STRING_8
		local
			s: STRING
		do
			debug ("refactor_fixme")
				fixme ("Refactor HTML code to use the new Bootstrap theme template")
			end
			if a_block.is_raw then
				create s.make_empty
				if attached a_block.title as l_title then
					s.append ("<div class=%"title%">" + html_encoded (l_title) + "</div>")
				end
				s.append (a_block.to_html (Current))
			else
				create s.make_from_string ("<div class=%"block%" id=%"block-" + a_block.name + "%">")
				if attached a_block.title as l_title then
					s.append ("<div class=%"title%">" + html_encoded (l_title) + "</div>")
				end
				s.append ("<div class=%"inside%">")
				s.append (a_block.to_html (Current))
				s.append ("</div>")
				s.append ("</div>")
			end
			Result := s
		end

	page_html (page: CMS_HTML_PAGE): STRING_8
			-- Render `page' as html.
		deferred
		end

feature {NONE} -- Implementation

	append_cms_link_to (lnk: CMS_LINK; s: STRING_8)
		local
			cl: STRING
		do
			if not lnk.is_forbidden then
				create cl.make_empty
				if lnk.is_active then
					cl.append ("active ")
				end
				if lnk.is_expandable then
					cl.append ("expandable ")
				end
				if lnk.is_expanded then
					cl.append ("expanded ")
				end
				cl := lnk.extended_css_class (cl).to_string_8
				if cl.is_empty then
					s.append ("<li>")
				else
					s.append ("<li class=%""+ cl + "%">")
				end
				s.append ("<a href=%"")
				s.append (url (lnk.location, Void))
				s.append ("%">")
				s.append (html_encoded (lnk.title))
				s.append ("</a>")
				if
					(lnk.is_expanded or lnk.is_collapsed) and then
					attached lnk.children as l_children
				then
					s.append ("<ul>%N")
					across
						l_children as c
					loop
						append_cms_link_to (c.item, s)
					end
					s.append ("</ul>")
				end
				s.append ("</li>")
			end
		end

note
	copyright: "2011-2022, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
