indexing

	description:
		"Abstract description of a type declaration. %
		%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class TYPE_DEC_AS_B

inherit

	TYPE_DEC_AS
		redefine
			id_list, type
		end;

	AST_EIFFEL_B
		undefine
			simple_format
		redefine 
			format, fill_calls_list, replicate
		end

feature -- Attributes

	id_list: EIFFEL_LIST_B [ID_AS_B];
			-- List of ids

	type: TYPE_B;
			-- Type

feature -- Initialization

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.set_separator (ti_Comma);
			ctxt.space_between_tokens;
			id_list.format (ctxt);
			ctxt.put_text_item (ti_Colon);
			ctxt.put_space;
			type.format(ctxt);
			ctxt.commit;
		end;

feature  -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			type.fill_calls_list (l);
				--| useful for like ... only
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to Replication
		do
			Result := clone (Current);
			Result.set_type (clone (type));
			Result.set_id_list (id_list.replicate (ctxt));
				--| useful for like ... only
		end;

end -- class TYPE_DEC_AS_B
