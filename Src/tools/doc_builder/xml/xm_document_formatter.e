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

create
	make_with_document

feature -- Access

	make_with_document (a_document: DOCUMENT) is
			-- Make with `a_document'
		require
			document_not_void: a_document /= Void
		do
			make
			document := a_document
		end

	process_element (e: XM_ELEMENT) is
			-- Process element `e'.
		local
			cnt: INTEGER
			l_text: STRING
			typer: XM_NODE_TYPER
			a_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			l_el: XM_ELEMENT
		do	
			if link_tag_names.has (e.name) then
				extract_url_from_link (e)
			end
			Precursor {XM_FORMATTER} (e)
		end

feature {DOCUMENT} -- Status Setting

	set_links (a_old, a_new: DOCUMENT_LINK) is
			-- Update all links in Current to `a_old' to link to `a_new'
		require
			old_link_not_void: a_old /= Void
			new_link_not_void: a_new /= Void
		do
			old_link := a_old
			new_link := a_new
		end

feature {NONE} -- Commands

	extract_url_from_link (e: XM_ELEMENT) is
			-- Extract url value from `e' if it exists
		local
			l_element: XM_ELEMENT
			l_file: RAW_FILE
			l_url: STRING
			l_link: DOCUMENT_LINK
			l_el_name, l_new_link: STRING
		do
			l_el_name := "url"
			l_element ?= e.element_by_name (l_el_name)
			if l_element /= Void then			
				l_url := l_element.text
				if l_url /= Void and then not l_url.is_empty then
					create l_link.make (document.name, l_url)
					if document.do_update_link then
						if l_link.matches (old_link) then
							l_element.wipe_out
							l_new_link := new_link.format (l_link.format_type)
							if l_new_link /= Void then
								l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, l_new_link))	
							end
						end
					else
						document.add_link (l_link)
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

	old_link: DOCUMENT_LINK
			-- Old link
	
	new_link: DOCUMENT_LINK
			-- New link

end -- class XM_DOCUMENT_FORMATTER
