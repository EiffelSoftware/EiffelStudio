class EXPORT_ITEM_AS

inherit

	AST_EIFFEL

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
			if clients /= Void then
				ctxt.set_separator (ti_Comma);
				ctxt.set_space_between_tokens;
				ctxt.format_ast (clients);
				ctxt.put_space
			end;
			ctxt.format_ast (features);
		end;

end -- class EXPORT_ITEM_AS
