
class EXTEND_TABLE [T, U->EB_HASHABLE]

inherit

	HASH_TABLE [T, U]
-- 		redefine
-- 			internal_search
-- 		end

creation

	make

feature

-- 	internal_search (search_key: U) is
-- 			-- Search for item of `search_key'.
-- 			-- If successful, set `position' to index
-- 			-- of item with this key (the same index as the key's index).
-- 			-- If not, set position to possible position for insertion.
-- 			-- Set `control' to `Found_constant' or `Not_found_constant'.
-- 		require else
-- 			good_key: valid_key (search_key)
-- 		local
-- 			increment, hash_code, table_size: INTEGER;
-- 			first_deleted_position, trace_deleted, visited_count: INTEGER;
-- 			old_key: U;
-- 			stop: BOOLEAN
-- 		do
-- 			from
-- 				first_deleted_position := -1;
-- 				table_size := keys.count;
-- 				hash_code := search_key.hash_code;
-- 				-- Increment computed for no cycle: `table_size' is prime
-- 				increment := 1 + hash_code \\ (table_size - 1);
-- 				position := (hash_code \\ table_size) - increment;
-- 			until
-- 				stop or else visited_count >= table_size
-- 			loop
-- 				position := (position + increment) \\ table_size;
-- 				visited_count := visited_count + 1;
-- 				old_key := keys.item (position);
-- 				if old_key = Void then
-- 					if not deleted_marks.item (position) then
-- 						control := Not_found_constant;
-- 						stop := true;
-- 						if first_deleted_position >= 0 then
-- 							position := first_deleted_position
-- 						end
-- 					elseif first_deleted_position < 0 then
-- 						first_deleted_position := position
-- 					end
-- 				elseif search_key.same (old_key) then
-- 					control := Found_constant;
-- 					stop := true
-- 				elseif old_key.hash_code = 0 then
-- 					if not deleted_marks.item (position) then
-- 						control := Not_found_constant;
-- 						stop := true;
-- 						if first_deleted_position >= 0 then
-- 							position := first_deleted_position
-- 						end
-- 					elseif first_deleted_position < 0 then
-- 						first_deleted_position := position
-- 					end
-- 				end
-- 			end;
-- 			if not stop then
-- 				control := Not_found_constant;
-- 				if first_deleted_position >= 0 then
-- 					position := first_deleted_position
-- 				end;
-- 			end;
-- 		end;


end
