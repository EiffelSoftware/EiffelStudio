indexing
	description: "Objects that stores all the info needed for validity checking of a declaration%N%
			%of a generic class with its generic creation constraint part"
	author: "Emmanuel STAPF"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTRAINT_CHECKING_INFO

creation
	make

feature -- Initialization

	make (
			g_type_a: GEN_TYPE_A;
			f_dec_as: FORMAL_DEC_AS
			c_type: TYPE_A;
			c_class: CLASS_C;
			t_check: TYPE_A;
			pos: INTEGER;
			formal: FORMAL_A) is
				-- Initialize all the fields.
		do
			gen_type_a := g_type_a
			formal_dec_as := f_dec_as
			constraint_type := c_type
			context_class := c_class
			to_check := t_check
			i := pos
			formal_type := formal
		end

feature -- Access

	gen_type_a: GEN_TYPE_A
			-- Actual generic class on which we are doing the checking

	formal_dec_as: FORMAL_DEC_AS
			-- Formal description of the constraint in the original generic class.

	constraint_type: TYPE_A
			-- Type of the constraint in the original generic class.

	context_class: CLASS_C
			-- Class where the occurrence of `gen_type_a' appears
			
	to_check: TYPE_A
			-- Type of the declaration of the `i'-th elements of `gen_type_a'.

	i: INTEGER
			-- Position in `gen_type_a' where the declaration is done.

	formal_type: FORMAL_A
			-- Is `to_check' a formal type in `context_class'?

end -- class CONSTRAINT_CHECKING_INFO
