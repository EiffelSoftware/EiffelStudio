indexing
	description: "Objects that represent stones carrying a GB_OBJECT that is already in existence in the project"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_STANDARD_OBJECT_STONE
	
inherit
	GB_OBJECT_STONE
		redefine
			object
		end
		
create
	make_with_object
	
feature {NONE} -- Initialization

	make_with_object (an_object: GB_OBJECT) is
			-- Create `current' and assifgn `an_object' to `internal_object'.
		require
			an_object_not_void: an_object /= Void
		local
			all_instance_objects: ARRAYED_LIST [GB_OBJECT]
		do
			internal_object := an_object
			if an_object.is_instance_of_top_level_object then
				associated_top_level_object := an_object.associated_top_level_object
			end

				-- Now must store all instances of nested objects within `an_object'.
			create all_instance_objects.make (20)
			an_object.all_children_recursive (all_instance_objects)
			all_instance_objects.extend (an_object)
			create all_contained_instances.make (10)
			from
				all_instance_objects.start
			until
				all_instance_objects.off
			loop
				if all_instance_objects.item.is_instance_of_top_level_object then
						-- By using `put', we ensure that there is only a single entry for each
						-- instance of a top level object.
					all_contained_instances.put (all_instance_objects.item.associated_top_level_object, all_instance_objects.item.associated_top_level_object)
				end
				all_instance_objects.forth
			end
		ensure
			object_set: internal_object = an_object
		end

feature -- Access

	object: GB_OBJECT is
			-- Object which `Current' is representing.
			-- As this obbject already exists for this type of
			-- pebble, it may be called as often as required with no slow down.
		do
			Result := internal_object
		end
		
	object_type: STRING is
			
		do
			Result := internal_object.type
		end

feature {NONE} -- Implementation

	internal_object: GB_OBJECT

end -- class GB_STANDARD_OBJECT_STONE