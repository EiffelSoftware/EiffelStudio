-- Access to a C external

class EXTERNAL_B 

inherit

	CALL_ACCESS_B
		redefine
			same, is_external, set_parameters, parameters, enlarged,
			is_unsafe, optimized_byte_node,
			calls_special_features, size,
			pre_inlined_code, inlined_byte_code,
			has_separate_call, reset_added_gc_hooks,
			make_end_byte_code, make_end_precomp_byte_code,
			make_precursor_byte_code
		end;
	SHARED_INCLUDE

feature 

	feature_name: STRING;
			-- Name of the feature called

	feature_id: INTEGER;
			-- Feature id: this is the key for the call in workbench mode

	type: TYPE_I;
			-- Type of the call

	parameters: BYTE_LIST [EXPR_B];
			-- Feature parameters: can be Void

feature -- Attributes for externals

	extension: EXTERNAL_EXT_I
			-- Encapsulation of external extensions

	external_name: STRING;
			-- Name of the C external

	encapsulated: BOOLEAN;
			-- Has the feature some assertion declared ?

	is_external: BOOLEAN is True;
			-- Access is an external call

feature -- Routines for externals

	set_extension (e: like extension) is
			-- Assign `e' to `extension'.
		do
			extension := e
		end;

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

	init (f: EXTERNAL_I) is
			-- Initialization
		require
			good_argument: f /= Void;
			not_attribute: not f.is_attribute;
		do
			feature_name := f.feature_name;
			feature_id := f.feature_id;
			routine_id := f.rout_id_set.first
		end;

	set_external_name (s: STRING) is
			-- Assign `s' to `external_name'.
		do
			external_name := s;
		end;

	set_encapsulated (b: BOOLEAN) is
			-- Assign `b' to `encapsulated'
		do
			encapsulated := b;
		end;

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			external_b: EXTERNAL_B;
		do
			external_b ?= other;
			if external_b /= Void then
				Result := external_name.is_equal (external_b.external_name);
			end;
		end;

	enlarged: EXTERNAL_BL is
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		do
			if context.final_mode then
				!!Result;
			else
				!EXTERNAL_BW!Result.make;
			end;
			Result.fill_from (Current);
		end;

feature -- Byte code generation

	make_code (ba: BYTE_ARRAY; flag: BOOLEAN) is
			-- Generate byte code for a call to an external. If not `flag',
			-- generate an invariant check before the call.
		local
			nb_protections, i: INTEGER;
			param: EXPR_B;
			has_hector: BOOLEAN;
			parameter_b: PARAMETER_B;
			hector_b: HECTOR_B;
			expr_address_b: EXPR_ADDRESS_B;
			nb_expr_address: INTEGER
			pos: INTEGER
		do
			if parameters /= Void then
					-- Generate the expression address byte code
				from
					parameters.start
				until
					parameters.after
				loop
					parameter_b ?= parameters.item;
					if parameter_b.is_hector then
						has_hector := True;
						expr_address_b ?= parameter_b.expression;
						if expr_address_b /= Void and then expr_address_b.is_protected then
							expr_address_b.generate_expression_byte_code (ba);
							nb_expr_address := nb_expr_address + 1;
						end
					end
					parameters.forth;
				end

				from
					parameters.start
				until
					parameters.after
				loop
					param := parameters.item;
					param.make_byte_code (ba);
					if 	(not param.is_hector)
						and then
						context.real_type (param.type).c_type.is_pointer
					then
						ba.append (Bc_protect);
						nb_protections := nb_protections + 1;
					end;
					parameters.forth;
				end;
			end;

			if has_hector then
				from
					 parameters.start
				until
					parameters.after
				loop
					pos := pos + 1;
					parameter_b ?= parameters.item;
					if parameter_b.is_hector then
						hector_b ?= parameter_b.expression;
						if hector_b /= Void then
							hector_b.make_protected_byte_code (ba, parameters.count - pos);
						else
								-- Cannot be Void
							expr_address_b ?= parameter_b.expression;
							if expr_address_b.is_protected then
								i := i + 1;
								expr_address_b.make_protected_byte_code (ba,
									parameters.count - pos,
									parameters.count + nb_expr_address - i);
							end
						end
					end
					parameters.forth;
				end
			end

			standard_make_code (ba, flag);

			if System.java_generation then
				-- Add info about name of external

				ba.append (Bc_java_external)

				if feature_name /= Void then
					ba.append_raw_string (feature_name)
				else
					ba.append_raw_string ("-no name-")
				end

				if external_name /= Void then
					ba.append_raw_string (external_name)
				else
					ba.append_raw_string ("-no name-")
				end
			end

			make_java_typecode (ba)

				-- Generation hector realease if any
			if nb_protections > 0 then
				ba.append (Bc_release);
				ba.append_short_integer (nb_protections);
			end;
			if nb_expr_address > 0 then
				ba.append (Bc_pop)
				ba.append_uint32_integer (nb_expr_address)
			end
		end;

	make_precursor_byte_code (ba: BYTE_ARRAY) is
			-- Add dynamic type of parent.
		do
			ba.append_short_integer (-1)
		end;

	code_first: CHARACTER is
			-- Code when external call is first (no invariant)
		local
			class_type: CL_TYPE_I;
		do
			class_type ?= context_type;
			if class_type /= Void and then class_type.is_separate then
					-- It's only possible for creation feature call.
				Result := Bc_sep_extern;
			else
				Result := Bc_extern;
			end;
		end;

	code_next: CHARACTER is
			-- Code when external call is nested (invariant)
		local
			class_type: CL_TYPE_I;
		do
			class_type ?= context_type;
			if class_type /= Void and then class_type.is_separate then
				Result := Bc_sep_extern_inv;
			else
				Result := Bc_extern_inv;
			end;
		end;

	precomp_code_first: CHARACTER is
			-- Code when external precompiled call is first (no invariant)
		local
			class_type: CL_TYPE_I;
		do
			class_type ?= context_type;
			if class_type /= Void and then class_type.is_separate then
					-- It's only possible for creation feature call.
				Result := Bc_sep_pextern;
			else
				Result := Bc_pextern;
			end;
		end;

	precomp_code_next: CHARACTER is
			-- Code when external precompiled call is nested (invariant)
		local
			class_type: CL_TYPE_I;
		do
			class_type ?= context_type;
			if class_type /= Void and then class_type.is_separate then
				Result := Bc_sep_pextern_inv;
			else
				Result := Bc_pextern_inv;
			end;
		end;

feature -- Array optimization

	is_unsafe: BOOLEAN is
		do
				-- An external call can have access to the entire system
				-- and move. resize objects. Thus it is unsafe to call
				-- an external feature.
			Result := True
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			if parameters /= Void then
				parameters := parameters.optimized_byte_node
			end
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			if parameters /= Void then
				Result := parameters.calls_special_features (array_desc)
			end
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
		do
			Result := Current
			if parameters /= Void then
				parameters := parameters.inlined_byte_code
			end
		end

feature -- Concurrent Eiffel

	attach_loc_to_sep: BOOLEAN is
			-- Does the feature call attach a local object to separate formal
			-- parameter?
		local
			p: PARAMETER_B;
		do
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
			if system.has_separate and  parameters /= Void then
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


		make_end_byte_code (ba: BYTE_ARRAY; flag: BOOLEAN;
					real_feat_id: INTEGER; static_type: INTEGER) is
			-- Make final portion of the standard byte code.
		local
			my_code: CHARACTER;
			class_type: CL_TYPE_I;
		do
			if  is_first or flag then
				my_code := code_first;
			else
				my_code := code_next;
			end;
			ba.append (my_code);
			if my_code = Bc_sep_extern or my_code = Bc_sep_extern_inv then
			-- "Bc_sep_extern" is impossible, delete it later.
					-- keep parameter number
				if parameters /= Void then
					ba.append_short_integer (parameters.count);
				else
					ba.append_short_integer (0);
				end;
					-- keep the class name of the target of the feature call
				class_type ?= context_type; -- Can't fail
				ba.append_raw_string (class_type.base_class.name_in_upper);
					-- keep the feature name of the feature call
				ba.append_raw_string (feature_name);
					-- keep the return value's type;
				ba.append_uint32_integer (Context.real_type (type).sk_value);
					-- keep if the acknowledgement for the proc. is necessary
				if attach_loc_to_sep then
					ba.append ('%/001/');
				else
					ba.append ('%/000/');
				end;
			end
			if  my_code = Bc_extern_inv then
					-- Generate feature name for test of void reference
				ba.append_raw_string (feature_name);
			end;
				-- Generate feature id
			ba.append_integer (real_feat_id);
			ba.append_short_integer (static_type);
		end;

	make_end_precomp_byte_code (ba: BYTE_ARRAY; flag: BOOLEAN;
					origin: INTEGER; offset: INTEGER) is
			-- Make final portion of the standard byte code
			-- for a precompiled call.
		local
			my_code: CHARACTER;
			class_type: CL_TYPE_I;
		do
			if  is_first or flag then
				my_code := precomp_code_first;
			else
				my_code := precomp_code_next;
			end;
			ba.append (my_code);
			if my_code = Bc_sep_pextern or my_code = Bc_sep_pextern_inv then
			-- Bc_sep_pfeature is impossible, delete it later.
					-- keep parameter number
				if parameters /= Void then
					ba.append_short_integer (parameters.count);
				else
					ba.append_short_integer (0);
				end;
					-- keep the class name of the target of the feature call
				class_type ?= context_type; -- Can't fail
				ba.append_raw_string (class_type.base_class.name_in_upper);
					-- keep the feature name of the feature call
				ba.append_raw_string (feature_name);
					-- keep the return value's type;
				ba.append_uint32_integer (Context.real_type (type).sk_value);
					-- keep if the acknowledgement for the proc. is necessary
				if attach_loc_to_sep then
					ba.append ('%/001/');
				else
					ba.append ('%/000/');
				end;
			end
			if  my_code = Bc_pextern_inv  then
					-- Generate feature name for test of void reference
				ba.append_raw_string (feature_name);
			end;
			ba.append_integer (origin);
			ba.append_integer (offset);
		end;
																	  
end
