class EXPORT_ITEM_AS_B

inherit

	EXPORT_ITEM_AS
		redefine
			clients, features
		end;

	AST_EIFFEL_B
		undefine
			simple_format
		redefine
			format
		end;

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

feature -- formatter

	format (ctxt : FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.begin;
			if clients /= Void then
				ctxt.set_separator (ti_Comma);
				ctxt.space_between_tokens;
				clients.format (ctxt);
				ctxt.put_space
			end;
			features.format (ctxt);
			ctxt.commit
		end;

end -- class EXPORT_ITEM_AS_B
