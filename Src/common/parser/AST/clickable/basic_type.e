indexing

	description: "Abstract class for Eiffel basic types.";
	date: "$Date$";
	revision: "$Revision$"

deferred class BASIC_TYPE

inherit

	TYPE;
	CLICKABLE_AST
		redefine
			is_class
		end			

feature -- Properties

	is_class: BOOLEAN is
			-- Does the Current AST represent a class?
		do
			Result := True
		end;

feature -- Initialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

end -- class BASIC_TYPE
