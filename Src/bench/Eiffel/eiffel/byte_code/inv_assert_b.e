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
				buf.putstring ("RTIT(")
				buf.putchar ('"')
				buf.putstring (tag)
				buf.putchar ('"')
				buf.putstring (gc_comma)
			else
				buf.putstring ("RTIS(")
			end
			context.Current_register.print_register
			buf.putstring (gc_rparan_semi_c)
			buf.new_line
				-- Now evaluate the expression
			expr.generate
			buf.putstring (gc_if_l_paran)
			expr.print_register
			buf.putstring (") {")
			generate_success (buf)
			buf.putstring (gc_lacc_else_r_acc)
			generate_failure (buf)
			buf.putchar ('}')
			buf.new_line
		end

end
