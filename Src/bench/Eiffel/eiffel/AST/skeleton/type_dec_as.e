indexing
	description:
		"Abstract description of a type declaration. %
		%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class TYPE_DEC_AS

inherit
	AST_EIFFEL
		redefine 
			fill_calls_list, replicate, is_equivalent
		end

	SHARED_NAMES_HEAP

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

feature -- Access

	id_list: ARRAYED_LIST [INTEGER]
			-- List of ids

	type: TYPE
			-- Type

	item_name (i: INTEGER): STRING is
			-- Name of `id' at position `i'.
		require
			valid_index: id_list.valid_index (i)
		do
			Result := Names_heap.item (id_list.i_th (i))
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equal (id_list, other.id_list) and then
				equivalent (type, other.type)
		end

feature  -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			type.fill_calls_list (l)
				--| useful for like ... only
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to Replication
		do
			Result := clone (Current)
			Result.set_type (clone (type))
			Result.set_id_list (clone (id_list))
				--| useful for like ... only
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			l_names_heap: like Names_heap
		do
			ctxt.set_separator (ti_Comma)
			ctxt.set_space_between_tokens

			from
				l_names_heap := Names_heap
				id_list.start
			until
				id_list.after
			loop
				ctxt.put_text_item (
					create {LOCAL_TEXT}.make (l_names_heap.item (id_list.item))
				)
				id_list.forth
				if not id_list.after then
					ctxt.put_separator
				end
			end

			ctxt.put_text_item_without_tabs (ti_Colon)
			ctxt.put_space
			ctxt.format_ast (type)
		end

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
