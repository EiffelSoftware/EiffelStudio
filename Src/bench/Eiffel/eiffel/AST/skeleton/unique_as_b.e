-- Description of a unique value

class UNIQUE_AS

inherit

	ATOMIC_AS
		redefine
			is_unique, type_check, format
		end

feature -- Conveniences

	is_unique: BOOLEAN is
			-- Is the terminal a unique constant ?
		do
			Result := True;
		end;

feature -- Initialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end; -- set

	type_check is
			-- Type check a unique type
		do
			context.put (Integer_type);
		end;

	format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.put_text_item (ti_Unique_keyword);
		end;

end
