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
			if tag /= Void then
				tag.format (ctxt);
				ctxt.put_special(": ");
			end;
			ctxt.no_new_line_between_tokens;
			ctxt.set_separator(", ");
			ctxt.separator_is_special;
			index_list.format (ctxt);
			ctxt.commit;
		end;

feature -- Case storage

	storage_info: S_TEXT_DATA is
		local
			txt: STRING
		do
			!! txt.make (0);
			if tag /= Void then
				txt.append (tag.string_value);
				txt.append (": ");
			end;
			from
				index_list.start
			until
				index_list.after
			loop
				txt.append (index_list.item.string_value);
				index_list.forth;
				if not index_list.after then
					txt.append (", ");
				end;
			end;
			!! Result.make (txt)
		end;

end
