indexing
	description: "XML formatter for DOCUMENTs."
	date: "$Date$"
	revision: "$Revision$"

class
	XM_DOCUMENT_FORMATTER

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

feature -- Tag

	process_element (e: XM_ELEMENT) is
			-- Process element `e'.
		do	
			if link_tag_names.has (e.name) then
				extract_url_from_link (e)
			end
			Precursor {XM_FORMATTER} (e)
		end

feature {NONE} -- Commands

	extract_url_from_link (e: XM_ELEMENT) is
			-- Extract url value from `e' if it exists
		local
			l_element: XM_ELEMENT
			l_url: STRING
			l_link: DOCUMENT_LINK
			l_el_name, l_new_link: STRING
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

end -- class XM_DOCUMENT_FORMATTER
