indexing

	description: "Abstract description of an item in the class indexing list.";
	date: "$Date$";
	revision: "$Revision$"

class INDEX_AS

inherit

	AST_EIFFEL

feature -- Attributes

	tag: ID_AS;
			-- Tag of the index list

	index_list: EIFFEL_LIST [ATOMIC_AS];
			-- Indexes

feature -- Equivalence

	is_equiv (other: like Current): BOOLEAN is
		do
			Result := deep_equal (tag, other.tag) and then
						deep_equal (index_list, other.index_list)
		end;

feature -- Initialization

	set is
			-- Yacc initialization
		do
			tag ?= yacc_arg (0);
			index_list ?= yacc_arg (1);
		ensure then
			list_exists: index_list /= Void;
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if tag /= Void then
				ctxt.format_ast (tag);
				ctxt.put_text_item_without_tabs (ti_Colon);
				ctxt.put_space
			end;

			ctxt.set_space_between_tokens;
			ctxt.set_separator (ti_Comma);
			ctxt.format_ast (index_list);
		end;
	
end -- class INDEX_AS
