indexing
	description: "URL Manager functions."
	date: "$Date$"
	revision: "$Revision$"

class
	LINK_MANAGER

create
	make_with_documents

feature -- Creation

	make_with_documents (a_documents: ARRAYED_LIST [DOCUMENT]) is
			-- Create with list
		require
			documents_not_void: a_documents /= Void
		do
			documents := a_documents
		ensure
			documents_set: documents /= Void
		end

feature -- Commands

	check_links is
			-- Check links in `documents'.  Put invalid links into `invalid_links'.
		local
			l_link: DOCUMENT_LINK
			l_links: like document_links
		do
			invalid_links.wipe_out
			from
				documents.start
			until
				documents.after
			loop
				if documents.item.is_valid_xml then					
					l_links := document_links (documents.item)
					if not l_links.is_empty then
						from
							l_links.start
						until
							l_links.after
						loop							
							l_link := l_links.item
							if not l_link.exists then
								invalid_links.extend (l_link)
							end
							l_links.forth
						end
					end	
				end
				documents.forth
			end			
		end		

	update_links (a_old, a_new: DOCUMENT_LINK) is
			-- Update `documents' so that all references to `a_old' are updated to `a_new'
		require
			old_not_void: a_old /= Void
			new_not_void: a_new /= Void
		local
			l_doc: DOCUMENT
		do
			from
				documents.start
			until
				documents.after
			loop
				l_doc := documents.item	
				documents.forth
			end		
		end

	set_links_relative is
			-- Set links in `documents' to relative links
		local
			l_doc: DOCUMENT
			l_doc_links: ARRAYED_LIST [DOCUMENT_LINK]
		do
			from
				documents.start
			until
				documents.after
			loop
				l_doc := documents.item
				l_doc_links := document_links (l_doc)
				documents.forth
			end
		end
		
	set_links_absolute is
			-- Set links in `documents' to absolute links
		local
			l_doc: DOCUMENT
			l_doc_links: ARRAYED_LIST [DOCUMENT_LINK]
		do
			from
				documents.start
			until
				documents.after
			loop
				l_doc := documents.item
				l_doc_links := document_links (l_doc)
				documents.forth
			end
		end		

feature -- Access

	documents: ARRAYED_LIST [DOCUMENT]
			-- Documents

	invalid_links: ARRAYED_LIST [DOCUMENT_LINK] is
			-- Invalid links, determined by last call to `check_links'
		once
			create Result.make (1)
		end
		
	document_links (a_doc: DOCUMENT): ARRAYED_LIST [DOCUMENT_LINK] is
			-- Retrieved links from `a_doc', if any
		require
			document_not_void: a_doc /= Void
			document_valid: a_doc.is_valid_xml
		local
			l_formatter: XM_DOCUMENT_FORMATTER
		do
			create l_formatter.make_with_document (a_doc)
			l_formatter.process_document (a_doc.xml)
			Result := l_formatter.links
		ensure
			has_result: Result /= Void
		end

	document_images (a_doc: DOCUMENT): ARRAYED_LIST [DOCUMENT_LINK] is
			-- Retrieved images from `a_doc', if any
		require
			document_not_void: a_doc /= Void
			document_valid: a_doc.is_valid_xml
		local
			l_formatter: XM_DOCUMENT_FORMATTER
		do
			create l_formatter.make_with_document (a_doc)
			l_formatter.process_document (a_doc.xml)
			Result := l_formatter.images
		ensure
			has_result: Result /= Void
		end

invariant
	has_documents: documents /= Void

end -- class LINK_FIXER
