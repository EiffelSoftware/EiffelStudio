-- ---------------------------------------------------------------
-- Root class for processing polynomials in the Polynomial language
--
-- DESCRIPTION:
-- Read a polynomial from a given file
-- prompt for integer values of the variables and evaluate
-- the polynomial.
--
--	POLYNOMIAL DESCRIPTION 
--       Grammar:
--          	LINE 			=  VARIABLES ":" SUM 
--				VARIABLES	 	=  VAR .. ";" 
--				SUM 			=  DIFF .. "+" 
--				DIFF 			=  PRODUCT .. "-" 
--				PRODUCT 		=  TERM .. "*" 
--				TERM			=  SIMPLE_VAR | INT_CONSTANT | NESTED
--				NESTED			=  "(" SUM ")" 
--
--	Example: 
--		x;y: x*(y+8-(2*x))
--
-- ----------------------------------------------------------------

class PROCESS

inherit

	POLY_LEX

create

	make

feature 

	root_line: LINE;

	make is
		local
			nb_try: INTEGER;
			t_b: BOOLEAN;
			text_name: STRING
		do  
			create root_line.make;
			build (root_line.document);
			io.putstring ("Do you want to test for left recursion? ");
			io.readword;
			io.next_line;
			if io.laststring.is_equal ("y") then
				root_line.print_mode.put (true);
				root_line.expand_all;
				t_b := not root_line.left_recursion;
				root_line.check_recursion;
				if not root_line.left_recursion.item then
					io.putstring ("No left recursion detected%N");
				end
			else
				from
				until
					nb_try < 5 and
					text_name /= Void and then text_name.count > 0
				loop
					io.putstring ("File name with polynom description: ");
					io.readword;
					text_name := io.laststring;
					nb_try := nb_try + 1
				end;
				if nb_try = 5 then
					io.putstring ("*** Demo stopped%N"); 
				else
					root_line.document.set_input_file (text_name);
					root_line.document.get_token;
					root_line.process
				end
			end
		end -- make

end -- class PROCESS

--|----------------------------------------------------------------
--| EiffelParse: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

