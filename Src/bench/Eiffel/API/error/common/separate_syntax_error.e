indexing

	description:
		"Syntax error when the %"separate%" keyword is used and %
		%Concurrent Eiffel is not enabled.";
	date: "$Date$";
	revision: "$Revision$"

class SEPARATE_SYNTAX_ERROR

inherit

	SYNTAX_ERROR
		redefine
			syntax_message
		end

create
	init

feature -- Property

	syntax_message: STRING is
			-- Specific syntax message.
		do
			Result := "Concurrent Eiffel is not enabled"
		end;
	
end -- class SEPARATE_SYNTAX_ERROR
