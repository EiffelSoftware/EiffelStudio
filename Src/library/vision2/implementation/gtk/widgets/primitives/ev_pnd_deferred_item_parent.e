indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PND_DEFERRED_ITEM_PARENT

feature {EV_ANY_I} -- Implementation

	row_from_y_coord (a_y: INTEGER): EV_PND_DEFERRED_ITEM is
			-- Retrieve the Current row from `a_y' coordinate
		deferred
		end

end -- class EV_PND_DEFERRED_ITEM_PARENT
