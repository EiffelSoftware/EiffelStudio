indexing
	description: "DOCUMENT -> File type filter.  Filters DOCUMENTs and creates new content."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FILE_FILTER

inherit
	DOCUMENT_FILTER

feature -- Access

	file_type: STRING is
			-- Type of output file (e.g, html, pdf, etc.)
		deferred
		end

end -- class FILE_FILTER
