indexing
	description	: "Abstract class representing routines that have a body."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class INTERNAL_AS

inherit
	ROUT_BODY_AS
		redefine
			type_check, byte_node, is_empty,
			has_instruction, index_of_instruction,
			number_of_breakpoint_slots, is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (c: like compound) is
			-- Create a new INTERNAL AST node.
		do
			compound := c
		ensure
			compound_set: compound = c
		end

feature -- Attributes

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound

feature -- test for empty body

	is_empty : BOOLEAN is
		do
			Result := (compound = Void) or else (compound.is_empty)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			if compound /= Void then
				Result := compound.number_of_breakpoint_slots
			end
		end

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does the current routine body has instruction `i'?
		do
			from
				compound.start
			until
				Result or else compound.off
			loop
				Result := equivalent (compound.item, i)
				compound.forth
			end
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this feature.
		do
			from
				compound.start
			until
				compound.off or else equivalent (i, compound.item)
			loop
				compound.forth
			end

			if not compound.off then
				Result := compound.index
			else
				Result := 0
			end
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check compound
		do
			if compound /= Void then
				compound.type_check
			end
		end

	byte_node: STD_BYTE_CODE is
			-- Byte code associated to `compound'
		do
			create Result
			if compound /= Void then
				Result.set_compound (compound.byte_node)
			end
			Result.record_separate_calls_on_arguments
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (begin_keyword)
			ctxt.new_line
			if compound /= Void then
				ctxt.indent
				format_compound (ctxt)
				ctxt.new_line
				ctxt.exdent
			end
		end

	format_compound (ctxt : FORMAT_CONTEXT) is
			-- Special formatting for compounds.
			-- A semicolon is needed at the end of a line when current line
			-- ends with a call with no arguments and the next line starts
			-- with an opening parenthesis. Example:
			--		do_nothing;
			--		(create {BOOLEAN_REF}).do_nothing
		local
			lc: like compound
			semicolon_candidate: BOOLEAN
		do
			lc := compound
			ctxt.begin
			from lc.start until lc.after loop

				ctxt.new_expression
				ctxt.begin
				lc.item.simple_format (ctxt)
				ctxt.commit

				semicolon_candidate := True
					--| FIXME Not always True of course, but
					--| a simplification of the problem:
					--| Semicolons are always added when next line starts
					--| with opening parenthesis.

				lc.forth
				if not lc.after then
					if semicolon_candidate and then lc.item.starts_with_parenthesis then
						ctxt.put_text_item (ti_Semi_colon)
						debug ("DOCUMENTATION")
							io.put_string ("Semicolon was needed.%N")
						end
					end
					ctxt.new_line
				end
			end
			ctxt.commit
		end

feature {INTERNAL_AS, CMD, USER_CMD, INTERNAL_MERGER} -- Replication
	
	set_compound (c: like compound) is
		do
			compound := c
		end;	

feature {NONE} -- Formatter
	
	begin_keyword: TEXT_ITEM is 
		deferred
		end
	
end -- class INTERNAL_AS
