-- Node for boolean constant

class BOOL_AS

inherit

	ATOMIC_AS
		redefine
			simple_format
		end

feature -- Attributes

	value: BOOLEAN;
			-- Integer value

feature -- Initialization

	set is
			-- Yacc initialization
		do
			value := yacc_bool_arg (0);
		end;

feature -- simple_formatter

	simple_format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.always_succeed;
			if value then
				ctxt.put_text_item (ti_True_keyword)
			else
				ctxt.put_text_item (ti_False_keyword)
			end
		end;

end
