class DEF_FUNC_I 

inherit
	DEF_PROC_I
		redefine
			transfer_to,
			unselected, replicated, set_type, is_function, type,
			new_api_feature
		end
	
feature 

	type: TYPE;
			-- Type of the function

	set_type (t: TYPE) is
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
			Precursor {DEF_PROC_I} (other);
			other.set_type (type);
		end;

feature {NONE} -- Implementation

	new_api_feature: E_FUNCTION is
		local
			t: TYPE_A;
		do
			!! Result.make (feature_name, feature_id);
			t ?= type;
			if t = Void then
				t := type.actual_type
			end;
			Result.set_type (t);
			update_api (Result);
		end;

end
