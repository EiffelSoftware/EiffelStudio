indexing
	description	: "Observer for DOCUMENTS"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DOCUMENT_OBSERVER
