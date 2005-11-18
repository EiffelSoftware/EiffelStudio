indexing
	description: "Eiffel Call and Access"
	date: "$Date$"
	version: "$Revision$"

deferred class
	CALL_ACCESS_B

inherit
	ACCESS_B
		redefine
			generate_il
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	DEBUG_OUTPUT
		export
			{NONE} all
		end

feature -- Access

	feature_id: INTEGER
			-- Feature id of the called feature.

	feature_name_id: INTEGER
			-- Feature name ID of called feature.

	feature_name: STRING is
			-- Feature name called
		require
			feature_name_id_set: feature_name_id > 0
		do
			Result := Names_heap.item (feature_name_id)
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end

	routine_id: INTEGER
			-- Routine ID for the access (used in final mode generation)

	written_in: INTEGER
			-- Class ID where Current is written.

	precursor_type : CL_TYPE_I
			-- Type of parent in a precursor call if any.

feature -- Setting

	set_precursor_type (p_type : CL_TYPE_I) is
			-- Assign `p_type' to `precursor_type'.
		require
			p_type_not_void: p_type /= Void
			not_attribute: not is_attribute
		do
			precursor_type := p_type
		ensure
			precursor_set : precursor_type = p_type
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for feature call.
		do
			generate_il_call (False)
		end

	generate_il_call (invariant_checked: BOOLEAN) is
			-- Generate IL code for feature call.
			-- If `invariant_checked' generates invariant check
			-- before call.
		require
			il_generation: System.il_generation
		deferred
		end

	generate_il_call_invariant (cl_type: CL_TYPE_I) is
			-- Generate IL code for calling invariant feature on class type `cl_type'.
		require
			cl_type_not_void: cl_type /= Void
		do
			if cl_type.is_true_expanded then
					-- Box object before checking its class invariant
				il_generator.generate_load_from_address (cl_type)
				il_generator.generate_metamorphose (cl_type)
			end
			il_generator.generate_invariant_checking (cl_type)
		end

	generate_il_call_invariant_leading (cl_type: CL_TYPE_I; is_checked_before_call: BOOLEAN) is
			-- Generate IL code for calling invariant feature on class type `cl_type'
			-- before associated feature call if `is_checked_before_call' is true.
			-- Object on which a class invariant has
			-- to be checked has to be on the evaluation stack.
			-- It is preserved for the subsequent invariant check after feature call.
		require
			cl_type_not_void: cl_type /= Void
		do
				-- Need two copies of current object in stack
				-- to perform invariant check before and after
				-- feature call.
			il_generator.duplicate_top
			if is_checked_before_call then
				il_generator.duplicate_top
				generate_il_call_invariant (cl_type)
			end
		end

	generate_il_call_invariant_trailing (cl_type: CL_TYPE_I; return_type: TYPE_I) is
			-- Generate IL code for calling invariant feature on class type `cl_type'
			-- after associated feature call with result type `return_type'.
			-- It is assumed that `generate_il_call_invariant_leading' is called
			-- before feature call to make necessary bookkeeping.
		require
			cl_type_not_void: cl_type /= Void
			return_type_not_void: return_type /= Void
		local
			local_number: INTEGER
		do
			if return_type.is_void then
				generate_il_call_invariant (cl_type)
			else
					-- It is a function and we need to save the result onto
					-- a local variable.
				context.add_local (return_type)
				local_number := context.local_list.count
				il_generator.put_dummy_local_info (return_type, local_number)
				il_generator.generate_local_assignment (local_number)
				generate_il_call_invariant (cl_type)
				il_generator.generate_local (local_number)
			end
		end

	need_real_metamorphose (a_type: CL_TYPE_I): BOOLEAN is
			-- Does call originate from a reference type?
		require
			a_type_not_void: a_type /= Void
			a_type_has_associated_class: a_type.base_class /= Void
		local
			class_c: CLASS_C
		do
			class_c := a_type.base_class
			Result := written_in /= class_c.class_id
		end

feature -- Byte code generation

	make_special_byte_code (ba: BYTE_ARRAY; basic_type: BASIC_I) is
			-- Make byte code for special calls.
		do
		end

	real_feature_id: INTEGER is
			-- The feature ID in INTEGER is not necessarily the same as
			-- in the INTEGER_REF class. And likewise for other simple types.
			-- But also for generic derivation which contains an expanded type
			-- as a generic parameter.
		local
			associated_class: CLASS_C
			feat_tbl: FEATURE_TABLE
			instant_context_type: TYPE_I
			basic_type: BASIC_I
			cl_type: CL_TYPE_I
			gen: GEN_TYPE_I
		do
			Result := feature_id
			if precursor_type = Void then
				instant_context_type := context_type
				if
					instant_context_type.is_basic
					and then not instant_context_type.is_bit
				then
						-- We perform a non-optimized call on a basic type
					basic_type ?= instant_context_type
						-- Process the feature id of `feature_name' in the
						-- associated reference type
					associated_class := basic_type.reference_type.base_class
					feat_tbl := associated_class.feature_table
					Result := feat_tbl.item_id (feature_name_id).feature_id
				else
						-- A generic parameter of current class has been derived
						-- into an expanded type, so we need to find the `feature_id'
						-- of the feature we want to call in the context of the
						-- expanded class.
						-- FIXME: Manu 01/24/2000
						-- We do the search even for a generic class which do not
						-- have a generic parameter who has been derived into an expanded type
						-- We could maybe find a way for not performing the check in the
						-- above case.
					gen ?= context.current_type
					if gen /= Void and then instant_context_type.is_true_expanded then
						cl_type ?= instant_context_type
						associated_class := cl_type.base_class
						feat_tbl := associated_class.feature_table
						Result := feat_tbl.item_id (feature_name_id).feature_id
					end
				end
			end
		end

	basic_register: REGISTRABLE is
			-- Register used to store the metamorphosed simple type
		do
		end

	is_feature_call: BOOLEAN is
			-- Is access a feature call?
		do
		end

	generate_parameters_list is
			-- Only for routines and externals
		do
		end

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate access on `reg' in a `typ' context\
		require
			reg_not_void: reg /= Void
			typ_not_void: typ /= Void
		do
		end

	generate_special_feature (reg: REGISTRABLE; basic_type: BASIC_I) is
			-- Generate code for special routines (is_equal, copy ...).
			-- (Only for feature calls)
		require
			reg_not_void: reg /= Void
			basic_type_not_void: basic_type /= Void
		do
		end

	is_il_feature_special (target_type: CL_TYPE_I): BOOLEAN is
			-- Is feature optimized in IL code generation?
		do
		end

	is_feature_special (compilation_type: BOOLEAN; target_type: BASIC_I): BOOLEAN is
			-- Is feature a special routine of class of `target_type'?
			-- (Only for feature calls)
		do
		end

	do_generate (reg: REGISTRABLE) is
			-- Generate call of feature on `reg'
		require
			valid_register: reg /= Void
		local
			type_i: TYPE_I
			class_type: CL_TYPE_I
			basic_type: BASIC_I
			buf: GENERATION_BUFFER
		do
			type_i := context_type
				-- Special provision is made for calls on basic types
				-- (they have to be themselves known by the compiler).
				-- Note: Manu 08/08/2002: if `precursor_type' is not Void, it can only means
				-- that we are currently performing a static access call on a feature
				-- from a basic class. Assuming otherwise is not correct as you
				-- cannot seriously inherit from a basic class.
			if type_i.is_basic and then precursor_type = Void then
				basic_type ?= type_i
				if not basic_type.is_bit and then is_feature_special (True, basic_type) then
					generate_special_feature (reg, basic_type)
				else
					buf := buffer
						-- Generation of metamorphosis is enclosed between (), and
						-- the expressions are separated with ',' which means the C
						-- keeps only the last expression, i.e. the function call.
						-- That way, statements like "s := i.out" are correctly
						-- generated with a minimum of temporaries.
					class_type := basic_type.reference_type
						-- If an invariant is to be checked however, the
						-- metamorphosis was already made by the invariant
						-- checking routine.
					buf.put_character ('(')
					basic_type.metamorphose (basic_register, reg,
									buf, context.workbench_mode)
					buf.put_character (',')
					buf.put_new_line
					buf.put_character ('%T')
					generate_metamorphose_end (basic_register, reg,
									class_type, basic_type, buf)
				end
			else
				class_type ?= type_i;	-- Cannot fail
				generate_end (reg, class_type)
			end
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_I) is
			-- Generate final portion of C code.
		require
			gen_reg_not_void: gen_reg /= Void
			class_type_not_void: class_type /= Void
		local
			buf: GENERATION_BUFFER
		do
			generate_access_on_type (gen_reg, class_type)
				-- Now generate the parameters of the call, if needed.
			if not is_attribute then
				buf := buffer
				buf.put_character ('(')
			end
			if is_feature_call then
				gen_reg.print_register
			end
			if parameters /= Void then
				generate_parameters_list
			end
			if not is_attribute then
				buf.put_character (')')
			end
		end

	generate_metamorphose_end (gen_reg, meta_reg: REGISTRABLE; class_type: CL_TYPE_I;
		basic_type: BASIC_I; buf: GENERATION_BUFFER) is
			-- Generate final portion of C code.
		require
			gen_reg_not_void: gen_reg /= Void
			meta_reg_not_void: meta_reg /= Void
			basic_type_not_void: basic_type /= Void
			buf_not_void: buf /= Void
		do
			generate_end (gen_reg, class_type)

				-- Now generate the parameters of the call, if needed.
			buf.put_string (");")
			buf.put_new_line
			basic_type.end_of_metamorphose (basic_register, meta_reg, buf)
		end

feature {NONE} -- Debug

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			if feature_name_id > 0 then
				Result := Names_heap.item (feature_name_id)
			else
				Result := "Not yet set"
			end
		end

end -- class CALL_ACCESS_B
