indexing
	description: "State editors manager."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class ST_EDITOR_MGR 

inherit
	EDITOR_MGR
		redefine
			editor_type, clear_editor
		end

creation
	make
	
feature {NONE}

	editor_type: STATE_EDITOR

	clear_editor (ed: like editor_type) is
		do
			ed.clear
		end

end -- class ST_EDITOR_MGR

