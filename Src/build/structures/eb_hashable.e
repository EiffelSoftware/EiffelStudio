indexing
	description: "General notion of hashable."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class EB_HASHABLE

inherit
	HASHABLE

feature -- Access

	same (other: like Current): BOOLEAN is
		deferred
		end

end -- class EB_HASHABLE

