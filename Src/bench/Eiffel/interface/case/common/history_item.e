indexing
	description: "History List Item"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	HISTORY_ITEM

inherit
	EV_LIST_ITEM

creation
	make_with_command

feature -- Initialization

	make_with_command(par: EV_LIST; com: UNDOABLE_EFC) is
			-- Initialize
		require

			parent_exists: par /= Void
			com_valid: com /= Void and then com.name /= Void
		do
			make_with_text(par,com.name)
			--command := com
		end

feature -- Access

	--command: UNDOABLE_EFC

end -- class HISTORY_ITEM
