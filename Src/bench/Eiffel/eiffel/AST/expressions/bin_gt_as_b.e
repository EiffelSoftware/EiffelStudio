class BIN_GT_AS_B

inherit

	BIN_GT_AS
		rename
			left as old_gt_left,
			right as old_gt_right
		end;

	COMPARISON_AS_B
		select
			left, right
		end

feature

	byte_anchor: BIN_GT_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_GT_AS_B
