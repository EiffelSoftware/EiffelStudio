indexing

	description: 
		"Item that represents an indentation.";
	date: "$Date$";
	revision: "$Revision $"

class INDENT_TEXT 

inherit

	TEXT_ITEM

create

	make

feature -- Initialization

	make (indent: INTEGER) is
			-- Make indentation text with `indent' indents.
		require
			indent >= 0
		do
			indent_depth := indent;
			image := indent_text
		end;

feature -- Properties

	image: STRING;
			-- Tab image

	indent_depth: INTEGER;
			-- Indentation depth

feature {NONE} -- Implementation

	indent_text: STRING is
			-- Indentation text based on indent_depth
		local
			i: INTEGER
		do
			create Result.make (indent_depth);
			from 
				i := 1
			until
				i > indent_depth
			loop
				Result.append ("%T");
				i := i + 1
			end;
		ensure
			required_nr_tabs: Result.count = indent_depth
		end;

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current indentation to `text'.
		do
			text.process_indentation (Current)
		end

end -- class INDENT_TEXT
