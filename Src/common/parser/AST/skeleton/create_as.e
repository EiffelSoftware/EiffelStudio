indexing

	description: 
		"AST representation of creation routines.";
	date: "$Date$";
	revision: "$Revision $"

class CREATE_AS

inherit

	AST_EIFFEL
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (c: like clients; f: like feature_list) is
			-- Create a new CREATION clause AST node.
		do
			clients := c
			feature_list := f
		ensure
			clients_set: clients = c
			feature_list_set: feature_list = f
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			clients ?= yacc_arg (0);
				--| A void feature_list implies that we
				--! have an empty creation clause
			feature_list ?= yacc_arg (1);
		end;

feature -- Properties

	clients: CLIENT_AS;
			-- Client list

	feature_list: EIFFEL_LIST [FEATURE_NAME];
			-- Feature list

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (clients, other.clients) and
				equivalent (feature_list, other.feature_list)
		end

feature -- Access

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

feature {AST_EIFFEL} -- Output

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Creation_keyword);
			ctxt.put_space;
			if clients /= void then
				clients.simple_format (ctxt);
			end;
			if feature_list /= Void then
				ctxt.indent;
				ctxt.new_line;
				ctxt.set_separator (ti_Comma);
				ctxt.set_new_line_between_tokens;
				feature_list.simple_format (ctxt);
				ctxt.new_line;
			end;
		end;
			
feature {COMPILER_EXPORTER} -- Convenience

	set_feature_list (f: like feature_list) is
		do
			feature_list := f
		end;

	set_clients (c: like clients) is
		do
			clients := c
		end;

end -- class CREATE_AS
