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
			type_check
		end

feature {AST_FACTORY} -- Initialization

	initialize (t: like tag; i: like index_list) is
			-- Create a new INDEX AST node.
		require
			i_not_void: i /= Void
		do
			tag := t
			index_list := i
		ensure
			tag_set: tag = t
			index_list_set: index_list = i
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

feature -- Type checking

	type_check is
			-- Type check a unique type
		do
			index_list.type_check
		end

feature {DOCUMENTATION_ROUTINES} -- Access

	content_as_string: STRING is
			-- Merge content into a single string.
		local
			il: like index_list
		do
			create Result.make (20)
			il := index_list
			if il /= Void then
				from
					il.start
				until
					il.after
				loop
					Result.append (il.item.string_value)
					il.forth
					if not il.after then
						Result.append (", ")
					end
				end
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if tag /= Void then
				ctxt.put_text_item (
					create {INDEXING_TAG_TEXT}.make (tag.string_value)
				)
				ctxt.put_text_item_without_tabs (ti_Colon)
				ctxt.put_space
			end
			if index_list /= Void then
				ctxt.set_in_indexing_clause (True)
				ctxt.put_text_item (ti_Before_indexing_content)
				ctxt.set_space_between_tokens
				ctxt.set_separator (ti_Comma)
				ctxt.format_ast (index_list)
				ctxt.put_text_item (ti_After_indexing_content)
				ctxt.set_in_indexing_clause (False)
			end
		end
	
end -- class INDEX_AS
