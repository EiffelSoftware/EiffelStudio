indexing

	description: 
		"List used in abstract syntax trees.";
	date: "$Date$";
	revision: "$Revision $"

class LACE_LIST [T->AST_LACE]

inherit
	AST_LACE
		undefine 
			pass_address, copy, setup, consistent, is_equal
		redefine
			adapt
		end

	CONSTRUCT_LIST [T]

creation
	make, make_filled

feature {COMPILER_EXPORTER}

	adapt is
			-- Adaptation iteration
		local
			l_area: SPECIAL [T]
			i, nb: INTEGER;
		do
			from
				l_area := area
				nb := count;
			until
				i = nb
			loop
				l_area.item (i).adapt;
				i := i + 1
			end
		end

end -- class LACE_LIST [T->AST_LACE]
