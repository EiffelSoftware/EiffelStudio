class EXPORT_ITEM_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

	SHARED_EXPORT_STATUS

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			clients ?= yacc_arg (0)
			features ?= yacc_arg (1)
		end

feature -- Attributes

	clients: CLIENT_AS
			-- Client list

	features: FEATURE_SET_AS
			-- Feature set

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (clients, other.clients) and
				equivalent (features, other.features)
		end

feature -- Export status computing

	update (export_adapt: EXPORT_ADAPTATION; parent: PARENT_C) is
			-- Update `export_adapt'.
		local
			export_status: EXPORT_I
		do
			if clients = Void then
				export_status := Export_all;	
			else
				export_status := clients.export_status; 
			end
			features.update (export_adapt, export_status, parent)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if clients /= Void then
				ctxt.set_separator (ti_Comma)
				ctxt.set_space_between_tokens
				ctxt.format_ast (clients)
				ctxt.put_space
			end
			ctxt.format_ast (features)
		end

end -- class EXPORT_ITEM_AS
