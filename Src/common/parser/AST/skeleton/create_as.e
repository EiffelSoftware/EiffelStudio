class CREATE_AS

inherit

	AST_EIFFEL
		redefine
			format
		end

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

feature -- formatter

	format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_keyword ("creation ");
--			clients.format(ctxt);
--			if not ctxt.last_was_printed then 
--				ctxt.rollback; -- check whether must retain if short
--			else
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.set_separator(",");
			-- must not fail; check?
				ctxt.new_line_between_tokens;
				feature_list.format (ctxt);
				ctxt.commit
--			end
		end;
end
