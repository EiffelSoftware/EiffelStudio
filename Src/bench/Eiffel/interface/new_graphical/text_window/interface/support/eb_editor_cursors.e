indexing
	description: "EiffelStudio cursors for the editor"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EB_EDITOR_CURSORS

inherit
	EDITOR_CURSORS
	
	EB_SHARED_CURSORS
		export
			{NONE} all
		end

create
	default_create

end -- class EB_EDITOR_CURSORS
