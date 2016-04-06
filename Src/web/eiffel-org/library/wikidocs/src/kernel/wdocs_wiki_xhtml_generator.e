note
	description: "Summary description for {WDOCS_WIKI_XHTML_GENERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_WIKI_XHTML_GENERATOR

inherit
	WIKI_XHTML_GENERATOR
		redefine
			make,
			page_title,
			visit_structure,
			visit_link,
			visit_missing_link
		end

create
	make

feature {NONE} -- Initialization

	make (b: like buffer)
		do
			Precursor (b)
			create interwiki_mappings.make (0)
			set_is_auto_toc_enabled (True)
		end

feature -- Setting

	overridden_title: detachable READABLE_STRING_8

	interwiki_mappings: STRING_TABLE [READABLE_STRING_8]
			-- handling of interwiki links indexed by name.
			-- For example [[wp:Name]] .
			--| examples:
			--|		Wikipedia: wp   | http://en.wikipedia.org/wiki/$1
			--|		DevEiffelCom: dev | http://dev.eiffel.com/$1
			--|		StaticReference: ref | isedoc/static/$1
			--|		UuidReference: uuid | isedoc/uuid/$1
			--|		Local file: file | sites/default/files/$1


feature -- Page processing

	visit_page_with_title (a_page: WIKI_PAGE; a_title: READABLE_STRING_8)
		do
			overridden_title := a_title
			visit_page (a_page)
			overridden_title := Void
		end

	visit_structure (a_structure: WIKI_STRUCTURE)
		local
			utf: UTF_CONVERTER
		do
			Precursor (a_structure)
			if 
				attached current_page as pg and then
				attached pg.metadata ("uuid") as l_uuid
			then
				output ("<div class%"uuid%">")
				output (utf.utf_32_string_to_utf_8_string_8 (l_uuid))
				output ("</div>")
			end
		end		

	visit_link (a_link: WIKI_LINK)
			-- <Precursor>
		local
			l_css_class: STRING
			l_url: STRING

			l_link_name: READABLE_STRING_8
			l_link_arg: READABLE_STRING_8
			l_interwiki_location: detachable STRING_8
		do
			l_link_name := a_link.name
			if l_link_name.has (':') then
				across
					interwiki_mappings as ic
				until
					l_interwiki_location /= Void
				loop
					if l_link_name.starts_with_general (ic.key.as_string_8 + ":") then
						create l_interwiki_location.make_from_string (ic.item)
						l_link_arg := l_link_name.substring (ic.key.count + 2, l_link_name.count)
						l_interwiki_location.replace_substring_all ("$1", l_link_arg)
					end
				end
			end
			if l_interwiki_location /= Void then
				create l_css_class.make_from_string ("wiki_external") -- TODO: "wiki_link")
				if attached a_link.fragment as l_fragment then
					l_url := l_interwiki_location + "#" + l_fragment
				else
					l_url := l_interwiki_location
				end
				output ("<a href=%"" + l_url + "%" class=%"" + l_css_class + "%">")
				a_link.text.process (Current)
				output ("</a>")
			else
				Precursor (a_link)
			end
		end

	visit_missing_link (a_link: WIKI_LINK)
			-- <Precursor>
		do
			Precursor (a_link)
		end

feature -- Helper

	page_title (a_page: WIKI_PAGE): STRING_8
			-- Title for page `a_page'.
		do
			if attached overridden_title as t then
				Result := t
			else
				Result := a_page.title
			end
		end

end
