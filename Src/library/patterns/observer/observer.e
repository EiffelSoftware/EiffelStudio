indexing
	description: "Observer of an entity."
	author: "Reda Kolli & Pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OBSERVER

feature -- Update 

	update is
			-- Update Current when the entity is possibly modified.
		deferred
		end

end -- class OBSERVER
