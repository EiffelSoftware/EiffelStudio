class EXPORT_ITEM_AS_B

inherit

	EXPORT_ITEM_AS
		redefine
			clients, features
		end;

	AST_EIFFEL_B;

	SHARED_EXPORT_STATUS;

feature -- Attributes

	clients: CLIENT_AS_B;
			-- Client list

	features: FEATURE_SET_AS_B;
			-- Feature set

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

end -- class EXPORT_ITEM_AS_B
