-- Table of correpondance beetween body indexes and body ids

class BODY_INDEX_TABLE 

inherit

	EXTEND_TABLE [INTEGER, INTEGER]
		rename
			force as tbl_force,
			put as tbl_put
		end;

	EXTEND_TABLE [INTEGER, INTEGER]
		redefine
			force, put
		select
			force, put
		end;

	SHARED_WORKBENCH
		undefine
			is_equal, copy
		end

creation

	make
	
feature -- Element change

	put (body_id, body_index: INTEGER) is
			-- Associated `body_id' with `body_index'. If `body_index'
			-- was already used (i.e. we are changing the body id of
			-- an already existing feature), keep track of the old
			-- body id in special correspondance table for DLE purposes
			-- (correspondance between "static" body id and "dynamic"
			-- body id for generation of encoded feature name among other
			-- things).
		local
			old_body_id: INTEGER
		do
			if has (body_index) then
				old_body_id := item (body_index);
				System.dle_frozen_nobid_table.put (old_body_id, body_id);
				if System.is_dynamic then
					System.dle_finalized_nobid_table.put (old_body_id, body_id)
				end
			end;
			tbl_put (body_id, body_index)
		end;

	force (body_id, body_index: INTEGER) is
			-- Associated `body_id' with `body_index'. If `body_index'
			-- was already used (i.e. we are changing the body id of
			-- an already existing feature), keep track of the old
			-- body id in special correspondance table for DLE purposes
			-- (correspondance between "static" body id and "dynamic"
			-- body id for generation of encoded feature name among other
			-- things).
		local
			old_body_id: INTEGER
		do
			if has (body_index) then
				old_body_id := item (body_index);
				System.dle_frozen_nobid_table.put (old_body_id, body_id);
				if System.is_dynamic then
					System.dle_finalized_nobid_table.put (old_body_id, body_id)
				end
			end;
			tbl_force (body_id, body_index)
		end;

end
