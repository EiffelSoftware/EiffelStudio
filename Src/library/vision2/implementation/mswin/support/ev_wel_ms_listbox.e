indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_MS_LISTBOX

inherit
	WEL_MULTIPLE_SELECTION_LIST_BOX
		export
			{EV_LIST_IMP} all
		end
	
	EV_WEL_LISTBOX

creation
	make, make_by_id

end -- class EV_WEL_MS_LISTBOX
