class EXPORT_ITEM_AS

inherit

	AST_EIFFEL;
	SHARED_EXPORT_STATUS;

feature -- Attributes

	clients: CLIENT_AS;
			-- Client list

	features: FEATURE_SET_AS;
			-- Feature set

feature -- Initialization

	set is
			-- Yacc initialization
		do
			clients ?= yacc_arg (0);
			features ?= yacc_arg (1);
		end;

feature -- Export status computing

	update (export_adapt: EXPORT_ADAPTATION; parent: PARENT_C) is
			-- Update `export_adapt'.
		local
			export_status: EXPORT_I;
		do
			if clients = Void then
				export_status := Export_all;	
			else
				export_status := clients.export_status; 
			end;
			features.update (export_adapt, export_status, parent);
		end;

end
