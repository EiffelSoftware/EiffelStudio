
-- Built from the parser

class CLICK_LIST

inherit

	CONSTRUCT_LIST [CLICK_AST]
		rename
			make as construct_list_make
		export
			{ANY} area, lower, upper
		end

creation

	make
	
feature 

	make (n: INTEGER) is
		do
			construct_list_make (n)
		end;

--	clickable_stones (aclass_c: CLASS_C): ARRAY [CLICK_STONE] is
--			-- Equivalent of current with stones for the interface,
--			-- the `aclass_c' argument is needed as a context
--		local
--			pos: INTEGER;
--			a_click_ast: CLICK_AST;
--			new_click_stone: CLICK_STONE
--		do
--			!!Result.make (1, count);
--			from
--				pos := 1
--			until
--				pos > count
--			loop
--				a_click_ast := i_th (pos);
--				!!new_click_stone.make
--					(a_click_ast.node.stone (aclass_c),
--					a_click_ast.start_position,
--					a_click_ast.end_position);
--				Result.put (new_click_stone, pos);
--				pos := pos + 1
--			end
--		end;

	trace is
		local
			i: INTEGER;
		do
			io.error.putstring ("Click list is:%N");
			io.error.putstring (tagged_out);
			io.error.putstring ("Content is:%N");
			from
			until
				i = count
			loop
				i := i + 1;
				io.error.putstring (i_th (i).tagged_out)
			end
		end

end
