indexing
	description: 
		"AST representation of an Eiffel loop instruction"
	date: "$Date$"
	revision: "$Revision$"

class
	LOOP_AS

inherit
	INSTRUCTION_AS

feature {AST_FACTORY} -- Initialization

	initialize (f: like from_part; i: like invariant_part;
		v: like variant_part; s: like stop;
		c: like compound; l: like location) is
			-- Create a new LOOP AST node.
		require
			s_not_void: s /= Void
			l_not_void: l /= Void
		do
			from_part := f
			invariant_part := i
			variant_part := v
			stop := s
			compound := c
			location := clone (l)
		ensure
			from_part_set: from_part = f
			invariant_part_set: invariant_part = i
			variant_part_set: variant_part = v
			stop_set: stop = s
			compound_set: compound = c
			location_set: location.is_equal (l)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_loop_as (Current)
		end

feature -- Attributes

	from_part: EIFFEL_LIST [INSTRUCTION_AS]
			-- from compound

	invariant_part: EIFFEL_LIST [TAGGED_AS]
			-- invariant list

	variant_part: VARIANT_AS
			-- Variant list

	stop: EXPR_AS
			-- Stop test

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Loop compound

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

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_breakable;
--			ctxt.put_text_item (ti_From_keyword);
--			ctxt.set_separator (ti_Semi_colon);
--			ctxt.set_new_line_between_tokens;
--			if from_part /= Void then
--				ctxt.indent;
--				ctxt.new_line;
--				ctxt.format_ast (from_part);
--				ctxt.new_line;
--				ctxt.exdent
--			else
--				ctxt.new_line
--			end
--			ctxt.put_breakable;
--			if invariant_part /= Void then
--				ctxt.put_text_item (ti_Invariant_keyword);
--				ctxt.indent;
--				ctxt.new_line;
--				ctxt.format_ast (invariant_part);
--				ctxt.new_line;
--				ctxt.exdent;
--			end
--			if variant_part /= Void then
--				ctxt.put_text_item (ti_Variant_keyword);
--				ctxt.indent;
--				ctxt.new_line;
--				ctxt.format_ast (variant_part);
--				ctxt.new_line;
--				ctxt.exdent;
--			end
--			ctxt.put_text_item (ti_Until_keyword);
--			ctxt.indent;
--			ctxt.new_line;
--			ctxt.new_expression
--			ctxt.format_ast (stop);
--			ctxt.exdent;
--			ctxt.new_line;
--			ctxt.put_text_item (ti_Loop_keyword);
--			if compound /= Void then
--				ctxt.indent;
--				ctxt.new_line;
--				ctxt.format_ast (compound);
--				ctxt.exdent;
--			end
--			ctxt.new_line;
--			ctxt.put_breakable;
--			ctxt.put_text_item (ti_End_keyword);
--		end

feature {LOOP_AS} -- Replication

	set_from_part (f: like from_part) is
		do
			from_part := f
		end

	set_invariant_part (i: like invariant_part) is
		do
			invariant_part := i
		end

	set_variant_part (v: like variant_part) is
		do
			variant_part := v
		end

	set_stop (s: like stop) is
		require
			valid_s: s /= Void
		do
			stop := s
		end

	set_compound (c: like compound) is
		do
			compound := c
		end
			
end -- class LOOP_AS
