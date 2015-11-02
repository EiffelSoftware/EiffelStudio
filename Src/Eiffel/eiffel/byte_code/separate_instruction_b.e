note
	description: "A byte node for a separate instruction."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SEPARATE_INSTRUCTION_B

inherit
	INSTR_B
		redefine
			analyze,
			assigns_to,
			calls_special_features,
			enlarge_tree,
			generate,
			inlined_byte_code,
			is_unsafe,
			optimized_byte_node,
			pre_inlined_code,
			size
		end

create
	make

feature {NONE} -- Creation

	make (a: like arguments; c: like compound; e: like end_location)
			-- Create a new separate instruction byte node with the specified
			-- arguments `a', compound `c' and end location `e'
		do
			arguments := a
			compound := c
			end_location := e
		ensure
			arguments_set: arguments = a
			compound_set: compound = c
			end_location_set: end_location = e
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_separate_b (Current)
		end

feature -- Access

	arguments: BYTE_LIST [ASSIGN_B]
			-- Instructions to initialize arguments.

	compound: 	detachable BYTE_LIST [BYTE_NODE]
			-- Compound of the instruction.

	end_location: LOCATION_AS
			-- Line number where `end' keyword is located

feature -- Code generation

	enlarge_tree
			-- Enlarge the generation tree
		do
			arguments.enlarge_tree
			if attached compound as c then
				c.enlarge_tree
			end
		end

	analyze
			-- Analyze the assertions
		local
			has_request_chain: BOOLEAN
		do
			arguments.analyze
			across
				arguments as arg
			until
				has_request_chain
			loop
				if not has_request_chain then
						-- Arguments are attached to object-test-like locals.
					check attached {OBJECT_TEST_LOCAL_B} arg.item.target as t then
						has_request_chain := real_type (t.type).is_separate
					end
				end
			end
				-- Mark current as used if there is a request chain.
			if has_request_chain then
				context.mark_current_used
			end
			if attached compound as c then
				c.analyze
			end
		end

	generate
			-- Generate the assertions
		local
			buf: GENERATION_BUFFER
			has_request_chain: BOOLEAN
			is_first_argument: BOOLEAN
		do
			generate_line_info
			arguments.generate
			if attached compound as c then
				buf:= buffer
				if system.is_scoop then
						-- Generate computation of whether a request chain is required in the form
						--		int uarg;
						--		int uarg1 = RTS_OU (loc1);
						--		...
						--		int uargN = RTS_OU (locN);
						--		RTS_SD
						--		uarg = uarg1 || uarg2 || ... || uargN;
					across
						arguments as arg
					loop
							-- Arguments are attached to object-test-like locals.
						check attached {OBJECT_TEST_LOCAL_B} arg.item.target as t then
							if real_type (t.type).is_separate then
								if not has_request_chain then
									has_request_chain := True
										-- Open a new block to declare variables that are used for separate calls chains.
									buf.put_new_line
									buf.put_character ('{')
									buf.indent
										-- Declare a variable that tells whether a request chain is required.
									buf.put_new_line
									buf.put_string ("int uarg;")
								end
									-- Declare a variable that tells whether this argument is uncontrolled.
								buf.put_new_line
								buf.put_string ("int uarg")
								buf.put_integer (arg.target_index)
								buf.put_string (" = RTS_OU (")
								buf.put_string (t.register_name)
								buf.put_character (')')
								buf.put_character (';')
							end
						end
					end
				end
				if has_request_chain then
						-- Initialize variables.
					buf.put_new_line
					buf.put_string ("RTS_SD;")
					buf.put_new_line
					buf.put_string ("uarg =")
					across
						arguments as arg
					from
						is_first_argument := True
					loop
							-- Arguments are attached to object-test-like locals.
						check attached {OBJECT_TEST_LOCAL_B} arg.item.target as t then
							if real_type (t.type).is_separate then
								if is_first_argument then
									is_first_argument := False
								else
									buf.put_three_character (' ', '|', '|')
								end
								buf.put_string (" uarg")
								buf.put_integer (arg.target_index)
							end
						end
					end
					buf.put_character (';')
						-- Separate arguments should be locked if they are not controlled yet.
						-- Locking is done for all the uncontrolled arguments at once.
						-- A request chain is created for that.
						-- If an argument is controlled, there is no need to lock it again.
						-- The generated code looks like
						--    if (uarg) {
						--       RTS_RC;      // Create request chain.
						--       if (uarg1) RTS_RS (loc1); // Register arguments in the chain.
						--       ...                     // Repeat for other arguments.
						--       RTS_RW;       // Wait until all arguments are locked.
						--    }
					buf.put_new_line
					buf.put_string ("if (uarg) {")
					buf.indent
					buf.put_new_line
					buf.put_string ("RTS_RC;")
					across
						arguments as arg
					loop
							-- Arguments are attached to object-test-like locals.
						check attached {OBJECT_TEST_LOCAL_B} arg.item.target as t then
							if real_type (t.type).is_separate then
								buf.put_new_line
								buf.put_string ("if (uarg")
								buf.put_integer (arg.target_index)
								buf.put_string (") RTS_RS (")
								buf.put_string (t.register_name)
								buf.put_two_character (')', ';')
							end
						end
					end
					buf.put_new_line
					buf.put_string ("RTS_RW;");
					buf.exdent
					buf.put_new_line
					buf.put_character ('}')
				end
					-- Generate compound.
				c.generate
				if has_request_chain then
						-- Generate request chain removal.
					buf.put_new_line
					buf.put_string ("if (uarg) RTS_RD;")
						-- Close block.
					buf.exdent
					buf.put_new_line
					buf.put_character ('}')
				end
			end
		end

feature -- Array optimization

	assigns_to (n: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result := arguments.assigns_to (n) or else
				attached compound as c and then c.assigns_to (n)
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
			Result := arguments.calls_special_features (array_desc) or else
				attached compound as c and then c.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN
		do
			Result := arguments.is_unsafe or else
				attached compound as c and then c.is_unsafe
		end

	optimized_byte_node: like Current
		do
			Result := Current
			arguments := arguments.optimized_byte_node
			if attached compound as c then
				compound := c.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER
		do
			Result := arguments.size
			if attached compound as c then
				Result := Result + c.size
			end
		end

	pre_inlined_code: like Current
		do
			Result := Current
			arguments := arguments.pre_inlined_code
			if attached compound as c then
				compound := c.pre_inlined_code
			end
		end

	inlined_byte_code: like Current
		do
			Result := Current
			arguments := arguments.inlined_byte_code
			if attached compound as c then
				compound := c.inlined_byte_code
			end
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
