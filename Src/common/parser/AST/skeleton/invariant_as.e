indexing

	description: 
		"AST representation of a class invariant.";
	date: "$Date$";
	revision: "$Revision$"

class INVARIANT_AS

inherit

	AST_EIFFEL
		redefine
			is_invariant_obj, is_equivalent
		end;

feature {AST_FACTORY} -- Initialization

	initialize (a: like assertion_list) is
			-- Create a new INVARIANT AST node.
		do
			assertion_list := a
		ensure
			assertion_list_set: assertion_list = a
		end

feature {NONE} -- Initialization

	set is
			-- Initialization routine.
		do
			assertion_list ?= yacc_arg (0);
		end;

feature -- Properties

	is_invariant_obj: BOOLEAN is True
			-- Is the current object an instance of INVARIANT_AS ?

	assertion_list: EIFFEL_LIST [TAGGED_AS];
			-- Assertion list

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
				-- FIXME: optimize (order doesn't matter)
			Result := equivalent (assertion_list, other.assertion_list)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Invariant_keyword);
			ctxt.indent;
			ctxt.new_line;
			ctxt.set_separator (ti_Semi_colon);
			ctxt.set_new_line_between_tokens;
			if assertion_list /= Void then
				simple_format_assertions (ctxt);
				ctxt.new_line;
				ctxt.new_line;
			end;
			ctxt.exdent;
		end;

	simple_format_assertions (ctxt: FORMAT_CONTEXT) is
			-- Format assertions of this invariant.
		local
			i, l_count: INTEGER;
			not_first: BOOLEAN
		do
			ctxt.begin;
			from
				i := 1;
				l_count := assertion_list.count;
			until
				i > l_count
			loop
				if not_first then
					ctxt.put_separator;
				end;
				ctxt.new_expression;
				assertion_list.i_th(i).simple_format(ctxt);
				not_first := True
				i := i + 1
			end;
			ctxt.commit;
		end;

feature {COMPILER_EXPORTER}

	set_assertion_list (a: like assertion_list) is
		do
			assertion_list := a
		end;

end -- class INVARIANT_AS
