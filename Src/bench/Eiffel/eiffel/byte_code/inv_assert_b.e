indexing
	description	: "Byte code for instruction inside an invariant clause."
	date		: "$Date$"
	revision	: "$Revision$"

class INV_ASSERT_B 

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
		do
			buf := buffer
				-- Generate the recording of the assertion
			if tag /= Void then
				buf.put_string ("RTIT(")
				buf.put_character ('"')
				buf.put_string (tag)
				buf.put_character ('"')
				buf.put_string (gc_comma)
			else
				buf.put_string ("RTIS(")
			end
			context.Current_register.print_register
			buf.put_string (gc_rparan_semi_c)
			buf.put_new_line
				-- Now evaluate the expression
			expr.generate
			buf.put_string (gc_if_l_paran)
			expr.print_register
			buf.put_string (") {")
			generate_success (buf)
			buf.put_string (gc_lacc_else_r_acc)
			generate_failure (buf)
			buf.put_character ('}')
			buf.put_new_line
		end

end
