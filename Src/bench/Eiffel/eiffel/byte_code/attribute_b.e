-- Access to an Eiffel attribute

class ATTRIBUTE_B 

inherit

	CALL_ACCESS_B
		rename
			feature_id as attribute_id,
			feature_name as attribute_name
		redefine
			reverse_code, expanded_assign_code, assign_code,
			make_end_assignment, make_end_reverse_assignment,
			creation_access, enlarged, is_creatable, is_attribute, read_only,
			assigns_to, pre_inlined_code
		end

feature 

	attribute_name: STRING
			-- name of the accessed attribute

	attribute_id: INTEGER
			-- Feature id: this is the key for the call in workbench mode

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
		do
			attribute_name := a.feature_name
			attribute_id := a.feature_id
			routine_id := a.rout_id_set.first
			written_in := a.written_in
		end

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
				!!attr_bl
			else
				!ATTRIBUTE_BW!attr_bl
			end
			attr_bl.fill_from (Current)
			Result := attr_bl
		end

feature -- IL code generation

	generate_il_call (invariant_checked: BOOLEAN) is
			-- Generate IL code for feature call.
			-- If `invariant_checked' generates invariant check
			-- before call.
		local
			r_type: TYPE_I
			cl_type: CL_TYPE_I
		do
				-- Type of attribute in current context
			r_type := Context.real_type (type)

			if r_type.is_none then
					-- Accessing Void attribute from ANY
				il_generator.put_default_value (r_type)
			else
					-- Type of class which defines current attribute.
				cl_type ?= context_type
				check
					valid_type: cl_type /= Void
				end

				if is_first then
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
					generate_il_metamorphose (cl_type, need_real_metamorphose (cl_type))
				end

					-- We push code to access Current attribute.
				il_generator.generate_attribute (cl_type, attribute_id)

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
					il_generator.generate_check_cast (r_type, r_type)
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
				r_id := base_class.feature_table.item
					(attribute_name).rout_id_set.first
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
				r_id := base_class.feature_table.item
					(attribute_name).rout_id_set.first
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
				!!inlined_attr_b
				inlined_attr_b.fill_from (Current)
				Result := inlined_attr_b
			end
		end

end
