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
			is_equivalent
		redefine 
			fill_calls_list, replicate
		end

feature -- Attributes

	id_list: EIFFEL_LIST_B [ID_AS_B];
			-- List of ids

	type: TYPE_B;
			-- Type

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
