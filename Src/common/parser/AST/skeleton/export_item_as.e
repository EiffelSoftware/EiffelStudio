class EXPORT_ITEM_AS

inherit

	AST_EIFFEL
		redefine
			simple_format
		end;

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

feature -- Simple formatting

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			if clients /= Void then
				ctxt.set_separator (ti_Comma);
				ctxt.space_between_tokens;
				clients.simple_format (ctxt);
				ctxt.put_space
			end;
			features.simple_format (ctxt);
			ctxt.commit
		end;

end -- class EXPORT_ITEM_AS
