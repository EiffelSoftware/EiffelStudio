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
				--| A void feature_list implies that we
				--! have an empty creation clause
			feature_list ?= yacc_arg (1);
		end;

feature -- formatter

	format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			last_was_printed: BOOLEAN;
		do
			ctxt.begin;
			ctxt.put_text_item (ti_Creation_keyword);
			ctxt.put_space;
			if clients = void then
				last_was_printed := true
			else
				clients.format(ctxt);
				last_was_printed := ctxt.last_was_printed;
			end;
			if not last_was_printed then 
				ctxt.rollback; -- check whether must retain if short
			else
				if feature_list /= Void then
					ctxt.indent_one_more;
					ctxt.next_line;
					ctxt.set_separator (ti_Comma);
					ctxt.new_line_between_tokens;
					feature_list.format (ctxt);
				end;
				ctxt.commit
			end
		end;
end
