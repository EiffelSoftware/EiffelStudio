-- Access to an Eiffel attribute

class ATTRIBUTE_B 

inherit

	CALL_ACCESS_B
		rename
			feature_id as attribute_id,
			feature_name_id as attribute_name_id,
			feature_name as attribute_name,
			escaped_feature_name as escaped_attribute_name
		redefine
			reverse_code, expanded_assign_code, assign_code,
			make_end_assignment, make_end_reverse_assignment,
			creation_access, enlarged, is_creatable, is_attribute, read_only,
			assigns_to, pre_inlined_code, generate_il_call_access,
			need_target
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

	creation_access (t: TYPE_I): ATTRIBUTE_B is
			-- Creation access
		do
			Result := clone (Current)
			Result.set_type (t)
		end

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
			class_c: CLASS_C
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
				target_type := il_generator.implemented_type (written_in, cl_type)

				check
					valid_type: cl_type /= Void
				end

				if is_first and need_target then
						-- Accessing attribute written in current analyzed class.
					if cl_type.is_reference then
							-- Normal access we simply push current
						il_generator.generate_current
					else
							-- It is declared in an expanded class, we need to
							-- load the address of current register.
						if need_real_metamorphose (cl_type) then
								-- Current attribute is written in a non-expanded class
								-- we need to box current register to be able to
								-- access urrent attribute.
							il_generator.generate_metamorphose (cl_type)
						end
					end
				elseif not cl_type.is_reference then
						-- Current attribute coming from an expanded class need a special
						-- transformation of the `parent' if we want to access it.
						-- If `need_real_metamorphose (cl_type)' a box operation will
						-- occur meaning that current attribute was written in a
						-- non-expanded class.
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
							feature {IL_SPECIAL_FEATURES}.set_item_type
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
					class_c := System.class_of_id (written_in)
					if address_required then
						il_generator.generate_attribute_address (target_type,
							r_type, attribute_id)
					else
						if class_c.is_frozen or class_c.is_single or class_c.is_external then
							il_generator.generate_attribute (need_target, target_type, attribute_id)
						else
							il_generator.generate_feature_access (target_type,
								attribute_id, 0, True, True)
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
				Result := Bc_passign
			else
				Result := Bc_assign
			end
		end

	expanded_assign_code: CHARACTER is
			-- Expanded assignment code to an attribute
		local
			cl_type: CL_TYPE_I
		do
			cl_type ?= context_type
			if cl_type /= Void and then cl_type.base_class.is_precompiled then
				Result := Bc_pexp_assign
			else
				Result := Bc_exp_assign
			end
		end

	make_end_assignment (ba: BYTE_ARRAY) is
			-- Finish the assignment to the current access
		local
			instant_context_type: CL_TYPE_I
			base_class: CLASS_C
			r_id: INTEGER
			rout_info: ROUT_INFO
		do
			instant_context_type ?= context_type
			base_class := instant_context_type.base_class
			if base_class.is_precompiled then
				r_id := base_class.feature_table.item_id (attribute_name_id).rout_id_set.first
				rout_info := System.rout_info_table.item (r_id)
				ba.append_integer (rout_info.origin)
				ba.append_integer (rout_info.offset)
			else
					-- Generate attribute id
				ba.append_integer (attribute_id)
					-- Generate static type of the call
				ba.append_short_integer
					(instant_context_type.associated_class_type.static_type_id - 1)
			end
				-- Generate attribute meta-type
			ba.append_uint32_integer (Context.real_type (type).sk_value)
		end

	reverse_code: CHARACTER is
			-- Reverse assignment code
		local
			cl_type: CL_TYPE_I
		do
			cl_type ?= context_type
			if cl_type /= Void and then cl_type.base_class.is_precompiled then
				Result := Bc_preverse
			else
				Result := Bc_reverse
			end
		end

	make_end_reverse_assignment (ba: BYTE_ARRAY) is
			-- Generate source reverse assignment byte code
		local
			instant_context_type: CL_TYPE_I
			base_class: CLASS_C
			r_id: INTEGER
			rout_info: ROUT_INFO
		do
			instant_context_type ?= context_type
			base_class := instant_context_type.base_class
			if base_class.is_precompiled then
				r_id := base_class.feature_table.item_id (attribute_name_id).rout_id_set.first
				rout_info := System.rout_info_table.item (r_id)
				ba.append_integer (rout_info.origin)
				ba.append_integer (rout_info.offset)
			else
					-- Generate attribute id
				ba.append_integer (attribute_id)
					-- Generate static type of the call
				ba.append_short_integer
					(instant_context_type.associated_class_type.static_type_id - 1)
			end
				-- Generate attribute meta-type
			ba.append_uint32_integer (Context.real_type (type).sk_value)
		end

	make_code (ba: BYTE_ARRAY; flag: BOOLEAN) is
			-- Generate byte code for an access to an attribute
		local
			r_type: TYPE_I
		do
			r_type := Context.real_type (type)
			if r_type.is_none then
				if is_first then
					ba.append (Bc_current)
				end
				ba.append (Bc_void)
			else
				standard_make_code (ba, flag)
				ba.append_uint32_integer (r_type.sk_value)
			end
		end

	code_first: CHARACTER is
			-- Byte code when access is first (no invariant)
		once	
			Result := Bc_attribute
		end

	code_next: CHARACTER is
			-- Byte code when access is nested (invariant)
		once
			Result := Bc_attribute_inv
		end

	precomp_code_first: CHARACTER is
			-- Byte code when precompiled access is first (no invariant)
		once
			Result := Bc_pattribute
		end

	precomp_code_next: CHARACTER is
			-- Byte code when precompiled access is nested (invariant)
		once
			Result := Bc_pattribute_inv
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
			if parent /= Void then
				Result := Current
			else
				create inlined_attr_b
				inlined_attr_b.fill_from (Current)
				Result := inlined_attr_b
			end
		end

end
