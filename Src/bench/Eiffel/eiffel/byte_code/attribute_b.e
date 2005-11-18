indexing
	description: "Access to an Eiffel attribute"
	date: "$Date$"
	revision: "$Revision$"

class ATTRIBUTE_B

inherit

	CALL_ACCESS_B
		rename
			feature_id as attribute_id,
			feature_name_id as attribute_name_id,
			feature_name as attribute_name
		redefine
			reverse_code, expanded_assign_code, assign_code,
			enlarged, is_creatable, is_attribute, read_only,
			assigns_to, pre_inlined_code, generate_il_call_access,
			need_target, generate_il_address
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_attribute_b (Current)
		end

feature

	type: TYPE_I
			-- Attribute type

	read_only: BOOLEAN is False
			-- Is the access only a read-only one ?

	set_type (t: TYPE_I) is
			-- Assign `t' to `type'.
		do
			type := t
		end

	init (a: FEATURE_I) is
			-- Initialization
		require
			good_argument: a /= Void
			is_attribute: a.is_attribute
		local
			l_attr: ATTRIBUTE_I
		do
			l_attr ?= a
			attribute_name_id := l_attr.feature_name_id
			routine_id := l_attr.rout_id_set.first
			if System.il_generation then
				attribute_id := l_attr.origin_feature_id
				written_in := l_attr.origin_class_id
			else
				attribute_id := l_attr.feature_id
				written_in := l_attr.written_in
			end
			if l_attr.extension /= Void then
				need_target := l_attr.extension.need_current (l_attr.extension.type)
			else
				need_target := True
			end
		end

	need_target: BOOLEAN
			-- Does current call really need a target to be performed?
			-- E.g. not a static external field

	is_attribute: BOOLEAN is True
			-- Is Current an access to an attribute ?

	is_creatable: BOOLEAN is True
			-- Can an access to an attribute be a target for a creation ?

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			attribute_b: ATTRIBUTE_B
		do
			attribute_b ?= other
			if attribute_b /= Void then
				Result := attribute_id = attribute_b.attribute_id
			end
		end

	enlarged: ATTRIBUTE_B is
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		local
			attr_bl: ATTRIBUTE_BL
		do
			if context.final_mode then
				create attr_bl
			else
				create {ATTRIBUTE_BW} attr_bl
			end
			attr_bl.fill_from (Current)
			Result := attr_bl
		end

feature -- IL code generation

	generate_il_address is
			-- Generate address of current attribute.
		local
			cl_type: CL_TYPE_I
		do
			cl_type ?= context_type
			il_generator.generate_current
			il_generator.generate_attribute_address (
				il_generator.implemented_type (written_in, cl_type),
				Context.real_type (type),
				attribute_id)
		end

	generate_il_call_access (is_target_of_call: BOOLEAN) is
			-- Generate IL code for an access to an attribute variable.
		local
			l_need_address: BOOLEAN
		do
			l_need_address := need_address (is_target_of_call)
			generate_il_call_attribute (True, l_need_address)
		end

	generate_il_call (invariant_checked: BOOLEAN) is
		do
			generate_il_call_attribute (invariant_checked, False)
		end

	generate_il_call_attribute (invariant_checked, address_required: BOOLEAN) is
			-- Generate IL code for feature call.
			-- If `invariant_checked' generates invariant check
			-- before call.
		require
			il_generation: system.il_generation
		local
			r_type: TYPE_I
			cl_type: CL_TYPE_I
			target_type: TYPE_I
			target_attribute_id: INTEGER
			l_feature_call: FEATURE_B
			l_cancel_attribute_generation: BOOLEAN
		do
				-- Type of attribute in current context
			r_type := Context.real_type (type)

			if r_type.is_none then
					-- Accessing Void attribute from ANY
				il_generator.put_default_value (r_type)
			else
					-- Type of class which defines current attribute.
				cl_type ?= context_type
				if cl_type.is_expanded and then not cl_type.is_external then
						-- Access attribute directly.
					target_type := cl_type
					target_attribute_id := cl_type.base_class.feature_of_rout_id (routine_id).feature_id
				else
					target_type := il_generator.implemented_type (written_in, cl_type)
					target_attribute_id := attribute_id
				end

				check
					valid_type: cl_type /= Void
				end

				if is_first and need_target then
						-- Accessing attribute written in current analyzed class.
					if address_required and not context.associated_class.is_single then
							-- We need current target which will be used later on in
							-- NESTED_B.generate_il to assign back the new value of the attribute.
						il_generator.generate_current
					end
					il_generator.generate_current
				elseif cl_type.is_basic then
						-- A metamorphose is required to perform call.
					generate_il_metamorphose (cl_type, target_type, need_real_metamorphose (cl_type))
				end

					-- Let's try to prepare call to `XXX.attribute.copy' in
					-- case of `attribute' is a basic type.
				if parent /= Void and r_type.is_basic then
					l_feature_call ?= parent.message
						-- It is safe to use `cl_type' because previous value is not used
						-- after this point.
					cl_type ?= r_type
					if
						l_feature_call /= Void and then
						l_feature_call.is_il_feature_special (cl_type) and then
						l_feature_call.Il_special_routines.function_type =
							{IL_SPECIAL_FEATURES}.set_item_type
					then
							-- Since we do not need to load attribute value onto the stack,
							-- we cancel the attribute generation.
							-- IL_SPECIAL_FEATURES.generate_set_item will know that Object
							-- where Current belongs is on top of the stack.
						l_cancel_attribute_generation := True
					end
				end

				if not l_cancel_attribute_generation then
						-- We push code to access Current attribute.
					if address_required then
						il_generator.generate_attribute_address (target_type,
							r_type, target_attribute_id)
					else
						if target_type.is_generated_as_single_type then
							il_generator.generate_attribute (need_target, target_type, target_attribute_id)
						else
							il_generator.generate_feature_access (target_type,
								target_attribute_id, 0, True, True)
						end

							-- Generate cast if we have to generate verifiable code
							-- since attribute might have been redefined and in this
							-- case its type for IL generation is the one from the
							-- parent not the redefined one. Doing the cast enable
							-- the verifier to find out that what we are doing is
							-- correct.
						if
							system.il_verifiable and then not r_type.is_expanded
							and then not r_type.is_none
						then
							il_generator.generate_check_cast (Void, r_type)
						end
					end
				end
			end
		end

feature -- Byte code generation

	assign_code: CHARACTER is
			-- Assignment code to an attribute
		local
			cl_type: CL_TYPE_I
		do
			cl_type ?= context_type
			if cl_type /= Void and then cl_type.base_class.is_precompiled then
				Result := {BYTE_CONST}.bc_passign
			else
				Result := {BYTE_CONST}.bc_assign
			end
		end

	expanded_assign_code: CHARACTER is
			-- Expanded assignment code to an attribute
		local
			cl_type: CL_TYPE_I
		do
			cl_type ?= context_type
			if cl_type /= Void and then cl_type.base_class.is_precompiled then
				Result := {BYTE_CONST}.bc_pexp_assign
			else
				Result := {BYTE_CONST}.bc_exp_assign
			end
		end

	reverse_code: CHARACTER is
			-- Reverse assignment code
		local
			cl_type: CL_TYPE_I
		do
			cl_type ?= context_type
			if cl_type /= Void and then cl_type.base_class.is_precompiled then
				Result := {BYTE_CONST}.bc_preverse
			else
				Result := {BYTE_CONST}.bc_reverse
			end
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := attribute_id = i
		end

feature -- Inlining

	pre_inlined_code: ATTRIBUTE_B is
		local
			inlined_attr_b: INLINED_ATTR_B
		do
			type := real_type (type)
			if parent /= Void then
				Result := Current
			else
				create inlined_attr_b
				inlined_attr_b.fill_from (Current)
				Result := inlined_attr_b
			end
		end

end
