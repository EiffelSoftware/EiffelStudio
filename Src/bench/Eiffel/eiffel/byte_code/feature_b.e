indexing
	description	: "Byte code generation for feature call."
	date: "$Date$"
	revision: "$Revision$"

class FEATURE_B 

inherit
	CALL_ACCESS_B
		redefine
			is_feature, set_parameters, 
			parameters, enlarged, context_type,
			is_feature_special, make_special_byte_code,
			is_unsafe, optimized_byte_node,
			calls_special_features, is_special_feature,
			is_il_feature_special,
			size, pre_inlined_code, inlined_byte_code,
			make_precursor_byte_code
		end

	SHARED_TABLE

	SHARED_SERVER

create
	make

feature {NONE} -- Initialization

	make (f: FEATURE_I; t: like type; p_type: like precursor_type) is
			-- Initialization
		require
			good_argument: f /= Void
		local
			feat: FEATURE_I
			feat_tbl: FEATURE_TABLE
		do
			feature_name_id := f.feature_name_id
			body_index := f.body_index
			routine_id := f.rout_id_set.first
			is_once := f.is_once
			is_process_relative := f.is_process_relative
			precursor_type := p_type
			type := t
			if System.il_generation then
				if precursor_type = Void then
						-- Normal feature call.
					if f.origin_class_id /= 0 then
						feature_id := f.origin_feature_id
						written_in := f.origin_class_id
					else
							-- Case of a non-external Eiffel routine
							-- written in an external class.
						feature_id := f.feature_id
						written_in := f.written_in
					end
				else
						-- Precursor access, we need to find where body
						-- is defined. It is slow since we have to do a lookup
						-- in the parent feature table but we do not have
						-- much choice at the moment. The good thing is that
						-- since it is done at degree 3, we are most likely
						-- to hit the feature table cache.
					written_in := f.written_in
					feat_tbl := System.class_of_id (written_in).feature_table
					feat := feat_tbl.feature_of_rout_id_set (f.rout_id_set)
					feature_id := feat.feature_id
				end
			else
				feature_id := f.feature_id
				written_in := f.written_in
			end
		end

feature -- Access

	type: TYPE_I
			-- Type of the call

	body_index: INTEGER
			-- Body Index of the feature

	is_once: BOOLEAN
			-- Is the current feature a once feature?
			--| Used when inlining is turned on in final mode, because we are not
			--| allowed to inline once routines

	is_process_relative: BOOLEAN
			-- Is current feature process-relative?

	parameters: BYTE_LIST [PARAMETER_B]
			-- Feature parameters: can be Void

	set_parameters (p: like parameters) is
			-- Assign `p' to `parameters'.
		do
			parameters := p
		end 

	set_type (t: TYPE_I) is
			-- Assign `t' to `type'.
		do
			type := t
		end

	special_routines: SPECIAL_FEATURES is
			-- Array containing special routines.
		once
			create Result
		end

	il_special_routines: IL_SPECIAL_FEATURES is
			-- Array containing special routines.
		once
			create Result
		end

	is_il_feature_special (cl_type: CL_TYPE_I): BOOLEAN is
			-- Is feature optimized for IL generation?
		do
			Result := il_special_routines.has (Current, cl_type)
		end

	is_feature_special (compilation_type: BOOLEAN; target_type: BASIC_I): BOOLEAN is
			-- Search for feature_name in special_routines.
			-- This is used for simple types only.
			-- If found return True (and keep reference position).
			-- Otherwize, return false
		do
			Result := special_routines.has (feature_name_id, compilation_type, target_type)
		end

	is_feature: BOOLEAN is True
			-- Is Current an access to an Eiffel feature ?

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			feature_b: FEATURE_B
		do
			feature_b ?= other
			if feature_b /= Void then
				Result := feature_id = feature_b.feature_id
			end
		end

	enlarged: FEATURE_B is
			-- Enlarge the tree to get more attributes and return the
			-- new enlarged tree node.
		local
			feature_bl: FEATURE_BL
		do
			if context.final_mode then
				create feature_bl
			else
				create {FEATURE_BW} feature_bl.make
			end
			feature_bl.fill_from (Current)
			Result := feature_bl
		end

feature -- Context type

	context_type: TYPE_I is
			-- Context type of the access (properly instantiated)
		do
			if precursor_type = Void then
				Result := Precursor {CALL_ACCESS_B}
			else
				Result := Context.real_type (precursor_type)
			end
		end

feature -- IL code generation

	generate_il_call (inv_checked: BOOLEAN) is
			-- Generate IL code for feature call.
			-- If `invariant_checked' generates invariant check
			-- before call.
		local
			cl_type: CL_TYPE_I
			return_type: TYPE_I
			native_array_class_type: NATIVE_ARRAY_CLASS_TYPE
			special_array_class_type: SPECIAL_CLASS_TYPE
			is_special_handled: BOOLEAN
			invariant_checked: BOOLEAN
			class_c: CLASS_C
			local_number: INTEGER
			real_metamorphose: BOOLEAN
			need_generation: BOOLEAN
			target_type: CL_TYPE_I
			l_count: INTEGER
		do
				-- Get type on which call will be performed.
			cl_type ?= context_type
			check
				valid_type: cl_type /= Void
			end

				-- Let's find out if we are performing a call on a basic type
				-- or on an enum type. This happens only when we are calling
				-- magically added feature on basic types.
			if is_il_feature_special (cl_type) then
				il_special_routines.generate_il (Current, cl_type, parameters)
			else
					-- Find location of feature.
				target_type ?= il_generator.implemented_type (written_in, cl_type)
				check
					target_type_not_void: target_type /= Void
				end

				class_c := cl_type.base_class

				if class_c.is_native_array then
					native_array_class_type ?= cl_type.associated_class_type
					check
						native_array_class_type_not_void: native_array_class_type /= Void
					end
				end
				
				invariant_checked := (context.workbench_mode or
					class_c.assertion_level.check_invariant) and then (not is_first or inv_checked)
					and then (native_array_class_type = Void)
				
				if cl_type.is_expanded then
						-- Current type is expanded. We need to find out if
						-- we need to generate a box operation, meaning that
						-- the feature is inherited from a non-expanded class.
					real_metamorphose := need_real_metamorphose (cl_type)
				end

				if is_first then
						-- First call in dot expression, we need to generate Current
						-- only when we do not call a static feature.
					if cl_type.is_reference then
							-- Normal call, we simply push current object.
						il_generator.generate_current
					else
						if real_metamorphose then
								-- Feature is written in an inherited class of current
								-- expanded class. We need to box.
							generate_il_metamorphose (cl_type, target_type, real_metamorphose)
						end
					end
				elseif cl_type.is_expanded then
						-- A metamorphose is required to perform call.
					generate_il_metamorphose (cl_type, target_type, real_metamorphose)
				end

				if invariant_checked then
						-- Need two copies of current object in stack
						-- to perform invariant check before and after
						-- feature call.
					il_generator.duplicate_top
					if inv_checked then
						il_generator.duplicate_top
						il_generator.generate_invariant_checking (cl_type)
					end
				end

				if class_c.is_special then
					special_array_class_type ?= cl_type.associated_class_type
					check
						special_array_class_type_not_void: special_array_class_type /= Void
					end
					inspect
						feature_name_id
					when
						{PREDEFINED_NAMES}.Item_name_id,
						{PREDEFINED_NAMES}.Infix_at_name_id,
						{PREDEFINED_NAMES}.Put_name_id
					then
						special_array_class_type.prepare_generate_il (feature_name_id, cl_type)
						is_special_handled := True
					else
					end
				end

				if parameters /= Void then
						-- Generate parameters if any.
					if
						native_array_class_type /= Void and then
						feature_name_id = {PREDEFINED_NAMES}.put_name_id
					then
						check
							parameters_count_is_two: parameters.count = 2
						end
						parameters.i_th (1).generate_il
						if parameters.i_th (2).type.is_true_expanded then
							native_array_class_type.generate_il_put_preparation (cl_type)
						end
						parameters.i_th (2).generate_il
					else
						parameters.generate_il
					end
					l_count := parameters.count
				end

				return_type := real_type (type)

				need_generation := True

				if native_array_class_type /= Void then
					need_generation := False
					native_array_class_type.generate_il (feature_name_id, cl_type)
					if System.il_verifiable then
						if 
							not return_type.is_expanded and then
							not return_type.is_none and then
							not return_type.is_void
						then
							il_generator.generate_check_cast (Void, return_type)
						end
					end
				elseif is_special_handled then
					special_array_class_type.generate_il (feature_name_id, cl_type)
					need_generation := False
					if System.il_verifiable then
						if 
							not return_type.is_expanded and then
							not return_type.is_none and then
							not return_type.is_void
						then
							il_generator.generate_check_cast (Void, return_type)
						end
					end
				end
				
				if need_generation then
						-- Perform call to feature
					if is_any_feature and precursor_type = Void then
						generate_il_any_call (target_type, cl_type,
							cl_type.is_reference or else real_metamorphose)
					else
						generate_il_normal_call (target_type,
							cl_type.is_reference or else real_metamorphose) 
					end
				end
				if invariant_checked then
					if type.is_void then
						il_generator.generate_invariant_checking (cl_type)
					else
							-- It is a function and we need to save the result onto
							-- a local variable.
						context.add_local (return_type)
						local_number := context.local_list.count
						il_generator.put_dummy_local_info (return_type, local_number)
						il_generator.generate_local_assignment (local_number)
						il_generator.generate_invariant_checking (cl_type)
						il_generator.generate_local (local_number)
					end
				end
			end
		end

feature {NONE} -- IL code generation

	generate_il_any_call (written_type, target_type: TYPE_I; is_virtual: BOOLEAN) is
			-- Generate call to routine of ANY that works for both ANY and SYSTEM_OBJECT
		require
			il_generation: System.il_generation
			is_any_feature: is_any_feature
			written_type_not_void: written_type /= Void
			target_type_not_void: target_type /= Void
			not_precursor_call: precursor_type = Void
		do
		end

	generate_il_normal_call (target_type: TYPE_I; is_virtual: BOOLEAN) is
			-- Normal feature call.
		require
			target_type_not_void: target_type /= Void
		local
			l_count: INTEGER
			l_return_type: TYPE_I
		do
			if parameters /= Void then
				l_count := parameters.count
			end

			l_return_type := context.real_type (type)

			if precursor_type /= Void then
					-- In IL, if you can call Precursor, it means that parent is
					-- not expanded and therefore we can safely generate a static
					-- call to Precursor feature.
				il_generator.generate_precursor_feature_access (
					target_type, feature_id, l_count, not l_return_type.is_void)
			else
				il_generator.generate_feature_access (
					target_type, feature_id, l_count, not l_return_type.is_void,
					is_virtual)
			end
			if System.il_verifiable then
				if 
					not l_return_type.is_expanded and then
					not l_return_type.is_none and then
					not l_return_type.is_void
				then
					il_generator.generate_check_cast (Void, l_return_type)
				end
			end
		end

	is_any_feature: BOOLEAN is
			-- Is Current an instance of ANY_FEATURE_B?
		do
		end

feature -- Byte code generation

	make_code (ba: BYTE_ARRAY; flag: BOOLEAN) is
			-- Generate byte code for a feature call. If not `flag', generate
			-- an invariant check before the call.
		local
			i, pos, nb_expr_address: INTEGER
			param: EXPR_B
			has_hector: BOOLEAN
			parameter_b: PARAMETER_B
			hector_b: HECTOR_B
			expr_address_b: EXPR_ADDRESS_B
			access_expression_b: ACCESS_EXPR_B
		do
			if parameters /= Void then
					-- Generate the expression address byte code
				from
					parameters.start
				until
					parameters.after
				loop
					parameter_b ?= parameters.item
					if parameter_b /= Void and then parameter_b.is_hector then
						has_hector := True
						expr_address_b ?= parameter_b.expression
						if expr_address_b /= Void and then expr_address_b.is_protected then
							expr_address_b.generate_expression_byte_code (ba)
							nb_expr_address := nb_expr_address + 1
						end
					end
					parameters.forth
				end

				has_hector := has_hector or else (parent /= Void and then parent.target.is_hector)

					-- Generate byte code for parameters
				from
					parameters.start
				until
					parameters.after
				loop
					param := parameters.item
					param.make_byte_code (ba)
					parameters.forth
				end
			end

			if has_hector then
				if (parent /= Void and then parent.target.is_hector) then
						-- We are in the case of a nested calls which have
						-- a target using the `$' operator. It can only be the case
						-- of `($a).f (..)'. where `($a)' represents an
						-- ACCESS_EXPR_B object which contains an HECTOR_B
						-- or an EXPR_ADDESS_B object.
					access_expression_b ?= parent.target
					check
						has_access_expression: access_expression_b /= Void
					end
					hector_b ?= access_expression_b.expr
					if hector_b /= Void then
						hector_b.make_protected_byte_code (ba, parameters.count)
					else
						expr_address_b ?= parameter_b.expression
						check
							expr_address_b_not_void: expr_address_b /= Void
						end
						if expr_address_b.is_protected then
							i := i + 1
							expr_address_b.make_protected_byte_code (ba,
								parameters.count,
								parameters.count + nb_expr_address - i)
						end
					end
				end
				from
					parameters.start
				until
					parameters.after
				loop
					pos := pos + 1
					parameter_b ?= parameters.item
					if parameter_b /= Void and then parameter_b.is_hector then
						hector_b ?= parameter_b.expression
						if hector_b /= Void then
							hector_b.make_protected_byte_code (ba, parameters.count - pos)
						else
								-- Cannot be Void
							expr_address_b ?= parameter_b.expression
							if expr_address_b.is_protected then
								i := i + 1
								expr_address_b.make_protected_byte_code (ba,
									parameters.count - pos,
									parameters.count + nb_expr_address - i)
							end
						end
					end
					parameters.forth
				end
			end

			standard_make_code (ba, flag)

			if nb_expr_address > 0 then
				ba.append (Bc_pop)
				ba.append_uint32_integer (nb_expr_address)
			end
		end

	make_special_byte_code (ba: BYTE_ARRAY; basic_type: BASIC_I) is
			-- Make byte code for special calls.
		do
			special_routines.make_byte_code (ba, basic_type)
		end

	make_precursor_byte_code (ba: BYTE_ARRAY) is
			-- Add dynamic type of parent.
		local
			cl_type_i: CL_TYPE_I
		do
			if precursor_type /= Void then
					if context.class_type.is_generic then
						cl_type_i := precursor_type.instantiation_in (context.class_type)
						ba.append_short_integer (cl_type_i.associated_class_type.static_type_id - 1)
					else
						ba.append_short_integer (precursor_type.associated_class_type.static_type_id - 1)
					end
			else
				ba.append_short_integer (-1)
			end
		end

	code_first: CHARACTER is
			-- Code when Eiffel call is first (no invariant)
		once
			Result := Bc_feature
		end

	code_next: CHARACTER is
			-- Code when Eiffel call is nested (invariant)
		once
			Result := Bc_feature_inv
		end

	precomp_code_first: CHARACTER is
			-- Code when Eiffel precompiled call is first (no invariant)
		once
			Result := Bc_pfeature
		end

	precomp_code_next: CHARACTER is
			-- Code when Eiffel precompiled call is nested (invariant)
		once
			Result := Bc_pfeature_inv
		end

feature -- Array optimization

	is_special_feature: BOOLEAN is
		local
			cl_type: CL_TYPE_I
			base_class: CLASS_C
			f: FEATURE_I
			dep: DEPEND_UNIT
		do
			cl_type ?= context_type -- Cannot fail
			base_class := cl_type.base_class
			f := base_class.feature_table.item_id (feature_name_id)
			create dep.make (base_class.class_id, f)
			Result := optimizer.special_features.has (dep)
		end

	is_unsafe: BOOLEAN is
		local
			cl_type: CL_TYPE_I
			base_class: CLASS_C
			f: FEATURE_I
			dep: DEPEND_UNIT
		do
			cl_type ?= context_type -- Cannot fail
			base_class := cl_type.base_class
			f := base_class.feature_table.item_id (feature_name_id)
debug ("OPTIMIZATION")
	io.error.put_string ("%N%N%NTESTING is_unsafe for ")
	io.error.put_string (feature_name)
	io.error.put_string (" from ")
	io.error.put_string (base_class.name)
	io.error.put_string (" is NOT safe%N")
end
			optimizer.test_safety (f, base_class)
			create dep.make (base_class.class_id, f)
			Result := (not optimizer.is_safe (dep))
				or else (parameters /= Void and then parameters.is_unsafe)
debug ("OPTIMIZATION")
	if Result then
		io.error.put_string (f.feature_name)
		io.error.put_string (" from ")
		io.error.put_string (base_class.name)
		io.error.put_string (" is NOT safe%N")
	end
end
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
			inlined_current_b: INLINED_CURRENT_B
		do
			if parent /= Void then
				Result := Current
			else
				create parent
				create inlined_current_b
				parent.set_target (inlined_current_b)
				inlined_current_b.set_parent (parent)

				parent.set_message (Current)

				Result := parent
			end
			type := real_type (type)
			if precursor_type /= Void then
				precursor_type ?= real_type (precursor_type)
			end
			if parameters /= Void then
				parameters := parameters.pre_inlined_code
			end
		end

	inlined_byte_code: FEATURE_B is
		local
			inlined_feat_b: INLINED_FEAT_B
			inline: BOOLEAN
			inliner: INLINER
			type_i: TYPE_I
			cl_type: CL_TYPE_I
			bc: STD_BYTE_CODE
			old_c_t: CLASS_TYPE
		do
			if not is_once then
				type_i := context_type
				if not type_i.is_basic then
					cl_type ?= type_i -- Cannot fail
						-- Inline only if it is not polymorphic and if it can be inlined.
					if Eiffel_table.is_polymorphic (routine_id, cl_type.type_id, True) = -1 then
						inliner := System.remover.inliner
						inline := inliner.inline (type, body_index)
					end
				end
			end

			if inline then
					-- Creation of a special node for the entire
					-- feature (descendant of STD_BYTE_CODE)
				inliner.set_current_feature_inlined
				if cl_type.base_class.is_special then
					create {SPECIAL_INLINED_FEAT_B} inlined_feat_b
				else
					create inlined_feat_b
				end
				inlined_feat_b.fill_from (Current)
				bc ?= Byte_server.disk_item (body_index)

				old_c_t := Context.class_type
				Context.set_class_type (current_class_type)
				bc := bc.pre_inlined_code
				Context.set_class_type (old_c_t)

				inlined_feat_b.set_inlined_byte_code (bc)
				Result := inlined_feat_b
			else
				Result := Current
				if parameters /= Void then
					parameters := parameters.inlined_byte_code
				end
			end
		end

	current_class_type: CLASS_TYPE is
			-- Current type for the call (NOT the static type but the
			-- type corresponding to the written in class)
		local
			written_class	: CLASS_C
			tuple_class		: TUPLE_CLASS_B
			original_feature: FEATURE_I
			m				: META_GENERIC
			true_gen		: ARRAY [TYPE_I]
			real_target_type: TYPE_A
			actual_type		: TYPE_A
			constraint		: TYPE_A
			formal_a		: FORMAL_A
			nb_generics, i	: INTEGER
			l_formal_dec: FORMAL_DEC_AS
		do
			original_feature := context_type.type_a.associated_class.
									feature_table.origin_table.item (routine_id)
			written_class := original_feature.written_class

			if written_class.generics = Void then
				Result := written_class.types.first
			else
				tuple_class ?= written_class
				if tuple_class /= Void then
					Result := tuple_class.types.first
				else
					real_target_type := context_type.type_a
						-- LINKED_LIST [STRING] is recorded as LINKED_LIST [REFERENCE_I]
						-- => LINKED_LIST [ANY] after previous call

					from
						i := 1
						nb_generics := written_class.generics.count
						create m.make (nb_generics)
						create true_gen.make (1, nb_generics)
					until
						i > nb_generics
					loop
						l_formal_dec := written_class.generics.i_th (1)
						create formal_a.make (l_formal_dec.is_reference, l_formal_dec.is_expanded, i)
						actual_type := formal_a.instantiation_in (real_target_type, written_class.class_id)

						if actual_type.is_expanded then
							m.put (actual_type.type_i, i)
						else
							constraint := written_class.constraint (i)
							m.put (constraint.type_i, i)
						end						
						true_gen.put (actual_type.type_i, i)
						i := i + 1
					end

					Result := (create {GEN_TYPE_I}.make (written_class.class_id, m, true_gen)).associated_class_type
				end
			end
		end

end
