indexing
	description: "Simple search dialog."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SEARCH_DIALOG

inherit
	SEARCH_DIALOG_IMP

	SHARED_OBJECTS
		undefine
			copy, 
			default_create
		end

create
	make,
	default_create
	
feature -- Initialization

	make (a_document: DOCUMENT_TEXT_WIDGET) is
			-- Create for searching within `a_document'
		require
			a_document_not_void: a_document /= Void
		do
			default_create
			document := a_document
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			find_but.select_actions.extend (agent search)
			cancel_but.select_actions.extend (agent hide)
		end
		
feature -- Status Setting

	set_document (a_document: DOCUMENT_TEXT_WIDGET) is
			-- Set `document' to `a_document'
		require
			document_nt_void: a_document /= Void
		do
			document := a_document			
		end

feature {NONE} -- Implementation

	document: DOCUMENT_TEXT_WIDGET
			-- Document

	search is
			-- Search for text in 'search_text' and highlight in 
			-- `document' if found.  If not found load message dialog
		do
			if not search_text.text.is_empty and then document.text.has_substring (search_text.text) then
				document.highlight_substring (search_text.text)		
			end
		end
	
end -- class SEARCH_DIALOG

