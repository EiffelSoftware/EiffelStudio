indexing

	description: "Node for boolean constant.";
	date: "$Date$";
	revision: "$Revision$"

class BOOL_AS

inherit

	ATOMIC_AS

feature -- Attributes

	value: BOOLEAN;
			-- Integer value

feature -- Initialization

	set is
			-- Yacc initialization
		do
			value := yacc_bool_arg (0);
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
		do
			if value then
				ctxt.put_text_item (ti_True_keyword)
			else
				ctxt.put_text_item (ti_False_keyword)
			end
		end;

    string_value: STRING is
        do
            Result := value.out
        end

end -- class BOOL_AS
