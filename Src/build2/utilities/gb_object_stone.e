indexing
	description: "Objects that represent stones for transport which carry a GB_OBJECT"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_OBJECT_STONE

feature -- Access

	object: GB_OBJECT is
			-- Object which `Current' is representing.
		deferred
		end
		
	object_type: STRING is
			-- EiffelVision2 Type of object represented.
		deferred
		end
		
	is_instance_of_top_level_object: BOOLEAN is
			-- Does `object' represent a top level object?
		do
			Result := associated_top_level_object > 0
		end
	
	associated_top_level_object: INTEGER
		-- The id of the top level object `Current' represents,
		-- or `0' if NONE.

end -- class GB_OBJECT_STONE
