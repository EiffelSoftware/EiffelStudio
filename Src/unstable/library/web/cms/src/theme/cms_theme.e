note
	description: "Abstract class describing a generic theme"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_THEME

inherit
	CMS_ENCODERS

	REFACTORING_HELPER


feature {NONE} -- Access

	setup:  CMS_SETUP

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

feature -- Conversion

	menu_html (a_menu: CMS_MENU; is_horizontal: BOOLEAN): STRING_8
		do
			debug ("refactor_fixme")
				fixme ("Refactor HTML code to use the new Bootstrap theme template")
			end
			create Result.make_from_string ("<div id=%""+ a_menu.name +"%" class=%"menu%">")
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
			debug ("refactor_fixme")
				fixme ("Remove HTML from Eiffel")
			end
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
			if cl.is_empty then
				s.append ("<li>")
			else
				s.append ("<li class=%""+ cl + "%">")
			end
			s.append ("<a href=%"" +  (lnk.location) + "%">" + html_encoded (lnk.title) + "</a>")
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
