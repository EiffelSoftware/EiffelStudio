class EXTERNAL_FUNC_I 

inherit

	EXTERNAL_I
		rename
			transfer_to as external_transfer_to
		redefine
			unselected, replicated, set_type, is_function, type		
		end;

	EXTERNAL_I
		redefine
			unselected, replicated, transfer_to, set_type, is_function, type
		select
			transfer_to
		end
	
feature 

	type: TYPE_B;
			-- Type of the function

	set_type (t: TYPE_B) is
			-- Assign `t' to `type'.
		do
			type := t
		end;

	is_function: BOOLEAN is
		do
			Result := True
		end;

	transfer_to (other: like Current) is
			-- Transfer datas form `other' into Current
		do
			external_transfer_to (other);
			other.set_type (type);
		end;

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_EXTERNAL_FUNC_I;
		do
			!!rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_EXTERNAL_FUNC_I;
		do
			!!unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

end
