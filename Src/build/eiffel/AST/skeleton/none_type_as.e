-- Node for type INTEGER

class NONE_TYPE_AS

inherit

	BASIC_TYPE
		redefine simple_format
	end

feature

	dump: STRING is "NONE";
			-- Dumped trace

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.put_string ("NONE");
			ctxt.always_succeed;
		end;

end
