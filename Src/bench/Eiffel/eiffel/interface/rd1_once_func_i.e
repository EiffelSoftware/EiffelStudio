-- Replicated unselected feature

class RD1_ONCE_FUNC_I

inherit

	D_ONCE_FUNC_I
		rename
			transfer_to as d_once_func_transfer_to
		redefine
			code_id
		end;
	D_ONCE_FUNC_I
		redefine
			code_id, transfer_to
		select
			transfer_to
		end;

feature

	code_id: INTEGER;
			-- Code id

	set_code_id (i: INTEGER) is
			-- Assign `i' to `code_id'.
		do
			code_id := i
		end;

	transfer_to (f: like Current) is
			-- Data transfer
		do
			d_once_func_transfer_to (f);
			f.set_code_id (code_id);
		end;

end
