indexing
	description: "Objects that compress all used ids in Build.%
		%This ensures that they are contiguous."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_ID_COMPRESSOR
	
inherit
	GB_SHARED_OBJECT_HANDLER
	
	GB_SHARED_ID

feature -- Basic operation

	compress_all_id is
			-- Compress all ids used in system, so they
			-- are contiguous.
		require
			no_deleted_items: object_handler.deleted_objects.is_empty
		local
			objects: ARRAYED_LIST [GB_OBJECT]
			counter: INTEGER
			objects_without_ids: BOOLEAN
		do
				-- First, intialization.
			create existing_ids.make (50)
			objects := object_handler.objects
				-- Firstly, store all ids into an array
			objects.do_all (agent record_id)
				-- Now create lookup table.
			create lookup.make (existing_ids.count)
				-- Populate `look_up'.
			from
				counter := 1
			until
				counter > existing_ids.count
			loop
						-- If existing id is 0, then it means that
						-- we are dealing with an old save, and as such there
						-- were no ids in the system, so ignore.
				if existing_ids @ counter /= 0  then
					lookup.extend (counter, existing_ids @ counter)
				else
					objects_without_ids := True
				end
				counter := counter + 1
			end
			
			
			
				-- Now update all ids stored in objects.
			from
				objects.start
			until
				objects.off
			loop
				objects.item.update_internal_id_references (lookup)
				objects.forth
			end
			set_current_id_counter (objects.count + 1)
			
			
				-- Now, if `objects_without_ids' is `True', it means
				-- that some of the objects referenced in the save file
				-- do not have ids (an old save file). So we must now add ids
				-- to all of these objects.
			from
				objects.start
			until
				objects.off
			loop
				if objects.item.id = 0 then
					objects.item.assign_id
				end
				objects.forth
			end
		end
		
	shift_all_ids_upwards is
			-- For every id in system, shift higher.
			-- Used when importing pjects, so we do not get
			-- a clash between the current and new ids.
		local
			objects: ARRAYED_LIST [GB_OBJECT]
		do
			objects := object_handler.objects
			objects.do_all (agent shift_id)
		end
		
	shift_id (an_object: GB_OBJECT) is
				-- Adjust id of `an_object' upwards by 32000.
			require
				an_object_not_void: an_object /= Void
			do
				an_object.set_id (an_object.id + 32000)
			end

	compress_object_id (an_object: GB_OBJECT; start_value: INTEGER) is
			-- Compress all ids of `an_object' and all children, so
			-- they are contiguous, starting at `start_value'.
		local
			objects: ARRAYED_LIST [GB_OBJECT]
			counter: INTEGER
		do
				-- Older systems may contain objects with no ids.
				-- If an object has an id of 0, then it means that
				-- it was originally created before ids were added
				-- to Build
			if an_object.id /= 0 then
				create existing_ids.make (50)
				create objects.make (50)
				objects.extend (an_object)
				an_object.all_children_recursive (objects)
				
					-- Firstly, store all ids into an array
				objects.do_all (agent record_id)
					-- Now create lookup table.
				create lookup.make (existing_ids.count)
					-- Populate `look_up'.
				from
					counter := 1
				until
					counter > existing_ids.count
				loop
					lookup.extend (counter + start_value - 1, existing_ids @ counter)
					counter := counter + 1
				end
	
					-- Now update all ids stored in objects.
				from
					objects.start
				until
					objects.off
				loop
					objects.item.update_internal_id_references (lookup)
					objects.forth
				end
				set_current_id_counter (current_id_counter + objects.count)
			end
		end
		
feature {GB_COMPONENT} -- implementation

	lookup: HASH_TABLE [INTEGER, INTEGER]
			-- All ids original position in `exising_ids',
			-- hashed on the id.
			
	existing_ids: ARRAYED_LIST [INTEGER]
			-- All ids before compression

feature {NONE} -- Implementation
		
		record_id (an_object: GB_OBJECT) is
				-- Add `id' of `an_object' to `existing_ids'.
			do
				existing_ids.extend (an_object.id)
					-- Firstly, store all ids into an array.
			end
			
end -- class GB_ID_COMPRESSOR
