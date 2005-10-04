indexing
	description: "Objects that is used for transport one object from object grid to object graph."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_OBJECT_STONE

inherit
	MA_STONE

create
	make

feature {NONE} -- Initlization
	make (a_object: ANY) is
			-- Creation method
		require
			a_object_not_void: a_object /= Void
		do
			internal_object := a_object
		ensure
			a_object_set: a_object = internal_object
		end
		
feature -- Access

	object: like internal_object is 
			-- `internal_object'
		do
			Result := internal_object
		end

feature {NONE} -- Implementation
	
	internal_object: ANY
			-- The object be transported

end
