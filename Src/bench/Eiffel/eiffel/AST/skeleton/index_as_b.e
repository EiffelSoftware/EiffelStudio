indexing

	 description:
			"Abstract description of an item in the class indexing list. %
			%Version for Bench.";
	 date: "$Date$";
	 revision: "$Revision$"

class INDEX_AS_B

inherit

	INDEX_AS
		redefine
			tag, index_list
		end;

	AST_EIFFEL_B
		undefine
			simple_format
		redefine
			format
		end

feature -- Attributes

	tag: ID_AS_B;
			-- Tag of the index list

	index_list: EIFFEL_LIST_B [ATOMIC_AS_B];
			-- Indexes

feature -- Initialization

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.begin;
			if tag /= Void then
				tag.format (ctxt);
				ctxt.put_text_item (ti_Colon);
				ctxt.put_space
			end;
			ctxt.space_between_tokens;
			ctxt.set_separator (ti_Comma);
			index_list.format (ctxt);
			ctxt.commit;
		end;

feature -- Case storage

	is_description_tag: BOOLEAN is
		local
			tmp: STRING
		do
			if tag /= Void then
				tmp := clone (tag);
				tmp.to_lower;
				Result := tmp.is_equal ("description") 
			end
		end;

	storage_info: S_TAG_DATA is
		local
			txt: STRING;
			tmp: STRING;
		do
			!! txt.make (0);
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
			if tag = Void then
				!! Result.make (Void, txt)
			else
				!! Result.make (tag.string_value, txt)
			end
		end;

end -- class INDEX_AS_B
