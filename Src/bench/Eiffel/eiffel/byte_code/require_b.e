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
					buf.putstring ("RTJB;")
					buf.new_line
				end
				Context.generate_current_label_definition
				Context.inc_label
				if first_generated then
					buf.putstring ("RTCK;")
					buf.new_line
				else
					Context.set_first_precondition_block_generated (True)
				end
				Context.set_new_precondition_block (False)
			end
				
				-- generate a debugger hook
			generate_frozen_debugger_hook

				-- Generate the recording of the assertion
			if tag /= Void then
				buf.putstring ("RTCT(")
				buf.putchar ('"')
				buf.putstring (tag)
				buf.putchar ('"')
				buf.putstring (gc_comma)
			else
				buf.putstring ("RTCS(")
			end
			generate_assertion_code (context.assertion_type)
			buf.putstring (gc_rparan_semi_c)
			buf.new_line

				-- Now evaluate the expression
			expr.generate
			buf.putstring ("RTTE(")
			expr.print_register
			buf.putstring (gc_comma)
			if System.has_separate and then expr.has_separate_call then
				context.print_concurrent_label
			else
				context.print_current_label
			end
			buf.putstring (gc_rparan_semi_c)
			buf.new_line
			buf.putstring ("RTCK;")
			buf.new_line
			if Context.has_separate_call_in_precondition then
				buf.exdent
				context.print_concurrent_label
				buf.putchar (':')
				buf.indent
				buf.putstring (" CURSSFC;")
				buf.new_line
			end

		end

end
