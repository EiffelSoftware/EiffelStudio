indexing

	description: 
		"Abstract class representing routines that have a body.";
	date: "$Date$";
	revision: "$Revision $"

deferred class INTERNAL_AS

inherit

	ROUT_BODY_AS
		redefine
			has_instruction, index_of_instruction,
			number_of_stop_points,
			is_equivalent
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			compound ?= yacc_arg (0);
		end

feature -- Properties

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound)
		end

feature -- Access

	number_of_stop_points: INTEGER is
			-- Number of stop points for AST
		do
			if compound /= Void then
				Result := compound.number_of_stop_points;
			end;
			Result := Result + 1;
		end;

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
		end;

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
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (begin_keyword);
			ctxt.new_line;
			if compound /= Void then
				ctxt.indent
				ctxt.set_new_line_between_tokens;
				compound.simple_format (ctxt);
				ctxt.new_line;
				ctxt.exdent
			end;
			ctxt.put_breakable;
		end;

feature {INTERNAL_AS, CMD, USER_CMD, INTERNAL_MERGER} -- Replication
	
	set_compound (c: like compound) is
		do
			compound := c;
		end;	

feature {NONE} -- Formatter
	
	begin_keyword: TEXT_ITEM is 
		deferred
		end;
	
end -- class INTERNAL_AS
