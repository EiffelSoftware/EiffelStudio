class CREATE_AS

inherit

	AST_EIFFEL
		redefine
			simple_format
		end;

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

feature -- Status report

	has_feature_name (f: FEATURE_NAME): BOOLEAN is
			-- Is `f' present in current creation?
		local
			cur: CURSOR
		do
			cur := feature_list.cursor
			
			from
				feature_list.start
			until
				feature_list.after or else Result
			loop
				Result := feature_list.item <= f and feature_list.item >= f
				feature_list.forth
			end

			feature_list.go_to (cur)
		end;

feature -- Simple formatting

	simple_format (ctxt : FORMAT_CONTEXT) is
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
				clients.simple_format(ctxt);
				--last_was_printed := ctxt.last_was_printed;
			end;
			if feature_list /= Void then
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.set_separator (ti_Comma);
				ctxt.new_line_between_tokens;
				feature_list.simple_format (ctxt);
			end;
			ctxt.commit
		end;
			
feature -- Convenience

	set_feature_list (f: like feature_list) is
		do
			feature_list := f
		end;

	set_clients (c: like clients) is
		do
			clients := c
		end;

end -- class CREATE_AS
