indexing

	description: "Node for NONE type.";
	date: "$Date$";
	revision: "$Revision$"

class NONE_TYPE_AS

inherit

	BASIC_TYPE
		redefine
			simple_format
		end;

feature

	dump: STRING is "NONE";
			-- Dumped trace

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.put_string ("NONE");
		end;

end -- class NONE_TYPE_AS
