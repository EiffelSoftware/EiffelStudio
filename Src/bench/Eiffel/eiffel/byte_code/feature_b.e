-- Access to an Eiffel feature

class FEATURE_B 

inherit

	CALL_ACCESS_B
		redefine
			is_feature, set_parameters, 
			parameters, enlarged,
			is_feature_special, make_special_byte_code,
			is_unsafe, optimized_byte_node,
			calls_special_features, is_special_feature,
			size, pre_inlined_code, inlined_byte_code
		end;
	SHARED_TABLE;
	SHARED_SERVER

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

	enlarged: FEATURE_B is
			-- Enlarge the tree to get more attributes and return the
			-- new enlarged tree node.
		local
			feature_bl: FEATURE_BL
		do
			if context.final_mode then
				!!feature_bl;
			else
				!FEATURE_BW!feature_bl.make;
			end;
			feature_bl.fill_from (Current);
			Result := feature_bl
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

feature -- Inlining

	size: INTEGER is
		do
			if parameters /= Void then
				Result := 1 + parameters.size
			else
				Result := 1
			end
		end

	pre_inlined_code: CALL_B is
		local
			nested_b: NESTED_B
			inlined_current_b: INLINED_CURRENT_B
		do
			if parent /= Void then
				Result := Current
			else
				!!nested_b;
				!!inlined_current_b;
				nested_b.set_target (inlined_current_b);
				inlined_current_b.set_parent (nested_b);

				nested_b.set_message (Current);
				parent := nested_b;

				Result := nested_b;
			end
			if parameters /= Void then
				parameters := parameters.pre_inlined_code
			end
		end

	inlined_byte_code: like Current is
		local
			inlined_feat_b: INLINED_FEAT_B
			inline: BOOLEAN
			inliner: INLINER
			type_i: TYPE_I;
			cl_type: CL_TYPE_I
			base_class: CLASS_C
			entry: POLY_TABLE [ENTRY];
			f: FEATURE_I
			inlined_bc: INLINED_BYTE_CODE
		do
			type_i := context_type;
			if not type_i.is_basic then
				cl_type ?= type_i; -- Cannot fail
				base_class := cl_type.base_class;
				if not (base_class.is_basic or else base_class.is_special) then
					f := base_class.feature_table.item (feature_name);

						-- Is it a polymorphic call ?
					entry := Eiffel_table.item_id (rout_id);
					if not entry.is_polymorphic (cl_type.type_id) then
						inliner := System.remover.inliner;
						inline := inliner.inline (f)
					end;
				end;
			end

			if inline then
					-- Creation of a special node for the entire
					-- feature (descendant of STD_BYTE_CODE)
				inliner.set_current_feature_inlined;

				!!inlined_feat_b;
				inlined_feat_b.fill_from (Current)
				inlined_bc ?= Byte_server.item (f.body_id).pre_inlined_code;
				inlined_feat_b.set_inlined_byte_code (inlined_bc);
				Result := inlined_feat_b
			else
				Result := Current
				if parameters /= Void then
					parameters := parameters.inlined_byte_code
				end
			end;
		end;

end
