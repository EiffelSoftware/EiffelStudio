-- Abstract description of an Eiffel loop instruction

class LOOP_AS

inherit

	INSTRUCTION_AS
		redefine
			simple_format
		end

feature -- Attributes

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

feature -- Initialization

	set is
			-- Yacc initialization
		do
			from_part ?= yacc_arg (0);
			invariant_part ?= yacc_arg (1);
			variant_part ?= yacc_arg (2);
			stop ?= yacc_arg (3);
			compound ?= yacc_arg (4);
		ensure then
			stop_exists: stop /= Void
		end;

feature -- Equivalence

	is_equiv (other: INSTRUCTION_AS): BOOLEAN is
			-- Is `other' instruction equivalent to Current?
		local
			loop_as: LOOP_AS
		do
			loop_as ?= other
			if loop_as /= Void then
				-- May be equivalent
				Result := equiv (loop_as)
			else
				-- NOT equivalent
				Result := False
			end
		end;

	equiv (other: like Current): BOOLEAN is
			-- Is `other' loop_as equivalent to Current?
		do
			Result := deep_equal (from_part, other.from_part)
			if Result then
				-- May be equivalent
				Result := deep_equal (invariant_part, other.invariant_part)
				if Result then
					-- May be equivalent
					Result := deep_equal (variant_part, other.variant_part)
					if Result then
						-- May be equivalent
						Result := deep_equal (stop, other.stop)
						if Result then
							-- May be equivalent
							Result := deep_equal (compound, other.compound)
						end
					end
				end
			end
		end;
			

feature -- simple_Formatter

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_breakable;
			ctxt.put_text_item (ti_From_keyword);
			ctxt.set_separator (ti_Semi_colon);
			ctxt.new_line_between_tokens;
			if from_part /= void then
				ctxt.indent_one_more;
				ctxt.next_line;
				from_part.simple_format (ctxt);
				ctxt.indent_one_less;
			end;
			ctxt.put_breakable;
			if invariant_part /= void then
				ctxt.next_line;
				ctxt.put_text_item (ti_Invariant_keyword);
				ctxt.indent_one_more;
				ctxt.next_line;
				invariant_part.simple_format (ctxt);
				ctxt.indent_one_less;
			end;
			if variant_part /= void then
				ctxt.next_line;
				ctxt.put_text_item (ti_Variant_keyword);
				ctxt.indent_one_more;
				ctxt.next_line;
				variant_part.simple_format(ctxt);
				ctxt.indent_one_less;
			end;
			ctxt.next_line;
			ctxt.put_text_item (ti_Until_keyword);
			ctxt.indent_one_more;
			ctxt.next_line;
			stop.simple_format (ctxt);
			ctxt.indent_one_less;
			ctxt.next_line;
			ctxt.put_text_item (ti_Loop_keyword);
			if compound /= void then
				ctxt.indent_one_more;
				ctxt.next_line;
				compound.simple_format (ctxt);
				ctxt.indent_one_less;
			end;
			ctxt.next_line;
			ctxt.put_breakable;
			ctxt.put_text_item (ti_End_keyword);
			ctxt.commit
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
			
end
