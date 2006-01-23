indexing
	description: "Eiffel Vision item id. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ID_IMP

feature {NONE} -- Initialization

	make_id is
			-- Generate new ID and assign it to `id'.
		do
			id := counter.item
			counter.set_item (id + 1)
		end

feature -- Access

	id: INTEGER
			-- Unique identifier within system.

feature {NONE} -- Implementation

	counter: INTEGER_REF is
			-- Counter to set unique id's to items.
		once
			create Result
			Result.set_item (1)
		end

invariant
	make_called: id > 0

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




end -- class EV_ID_IMP

