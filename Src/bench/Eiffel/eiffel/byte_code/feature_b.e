-- Access to an Eiffel feature

class FEATURE_B 

inherit

	CALL_ACCESS_B
		redefine
			is_feature, set_parameters, 
			parameters, enlarged,
			is_feature_special, make_special_byte_code,
			is_unsafe, optimized_byte_node,
			calls_special_features, is_special_feature
		end;

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

	special_routines: SPECIAL_FEATURES is
			-- Array containing special routines.
		once
			!!Result.make
		end;

	is_feature_special: BOOLEAN is
			-- Search for feature_name in special_routines.
			-- This is used for simple types only.
			-- If found return True (and keep reference position).
			-- Otherwize, return false;
		do
			special_routines.find (feature_name);
			Result := special_routines.found;
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

	make_special_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for special calls.
		do
			ba.append (special_routines.bc_code);
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

feature -- Array optimization

	is_special_feature: BOOLEAN is
		local
			cl_type: CL_TYPE_I;
			base_class: CLASS_C;
			f: FEATURE_I;
			dep: DEPEND_UNIT
		do
			cl_type ?= context_type; -- Cannot fail
			base_class := cl_type.base_class;
			f := base_class.feature_table.item (feature_name);
			!!dep.make (base_class.id, f.feature_id);
			Result := optimizer.special_features.has (dep);
		end;

	is_unsafe: BOOLEAN is
		local
			cl_type: CL_TYPE_I;
			base_class: CLASS_C;
			f: FEATURE_I
		do
			cl_type ?= context_type; -- Cannot fail
			base_class := cl_type.base_class;
			f := base_class.feature_table.item (feature_name);
debug ("OPTIMIZATION")
	io.error.putstring ("%N%N%NTESTING is_unsafe for ");
	io.error.putstring (feature_name);
	io.error.putstring (" from ")
	io.error.putstring (base_class.class_name);
	io.error.putstring (" is NOT safe%N");
end;
			optimizer.test_safety (f, base_class);
			Result := (not optimizer.is_safe (f))
				or else (parameters /= Void and then parameters.is_unsafe)
debug ("OPTIMIZATION")
	if result then
		io.error.putstring (f.feature_name);
		io.error.putstring (" from ")
		io.error.putstring (base_class.class_name);
		io.error.putstring (" is NOT safe%N");
	end;
end
		end

	optimized_byte_node: like Current is
		do
			Result := Current;
			if parameters /= Void then
				parameters := parameters.optimized_byte_node
			end
		end;

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			if parameters /= Void then
				Result := parameters.calls_special_features (array_desc)
			end
		end

feature {NONE} -- Array optimization

	optimizer: ARRAY_OPTIMIZER is
		do
			Result := System.remover.array_optimizer
		end

end
