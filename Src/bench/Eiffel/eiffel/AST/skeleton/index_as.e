indexing

	 description:
			"Abstract description of an item in the class indexing list. %
			%Version for Bench."
	 date: "$Date$"
	 revision: "$Revision$"

class INDEX_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			tag ?= yacc_arg (0)
			index_list ?= yacc_arg (1)
		ensure then
			list_exists: index_list /= Void
		end

feature -- Attributes

	tag: ID_AS
			-- Tag of the index list

	index_list: EIFFEL_LIST [ATOMIC_AS]
			-- Indexes

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (tag, other.tag) and
				equivalent (index_list, other.index_list)
		end

	is_equiv (other: like Current): BOOLEAN is
		do
			Result := equivalent (tag, other.tag) and then
						equivalent (index_list, other.index_list)
		end

feature -- Case storage

	is_description_tag: BOOLEAN is
		local
			tmp: STRING
		do
			if tag /= Void then
				tmp := clone (tag)
				tmp.to_lower
				Result := tmp.is_equal ("description") 
			end
		end

	storage_info: S_TAG_DATA is
		local
			txt: STRING
			tmp: STRING
		do
			!! txt.make (0)
			if index_list /= Void then
				from
					index_list.start
				until
					index_list.after
				loop
					txt.append (index_list.item.string_value)
					index_list.forth
					if not index_list.after then
						txt.append (", ")
					end
				end
			end

			if tag = Void then
				!! Result.make (Void, txt)
			else
				!! Result.make (tag.string_value, txt)
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if tag /= Void then
				ctxt.format_ast (tag)
				ctxt.put_text_item_without_tabs (ti_Colon)
				ctxt.put_space
			end

			ctxt.set_space_between_tokens
			ctxt.set_separator (ti_Comma)
			ctxt.format_ast (index_list)
		end
	
end -- class INDEX_AS
