indexing

	description: 
		"AST representation of a type declaration.";
	date: "$Date$";
	revision: "$Revision$"

class TYPE_DEC_AS

inherit

	AST_EIFFEL
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (i: like id_list; t: like type) is
			-- Create a new TYPE_DEC AST node.
		require
			i_not_void: i /= Void
			t_not_void: t /= Void
		do
			id_list := i
			type := t
		ensure
			id_list_set: id_list = i
			type_set: type = t
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			id_list ?= yacc_arg (0);
			type ?= yacc_arg (1);
		ensure then
			good_list: id_list /= Void;
			type_exists: type /= Void
		end;

feature -- Properties

	id_list: EIFFEL_LIST [ID_AS];
			-- List of ids

	type: TYPE;
			-- Type

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (id_list, other.id_list) and then
				equivalent (type, other.type)
		end

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

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.set_separator (ti_Comma);
			ctxt.set_space_between_tokens;
			ctxt.format_ast (id_list);
			ctxt.put_text_item_without_tabs (ti_Colon);
			ctxt.put_space;
			ctxt.format_ast (type);
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

end -- class TYPE_DEC_AS
