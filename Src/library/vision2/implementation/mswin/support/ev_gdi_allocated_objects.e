--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		" EiffelVision utility used to retrieve an allocated WEL item. %
		% This class has been created in order to decrease the number of %
		% GDI object allocated "
	status: "See notice at end of class"
	id: "$Id:"
	date: "$Date:"
	revision: "$Revision:"

class
	EV_GDI_ALLOCATED_OBJECTS[G->HASHABLE]

inherit
	ANY
		redefine
			default_create
		end

creation
	default_create

feature -- Initialization

	default_create is
			-- Default initialization feature
		do
				-- Allocate space for 10 objects.
			create allocated_objects.make (10)
		end

feature {NONE} -- Implementation

	allocated_objects: HASH_TABLE[G,G]

	total_cache: INTEGER
			-- debugging purpose

	successful_cache: INTEGER
			-- debugging purpose

end -- class EV_GDI_ALLOCATED_OBJECTS
