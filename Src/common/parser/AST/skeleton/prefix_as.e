indexing
	description: "AST representation of an Eiffel prefixed feature name."
	date: "$Date$"
	revision: "$Revision$"

class
	PREFIX_AS

inherit
	INFIX_AS
		redefine
			is_infix,
			is_prefix
		end

feature -- Properties

	Fix_notation: STRING is "_prefix_"
			-- Prefix for prefixed Eiffel feature name used by
			-- the compiler

	is_infix: BOOLEAN is
			-- is the current feature name an infixed notation ?
		do
			Result := False
		end

	is_prefix: BOOLEAN is True
			-- Is the current feature name a prefixed notation ?

end -- class PREFIX_AS
