indexing
	description: 
		"AST representation of an item in the class indexing list."
	date: "$Date$"
	revision: "$Revision$"

class
	INDEX_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_index_as (Current)
		end

feature -- Attributes

	tag: ID_AS;
			-- Tag of the index list

	index_list: EIFFEL_LIST [ATOMIC_AS];
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

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			if tag /= Void then
--				ctxt.format_ast (tag);
--				ctxt.put_text_item_without_tabs (ti_Colon);
--				ctxt.put_space
--			end
--
--			ctxt.set_space_between_tokens;
--			ctxt.set_separator (ti_Comma);
--			ctxt.format_ast (index_list);
--		end
	
end -- class INDEX_AS
