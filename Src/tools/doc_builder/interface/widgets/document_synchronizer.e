indexing
	description: "Synchronizer for types of document widgets."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_SYNCHRONIZER

inherit
	SHARED_OBJECTS

feature -- Status Setting

	add_document (a_doc: DOCUMENT) is
			-- Add `a_doc'
		do
			if  modified_documents.has (a_doc) then
				modified_documents.prune (a_doc)				
			end
			modified_documents.extend (a_doc)
		end		

feature -- Commands
	
	synchronize is
			-- Synchronize
		do
			Modified_documents.do_all (agent update_toc)
			Modified_documents.wipe_out
		end		

feature -- Implementation

	modified_documents: ARRAYED_LIST [DOCUMENT] is
			-- List of documents that have been modified and need synchronizing at
			-- some point
		once
			create Result.make (3)
		end		

	update_toc (a_doc: DOCUMENT) is
			-- TOC
		do
			if Shared_project.document_toc /= Void then
				Shared_project.document_toc.update_node (a_doc)
			end
		end

end -- class DOCUMENT_SYNCHRONIZER
