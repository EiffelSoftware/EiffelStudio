-- Access to an Eiffel feature

class FEATURE_B 

inherit

	CALL_ACCESS_B
		redefine
			is_feature, set_parameters, 
			parameters, enlarged, context_type,
			is_feature_special, make_special_byte_code,
			is_unsafe, optimized_byte_node,
			calls_special_features, is_special_feature,
			size, pre_inlined_code, inlined_byte_code,
			has_separate_call, reset_added_gc_hooks,
			make_precursor_byte_code
		end;
	SHARED_TABLE;
	SHARED_SERVER
	SHARED_ID_TABLES

feature 

	feature_name: STRING;
			-- Name of the feature called

	feature_id: INTEGER;
			-- Feature id: this is the key for the call in workbench mode

	type: TYPE_I;
			-- Type of the call

	body_index: BODY_INDEX
			-- Body Index of the feature

	body_id: BODY_ID is
			-- Body Id of the feature.
		require
			has_body_id: has_body_id (body_index)
		do
			Result := Body_index_table.item (body_index)
		ensure
			non_void_body_id: Result /= Void
		end

	has_body_id (v: BODY_INDEX): BOOLEAN is
			-- Does the system have `v' as BODY_INDEX?
		do
			Result := Body_index_table.has (body_index)
		end

	is_once: BOOLEAN
			-- Is the current feature a once function
			--| Used when inlining is turned on in final mode, because we are not
			--| allowed to inline once routines

	parameters: BYTE_LIST [EXPR_B];
			-- Feature parameters: can be Void

	precursor_type : CL_TYPE_I
			-- Type of parent in a precursor call

	set_precursor_type (p_type : CL_TYPE_I) is
			-- Assign `p_type' to `precursor_type'.
		do
			precursor_type := p_type
		ensure
			precursor_set : precursor_type = p_type
		end
		
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
			!!Result
		end;

	is_feature_special: BOOLEAN is
			-- Search for feature_name in special_routines.
			-- This is used for simple types only.
			-- If found return True (and keep reference position).
			-- Otherwize, return false;
		do
			Result := special_routines.has (feature_name);
		end;

	init (f: FEATURE_I) is
			-- Initialization
		require
			good_argument: f /= Void;
		do
			feature_name := f.feature_name;
			feature_id := f.feature_id;
			body_index := f.body_index
			routine_id := f.rout_id_set.first
			is_once := f.is_once
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

feature -- Context type

	context_type: TYPE_I is
			-- Context type of the access (properly instantiated)
		do
			if precursor_type = Void then
				Result := {CALL_ACCESS_B} Precursor
			else
				Result := precursor_type
				Result := Context.real_type (Result);
			end;
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
			make_java_typecode (ba)
		end;

	make_special_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for special calls.
		do
			ba.append (special_routines.bc_code);
		end;

	make_precursor_byte_code (ba: BYTE_ARRAY) is
			-- Add dynamic type of parent.
		do
			if precursor_type /= Void then
				ba.append_short_integer (precursor_type.associated_class_type.id.id - 1)
			else
				ba.append_short_integer (-1)
			end
		end;

	code_first: CHARACTER is
			-- Code when Eiffel call is first (no invariant)
		once
			Result := Bc_feature
		end;

	code_next: CHARACTER is
			-- Code when Eiffel call is nested (invariant)
		once
			Result := Bc_feature_inv;
		end;

	precomp_code_first: CHARACTER is
			-- Code when Eiffel precompiled call is first (no invariant)
		once
			Result := Bc_pfeature;
		end;

	precomp_code_next: CHARACTER is
			-- Code when Eiffel precompiled call is nested (invariant)
		once
			Result := Bc_pfeature_inv;
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
			!!dep.make (base_class.id, f);
			Result := optimizer.special_features.has (dep);
		end;

	is_unsafe: BOOLEAN is
		local
			cl_type: CL_TYPE_I;
			base_class: CLASS_C;
			f: FEATURE_I
			dep: DEPEND_UNIT
		do
			cl_type ?= context_type; -- Cannot fail
			base_class := cl_type.base_class;
			f := base_class.feature_table.item (feature_name);
debug ("OPTIMIZATION")
	io.error.putstring ("%N%N%NTESTING is_unsafe for ");
	io.error.putstring (feature_name);
	io.error.putstring (" from ")
	io.error.putstring (base_class.name);
	io.error.putstring (" is NOT safe%N");
end;
			optimizer.test_safety (f, base_class);
			!! dep.make (base_class.id, f)
			Result := (not optimizer.is_safe (dep))
				or else (parameters /= Void and then parameters.is_unsafe)
debug ("OPTIMIZATION")
	if Result then
		io.error.putstring (f.feature_name);
		io.error.putstring (" from ")
		io.error.putstring (base_class.name);
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
			bc: STD_BYTE_CODE
			old_c_t: CL_TYPE_I
			computed_body_id: BODY_ID
		do
			if not is_once then
				type_i := context_type;
				if not type_i.is_basic then
					cl_type ?= type_i; -- Cannot fail
						-- Inline only if it is not polymorphic and if it can be inlined.
					if Eiffel_table.is_polymorphic (routine_id, cl_type.type_id, True) = -1 then
						inliner := System.remover.inliner;
						computed_body_id := body_id
						inline := inliner.inline (type, computed_body_id)
					end;
				end
			end

			if inline then
					-- Creation of a special node for the entire
					-- feature (descendant of STD_BYTE_CODE)
				inliner.set_current_feature_inlined;
				if cl_type.base_class.is_special then
					!SPECIAL_INLINED_FEAT_B! inlined_feat_b
				else
					!! inlined_feat_b;
				end
				inlined_feat_b.fill_from (Current)
				bc ?= Byte_server.disk_item (computed_body_id);

				old_c_t := Context.current_type;
				Context.set_current_type (current_type);
				bc := bc.pre_inlined_code;
				Context.set_current_type (old_c_t);

				inlined_feat_b.set_inlined_byte_code (bc);
				Result := inlined_feat_b
			else
				Result := Current
				if parameters /= Void then
					parameters := parameters.inlined_byte_code
				end
			end;
		end;

	current_type: CL_TYPE_I is
			-- Current type for the call (NOT the static type but the
			-- type corresponding to the written in class)
		local
			written_class: CLASS_C
			tuple_class: TUPLE_CLASS_B
			original_feature: FEATURE_I
			gen_type_i: GEN_TYPE_I
			tuple_type_i: TUPLE_TYPE_I
			m: META_GENERIC
			true_gen : ARRAY [TYPE_I]
			actual_gen: ARRAY [TYPE_A]
			real_target_type, actual_type: TYPE_A
			constraint: TYPE_A
			formal_a: FORMAL_A
			nb_generics, i: INTEGER
			t_i: TYPE_I
		do
			original_feature := context_type.type_a.associated_class.
									feature_table.origin_table.item (routine_id);
			written_class := original_feature.written_class;

			if written_class.generics = Void then
				Result := written_class.types.first.type
			else

				real_target_type := context_type.type_a;
					-- LINKED_LIST [STRING] is recorded as LINKED_LIST [REFERENCE_I]
					-- => LINKED_LIST [ANY] after previous call

				from
					i := 1
					nb_generics := written_class.generics.count;
					!!m.make (nb_generics)
					!!true_gen.make (1, nb_generics)
					!!actual_gen.make (1, nb_generics)
				until
					i > nb_generics
				loop
					!!formal_a;
					formal_a.set_position (i);
					actual_type := formal_a.instantiation_in (real_target_type, written_class.id)
					actual_gen.put (actual_type, i)
					if actual_type.is_basic then
						m.put (actual_type.type_i, i)
					else
						constraint := written_class.constraint (i);
						m.put (constraint.type_i, i)
					end
					true_gen.put (actual_type.type_i, i)
					i := i + 1
				end

				tuple_class ?= written_class
				if tuple_class = Void then
					!!gen_type_i;
					gen_type_i.set_base_id (written_class.id)
					gen_type_i.set_meta_generic (m)
					gen_type_i.set_true_generics (true_gen)
					Result := gen_type_i
				else
					!!tuple_type_i;
					tuple_type_i.set_base_id (written_class.id)
					tuple_type_i.set_meta_generic (m)
					tuple_type_i.set_true_generics (true_gen)
					Result := tuple_type_i
				end
			end
		end

feature -- Concurrent Eiffel

	attach_loc_to_sep: BOOLEAN is
		-- Does the feature call attach a local object to separate formal
		-- parameter?
		local
			p: PARAMETER_B;
		do
			Result := false;
			if parameters /= Void then
				from
					parameters.start
				until
					Result or parameters.after
				loop
					p ?= parameters.item;
					if real_type(p.attachment_type).is_separate and
						not real_type(p.expression.type).is_separate then
						Result := True;
					end;
					parameters.forth;
				end;
			end;
		end

	has_separate_call: BOOLEAN is
			-- Is there separate feature call in the assertion?
		local
			p: PARAMETER_B;
			class_type: CL_TYPE_I;
		do
			class_type ?= context_type;
			if class_type /= Void then
				Result := class_type.is_separate;
			end;
			if not Result and parameters /= Void  then
				from
					parameters.start
				until
					Result or parameters.after
				loop
					p ?= parameters.item;
					-- can't fail but it failed for class RESOURCE_STRING_LEX
					if p /= Void and then p.expression /= Void then
						Result := p.expression.has_separate_call;
					end;
					parameters.forth;
				end;
			end;
		end

	reset_added_gc_hooks is
		local
			expr: PARAMETER_B;
			para_type: TYPE_I;
			loc_idx: INTEGER
			buf: GENERATION_BUFFER
		do
			if system.has_separate and then parameters /= Void then
				from
					buf := buffer
					parameters.start;
				until
					parameters.after
				loop
					expr ?= parameters.item;	-- Cannot fail
					if expr /= Void then
						para_type := real_type(expr.attachment_type);
						if para_type.is_separate then
							if expr.stored_register.register_name /= Void then
								loc_idx := context.local_index (expr.stored_register.register_name);
							else
								loc_idx := -1;
							end;
							if loc_idx /= -1 then
								buf.putstring ("l[");
								buf.putint (context.ref_var_used + loc_idx);
								buf.putstring ("] = (char *)0;");
								buf.new_line;
							end
						end
					end
					parameters.forth;
				end;
			end
		end

end
