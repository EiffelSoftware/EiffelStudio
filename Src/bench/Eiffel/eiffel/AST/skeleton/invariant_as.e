indexing

	description: "Description of class invariant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class INVARIANT_AS

inherit
	AST_EIFFEL
		redefine
			is_invariant_obj, type_check, byte_node, format
		end

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

feature {AST_FACTORY} -- Initialization

	initialize (a: like assertion_list) is
			-- Create a new INVARIANT AST node.
		do
			assertion_list := a
		ensure
			assertion_list_set: assertion_list = a
		end

feature -- Attribute

	assertion_list: EIFFEL_LIST [TAGGED_AS]
			-- Assertion list

feature -- Properties

	is_invariant_obj: BOOLEAN is True
			-- Is the current object an instance of INVARIANT_AS ?

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
					-- Set the access id analysis level to `level2': only
				   -- features are taken into account.
				context.begin_expression
				context.set_level2 (True)
				assertion_list.type_check
					-- Reset the level
				context.set_level2 (False)
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
			ctxt.new_line
			ctxt.set_new_line_between_tokens
			if assertion_list /= Void then
				simple_format_assertions (ctxt)
				ctxt.new_line
				ctxt.new_line
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
