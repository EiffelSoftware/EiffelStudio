-- Byte code for reverse assignment

class REVERSE_B 

inherit
	ASSIGN_B
		redefine
			enlarged, make_byte_code, generate_il
		end

feature -- Access

	info: CREATE_INFO
			-- Keep info about `target' type.
			-- Never Void.

feature -- Settings

	set_info (a_info: like info) is
			-- Set `info' to `a_info'.
		require
			a_info_not_void: a_info /= Void
		do
			info := a_info
		ensure
			info_set: info = a_info
		end

feature -- Enlarging

	enlarged: REVERSE_BL is
			-- Enlarge current node.	
		do
			create Result
			Result.set_target (target.enlarged)
			Result.set_source (source.enlarged)
			Result.set_line_number (line_number)
			Result.set_info (info)
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for a reverse assignment.
		local
			target_type, source_type: TYPE_I
			success_label, failure_label: IL_LABEL
		do
			generate_il_line_info

				-- Code that needs to be generated when performing
				-- assignment to an attribute.
			target.generate_il_start_assignment

				-- Generate expression byte code
			source.generate_il

				-- Get type
			target_type ?= Context.creation_type (target.type)
			check
				target_type_not_void: target_type /= Void
			end

				-- FIXME: At the moment we don't know how to
				-- find out the real type of the generic
				-- parameter, so we cheat.
			if target_type.has_formal then
				target_type ?= real_type (target_type)
			end

			il_generator.duplicate_top

				-- Generate Test on type
			il_generator.generate_is_instance_of (target_type)
			success_label := il_label_factory.new_label
			il_generator.branch_on_true (success_label)

			il_generator.pop
			if target_type.is_expanded then
					-- Assignment attempt failed, we simply load previous
					-- value of `target'.
				target.generate_il
			else			
				il_generator.put_default_value (target_type)
			end

			failure_label := il_label_factory.new_label
			il_generator.branch_to (failure_label)
			
			source_type ?= context.real_type (source.type)

			il_generator.mark_label (success_label)
			if not target_type.is_expanded then
					-- It is not allowed to generate a `cast' when target type
					-- is expanded. But since we cannot redefined expanded
					-- type, we are sure that the type on top of the stack
					-- is the exact type and therefore we don't need the cast.
				il_generator.generate_check_cast (source_type, target_type)
			else
				il_generator.generate_unmetamorphose (target_type)
			end

			il_generator.mark_label (failure_label)

				-- Generate assignment header depending of the type
				-- of the target (local, attribute or result).
			target.generate_il_assignment (source_type)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a reverse assignment
		local
			source_type: TYPE_I
		do
			generate_melted_debugger_hook (ba)

				-- Generate expression byte code
			source.make_byte_code (ba)

			source_type ?= context.real_type (source.type)
			make_reverse_code (ba, source_type)
		end

feature {NONE} -- Implementation

	make_reverse_code (ba: BYTE_ARRAY; source_type: TYPE_I) is
			-- Generate source reverse assignment byte code
		require
			target.is_creatable
			ba_not_void: ba /= Void
			good_argument: source_type /= Void
			consistency: not source_type.is_void
		local
			basic_type: BASIC_I
			target_type: TYPE_I
			cl_type: CL_TYPE_I
			gen_type: GEN_TYPE_I
		do
			target_type := Context.creation_type (target.type)

			check
				not_expanded: not target_type.is_true_expanded
				not_basic: not target_type.is_basic
			end
			if target_type.is_none then
				ba.append (Bc_none_assign)
			else
					-- Target is a reference
				if source_type.is_basic then
						-- Source is basic and target is a reference:
						-- metamorphose and simple attachment
					basic_type ?= source_type
					ba.append (Bc_metamorphose)
				elseif source_type.is_true_expanded then
						-- Source is expanded and target is a reference: clone
						-- and simple attachment
					ba.append (Bc_clone)
				end
				ba.append (target.reverse_code)
				target.make_end_reverse_assignment (ba)

					-- Append the target static type
				cl_type ?= target_type
				ba.append_short_integer (cl_type.type_id - 1)

				ba.append_short_integer (context.current_type.generated_id (False))

					-- Find out if real type of `target' is a generic type. If `target''s type
					-- was either anchored or if `target' was an attribute, `type_to_create'
					-- will return Void to show that we need to use `info' to generate the
					-- proper type information.
				gen_type ?= info.type_to_create
				if gen_type /= Void then
					gen_type.make_gen_type_byte_code (ba, True)
				else
					info.make_reverse_byte_code (ba)
				end
				ba.append_short_integer (-1)
			end
		end

end
