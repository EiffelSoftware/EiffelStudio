indexing
	description: "Representation of an external function"
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_FUNC_I 

inherit
	EXTERNAL_I
		redefine
			unselected, replicated, transfer_to, set_type, is_function, type,
			new_api_feature
		end

create
	make

feature 

	type: TYPE_AS
			-- Type of the function

	set_type (t: like type) is
			-- Assign `t' to `type'.
		do
			type := t
		end;

	is_function: BOOLEAN is True

	transfer_to (other: like Current) is
			-- Transfer datas form `other' into Current
		do
			Precursor {EXTERNAL_I} (other);
			other.set_type (type);
		end;

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_EXTERNAL_FUNC_I;
		do
			create rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_EXTERNAL_FUNC_I;
		do
			create unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

feature -- Api creation
 
	new_api_feature: E_FUNCTION is 
			-- API feature creation
		local
			t: TYPE_A
		do
			create Result.make (feature_name, alias_name, has_convert_mark, feature_id)
			t ?= type
			if t = Void then
				t := type.actual_type
			end
			Result.set_type (t)
			update_api (Result)
		end

end
