indexing

	description: "Abstract description of a type declaration.";
	date: "$Date$";
	revision: "$Revision$"

class TYPE_DEC_AS

inherit

	AST_EIFFEL
		redefine
			simple_format
		end;

feature -- Attributes

	id_list: EIFFEL_LIST [ID_AS];
			-- List of ids

	type: TYPE;
			-- Type

feature -- Initialization

	set is
			-- Yacc initialization
		do
			id_list ?= yacc_arg (0);
			type ?= yacc_arg (1);
		ensure then
			good_list: id_list /= Void;
			type_exists: type /= Void
		end;

feature -- Incrementality

	reset is
		do
			id_list.start
		end;

feature -- Status report

	has_id (i: ID_AS): BOOLEAN is
			-- Does current type declaration contain
			-- id `i'?
		local
			cur: CURSOR
		do
			cur := id_list.cursor
			from
				id_list.start
			until
				id_list.after or else Result
			loop
				Result := id_list.item.is_equal (i)
				id_list.forth
			end;
	
			id_list.go_to (cur)
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.set_separator (ti_Comma);
			ctxt.space_between_tokens;
			id_list.simple_format (ctxt);
			ctxt.put_text_item (ti_Colon);
			ctxt.put_space;
			type.simple_format(ctxt);
			ctxt.commit;
		end;

feature {TYPE_DEC_AS, LOCALS_MERGER} -- Replication

	set_type (t: like type) is
		require
			valid_t: t /= Void
		do
			type := t
		end; 

	set_id_list (id: like id_list) is
		require
			valid_t: id /= Void
		do
			id_list := id
		end; 

feature -- Debug

	trace is
		do
			type.trace;
			io.error.putstring (id_list.tagged_out);
			from
				id_list.start
			until
				id_list.after
			loop
				io.error.putstring ("Name: ");
				io.error.putstring (id_list.item);
				io.error.new_line;
				id_list.forth
			end;
		end

end -- class TYPE_DEC_AS
