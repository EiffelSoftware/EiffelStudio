indexing
	description: "URL Manager functions."
	date: "$Date$"
	revision: "$Revision$"

class
	LINK_MANAGER

inherit
	GENERATOR
	
	UTILITY_FUNCTIONS

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

	run (a_old, a_new: DOCUMENT_LINK; a_rel, a_abs: BOOLEAN) is
			-- Run link manager based on argument options.
		require
			old_link_not_void_implies_new_link_not_void: a_old /= Void implies a_new /= void
			new_link_not_void_implies_old_link_not_void: a_new /= Void implies a_old /= void
			exclusive_rel_or_abs: a_rel implies not a_abs and a_abs implies not a_rel
		do
			if a_old /= Void then
				old_link := a_old
				new_link := a_new
				update := True
			else
				update := False
			end
			if a_rel or a_abs then
				convert_relative := a_rel
				convert_absolute := a_abs
			end
			generate
		end		

feature -- Access

	documents: ARRAYED_LIST [DOCUMENT]
			-- Documents

feature {NONE} -- Implementation

	old_link: DOCUMENT_LINK
			-- Old Link
			
	new_link: DOCUMENT_LINK
			-- New Link

	update: BOOLEAN
			-- Update links?
	
	convert_relative: BOOLEAN
			-- Convert links to relative?
	
	convert_absolute: BOOLEAN
			-- Convert links to absolute?

	progress_title: STRING is "Processing Documents Links"
			-- Progress Title
			
	upper_range_value: INTEGER is
			-- Upper range value
		do
			Result := documents.count
		end

	internal_generate is
			-- Empty generate since has more than 1 generation option
		local
			l_doc: DOCUMENT
		do
			from
				documents.start
			until
				documents.after
			loop
				l_doc := documents.item
				if update then
					l_doc.update_link (old_link, new_link)
				end
				if convert_relative then
					l_doc.set_links_relative
				elseif convert_absolute then
					l_doc.set_links_absolute
				end				
				documents.forth
				update_progress_report
			end
		end		

invariant
	has_documents: documents /= Void

end -- class LINK_FIXER
