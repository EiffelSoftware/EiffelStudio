indexing
	description: "URL Manager functions."
	date: "$Date$"
	revision: "$Revision$"

class
	LINK_MANAGER

create
	default_create,
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
			l_xml_routines: XML_ROUTINES
		do
			if documents /= Void then
				invalid_links.wipe_out
				invalid_files.wipe_out
				create l_xml_routines
				from
					documents.start
				until
					documents.after
				loop
					if l_xml_routines.is_valid_xml (documents.item.text) then					
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
									if not invalid_files.has (l_link.filename) then
										invalid_files.extend (l_link.filename)	
									end									
								end
								l_links.forth
							end
						end	
					end
					documents.forth
				end	
			end					
		end		

	update_links (a_old, a_new: DOCUMENT_LINK) is
			-- Update `documents' so that all references to `a_old' are updated to `a_new'
		require
			old_not_void: a_old /= Void
			new_not_void: a_new /= Void
		local
			l_doc: DOCUMENT
			l_formatter: XM_LINK_FORMATTER
		do
			if documents /= Void then
				from
					documents.start
				until
					documents.after
				loop
					l_doc := documents.item
					create l_formatter.make_with_document (l_doc)
					l_formatter.set_update_data (a_old.filename, a_new.filename)
					l_formatter.process_document (l_doc.xml)				
					documents.forth
				end		
			end
		end

	set_links_relative is
			-- Set links in `documents' to relative links
		local
			l_doc: DOCUMENT
			l_formatter: XM_LINK_FORMATTER
			l_xml_routines: XML_ROUTINES
			l_xm_doc: XM_DOCUMENT
		do
			if documents /= Void then
				create l_xml_routines
				from
					documents.start
				until
					documents.after
				loop
					l_doc := documents.item				
					create l_formatter.make_with_document (l_doc)
					l_formatter.set_convert_to_relative (True)
					l_xm_doc := l_doc.xml
					if l_xm_doc /= Void then					
						-- TO DO
					end
					documents.forth
				end
			end
		end	

feature -- Status Setting

	add_document (a_doc: DOCUMENT) is
			-- Add document to list
		require
			doc_not_void: a_doc /= Void
		do	
			if documents = Void then
				create documents.make (1)
			end
			documents.extend (a_doc)
		ensure
			has_document: documents.has (a_doc)
		end		

feature -- Access

	documents: ARRAYED_LIST [DOCUMENT]
			-- Documents

	invalid_links: ARRAYED_LIST [DOCUMENT_LINK] is
			-- Invalid links, determined by last call to `check_links'
		once
			create Result.make (1)
		end
		
	invalid_files: ARRAYED_LIST [STRING] is
			-- Files containing one or more invalid links
		once
			create Result.make (1)
			Result.compare_objects
		end	
		
	document_links (a_doc: DOCUMENT): ARRAYED_LIST [DOCUMENT_LINK] is
			-- Retrieved links from `a_doc', if any
		require
			document_not_void: a_doc /= Void
		local
			l_formatter: XM_LINK_FORMATTER
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
		local
			l_formatter: XM_LINK_FORMATTER
		do
			create l_formatter.make_with_document (a_doc)
			l_formatter.process_document (a_doc.xml)
			Result := l_formatter.images
		ensure
			has_result: Result /= Void
		end

end -- class LINK_FIXER
