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

feature -- Attributes

	id_list: EIFFEL_LIST [ID_AS]
			-- List of ids

	type: TYPE
			-- Type

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (id_list, other.id_list) and then
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
			Result.set_id_list (id_list.replicate (ctxt))
				--| useful for like ... only
		end

feature -- Status report

	has_id (i: ID_AS): BOOLEAN is
			-- Does current type declaration contain id `i'?
		local
			cur: CURSOR
		do
			cur := id_list.cursor
			from
				id_list.start
			until
				id_list.after or else Result
			loop
				Result := id_list.item.is_equal (i)
				id_list.forth
			end

			id_list.go_to (cur)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.set_separator (ti_Comma)
			ctxt.set_space_between_tokens

			from
				id_list.start
			until
				id_list.after
			loop
				ctxt.put_text_item (
					create {LOCAL_TEXT}.make (id_list.item)
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
