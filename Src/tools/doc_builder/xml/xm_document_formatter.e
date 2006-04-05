indexing
	description: "XML formatter for DOCUMENTs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XM_LINK_FORMATTER

inherit
	XM_FORMATTER					
		redefine
			process_element
		end

	UTILITY_FUNCTIONS

create
	make_with_document

feature -- Creation

	make_with_document (a_document: DOCUMENT) is
			-- Make with `a_document'
		require
			document_not_void: a_document /= Void
		do
			make
			create links.make (0)
			create images.make (0)
			document := a_document
		end

feature -- Access

	links: ARRAYED_LIST [DOCUMENT_LINK]
			-- Links

	images: ARRAYED_LIST [DOCUMENT_LINK]
			-- Images

	convert_to_relative: BOOLEAN
			-- Should found links be converted to relative links?

	update: BOOLEAN
			-- Should links matching `old_link' be updated to `new_link'?
			
feature -- Status Setting

	set_convert_to_relative (a_flag: BOOLEAN) is
			-- Set `convert_to_relative'
		do
			convert_to_relative := a_flag	
		end		
		
	set_update_data (a_old_link, a_new_link: STRING) is
			-- Convert `a_old_link' links to `a_new_link'
		require
			old_not_void: a_old_link /= void
			new_not_void: a_new_link /= Void
		do
			update := True
			old_link := a_old_link
			new_link := a_new_link
		end		

feature -- Tag

	process_element (e: XM_ELEMENT) is
			-- Process element `e'.
		do	
			Precursor {XM_FORMATTER} (e)
			if link_tag_names.has (e.name) then
				extract_url_from_link (e)
				if convert_to_relative then
					convert_link_to_relative (e)
				end
			end			
		end

feature {NONE} -- Commands

	extract_url_from_link (e: XM_ELEMENT) is
			-- Extract url value from `e' if it exists
		local
			l_element: XM_ELEMENT
			l_url: STRING
			l_link: DOCUMENT_LINK
			l_el_name: STRING
		do
			l_el_name := "url"
			l_element ?= e.element_by_name (l_el_name)
			if l_element /= Void then
				l_url := l_element.text
				if l_url /= Void and then not l_url.is_empty then
					l_url := tidied_string (l_url)
							-- Create document link based on `document' and `e' link
					create l_link.make (document.name, l_url)		
					links.extend (l_link)
					if e.name.is_equal ("image") then
						images.extend (l_link)
					end
				end
			end
		end
		
	convert_link_to_relative (e: XM_ELEMENT) is
			-- Convert link in `e' to relative
		local
			l_element: XM_ELEMENT
			l_url: STRING
			l_link: DOCUMENT_LINK
			l_el_name: STRING
		do
			l_el_name := "url"
			l_element ?= e.element_by_name (l_el_name)
			if l_element /= Void then
				l_url := l_element.text								
				if l_url /= Void and then not l_url.is_empty then					
					l_url := tidied_string (l_url)				
					create l_link.make (document.name, l_url)				
					l_url := l_link.relative_url
					if l_url /= void and then not l_url.is_empty then						
						e.wipe_out
						e.put_first (create {XM_CHARACTER_DATA}.make (e, l_url))	
					end
				end
			end
		end

feature {NONE} -- Implementation

	document: DOCUMENT
			-- Document
			
	link_tag_names: ARRAYED_LIST [STRING] is
			-- List of tags which may contain link or image urls
		once
			create Result.make (3)
			Result.extend ("link")
			Result.extend ("help_link")
			Result.extend ("image")
			Result.compare_objects
		end		

	old_link,
	new_link: STRING;
			-- Old and new links values for updating

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class XM_LINK_FORMATTER
