-- Abstract description of a call as an expression

class EXPR_CALL_AS

inherit

	EXPR_AS
		redefine
			simple_format
		end

feature -- Attributes

	call: CALL_AS;
			-- Expression call

feature -- Inialization

	set is
			-- Yacc initialization
		do
			call ?= yacc_arg (0);
		ensure then
			call_exists: call /= Void;
		end;

feature -- Type check, byte code and dead code removal

	simple_format(ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			call.simple_format (ctxt);
		end;

feature {EXPR_CALL_AS}

	set_call (c: like call) is
		require
			valid_arg: c /= Void
		do
			call := c;
		end

end
