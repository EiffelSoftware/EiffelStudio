-- Byte code for reverse assignment

class REVERSE_B 

inherit
	ASSIGN_B
		redefine
			enlarged, make_byte_code, generate_il
		end
	
feature -- Enlarging

	enlarged: REVERSE_BL is
			-- Enlarge current node.	
		do
			create Result
			Result.set_target (target.enlarged)
			Result.set_source (source.enlarged)
			Result.set_line_number (line_number)
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
			il_generator.put_default_value (target_type)

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
			target.make_reverse_code (ba, source_type)
		end
		
end
