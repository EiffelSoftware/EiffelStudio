indexing
	description: "URL Manager functions.  Will perform url checking and conversion%
		%functions on alist of documents."
	date: "$Date$"
	revision: "$Revision$"

class
	LINK_MANAGER

inherit	
	UTILITY_FUNCTIONS
	
	SHARED_OBJECTS

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
			-- Options: 	a_old, a_new: old and new link values.
			--				a_rel: make all links in `documents' relative
			--				a_abs: make all links in `documents' absolute
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
			progress_generator.set_title ("Link Processing")
			progress_generator.set_procedure (agent generate)
			progress_generator.set_upper_range (documents.count)
			progress_generator.generate
		end		

	check_links is
			-- Check all links in `documents'
		do
			do_check := True
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
			
	do_check: BOOLEAN
			-- Check document links to see if they exist?
	
	convert_relative: BOOLEAN
			-- Convert links to relative?
	
	convert_absolute: BOOLEAN
			-- Convert links to absolute?

	generate is
			-- Generation
		local
			l_doc: DOCUMENT
		do
					-- Prepare error report for any errors
			if error_report /= Void then
				error_report.clear
			else
				create error_report.make_empty ("Invalid Links")
			end
					-- Traverse `documents' and perform necessary commands
			from
				documents.start
			until
				documents.after
			loop
				l_doc := documents.item
				progress_generator.set_status_text (l_doc.name)				
				if update then
					l_doc.update_link (old_link, new_link)
				end
				if convert_relative then
					l_doc.set_links_relative
				elseif convert_absolute then
					l_doc.set_links_absolute
				end
				if do_check then
					l_doc.check_links
					if not l_doc.invalid_links.is_empty then
						error_report.append_report (l_doc.invalid_links)
					end
				end
				documents.forth
				progress_generator.update_progress_report
			end
		end		

	error_report: ERROR_REPORT
			-- Error Report

invariant
	has_documents: documents /= Void

end -- class LINK_FIXER
