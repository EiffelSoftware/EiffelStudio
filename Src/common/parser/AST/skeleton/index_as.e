-- Abstract description of an item in the class indexing list

class INDEX_AS

inherit

	AST_EIFFEL
		redefine
			format
		end

feature -- Attributes

	tag: ID_AS;
			-- Tag of the index list

	index_list: EIFFEL_LIST [ATOMIC_AS];
			-- Indexes

feature -- Initialization

	set is
			-- Yacc initialization
		do
			tag ?= yacc_arg (0);
			index_list ?= yacc_arg (1);
		ensure then
			list_exists: index_list /= Void;
		end;

	
	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			tag.format (ctxt);
			ctxt.put_special(": ");
			ctxt.no_new_line_between_tokens;
			ctxt.set_separator(", ");
			ctxt.separator_is_special;
			index_list.format (ctxt);
			ctxt.commit;
		end;

end
