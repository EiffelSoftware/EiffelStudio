indexing
	description	: "Abstract description ao an alternative of a multi_branch %
				  %instruction. Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class CASE_AS

inherit
	AST_EIFFEL
		redefine
			number_of_breakpoint_slots, is_equivalent, line_number,
			type_check, byte_node, fill_calls_list, replicate
		end

feature {AST_FACTORY} -- Initialization

	initialize (i: like interval; c: like compound; l: INTEGER) is
			-- Create a new WHEN AST node.
		require
			i_not_void: i /= Void
		do
			interval := i
			compound := c
			line_number := l
		ensure
			interval_set: interval = i
			compound_set: compound = c
			line_number_set: line_number = l
		end

feature -- Attributes

	interval: EIFFEL_LIST [INTERVAL_AS]
			-- Interval of the alternative

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and
				equivalent (interval, other.interval)
		end

feature -- Access

	line_number: INTEGER

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points
		do
			if compound /= Void then
				Result := compound.number_of_breakpoint_slots
			end
		end

feature {NONE} -- Type check, byte code production, dead code removal

	type_check is
			-- Type check a multi-branch alternative
		do
			interval.type_check
			if compound /= Void then
				compound.type_check
			end
		end

	byte_node: CASE_B is
			-- Associated byte code
		local
			tmp: BYTE_LIST [BYTE_NODE]
			tmp2: BYTE_LIST [BYTE_NODE]
		do
			tmp := interval.byte_node
			tmp := tmp.remove_voids
			if compound /= Void then
				tmp2 := compound.byte_node
			end
			if tmp /= Void then
				create Result
				Result.set_interval (tmp)
				if compound /= Void then
					Result.set_compound (tmp2)
				end
				Result.set_line_number (line_number)
			end
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do	
			interval.fill_calls_list (l)
			if compound /= Void then
				compound.fill_calls_list (l)
			end
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current)
			Result.set_interval (interval.replicate (ctxt))
			if compound /= Void then
				Result.set_compound (
					compound.replicate (ctxt))
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_When_keyword)
			ctxt.put_space
			ctxt.set_separator (ti_Comma)
			ctxt.set_no_new_line_between_tokens
			ctxt.format_ast (interval)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_Then_keyword)
			ctxt.put_space
			ctxt.new_line
			if compound /= Void then
				ctxt.indent
				ctxt.set_separator (ti_Semi_colon)
				ctxt.set_new_line_between_tokens
				ctxt.format_ast (compound)
				ctxt.new_line
				ctxt.exdent
			end
		end

feature {CASE_AS} -- Replication

	set_interval (i: like interval) is
		require
			valid_arg: i /= Void
		do
			interval := i
		end

	set_compound (c: like compound) is
		do
			compound := c
		end

end -- class CASE_AS
