indexing

	description: "Description of class invariant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class INVARIANT_AS

inherit
	AST_EIFFEL
		redefine
			type_check, byte_node, format
		end

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

feature {AST_FACTORY} -- Initialization

	initialize (a: like assertion_list; oms_count: like once_manifest_string_count) is
			-- Create a new INVARIANT AST node.
		require
			valid_oms_count: oms_count >= 0
		do
			assertion_list := a
			once_manifest_string_count := oms_count
		ensure
			assertion_list_set: assertion_list = a
			once_manifest_string_count_set: once_manifest_string_count = oms_count
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_invariant_as (Current)
		end

feature -- Attribute

	assertion_list: EIFFEL_LIST [TAGGED_AS]
			-- Assertion list

	once_manifest_string_count: INTEGER
			-- Number of once manifest strings

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
				-- FIXME: optimize (order doesn't matter)
			Result := equivalent (assertion_list, other.assertion_list)
		end

feature -- Type check and byte code

	type_check is
			-- Type check invariant clause
		do
			if assertion_list /= Void then
					-- Set the access id analysis level to `is_checking_invariant': only
				   -- features are taken into account.
				context.begin_expression
				context.set_is_checking_invariant (True)
				assertion_list.type_check
					-- Reset the level
				context.set_is_checking_invariant (False)
				context.pop (1)
			end
		end

	byte_node: BYTE_LIST [BYTE_NODE] is
			-- Invariant byte code
		do
			if assertion_list /= Void then
					-- Intialization of the access line
				context.access_line.start

				Result := assertion_list.byte_node
			end
		end
	
feature -- Formatter

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.continue_on_failure
			ctxt.set_new_line_between_tokens
			if assertion_list /= Void then
				format_assertions (ctxt)
			end
			if ctxt.last_was_printed then
				ctxt.commit
			else
				ctxt.rollback
			end
		end

	format_assertions (ctxt: FORMAT_CONTEXT) is
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			from
				ctxt.begin
				i := 1
				l_count := assertion_list.count
			until
				i > l_count
			loop
				ctxt.begin
				if not_first then
					ctxt.put_separator
				end
				ctxt.new_expression
				assertion_list.i_th (i).format(ctxt)
				if ctxt.last_was_printed then
					not_first := True
					ctxt.commit
				else
					ctxt.rollback
				end
				i := i + 1
			end
			if not_first then
				ctxt.exdent
				ctxt.commit
			else
				ctxt.rollback
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Invariant_keyword)
			ctxt.indent
			ctxt.put_new_line
			ctxt.set_new_line_between_tokens
			if assertion_list /= Void then
				simple_format_assertions (ctxt)
				ctxt.put_new_line
				ctxt.put_new_line
			end
			ctxt.exdent
		end

	simple_format_assertions (ctxt: FORMAT_CONTEXT) is
			-- Format assertions of this invariant.
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			ctxt.begin
			from
				i := 1
				l_count := assertion_list.count
			until
				i > l_count
			loop
				if not_first then
					ctxt.put_separator
				end
				ctxt.new_expression
				assertion_list.i_th(i).simple_format(ctxt)
				not_first := True
				i := i + 1
			end
			ctxt.commit
		end

feature {COMPILER_EXPORTER}

	set_assertion_list (a: like assertion_list) is
		do
			assertion_list := a
		end

end -- class INVARIANT_AS
