class EB_LINKED_LIST [T->HELPABLE]

inherit

	LINKED_LIST [T]
		rename
			duplicate as ll_duplicate
		end

creation

	make

feature

	duplicate: EB_LINKED_LIST [like item] is
		local
			cur: CURSOR
		do
			!!Result.make;
			from
				cur := cursor;
				finish
			until
				before
			loop
				Result.put_right (item);
				back;
			end;
			go_to (cur);
		end;

	merge (other: EB_LINKED_LIST [like item]) is
			-- Merge `other' at the end of the current
			-- list. Move cursor to end of list.
			-- (Do not wipe out other).
		local
			copied_l: like other
		do
			copied_l := other.duplicate;
			finish;
			merge_right (copied_l);
		end;

	set (other: EB_LINKED_LIST [like item]) is
			-- Set the current list to `other' and manage the
			-- corresponding icons to `other'.
		do
			wipe_out;
			merge (other);	
		end; -- set

end
