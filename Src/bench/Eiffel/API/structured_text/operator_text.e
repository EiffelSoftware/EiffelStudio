indexing

	description: 
		"Operator text (prefix and infix routines).";
	date: "$Date$";
	revision: "$Revision $"

class OPERATOR_TEXT

inherit

	FEATURE_TEXT
		redefine
			append_to
		end

creation

	make

feature -- Properties

	is_keyword: BOOLEAN is
			-- Is Current a keyword?
		require
			valid_image: image /= Void and then not image.is_empty
		do
			Result := (image @ 1).is_alpha
		end

	is_symbol: BOOLEAN is
			-- Is Current a symbol?
		require
			valid_image: image /= Void and then not image.is_empty
		do	
			Result := not is_keyword
		ensure
			not_keyword: Result = not is_keyword
		end

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current basic text to `text'.
		do
			text.process_operator_text (Current)
		end

end -- class OPERATOR_TEXT
