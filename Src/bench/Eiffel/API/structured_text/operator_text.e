indexing

	description: 
		"Operator text (prefix and infix routines).";
	date: "$Date$";
	revision: "$Revision $"

class OPERATOR_TEXT

inherit

	FEATURE_NAME_TEXT
		redefine
			append_to
		end

creation

	make

feature -- Properties

	is_keyword: BOOLEAN;
			-- Is Current a keyword?

	is_symbol: BOOLEAN is
			-- Is Current a symbol?
		do	
			Result := not is_keyword
		ensure
			not_keyword: Result = not is_keyword
		end;

feature -- Setting

	set_is_keyword is
			-- Set is_keyword to True.
		do
			is_keyword := True
		ensure
			is_keyword: is_keyword
		end;

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current basic text to `text'.
		do
			text.process_operator_text (Current)
		end

end -- class OPERATOR_TEXT
