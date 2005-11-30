class CHECK_B

inherit
	INSTR_B
		redefine
			enlarge_tree, analyze, generate,
			is_unsafe, optimized_byte_node,
			calls_special_features, size, inlined_byte_code,
			pre_inlined_code
		end

	ASSERT_TYPE
		export
			{NONE} all
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_check_b (Current)
		end

feature -- Access

	check_list: BYTE_LIST [BYTE_NODE];
			-- Assertion list {list of ASSERT_B}: can be Void

	end_location: LOCATION_AS
			-- Line number where `end' keyword is located

feature -- Settings

	set_check_list (c: like check_list) is
			-- Assign `c' to `chcek_list'.
		do
			check_list := c
		end

	set_end_location (e: like end_location) is
			-- Set `end_location' with `e'.
		require
			e_not_void: e /= Void
		do
			end_location := e
		ensure
			end_location_set: end_location = e
		end

feature -- Code generation

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
					buf.put_string ("if (RTAL & CK_CHECK) {")
					buf.put_new_line
					buf.indent
					check_list.generate
					buf.exdent
					buf.put_character ('}')
					buf.put_new_line
				elseif context.assertion_level.check_check then
					buf.put_string ("if (~in_assertion) {")
					buf.put_new_line
					buf.indent
					check_list.generate
					buf.exdent
					buf.put_character ('}')
					buf.put_new_line
				end
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
			if context.final_mode and not system.keep_assertions then
					-- Nothing to be done, we do as if there has
					-- been no expressions in `check_list'.
				check_list := Void
			else
				if check_list /= Void then
					check_list := check_list.inlined_byte_code
				end
			end
		end

end
