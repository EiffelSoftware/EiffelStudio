indexing
	description	: "Byte code for instruction inside a require."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class REQUIRE_B 

inherit
	ASSERT_B
		redefine
			generate, process
		end
	
feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_require_b (Current)
		end
	
feature 

	fill_from (a: ASSERT_B) is
			-- Initialization
		require
			good_argument: not (a = Void)
		do
			expr := a.expr.enlarged
				-- Make sure the expression has never been analyzed before
			expr.unanalyze
			tag := a.tag
		end

	generate is
			-- Generate assertion
		local
			buf: GENERATION_BUFFER
			first_generated: BOOLEAN
		do
			buf := buffer

			if Context.is_new_precondition_block then
				first_generated := Context.is_first_precondition_block_generated 
				if first_generated then
					buf.put_string ("RTJB;")
					buf.put_new_line
				end
				Context.generate_current_label_definition
				Context.inc_label
				if first_generated then
					buf.put_string ("RTCK;")
					buf.put_new_line
				else
					Context.set_first_precondition_block_generated (True)
				end
				Context.set_new_precondition_block (False)
			end
				
				-- generate a debugger hook
			generate_frozen_debugger_hook

				-- Generate the recording of the assertion
			if tag /= Void then
				buf.put_string ("RTCT(")
				buf.put_character ('"')
				buf.put_string (tag)
				buf.put_character ('"')
				buf.put_string (gc_comma)
			else
				buf.put_string ("RTCS(")
			end
			generate_assertion_code (context.assertion_type)
			buf.put_string (gc_rparan_semi_c)
			buf.put_new_line

				-- Now evaluate the expression
			expr.generate
			buf.put_string ("RTTE(")
			expr.print_register
			buf.put_string (gc_comma)
			context.print_current_label
			buf.put_string (gc_rparan_semi_c)
			buf.put_new_line
			buf.put_string ("RTCK;")
			buf.put_new_line
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
