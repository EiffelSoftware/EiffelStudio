class CHECK_B 

inherit
	INSTR_B
		redefine
			enlarge_tree, analyze, generate, make_byte_code,
			is_unsafe, optimized_byte_node,
			calls_special_features, size, inlined_byte_code,
			pre_inlined_code, generate_il
		end

	ASSERT_TYPE
		export
			{NONE} all
		end
	
feature -- Access

	check_list: BYTE_LIST [BYTE_NODE];
			-- Assertion list {list of ASSERT_B}: can be Void

	set_check_list (c: like check_list) is
			-- Assign `c' to `chcek_list'.
		do
			check_list := c
		end

	enlarge_tree is
			-- Enlarge the generation tree
		do
			if check_list /= Void then
				check_list.enlarge_tree
			end
		end
	
	analyze is
			-- Analyze the assertions
		local
			workbench_mode: BOOLEAN
		do
			if check_list /= Void then
				workbench_mode := context.workbench_mode
				if 	workbench_mode
					or else
					context.assertion_level.check_check
				then
					if workbench_mode then
						context.add_dt_current
					end
					check_list.analyze
				end
			end
		end

	generate is
			-- Generate the assertions
		local
			workbench_mode: BOOLEAN
			buf: GENERATION_BUFFER
		do
			generate_line_info
			if check_list /= Void then
				buf := buffer
				workbench_mode := context.workbench_mode
				context.set_assertion_type (In_check)
				if workbench_mode then
					buf.putstring ("if (RTAL & CK_CHECK) {")
					buf.new_line
					buf.indent
					check_list.generate
					buf.exdent
					buf.putchar ('}')
					buf.new_line
				elseif context.assertion_level.check_check then
					buf.putstring ("if (~in_assertion) {")
					buf.new_line
					buf.indent
					check_list.generate
					buf.exdent
					buf.putchar ('}')
					buf.new_line
				end
			end
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for a check instruction.
		do
			if
				check_list /= Void and then
				context.class_type.associated_class.assertion_level.check_check
			then
				context.set_assertion_type (In_check)
				generate_il_line_info
				check_list.generate_il
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a check instruction.
		do
			if check_list /= Void then
					-- Set assertion type
				context.set_assertion_type (In_check)

				ba.append (Bc_check)
					-- In case, the check assertions won't be checked, we
					-- have to put a jump offset
				ba.mark_forward
					-- Assertion byte code
				check_list.make_byte_code (ba)
					-- Jump offset evaluation
				ba.write_forward
			end
		end

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := check_list /= Void and then
						check_list.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := check_list /= Void and then check_list.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			if check_list /= Void then
				check_list := check_list.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER is
		do
			if check_list /= Void then
				Result := check_list.size
			end
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			if check_list /= Void then
				check_list := check_list.pre_inlined_code
			end
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			if check_list /= Void then
				check_list := check_list.inlined_byte_code
			end
		end

end
