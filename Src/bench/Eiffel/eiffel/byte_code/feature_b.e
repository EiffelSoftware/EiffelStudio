-- Access to an Eiffel feature

class FEATURE_B 

inherit

	CALL_ACCESS_B
		rename
			make_code as standard_make_code
		redefine
			is_feature, set_parameters, parameters, enlarged		
		end;

	CALL_ACCESS_B
		redefine
			make_code,
			is_feature, set_parameters, parameters, enlarged
		select
			make_code
		end
			
feature 

	feature_name: STRING;
			-- Name of the feature called

	feature_id: INTEGER;
			-- Feature id: this is the key for the call in workbench mode

	type: TYPE_I;
			-- Type of the call

	parameters: BYTE_LIST [BYTE_NODE];
			-- Feature parameters {list of EXPR_B}: can be Void

	set_parameters (p: like parameters) is
			-- Assign `p' to `parameters'.
		do
			parameters := p;
		end; 

	set_type (t: TYPE_I) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	init (f: FEATURE_I) is
			-- Initialization
		require
			good_argument: f /= Void;
		do
			feature_name := f.feature_name;
			feature_id := f.feature_id;
		end;

	is_feature: BOOLEAN is True;
			-- Is Current an access to an Eiffel feature ?

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			feature_b: FEATURE_B;
		do
			feature_b ?= other;
			if feature_b /= Void then
				Result := feature_id = feature_b.feature_id;
			end;
		end;

	enlarged: FEATURE_BL is
			-- Enlarge the tree to get more attributes and return the
			-- new enlarged tree node.
		do
			if context.final_mode then
				!!Result;
			else
				!FEATURE_BW!Result.make;
			end;
			Result.fill_from (Current);
		end;

feature -- Byte code generation

	make_code (ba: BYTE_ARRAY; flag: BOOLEAN) is
			-- Generate byte code for a feature call. If not `flag', generate
			-- an invariant check before the call.
		do
			if parameters /= Void then
				parameters.make_byte_code (ba);
			end;
			standard_make_code (ba, flag);
		end;

	code_first: CHARACTER is
			-- Code when Eiffel call is first (no invariant)
		do
			Result := Bc_feature
		end;

	code_next: CHARACTER is
			-- Code when Eiffel call is nested (invariant)
		do
			Result := Bc_feature_inv
		end;

end
