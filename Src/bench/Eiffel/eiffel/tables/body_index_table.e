-- Table of correpondance beetween body indexes and body ids

class
	BODY_INDEX_TABLE 

inherit
	EXTEND_TABLE [BODY_ID, BODY_INDEX]
		redefine
			force, put
		end;

	SHARED_WORKBENCH
		undefine
			is_equal, copy
		end

creation

	make
	
feature -- Element change

	put (body_id: BODY_ID; body_index: BODY_INDEX) is
			-- Associated `body_id' with `body_index'. If `body_index'
			-- was already used (i.e. we are changing the body id of
			-- an already existing feature), keep track of the old
			-- body id in special correspondance table for DLE purposes
			-- (correspondance between "static" body id and "dynamic"
			-- body id for generation of encoded feature name among other
			-- things).
		local
			old_body_id: BODY_ID
		do
			if has (body_index) then
				old_body_id := found_item
				System.dle_frozen_nobid_table.put (old_body_id, body_id);
				if System.is_dynamic then
					System.dle_finalized_nobid_table.put (old_body_id, body_id)
				end
			end;
			{EXTEND_TABLE} Precursor (body_id, body_index)
		end;

	force (body_id: BODY_ID; body_index: BODY_INDEX) is
			-- Associated `body_id' with `body_index'. If `body_index'
			-- was already used (i.e. we are changing the body id of
			-- an already existing feature), keep track of the old
			-- body id in special correspondance table for DLE purposes
			-- (correspondance between "static" body id and "dynamic"
			-- body id for generation of encoded feature name among other
			-- things).
		local
			old_body_id: BODY_ID
		do
			if has (body_index) then
				old_body_id := found_item
				System.dle_frozen_nobid_table.put (old_body_id, body_id);
				if System.is_dynamic then
					System.dle_finalized_nobid_table.put (old_body_id, body_id)
				end
			end;
			{EXTEND_TABLE} Precursor (body_id, body_index)
		end;

	append (other: like Current) is
			-- Add items of `other' to `Current'.
			-- Used during precompilation merging.
		require
			other_not_void: other /= Void
		local
			other_body_index: BODY_INDEX;
			other_body_id, body_id: BODY_ID
		do
			from
				other.start
			until
				other.after
			loop
				other_body_index := other.key_for_iteration;
				other_body_id := other.item_for_iteration;
				if not has (other_body_index) then
					put (other_body_id, other_body_index)
				else
					body_id := found_item
					if not other_body_id.is_equal (body_id) then
						System.onbidt.put (body_id, other_body_id)
					end
				end;
				other.forth
			end
		end

end
