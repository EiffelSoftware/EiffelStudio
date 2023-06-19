note
	description: "Summary description for {PE_INDEX_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_INDEX_ITEM

inherit
	PE_ITEM

feature -- Access

	index: NATURAL_32
		deferred
		end

feature -- Element change

	update_index (idx: NATURAL_32)
		deferred
		end

end
