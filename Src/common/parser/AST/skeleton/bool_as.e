indexing

	description: 
		"AST representation of a boolean constant.";
	date: "$Date$";
	revision: "$Revision$"

class BOOL_AS

inherit

	ATOMIC_AS

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			value := yacc_bool_arg (0);
		end;

feature -- Properties

	value: BOOLEAN;
			-- Integer value

feature -- Output

    string_value: STRING is
        do
            Result := value.out
        end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
		do
			if value then
				ctxt.put_text_item (ti_True_keyword)
			else
				ctxt.put_text_item (ti_False_keyword)
			end
		end;

end -- class BOOL_AS
