-- New/Old table

class NEW_OLD_TABLE inherit

	EXTEND_TABLE [INTEGER, INTEGER]
		rename
			put as tbl_put,
			item as tbl_item
		export
			{NONE} all;
			{ANY} clear_all, empty
		end

creation

	make

feature

	put (old_value, new_value: INTEGER) is
			-- Associate `old_value' with `new_value'.
		local
			latest_old_value: INTEGER
		do
			if not has (new_value) then
				latest_old_value := item (old_value);
				if latest_old_value <= threshold then
					force (latest_old_value, new_value)
				end
			end
		end;
			
	item (i: INTEGER): INTEGER is
			-- Old value associated with `i'. If old value is greater
			-- than `thresold' (not so old!), return `i' itself
		do
			if has (i) then
				Result := tbl_item (i)
			else
				Result := i
			end
		end;

	set_threshold (i: INTEGER) is
			-- Assign `i' to `threshold'.
		require
			empty: empty
		do
			threshold := i
		end;

	threshold: INTEGER;
			-- Water mark to assess the age of a value

end -- class NEW_OLD_TABLE
