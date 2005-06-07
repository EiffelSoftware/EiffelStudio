indexing
	description: "Representation of a deferred function"
	date: "$Date$"
	revision: "$Revision$"

class DEF_FUNC_I 

inherit
	DEF_PROC_I
		redefine
			assigner_name_id, transfer_to,
			unselected, replicated, set_type, is_function, type,
			new_api_feature
		end
	
feature 

	type: TYPE_AS
			-- Type of the function

	assigner_name_id: INTEGER
			-- Id of `assigner_name' in `Names_heap' table

	set_type (t: like type; a: like assigner_name_id) is
			-- Assign `t' to `type' and `a' to `assigner_name_id'.
		do
			type := t
			assigner_name_id := a
		end

	is_function: BOOLEAN is True;
			-- Is the current feature a function ?

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_DEF_FUNC_I;
		do
			create rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_DEF_FUNC_I
		do
			create unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

	transfer_to (other: like Current) is
			-- Transfer datas form `other' into Current
		do
			Precursor {DEF_PROC_I} (other)
			other.set_type (type, assigner_name_id)
		end

feature {NONE} -- Implementation

	new_api_feature: E_FUNCTION is
		local
			t: TYPE_A
		do
			create Result.make (feature_name, alias_name, has_convert_mark, feature_id)
			t ?= type
			if t = Void then
				t := type.actual_type
			end
			Result.set_type (t, assigner_name)
			update_api (Result)
		end

end
