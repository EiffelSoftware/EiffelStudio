-- Table of correpondance beetween body indexes and body ids

class
	BODY_INDEX_TABLE 

inherit
	EXTEND_TABLE [BODY_ID, BODY_INDEX]

	SHARED_WORKBENCH
		undefine
			is_equal, copy
		end

creation
	make
	
feature -- Element change

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
