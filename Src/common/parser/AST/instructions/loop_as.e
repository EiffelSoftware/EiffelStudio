indexing

	description: 
		"AST representation of an Eiffel loop instruction";
	date: "$Date$";
	revision: "$Revision$"

class LOOP_AS

inherit

	INSTRUCTION_AS
		redefine
			number_of_stop_points
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			from_part ?= yacc_arg (0);
			invariant_part ?= yacc_arg (1);
			variant_part ?= yacc_arg (2);
			stop ?= yacc_arg (3);
			compound ?= yacc_arg (4);
			start_position := yacc_position;
			line_number := yacc_line_number
		ensure then
			stop_exists: stop /= Void
		end;

feature -- Properties

	from_part: EIFFEL_LIST [INSTRUCTION_AS];
			-- from compound

	invariant_part: EIFFEL_LIST [TAGGED_AS];
			-- invariant list

	variant_part: VARIANT_AS;
			-- Variant list

	stop: EXPR_AS;
			-- Stop test

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Loop compound

feature -- Access

	number_of_stop_points: INTEGER is
			-- Number of stop points for AST
		do
			Result := 1;
			if from_part /= Void then
				Result := Result + from_part.number_of_stop_points;
			end;
			Result := Result + 1;
			if compound /= Void then
				Result := Result + compound.number_of_stop_points;
			end;
			Result := Result + 1;
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and then
				equivalent (from_part, other.from_part) and then
				equivalent (invariant_part, other.invariant_part) and then
				equivalent (stop, other.stop) and then
				equivalent (variant_part, other.variant_part)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable;
			ctxt.put_text_item (ti_From_keyword);
			ctxt.set_separator (ti_Semi_colon);
			ctxt.set_new_line_between_tokens;
			if from_part /= Void then
				ctxt.indent;
				ctxt.new_line;
				ctxt.format_ast (from_part);
				ctxt.new_line;
				ctxt.exdent
			else
				ctxt.new_line
			end;
			ctxt.put_breakable;
			if invariant_part /= Void then
				ctxt.put_text_item (ti_Invariant_keyword);
				ctxt.indent;
				ctxt.new_line;
				ctxt.format_ast (invariant_part);
				ctxt.new_line;
				ctxt.exdent;
			end;
			if variant_part /= Void then
				ctxt.put_text_item (ti_Variant_keyword);
				ctxt.indent;
				ctxt.new_line;
				ctxt.format_ast (variant_part);
				ctxt.new_line;
				ctxt.exdent;
			end;
			ctxt.put_text_item (ti_Until_keyword);
			ctxt.indent;
			ctxt.new_line;
			ctxt.new_expression
			ctxt.begin
			ctxt.format_ast (stop);
			ctxt.exdent;
			ctxt.new_line;
			ctxt.put_text_item (ti_Loop_keyword);
			if compound /= Void then
				ctxt.indent;
				ctxt.new_line;
				ctxt.format_ast (compound);
				ctxt.exdent;
			end;
			ctxt.new_line;
			ctxt.put_breakable;
			ctxt.put_text_item (ti_End_keyword);
		end;

feature {LOOP_AS} -- Replication

	set_from_part (f: like from_part) is
		do
			from_part := f
		end;

	set_invariant_part (i: like invariant_part) is
		do
			invariant_part := i
		end;

	set_variant_part (v: like variant_part) is
		do
			variant_part := v
		end;

	set_stop (s: like stop) is
		require
			valid_s: s /= Void
		do
			stop := s
		end;

	set_compound (c: like compound) is
		do
			compound := c
		end;
			
end -- class LOOP_AS
