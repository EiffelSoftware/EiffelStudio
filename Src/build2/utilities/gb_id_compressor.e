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
		export
			{NONE} all
		end
	
	GB_CONSTANTS
		export
			{NONE} all
		end

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
			current_object: GB_OBJECT
		do
				-- First, intialization.
			create existing_ids.make (50)
			objects := object_handler.objects.linear_representation
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
			
				-- Clear all existing objects.			
			object_handler.objects.clear_all
			
				-- Now update all ids stored in objects.
			from
				objects.start
			until
				objects.off
			loop
				current_object := objects.item
				current_object.update_internal_id_references (lookup)
			
					-- Now place object back in `objects' as it's id has changed.
				object_handler.objects.extend (current_object, current_object.id)
					
				objects.forth
			end
			set_current_id_counter (objects.count + 1)
			
			
				-- Now, if `objects_without_ids' is `True', it means
				-- that some of the objects referenced in the save file
				-- do not have ids (an old save file). So we must now add ids
				-- to all of these objects.
				--| FIXME
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
			-- Used when importing projects, so we do not get
			-- a clash between the current and new ids.
		local
			linear_objects: LINEAR [GB_OBJECT]
		do
			linear_objects := object_handler.objects.linear_representation
			from
				linear_objects.start
			until
				linear_objects.off
			loop
				shift_id (linear_objects.item)
				shift_referer_ids (linear_objects.item)
				linear_objects.forth
			end
		end
		
	shift_object_ids_updwards (an_object: GB_OBJECT) is
			-- For `an_object' and all child objects recursively, shift their
			-- ids upwards by `amount_to_shift_ids_during_import'.
		require
			an_object_not_void: an_object /= Void
			is_new_object: not object_handler.objects.has_item (an_object) and not object_handler.deleted_objects.has_item (an_object)
			no_instance_referers: an_object.instance_referers.is_empty
		local
			recursive_children: ARRAYED_LIST [GB_OBJECT]
			current_object: GB_OBJECT
		do
			an_object.set_id (an_object.id + amount_to_shift_ids_during_import)
			create recursive_children.make (50)
			an_object.all_children_recursive (recursive_children)
			from
				recursive_children.start
			until
				recursive_children.off
			loop
				current_object := recursive_children.item
				current_object.set_id (current_object.id + amount_to_shift_ids_during_import)
				recursive_children.forth
			end
		end

	shift_referer_ids (an_object: GB_OBJECT) is
			-- For all `instance_referers' of `an_object', shift their
			-- ids upwards by `amount_to_shift_ids_during_import'.
		require
			an_object_not_void: an_object /= Void
		local
			linear: LINEAR [INTEGER]
			new_value: INTEGER
		do
			linear := an_object.instance_referers.linear_representation
				-- Remove all entries from the `instance_referers'.
			an_object.instance_referers.clear_all
			from
				linear.start
			until
				linear.off
			loop
				new_value := linear.item + amount_to_shift_ids_during_import
					-- Insert the new referer back into `instance_referers'.
				an_object.instance_referers.extend (new_value, new_value)
				linear.forth
			end
		ensure
			instance_referers_count_not_changed: old an_object.instance_referers.count = an_object.instance_referers.count
		end

	shift_id (an_object: GB_OBJECT) is
			-- Adjust id of `an_object' upwards by `amount_to_shift_ids_during_import'.
		require
			an_object_not_void: an_object /= Void
			object_already_exists: object_handler.objects.has (an_object.id) or object_handler.deleted_objects.has (an_object.id)
		local
			in_objects: BOOLEAN
		do
			in_objects := object_handler.objects.has (an_object.id)
			if in_objects then
				object_handler.objects.remove (an_object.id)
			else
				object_handler.deleted_objects.remove (an_object.id)
			end
			an_object.set_id (an_object.id + amount_to_shift_ids_during_import)
			if in_objects then
				object_handler.objects.put (an_object, an_object.id)
			else
				object_handler.deleted_objects.put (an_object, an_object.id)
			end
		end

	compress_object_id (an_object: GB_OBJECT; start_value: INTEGER) is
			-- Compress all ids of `an_object' and all children, so
			-- they are contiguous, starting at `start_value'.
		require
			an_object_not_void: an_object /= Void
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
		require
			an_object_not_void: an_object /= Void
		do
			existing_ids.extend (an_object.id)
				-- Firstly, store all ids into an array.
		ensure
			added: existing_ids.has (an_object.id)
		end
			
end -- class GB_ID_COMPRESSOR
