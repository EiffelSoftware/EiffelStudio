class FEATURE_CLAUSE_AS

inherit

	AST_EIFFEL;
	SHARED_EXPORT_STATUS;

feature -- Attributes

	clients: CLIENT_AS;
			-- Client list

	features: EIFFEL_LIST [FEATURE_AS];
			-- Features

feature -- Initialization

	set is
			-- Yacc initialization
		do
			clients ?= yacc_arg (0);
			features ?= yacc_arg (1);
		ensure then
			features_exists: features /= Void;
		end;

feature -- Export status computing

	export_status: EXPORT_I is
			-- Export status of the clause
		do
			if clients /= Void then
				Result := clients.export_status;
			else
				Result := Export_all;
			end;
		end;

end
