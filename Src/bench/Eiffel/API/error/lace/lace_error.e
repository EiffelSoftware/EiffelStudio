indexing

	description: 
		"Error detected when parsing the Ace file specified in LACE.";
	date: "$Date$";
	revision: "$Revision $"

deferred class LACE_ERROR

inherit

	ERROR

feature -- Property

	code: STRING is
			-- Error code
		do
			Result := generator;
		end;

end -- class LACE_ERROR
