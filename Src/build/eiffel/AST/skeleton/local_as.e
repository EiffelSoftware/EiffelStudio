-- Abstract description of local declarations

class LOCAL_AS

inherit

	AST_EIFFEL

feature -- Attributes

	declarations: EIFFEL_LIST [TYPE_DEC_AS];
			-- Local lists of ids and types

feature -- Initialization

	set is
			-- Yacc initialization
		do
			declarations ?= yacc_arg (0);
		end;

end

