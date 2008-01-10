indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
					context.assertion_level.is_check
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
				buf.put_new_line
				if workbench_mode then
					buf.put_string ("if (RTAL & CK_CHECK) {")
					buf.indent
					check_list.generate
					buf.exdent
					buf.put_new_line
					buf.put_character ('}')
				elseif context.assertion_level.is_check then
					buf.put_string ("if (~in_assertion) {")
					buf.indent
					check_list.generate
					buf.exdent
					buf.put_new_line
					buf.put_character ('}')
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
