indexing

	description: "Abstract description of an Eiffel prefixed feature name.";
	date: "$Date$";
	revision: "$Revision$"

class PREFIX_AS

inherit

	INFIX_AS
		redefine
			Fix_notation, is_infix, is_prefix
		end

feature

	Fix_notation: STRING is
			-- Prefix for prefixed Eiffel feature name used by
			-- the compiler
		once
			Result := "_prefix_"
		end;

	is_infix: BOOLEAN is
			-- is the current feature name an infixed notation ?
		do
			Result := False;
		end;

	is_prefix: BOOLEAN is
			-- Is the current feature name a prefixed notation ?
		do
			Result := True;
		end;

end -- class PREFIX_AS
