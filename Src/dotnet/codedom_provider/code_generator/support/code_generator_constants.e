indexing 
	description: "Shared data for Eiffel code_generator"
	date: "$$"
	revision: "$$"

class
	CODE_GENERATOR_CONSTANTS

feature -- Constants

	Eiffel_file_extension: STRING is "e"
			-- Eiffel file extension.
			
	Cast_expr_local: STRING is "l_cast_exp_"
			-- Constant for assignment attempt local variable name

	Return_var_name: STRING is "l_res"
			-- Constant for dummy function calls return values

end -- class CODE_GENERATOR_CONSTANTS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
