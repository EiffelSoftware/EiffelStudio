indexing
	description: "Abstraction of a SymDocumentWriter"
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_DOCUMENT_WRITER

inherit
	COM_OBJECT
		export
			{DBG_WRITER} item
		end

create
	make_by_pointer

end -- class DBG_DOCUMENT_WRITER
