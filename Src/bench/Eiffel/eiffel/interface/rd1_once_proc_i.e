-- Replicated unselected feature

class RD1_ONCE_PROC_I

inherit

	D_ONCE_PROC_I
		rename
			transfer_to as d_once_proc_transfer_to
		redefine
			code_id, is_replicated, is_code_replicated,
			set_is_code_replicated,
			set_code_id
		end;
	D_ONCE_PROC_I
		redefine
			code_id, transfer_to, is_replicated,
			is_code_replicated, set_is_code_replicated,
			set_code_id
		select
			transfer_to
		end;

feature

	code_id: BODY_ID;
			-- Code id

	set_code_id (i: BODY_ID) is
			-- Assign `i' to `code_id'.
		do
			code_id := i
		end;

	transfer_to (f: like Current) is
			-- Data transfer
		do
			d_once_proc_transfer_to (f);
			f.set_code_id (code_id);
		end;

    is_code_replicated: BOOLEAN;
            -- Is Current feature code replicated
 
    is_replicated: BOOLEAN is True;
            -- Is Current feature conceptually replicated (True)
 
    set_is_code_replicated is  
            -- Set `is_code_replicated' to True. 
		do
			is_code_replicated := True;
		end;
 
end
