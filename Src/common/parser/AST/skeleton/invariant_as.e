indexing

	description: "Description of class invariant.";
	date: "$Date$";
	revision: "$Revision$"

class INVARIANT_AS

inherit

	AST_EIFFEL
		redefine
			is_invariant_obj, simple_format
		end;

feature -- Identity

	id: INTEGER;
			-- Class id of the class to which current is the invariant
			-- description

	set_id (i: INTEGER) is
			-- Assign `i' to `id'.
		do
			id := i;
		end; -- set_id

feature -- Attribute

	assertion_list: EIFFEL_LIST [TAGGED_AS];
			-- Assertion list

	set_assertion_list (a: like assertion_list) is
		do
			assertion_list := a
		end;

feature -- Initialization

	set is
			-- Initialization routine
		do
			assertion_list ?= yacc_arg (0);
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_text_item (ti_Before_invariant);
			ctxt.put_text_item (ti_Invariant_keyword);
			ctxt.indent_one_more;
			ctxt.next_line;
			ctxt.set_separator (ti_Semi_colon);
			ctxt.new_line_between_tokens;
			if assertion_list /= Void then
				format_assertions (ctxt);
			end;
			ctxt.commit;
			ctxt.put_text_item (ti_After_invariant)
			ctxt.next_line
		end;

	format_assertions (ctxt: FORMAT_CONTEXT) is
			-- Format assertions of this invariant.
		local
			i, l_count: INTEGER;
			not_first: BOOLEAN
		do
			from
				ctxt.begin;
				i := 1;
				l_count := assertion_list.count;
			until
				i > l_count
			loop
				ctxt.begin;
				if not_first then
					ctxt.put_separator;
				end;
				ctxt.new_expression;
				assertion_list.i_th(i).simple_format(ctxt);
				not_first := True
				ctxt.commit;
				i := i + 1
			end;
			if not_first then
				ctxt.indent_one_less;
				ctxt.commit
			end
		end;

feature -- Conveniences

	is_invariant_obj: BOOLEAN is
			-- Is the current object an instance of INVARIANT_AS ?
		do
			Result := True;
		end;

end -- class INVARIANT_AS
