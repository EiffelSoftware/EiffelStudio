indexing

	description: "Abstract description of a check clause";
	date: "$Date$";
	revision: "$Revision$"

class CHECK_AS

inherit

	INSTRUCTION_AS
		redefine
			simple_format
		end;

feature -- Attributes

	check_list: EIFFEL_LIST [TAGGED_AS];
			-- List of tagged boolean expression

feature -- Initialization

	set is
			-- Yacc initialization
		do
			check_list ?= yacc_arg (0);
		end;

feature -- Equivalence 

	is_equiv (other: INSTRUCTION_AS): BOOLEAN is
			-- Is `other' instruction equivalent to Current?
		local
			check_as: CHECK_AS
		do
			check_as ?= other
			if check_as /= Void then
				-- May be equivalent
				Result := equiv (check_as)
			else
				-- NOT equivalent
				Result := False
			end
		end;

	equiv (other: like Current): BOOLEAN is
			-- Is `other' check_as equivalent to Current?
		do
			Result := deep_equal (check_list, other.check_list)
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute Text
		do
			ctxt.begin;
			ctxt.put_breakable;
			ctxt.put_text_item (ti_check_keyword);
			if check_list /= void then
				ctxt.indent_one_more;
				ctxt.next_line;
				check_list.simple_format (ctxt);
				ctxt.indent_one_less;
				ctxt.next_line;
			end;
			ctxt.put_text_item (ti_End_keyword);
			ctxt.commit;
		end;
			
feature {CHECK_AS} -- Replication
	
	set_check_list (c: like check_list) is
		do
			check_list := c
		end;

end -- class CHECK_AS
