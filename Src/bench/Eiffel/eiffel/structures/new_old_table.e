-- New/Old table

class NEW_OLD_TABLE [G -> COMPILER_ID] inherit

	EXTEND_TABLE [G, G]
		rename
			put as tbl_put,
			item as tbl_item
		export
			{NONE} all;
			{ANY} clear_all, empty
		end;
	COMPILER_EXPORTER
		undefine
			is_equal, copy
		end

creation

	make

feature

	put (old_value, new_value: G) is
			-- Associate `old_value' with `new_value'.
		local
			latest_old_value: G
		do
			if not has (new_value) then
				latest_old_value := item (old_value);
				if latest_old_value.id <= threshold then
					force (latest_old_value, new_value)
				end
			end
		end;
			
	item (i: G): G is
			-- Old value associated with `i'. If old value is greater
			-- than `thresold' (not so old!), return `i' itself
		do
			if has (i) then
				Result := found_item
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
