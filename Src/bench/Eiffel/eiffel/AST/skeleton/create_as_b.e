class CREATE_AS

inherit

	AST_EIFFEL

feature -- Attributes

	clients: CLIENT_AS;
			-- Client list

	feature_list: EIFFEL_LIST [FEATURE_NAME];
			-- Feature list

feature -- Initialization

	set is
			-- Yacc initialization
		do
			clients ?= yacc_arg (0);
			feature_list ?= yacc_arg (1);
		ensure then
			feature_list /= Void
		end;
					
end
