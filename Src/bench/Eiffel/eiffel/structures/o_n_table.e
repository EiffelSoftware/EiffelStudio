-- Old/New table

class O_N_TABLE 

inherit

	EXTEND_TABLE [INTEGER, INTEGER]
		rename
			put as tbl_put,
			item as tbl_item
		export
			{NONE} all
		end

creation

	make

feature

	put (new_value, old_value: INTEGER) is
		local
			temp: INTEGER;
			latest_old: INTEGER
		do
			if not has (new_value) then
				latest_old := item (old_value);
				force (new_value, latest_old);
				from
					start
				until
					after
				loop
					if item_for_iteration = latest_old then
						content.put (new_value, position_for_iteration);
						control := Changed_constant;
					end;
					forth
				end;
			end;
		end;

	item (i: INTEGER): INTEGER is
		do
			if has (i) then
				Result := tbl_item (i)
			else
				Result := i
			end;
		end;

feature -- Trace

	trace is
			-- For debug purposes
		do
			from
				start;
				io.error.putstring ("==== Old/New table ====%N");
			until
				after
			loop
				io.error.putstring ("Old: ");
				io.error.putint (key_for_iteration);
				io.error.putstring (" , New: ");
				io.error.putint (item_for_iteration);
				io.error.new_line;
				forth
			end
		end;

end
