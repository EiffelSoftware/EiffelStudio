-- Class_rename_pair       : Name LEX_SD Name
--
-- ExternaL_rename_pair    : /* empty */
--                         | Name LEX_SD Name

class TWO_NAME_SD

inherit

	AST_LACE

feature -- Attributes

	old_name: ID_SD;
			-- Old name

	new_name: ID_SD;
			-- New name

feature -- Initialization

	set is
			-- Yacc initialization
		do
			old_name ?= yacc_arg (0);
			new_name ?= yacc_arg (1)
		end

end
