-- Abstract description of a type declaration

class TYPE_DEC_AS

inherit

	AST_EIFFEL

feature -- Attributes

	id_list: EIFFEL_LIST [ID_AS];
			-- List of ids

	type: TYPE;
			-- Type

feature -- Initialization

	set is
			-- Yacc initialization
		do
			id_list ?= yacc_arg (0);
			type ?= yacc_arg (1);
		ensure then
			good_list: id_list /= Void;
			type_exists: type /= Void
		end;

end
