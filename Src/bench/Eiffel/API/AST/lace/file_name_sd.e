class FILE_NAME_SD

inherit

	AST_LACE

feature

	file__name: ID_SD;
			-- File name

	set is
			-- Yacc initialization
		do
			file__name ?= yacc_arg (0);
		end;

end
