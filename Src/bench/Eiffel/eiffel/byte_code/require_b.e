indexing
	description	: "Byte code for instruction inside a require."
	date		: "$Date$"
	revision	: "$Revision$"

class REQUIRE_B 

inherit
	ASSERT_B
		redefine
			generate
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

end
