class DEF_FUNC_I 

inherit

	DEF_PROC_I
		rename
			transfer_to as procedure_transfer_to
		redefine
			unselected, replicated, set_type, is_function, type,
			new_api_feature
		end;
	DEF_PROC_I
		redefine
			transfer_to,
			unselected, replicated, set_type, is_function, type,
			new_api_feature
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

	is_function: BOOLEAN is True;
			-- Is the current feature a function ?

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_DEF_FUNC_I;
		do
			!!rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_DEF_FUNC_I
		do
			!!unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

	transfer_to (other: like Current) is
			-- Transfer datas form `other' into Current
		do
			procedure_transfer_to (other);
			other.set_type (type);
		end;

feature {NONE} -- Implementation

	new_api_feature: E_ROUTINE is
		local
			t: TYPE_A;
			new_f: E_FUNCTION
		do
			t ?= type;
			!! new_f.make (feature_name, feature_id);
			new_f.set_type (t);
			update_api (new_f);
			Result := new_f;
		end;

end
