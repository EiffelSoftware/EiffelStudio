indexing
	description: 
		" EiffelVision utility used to retrieve an allocated WEL item. %
		% This class has been created in order to decrease the number of %
		% GDI object allocated."
	date: "$Date:"
	revision: "$Revision:"

class
	EV_GDI_ALLOCATED_OBJECTS [G -> EV_GDI_OBJECT]

inherit
	ANY
		redefine
			default_create
		end

creation
	default_create

feature -- Initialization

	default_create is
			-- Default initialization feature.
		do
				-- Allocate space for `Max_allocated_objects' objects.
			create allocated_objects.make (1, Max_allocated_objects)
		end

feature {NONE} -- Implementation

	allocated_objects: ARRAY [G]
			-- Sorted array (The most used item at the end of the array)
			-- of all objects located in `allocated_objects'.

	allocated_objects_number: INTEGER
			-- Current number of allocated pens.

	found_object_index: INTEGER
			-- Index of the last object found by `has_object'.

	cache_time: INTEGER
			-- Current time, used to compute for each object the date of the last access.

	successful_cache: INTEGER
			-- debugging purpose

	index_lightest_object: INTEGER
			-- Index of the lightest object.

	has_object (an_object: EV_GDI_OBJECT): BOOLEAN is
			-- Is `an_object' in `allocated_objects'?
		local
			i: INTEGER
			object_hash_code: INTEGER
			curr_item: G
			curr_item_value: INTEGER
			previous_item_value: INTEGER
			index_item_to_remove: INTEGER
			value_item_to_remove: INTEGER
		do
			found_object_index := 0
		
			from
				i := 1
				value_item_to_remove := 2147483646
				object_hash_code := an_object.hash_code
			until
				found_object_index /= 0 or else i > allocated_objects_number
			loop
				curr_item := allocated_objects.item(i)
				if (object_hash_code = curr_item.hash_code) and then
					an_object.is_equal (curr_item)
				then
					found_object_index := i
				else
						-- Can't find the object, so track the element to
						-- be deleted in case a new cell is required.
					curr_item_value := curr_item.value
					if curr_item_value < value_item_to_remove then
						value_item_to_remove := curr_item_value
						index_item_to_remove := i
					end

						-- Swap Current and Previous if they are not ordered.
					if (i > 1) and then (curr_item_value > previous_item_value) then
						swap_allocated_objects (i, i-1)
						if index_item_to_remove = i then
							index_item_to_remove := i - 1
						end
						if index_item_to_remove = i-1 then
							index_item_to_remove := i
						end
					end
				end
					-- Prepare next iteration
				i := i + 1
				previous_item_value := curr_item_value
			end
			Result := (found_object_index /= 0)

			if not Result then
				-- We will delete an object, update the needed fields
				index_lightest_object := index_item_to_remove
			end
		end

	add_to_allocated_objects (new_object: G) is
			-- Add `new_object' to the array of allocated objects.
		local
			index_new_item: INTEGER
		do
			check
				not (allocated_objects_number > Max_allocated_objects)
			end
			if allocated_objects_number = Max_allocated_objects then
				index_new_item := index_lightest_object
					-- Free the object that will be replaced...				
				allocated_objects.item (index_new_item).delete
			else
				allocated_objects_number := allocated_objects_number + 1
				index_new_item := allocated_objects_number
			end

				-- ..and we add it in our array.
			allocated_objects.put (new_object, index_new_item)

			debug("VISION2_WINDOWS_GDI")
				io.putstring("created ")
			end
		end

	get_previously_allocated_object (real_object_index: INTEGER): WEL_GDI_ANY is
			-- Retrieve the WEL object located in the array at index `real_object_index'.
		local
			real_object: G
		do
				-- Requested pen has been already allocated. We return the
				-- item found in our table.
			real_object := allocated_objects.item (real_object_index)
			real_object.update (cache_time)

			Result := real_object.item
			Result.increment_reference

			debug("VISION2_WINDOWS_GDI")
				successful_cache := successful_cache + 1
				io.putstring("retrieved cached version ")
			end
		end

	swap_allocated_objects (first_index, second_index: INTEGER) is
			-- Swap objects at indexes `first_index' and `second_index'.
		require
			valid_first_index: 
				first_index >= 1 and then 
				first_index <= allocated_objects_number
			valid_second_index: 
				second_index >= 1 and then 
				second_index <= allocated_objects_number
		local
			first_object: G
			second_object: G
		do
			first_object := allocated_objects.item (first_index)
			second_object := allocated_objects.item (second_index)
			
			allocated_objects.put (first_object, second_index)
			allocated_objects.put (second_object, first_index)
		end

feature {NONE} -- Constants

	Max_allocated_objects: INTEGER is 15
			-- Maximum number of allocated objects we keep.

end -- class EV_GDI_ALLOCATED_OBJECTS

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.5  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.4  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.6.7  2001/02/25 18:20:24  pichery
--| Renammed debug clause
--|
--| Revision 1.3.6.6  2000/10/24 15:27:25  pichery
--| Improved the cache system for caching GDI objects. It now
--| takes into account the date of the last access to the object.
--|
--| Revision 1.3.6.5  2000/10/16 14:27:35  pichery
--| Improved WEL_BRUSH and WEL_PEN caching
--|
--| Revision 1.3.6.4  2000/10/12 18:50:05  manus
--| Cosmetics.
--|
--| Revision 1.3.6.3  2000/08/11 19:12:43  rogers
--| Fixed copyright clause. Now use ! instead of |. Formatting.
--|
--| Revision 1.3.6.2  2000/08/03 17:55:45  rogers
--| Comments. Added copyright and CVS log.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
