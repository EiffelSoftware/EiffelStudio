indexing

	description: "Abstract description of retry instruction";
	date: "$Date$";
	revision: "$Revision$"

class RETRY_AS

inherit

	INSTRUCTION_AS

feature -- Initialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

feature -- Equivalence
		
	is_equiv (other: INSTRUCTION_AS): BOOLEAN is
			-- Is `other' instruction equivalent to Current?
		local
			retry_as: RETRY_AS
		do
			retry_as ?= other
			Result := retry_as /= Void
		end;
	
	equiv (other: like Current): BOOLEAN is
			-- Is `other' retry_as equivalent to Current?
		do
			Result := True
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable;
			ctxt.put_text_item (ti_Retry_keyword);
		end;

end -- class RETRY_AS
