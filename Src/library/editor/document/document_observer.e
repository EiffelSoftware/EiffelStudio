indexing
	description	: "Observer for DOCUMENTS"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	DOCUMENT_OBSERVER

feature -- Updates

	on_item_added (a_item: DOCUMENT_ITEM) is
			-- `a_item' has been added
		do
		end

	on_item_removed (a_item: DOCUMENT_ITEM) is
			-- `a_item' has been removed.
		do
		end

	on_update is
			-- Completely recompute the observer state.
		do
		end

end -- class DOCUMENT_OBSERVER
