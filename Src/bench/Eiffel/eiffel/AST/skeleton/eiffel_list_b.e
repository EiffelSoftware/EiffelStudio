-- List used in abstract syntax trees.

class EIFFEL_LIST [T->AST_EIFFEL]

inherit

	AST_EIFFEL
		undefine
			pass_address, twin
		redefine
			byte_node, type_check
		end;
	CONSTRUCT_LIST [T]

creation

	make

feature -- Type check, byte code and dead code removal


	type_check is
			-- Type check iteration
		local
			i, nb: INTEGER;
		do
			from
				nb := count;
				i := 1;
			until
				i > nb
			loop
				i_th (i).type_check;
				i := i + 1
			end;
		end;

	byte_node: BYTE_LIST [BYTE_NODE] is
			-- Byte code list
		local
			i, nb: INTEGER;
		do
			from
				nb := count;
				!!Result.make (nb);
				i := 1;
			until
				i > nb
			loop
				Result.put_i_th (i_th (i).byte_node, i);
				i := i + 1;
			end;
		end;

end
			
