-- CALLS_LIST has a list of features of unqualified calls
-- (i.e x or y (i)) or calls before the first dot in a 
-- qualified call. 

class CALLS_LIST

inherit

	LINKED_LIST [STRING]
		rename
			make as set_make,
			add as set_add,
			wipe_out as set_wipe_out
		end;

creation

	make

feature

	is_new: BOOLEAN;

	make is
		do
			set_make;
			is_new := true;
		end;

	add (v: STRING) is
			-- Add `v' to Current
		do
			if is_new then
				add_front (v);
				is_new := false;
			end;
		end;

	stop_filling is
		do
			is_new := false
		end;

	wipe_out is
		do
			set_wipe_out;
			is_new := True;
		end;

	has_equal (s: STRING): BOOLEAN is
			-- Does Current have `s' (is_equal test)?
		do
			from
				start
			until
				after or else Result
			loop
				Result := item.is_equal (s);
				forth
			end
		end;

	trace is
			-- Debugging purposes 
		do
			io.error.putstring (" calls list content%N");
			from
				start
			until
				after 
			loop
				io.error.putstring ("%Tcall list item: ");
				io.error.putstring (item);
				io.error.new_line;
				forth
			end
		end;

	merge (other: like Current) is
		do
			finish;
			merge_right (other);
		end;

end
