indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	MT_OBJECT_TABLE [G->MT_OBJECT, H->INTEGER]

inherit
	HASH_TABLE[G, H]
		redefine
			accommodate,
			internal_search,
			search_for_insertion,
			put_at_position,
			occupied
		end

creation
	make


feature

	accommodate (n: INTEGER) is
			-- Reallocate table with enough space for `n' items;
			-- keep all current items.
		local
			i: INTEGER
			--other: like Current
			other: MT_OBJECT_TABLE [G, H]
			default_key: H
		do
				-- (Could also use iteration facilities.)
			from
				!! other.make (count.max (n))
			until
				i = capacity
			loop
				if occupied (i) then
					check
						not other.soon_full
							-- See invariant clause `sized_generously_enough'
					end
					other.put (content.item (i), keys.item (i))
				end
				i := i + 1
			end

			if has_default then
				other.put (content.item (capacity), default_key)
			end

			set_content (other.content)
			set_keys (other.keys)
			set_deleted_marks (other.deleted_marks)

			capacity := other.capacity
			used_slot_count := count
			iteration_position := other.iteration_position
			if other.has_default then
				set_default
			else
				set_no_default
			end
		end
	
feature {NONE} -- Implementation

	internal_search (key: H) is
			-- Require key /= 0
		local
			increment: INTEGER
			stop: BOOLEAN
		do
			deleted_position := Impossible_position
			from
				increment := position_increment (key)
				position := initial_position (key)
			until
				stop
			loop
				if deleted (position) then
					if deleted_position = Impossible_position then
						deleted_position := position
					end
					to_next_candidate (increment)
				elseif keys.item (position) = 0 then
					stop := True;
					set_not_found
				elseif keys.item (position) = key then
					stop := True;
					set_found
				else
					to_next_candidate (increment)
				end
			end
		end

	search_for_insertion (key: H) is
			-- Assuming there is no item of key `key', compute
			-- `position' at which to insert such an item.
		local
			increment: INTEGER
		do
			from
				increment := position_increment (key);
				position := initial_position (key)
			until
				deleted (position) or keys.item (position) = 0
			loop
				to_next_candidate (increment)
			end
		end

	put_at_position(new: G; key: H) is
		do
			content.put (new, position)
			keys.put (key, position)
		end
	
	occupied(i: INTEGER): BOOLEAN is
		do
			Result := keys.item (i) /= 0
		end



feature -- Check

	check_content is
		local
			a_count,upper, i, a_key: INTEGER
			an_obj: MT_OBJECT
		do
			upper := keys.upper
			from 
				i := 0
			until 
				i > upper
			loop
				a_key := keys.item (i)
				an_obj := content.item (i)
				if a_key = 0 then
					if an_obj /= Void then
						print ("%NCheck_content: Non-Void Error!!")
					end
				else
					if a_key /= an_obj.oid then
						print ("%NCheck_content: Non-matching Error!!")
					end
					a_count := a_count + 1
				end
				i := i + 1
			end
			print ("%Ncount = ") 
			print (count)
			print ("%Nincremented count = ") 
			print (a_count)
			if a_count /= count then
				print ("%NCheck_content: Incorrenct-count Error!!")
			end
			print ("%Nchecking is done.")
		end

				
end -- class MT_OBJECT_TABLE
