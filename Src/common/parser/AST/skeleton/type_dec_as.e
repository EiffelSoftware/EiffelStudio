indexing

	description: 
		"AST representation of a type declaration.";
	date: "$Date$";
	revision: "$Revision$"

class TYPE_DEC_AS

inherit

	AST_EIFFEL

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

feature {ROUTINE_AS} -- Incrementality

	reset is
		do
			id_list.start
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
