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

feature -- Attributes

	tag: ID_AS_B;
			-- Tag of the index list

	index_list: EIFFEL_LIST_B [ATOMIC_AS_B];
			-- Indexes

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
			if index_list /= Void then
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
			end

			if tag = Void then
				!! Result.make (Void, txt)
			else
				!! Result.make (tag.string_value, txt)
			end
		end;

end -- class INDEX_AS_B
